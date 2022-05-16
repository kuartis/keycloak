# Builder
FROM quay.io/keycloak/keycloak:17.0.1 as builder
ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=token-exchange,upload-scripts
ENV KC_DB=postgres
RUN /opt/keycloak/bin/kc.sh build

# Runtime
FROM quay.io/keycloak/keycloak:17.0.1
COPY --from=builder /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/
WORKDIR /opt/keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]
