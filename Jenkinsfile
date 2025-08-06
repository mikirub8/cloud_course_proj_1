pipeline {
  agent { label 'docker-agent' }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/avielb/rmqp-example.git', branch: 'master'
      }
    }

    stage('Build Producer and Consumer Docker Images') {
      steps {
        container('docker') {
          sh '''
            docker version
            docker build -t my-producer:latest producer
            docker build -t my-consumer:latest consumer
          '''
        }
      }
    }

    stage('Push Docker Images') {
      steps {
        container('docker') {
          // Replace <your-dockerhub-username> and ensure Jenkins credentialsId 'dockerhub' exists
          withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
            sh '''
              echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
              docker tag my-producer:latest $DOCKER_USER/my-producer:latest
              docker tag my-consumer:latest $DOCKER_USER/my-consumer:latest
              docker push $DOCKER_USER/my-producer:latest
              docker push $DOCKER_USER/my-consumer:latest
            '''
          }
        }
      }
    }
  }
}
