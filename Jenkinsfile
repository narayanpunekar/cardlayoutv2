pipeline {
    agent any  
    options { timeout(time: 30) }
    stages {
        stage("Stage One") {
            steps {
                sleep 30
            }
        }
        stage("Stage Two") {
            steps {
                echo 'cardlayoutv2'
            }
        }
        stage("Checkout") {
            steps {
                echo 'git url: https://github.com/narayanpunekar/cardlayoutv2.git'
                git url: 'https://github.com/narayanpunekar/cardlayoutv2.git'
            }
        }
        stage("Compile") {
            steps {
                sh "mvn clean compile"
            }
        }
		stage("Unit Test") {
			steps { 
				sh "mvn test" 
			} 
		} 
		stage("Package") {
            steps {
                sh "mvn package"
            }
		}
		stage("Docker build") {
			steps {
				sh "docker build -t npunekar/cardlayoutv2 ."
			}
		}
		stage("Docker push") {
			steps {
				sh "cat ./password | docker login --username npunekar --password-stdin"  
				sh "docker push npunekar/cardlayoutv2"
				sh "docker logout" 
			}
		}
		stage("Deploy to staging") {
			steps { 
				sh "docker container rm -f cardlayoutv2-app" 
				sh "docker run -d -p 8180:8080 --name cardlayoutv2-app npunekar/cardlayoutv2"
			}
		}
    }
    post {
        always {
            mail to: 'narayan.v.punekar@gmail.com',
            subject: "Completed Pipeline: ${currentBuild.fullDisplayName}", 
            body: "Build completed, ${env.BUILD_URL}"
        }
    }
} 

