FROM golang:1.22.1-alpine AS build-stage

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -o /sample-rest-api .

FROM gcr.io/distroless/base-debian11 AS build-release-stage

WORKDIR /

COPY --from=build-stage ./sample-rest-api ./sample-rest-api

ENV ENVIRONMENT=container

EXPOSE 1323

CMD ["./sample-rest-api"]