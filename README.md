# keycloak-restrict-client-auth-image

This project is meant to use github actions to build docker image containing [`sventorben/keycloak-restrict-client-auth`](https://github.com/sventorben/keycloak-restrict-client-auth) jar to inject it in [keycloak](https://www.keycloak.org/) as `initContainer`.

You'll find the resulting build at https://hub.docker.com/r/beardedbabs/keycloak-restrict-client-auth-image

## Naming scheme

As `sventorben` follows keycloak major versioning for compatibility reasons, the same is performed here.
- `vXX.y.z` release will contain original `vXX.y.z` version
- `vXX` release will contain the latest `vXX.y.z`
- `latest` will contain the latest version at build time

## Usage example

With [Bitnami's Helm](https://github.com/bitnami/charts/tree/main/bitnami/keycloak/), you can use it by adding something like the following in your `values.yaml`:

```yaml
initdbScripts:
  deploy-custom-providers.sh: |
      echo "Deploy custom providers..."
      cp -v /custom-providers/*.jar /opt/bitnami/keycloak/providers/
      echo "Custom providers deployed"

initContainers:
  - name: keycloak-restrict-client-auth-image
    image: beardedbabs/keycloak-restrict-client-auth-image:v20
    imagePullPolicy: IfNotPresent
    command:
      - sh
    args:
      - -c
      - |
        echo "Copying keycloak-restrict-client-auth.jar..."
        cp -v /dist/*.jar /target/
        echo "Copy done."
    volumeMounts:
      - name: providers
        mountPath: /target/

extraVolumeMounts:
  - name: providers
    mountPath: /custom-providers/

extraVolumes:
  - name: providers
    emptyDir: {}
```