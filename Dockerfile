FROM golang:alpine AS builder

WORKDIR /usr/src/app

COPY go.mod ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o viniciusnakadev/fullcycle .

FROM scratch

COPY --from=builder /usr/src/app/viniciusnakadev/fullcycle /viniciusnakadev/fullcycle

EXPOSE 8080

ENTRYPOINT [ "./viniciusnakadev/fullcycle"]