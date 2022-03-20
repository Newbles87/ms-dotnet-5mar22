import groovy.json.JsonSlurper

node {
    ws('netcore') {
        stage('SCM') {
            git branch: 'master', url: 'https://github.com/Newbles87/ms-dotnet-5mar22.git'          
        }
        stage('Build') {
            dotnet_build();
        }
        stage('Docker') {              
              bat(script: 'docker build -t ricardoalarcon87/dotnet5 .', returnStdout: true);
              bat(script: 'docker push ricardoalarcon87/dotnet5', returnStdout: true);            
        }
        stage('Deploy Dev') {
              bat(script: 'az login --service-principal --username 42af295e-540b-41cd-bd7e-8512e165971e --password lMhroJFDa7GsieDG~woGpdw6Z5On6-U_.T  --tenant f575824d-a581-46c9-835b-4530ff100398', returnStdout: true);
              bat(script: 'az account set --subscription 7b064172-da45-452b-82fb-23b11b84cbf3', returnStdout: true);
              bat(script: 'az container restart --name ci-aforo255-rsac --resource-group aforo255Devops', returnStdout: true);  
        }
        stage('Deploy Prod') {
             bat(script: 'az aks get-credentials --resource-group aforo255Devops --name k8s-cluster-aforo255rac & kubectl config get-contexts --kubeconfig=%KUBE_PATH_CONFIG%', returnStdout: true);
             bat(script: 'kubectl config use-context k8s-cluster-aforo255rac --kubeconfig=%KUBE_PATH_CONFIG%', returnStdout: true);
             bat(script: 'Kubectl delete --all pods --kubeconfig=%KUBE_PATH_CONFIG% & kubectl apply -f k8s.yml --kubeconfig=%KUBE_PATH_CONFIG%', returnStdout: true);
        }        
    }
}

def dotnet_build() {
    bat(script: 'dotnet restore', returnStdout: true);
    bat(script: 'dotnet build', returnStdout: true);
    bat(script: 'dotnet test', returnStdout: true);
}
