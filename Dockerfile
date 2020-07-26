FROM golang:1.13-alpine as compiler
RUN apk add --no-cache git
WORKDIR /go/src/birkantest
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o /bin/app

FROM alpine
COPY --from=compiler /bin/app /birkantest
ENTRYPOINT /birkantest