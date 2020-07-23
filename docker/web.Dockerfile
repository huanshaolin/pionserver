FROM caddy:2.0.0-alpine

ENV ENABLE_TELEMETRY="false"
WORKDIR /usr/src/ion

COPY ./sdk/js /usr/src/ion
RUN apk add --no-cache --update nodejs npm \
  && mkdir -p /app/demo \
  && npm install \
  && cd demo  \
  && npm install \
  && npm run build \
  && mv dist /app/demo \
  && rm -rf /usr/src/ion /root/.npm /tmp/* \
  && apk del --no-cache nodejs npm

FROM caddy:2.0.0-alpine

ENTRYPOINT ["/usr/local/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout", "--agree=true"]
