package main

import (
	"github.com/sirupsen/logrus"
	"net/http"
)

func main() {
	log := logrus.New()
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		log.WithField("path", "/").Info("handler invoked")
	})
	http.ListenAndServe(":80", nil)
}
