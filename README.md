# Keycloak with PostgreSQL

## Usage

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: keycloak
  labels:
    app: keycloak
spec:
  replicas: 1
  selector:
    matchLabels:
      app: keycloak
  template:
    metadata:
      labels:
        app: keycloak
    spec:
      containers:
        - name: keycloak
          image: ghcr.io/kuartis/keycloak:17.0.1
          env:
            - name: KEYCLOAK_ADMIN
              value: 'admin'
            - name: KEYCLOAK_ADMIN_PASSWORD
              value: 'admin'
            - name: KC_DB_URL
              value: jdbc:postgresql://postgresql:5432/keycloak
            - name: KC_DB_USERNAME
              value: postgres
            - name: KC_DB_PASSWORD
              value: '123456'
            - name: KC_HOSTNAME
              value: auth.keycloak.com
          ports:
            - name: http
              containerPort: 8080
          resources:
            requests:
              cpu: '2'
              memory: 1000Mi
            limits:
              cpu: '4'
              memory: 8000Mi
          readinessProbe:
            httpGet:
              path: /realms/master
              port: 8080
```
