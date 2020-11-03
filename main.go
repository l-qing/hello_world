// https://gin-gonic.com/docs/examples/http-method/
package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	// Creates a gin router with default middleware:
	// logger and recovery (crash-free) middleware
	router := gin.Default()

	router.GET("/healthy", healthy)

	// By default it serves on :8080 unless a
	// PORT environment variable was defined.
	// router.Run()
	router.Run(":80") // for a hard coded port
}

func healthy(c *gin.Context) {
	c.JSON(http.StatusOK,
		gin.H{
			"code": 0,
			"msg":  "心跳正常",
			"data": nil,
		})
}
