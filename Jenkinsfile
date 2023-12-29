pipeline {
    agent any
      
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t "904277552529.dkr.ecr.eu-central-1.amazonaws.com/flaskapp:$GIT_COMMIT" .'
            }
        }
        stage('Push') {
            steps {
                sh 'aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 904277552529.dkr.ecr.eu-central-1.amazonaws.com/'
                sh 'docker push 904277552529.dkr.ecr.eu-central-1.amazonaws.com/flaskapp:$GIT_COMMIT'
            }
        }
        stage('Deploy') {
            steps {
                sh 'helm upgrade flaskapp helm/flaskapp/ --install --atomic --wait --set deployment.tag=$GIT_COMMIT'
            }
        }
     }
   }
 
