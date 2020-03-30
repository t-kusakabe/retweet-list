FROM golang:1.14.1-alpine3.11 as builder

WORKDIR /retweet-list
COPY go.mod go.sum .env ./

RUN --mount=type=cache,target=/root/.cache/go-mod \
      GO111MODULE=on go get

RUN --mount=type=bind,source=./,target=/tool-SlackBotAdmin \
      CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
      go build -o /bin/slackbot

FROM alpine

WORKDIR /tool-SlackBotAdmin
RUN apk add --no-cache ca-certificates
