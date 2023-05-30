
pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "M3"
    }

 environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub')
  }
    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
              git branch: 'main', url: 'https://github.com/krishnar8corenuts/exam-portal-angular.git'
                sh 'docker build -f exam-portal-angular/Dockerfile  -t krishnar8/exam-portal-angular exam-portal-angular'


            
            }

          }
    
      stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push') {
      steps {
        sh 'docker push krishnar8/exam-portal-angular'
  
      }
    }
  
    } 
}

