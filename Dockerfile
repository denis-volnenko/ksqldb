FROM bitnami/ksql:6.2.10 as ksql

FROM alt:latest as alt

ARG JAVA_EXTRA_SECURITY_DIR="/bitnami/java/extra-security"
ARG TARGETARCH

LABEL com.vmware.cp.artifact.flavor="sha256:c50c90cfd9d12b445b011e6ad529f1ad3daea45c26d20b00732fae3cd71f6a83" \
      org.opencontainers.image.base.name="docker.io/bitnami/minideb:bookworm" \
      org.opencontainers.image.created="2024-05-14T06:26:07Z" \
      org.opencontainers.image.description="Application packaged by Broadcom, Inc." \
      org.opencontainers.image.documentation="https://github.com/bitnami/containers/tree/main/bitnami/ksql/README.md" \
      org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.ref.name="6.2.10-alt" \
      org.opencontainers.image.source="https://github.com/bitnami/containers/tree/main/bitnami/ksql" \
      org.opencontainers.image.title="ksql" \
      org.opencontainers.image.vendor="Broadcom, Inc." \
      org.opencontainers.image.version="6.2.10"

ENV HOME="/" \
    OS_ARCH="${TARGETARCH:-amd64}" \
    OS_FLAVOUR="alt" \
    OS_NAME="linux"
    
WORKDIR /opt
COPY --from=ksql /opt .

RUN chmod g+rwX /opt/bitnami
RUN find / -perm /6000 -type f -exec chmod a-s {} \; || true

RUN /opt/bitnami/scripts/java/postunpack.sh
RUN /opt/bitnami/scripts/ksql/postunpack.sh
ENV APP_VERSION="6.2.10" \
    BITNAMI_APP_NAME="ksql" \
    JAVA_HOME="/opt/bitnami/java" \
    PATH="/opt/bitnami/java/bin:/opt/bitnami/common/bin:/opt/bitnami/ksql/bin:$PATH"

USER 1001
ENTRYPOINT [ "/opt/bitnami/scripts/ksql/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/ksql/run.sh" ]