# azdevops-agent
A self hosted Azure DevOps agent to deploy in k8s

# Before start, read this (:
The Dockerfile of this agent uses the Docker in Docker image, if you need to run docker commands and secure you environment, or needs to work on docker image cache, is more wise deploy your agent inside a instance or VM.

# Azure DevOps step
## Create your PAT on Azure DevOps
[https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=Windows](https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=Windows#create-a-pat)

# Deploy on Kubernetes steps

## Create the namespace
kubectl create ns azdevops-agent

## Create secrets
```
kubectl create secret generic azdevops \
  --from-literal=AZP_URL=https://dev.azure.com/yourOrg \
  --from-literal=AZP_TOKEN=YourPAT \
  --from-literal=AZP_POOL=NameOfYourPool
```

| Environment variable | Description |
|    -  |   -   |
| AZP_URL | The URL of the Azure DevOps or Azure DevOps Server instance. |
| AZP_TOKEN | Personal Access Token (PAT) with Agent Pools (read, manage) scope created by a user who has permission to configure agents, at AZP_URL. |
| AZP_AGENT_NAME |	Agent name (default value: the container hostname). |
| AZP_POOL | Agent pool name (default value: Default). |
| AZP_WORK | Work directory (default value: _work). |

## Apply the deployment manifest

```
kubectl apply -f deployment.yaml
```

For more informations read this documentation: https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops
