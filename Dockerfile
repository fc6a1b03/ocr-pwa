FROM node:20 AS builder
WORKDIR /usr/src
COPY . .
RUN npm install -g pnpm
RUN pnpm install && pnpm run build

# =============================================================

FROM caddy:alpine
WORKDIR /usr/share/caddy
COPY --from=builder /usr/src/dist .
COPY --from=builder /usr/src/index.html .
COPY Caddyfile /etc/caddy/Caddyfile
EXPOSE 80
