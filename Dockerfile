FROM golang:1.15.0-alpine@sha256:59eae48746048266891b7839f7bb9ac54a05cec6170f17ed9f4fd60b331b644b
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
RUN apk add --no-cache ca-certificates && update-ca-certificates

ADD . /go/src/github.com/app/app
RUN go build -a -ldflags '-extldflags "static" -w -s' github.com/app/app

FROM scratch
COPY --from=0 /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=0 /go/app /app
ENTRYPOINT ["/app"]
