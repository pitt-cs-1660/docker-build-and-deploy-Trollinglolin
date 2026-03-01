FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod .
COPY main.go .
COPY templates/ ./templates/

RUN CGO_ENABLED=0 go build -o band-generator .

FROM scratch

COPY --from=builder /app/band-generator /band-generator
COPY --from=builder /app/templates/ /templates/

ENTRYPOINT ["/band-generator"]
