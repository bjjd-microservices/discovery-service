pipeline {
    agent any
    environment {
            GITHUB_CREDENTIALS = credentials('github-credentials-id')
    }
    tools {
        maven 'M3'
     }
    stages {
        stage('Checkout from Github') {
            steps{
             git url: 'https://github.com/bjjd-microservices/eureka-server.git' , branch: 'master'
            }
        }
        stage('Remove existing Docker Image') {
                     steps {
                         sh "docker rm -f eureka-server || true"
                         sh "docker rmi \$(docker images | grep 'rajivbansal2981/eureka-server') &> /dev/null || true"
                     }
        }
        stage('Build Project') {
            steps{
                sh "mvn clean install -DskipTests"
            }
        }
        stage('Build Docker Image') {
            steps {
                 sh "docker build -t rajivbansal2981/eureka-server:${BUILD_NUMBER} ."
            }
        }
        stage('Docker Login and push') {
                steps {
                         withCredentials([string(credentialsId: 'DockerHubPassword', variable: 'DockerHubPassword')]) {
                             sh "docker login -u rajivbansal2981 -p ${DockerHubPassword}"
                         }
                         sh "docker push rajivbansal2981/eureka-server:${BUILD_NUMBER}"
                    }
                }
        stage('Deploy Docker application in Docker Deployment Server') {
            steps {
                     sh "docker run -d -p 8761:8761 --name eureka-server rajivbansal2981/eureka-server:${BUILD_NUMBER}"
            }
        }
    }
}