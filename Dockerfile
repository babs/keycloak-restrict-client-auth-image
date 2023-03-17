FROM busybox:latest

ARG KRCA_ASSET_URL=https://github.com/sventorben/keycloak-restrict-client-auth/releases/latest/download/keycloak-restrict-client-auth.jar

ADD --chmod=0644 ${KRCA_ASSET_URL} /dist/
