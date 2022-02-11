ARG ELIXIR=1.13.2
ARG OTP=24.2.1
FROM hexpm/elixir:$ELIXIR-erlang-$OTP-alpine-3.15.0
ENV MIX_ENV=dev
RUN apk add --no-progress --update openssl ncurses-libs bash git build-base npm inotify-tools postgresql-client
ENV ELIXIR_ASSERT_TIMEOUT=10000
WORKDIR /app
ENV HOME=/app

COPY mix.exs mix.lock ./
COPY config ./config
RUN mix local.rebar --force \
  && mix local.hex --force \
  && mix deps.get \
  && mix deps.compile

COPY assets/package.json ./assets/
RUN npm --prefix ./assets install --progress=false --no-audit --loglevel=error

COPY . ./

CMD ["/app/entrypoint.sh"]
