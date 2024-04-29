### Cluster Setup and Deployment Guide

This guide outlines the steps to set up and deploy a Kubernetes cluster using Minikube.

You will need to have Docker and Minikube installed on your machine.


### Starting the Cluster

To initiate the cluster named "minikube," execute the following command:

```bash
minikube start
```

### Adding Ingress

Enable Ingress using the command:

```bash
minikube addons enable ingress
```

Ensure everything is functioning properly:

```bash
kubectl get pods -n ingress-nginx
```

If encountering the error:

```bash
❌  Exiting due to MK_ADDON_ENABLE: enable failed: run callbacks: running callbacks: [waiting for app.kubernetes.io/name=ingress-nginx pods: context deadline exceeded]
```

Resolve it by:

```bash
minikube delete --all 
minikube start --driver=docker --vm=true 
minikube addons enable ingress
```

### Creating Secrets
Run the following command : 

- To create a generic secret for PostgreSQL password:
```bash
kubectl create secret generic pgpassword --from-literal PGPASSWORD=postgres
```

- To create TLS certificates secret:
```bash
kubectl create secret tls tls-certs --cert=./development-certs/localhost.crt --key=./development-certs/localhost.key
```

- To create a ConfigMap for PostgreSQL initialization:
```bash
kubectl create configmap postgres-initdb --from-file=./database/initdb.sql
```

---

### Deploying Components

Deploy all components using the folder k8s:

```bash
kubectl apply -f k8s
```
Now you need to wait a little bit ☕ 

Execute:

```bash
minikube tunnel
```

This will make your Ingress resources available at `127.0.0.1`.

**Go to https://localhost/client to see the result !!** 


#### Useful Commands:

- To list available nodes:
```bash
minikube node list
```

- To retrieve pods information across all namespaces:
```bash
minikube kubectl -- get pods -A -o wide
```

- To access the Kubernetes dashboard:
```bash
minikube dashboard
```