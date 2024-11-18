FROM node:16 AS builder
WORKDIR /usr/src
COPY . .
RUN curl -fsSL https://get.pnpm.io/v6.0.js | node - add --global pnpm
RUN pnpm install && pnpm run build

# =============================================================

FROM caddy:alpine
WORKDIR /usr/share/caddy
COPY --from=builder /usr/src/dist .
COPY --from=builder /usr/src/index.html .
COPY Caddyfile /etc/caddy/Caddyfile
EXPOSE 80
