pipeline {
    agent any
    stages {
        stage('Compilation') {
            steps {
                script {
                    sh './gradlew compileJava'
                }
            }
        }
        stage('Test Unitaire') {
            steps {
                script {
                    sh './gradlew test'
                }
            }
        }
        stage('Code Coverage') {
            steps {
                script {
                    sh './gradlew jacocoTestReport'
                    publishHTML(target: [
                        reportDir: 'build/reports/jacoco/test/html',
                        reportFiles: 'index.html',
                        reportName: 'JaCoCo Report'
                    ])
                    sh './gradlew jacocoTestCoverageVerification'
                }
            }
        }
        stage("Package") {
            steps {
                script {
                    sh "./gradlew build"
                }
            }
        }
        stage("Docker Build") {
            steps {
                script {
                    sh "docker build -t calculator:latest ."
                }
            }
        }
        stage("Docker Push") {
            steps {
                script {
                    sh "docker push localhost:5000/calculator:latest"
                }
            }
        }
        stage("Déploiement sur Staging") {
            steps {
                script {
                    sh "docker run -d --rm -p 8765:8080 --name calculator localhost:5000/calculator:latest"
                }
            }
        }
        stage("Test d'acceptation") {
            steps {
                script {
                    sleep 60
                    sh "chmod +x acceptance_test.sh && ./acceptance_test.sh"
                }
            }
        }
    }
    post {
        always {
            script {
                sh "docker stop calculator"
            }
        }
    }
}

