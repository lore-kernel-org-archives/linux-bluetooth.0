Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 1/6] gobex: Add translating error codes to strings
Date: Thu,  8 Dec 2011 14:07:53 +0100
Message-Id: <1323349678-17905-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gobex/gobex.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 gobex/gobex.h |    2 ++
 2 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index b374b06..38d6812 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -114,6 +114,62 @@ struct setpath_data {
 	guint8 constants;
 } __attribute__ ((packed));
 
+struct error_code {
+	guint8 code;
+	const char *name;
+} obex_errors[] = {
+	{ G_OBEX_RSP_CONTINUE,			"Continue" },
+	{ G_OBEX_RSP_SUCCESS,			"Success" },
+	{ G_OBEX_RSP_CREATED,			"Created" },
+	{ G_OBEX_RSP_ACCEPTED,			"Accepted" },
+	{ G_OBEX_RSP_NON_AUTHORITATIVE,		"Non Authoritative" },
+	{ G_OBEX_RSP_NO_CONTENT,		"No Content" },
+	{ G_OBEX_RSP_RESET_CONTENT,		"Reset Content" },
+	{ G_OBEX_RSP_PARTIAL_CONTENT,		"Partial Content" },
+	{ G_OBEX_RSP_MULTIPLE_CHOICES,		"Multiple Choices" },
+	{ G_OBEX_RSP_MOVED_PERMANENTLY,		"Moved Permanently" },
+	{ G_OBEX_RSP_MOVED_TEMPORARILY,		"Moved Temporarily" },
+	{ G_OBEX_RSP_SEE_OTHER,			"See Other" },
+	{ G_OBEX_RSP_NOT_MODIFIED,		"Not Modified" },
+	{ G_OBEX_RSP_USE_PROXY,			"Use Proxy" },
+	{ G_OBEX_RSP_BAD_REQUEST,		"Bad Request" },
+	{ G_OBEX_RSP_UNAUTHORIZED,		"Unauthorized" },
+	{ G_OBEX_RSP_PAYMENT_REQUIRED,		"Payment Required" },
+	{ G_OBEX_RSP_FORBIDDEN,			"Forbidden" },
+	{ G_OBEX_RSP_NOT_FOUND,			"Not Found" },
+	{ G_OBEX_RSP_METHOD_NOT_ALLOWED,	"Method Not Allowed" },
+	{ G_OBEX_RSP_NOT_ACCEPTABLE,		"Not Acceptable" },
+	{ G_OBEX_RSP_PROXY_AUTH_REQUIRED,	"Proxy Authentication Required" },
+	{ G_OBEX_RSP_REQUEST_TIME_OUT,		"Request Time Out" },
+	{ G_OBEX_RSP_CONFLICT,			"Conflict" },
+	{ G_OBEX_RSP_GONE,			"Gone" },
+	{ G_OBEX_RSP_LENGTH_REQUIRED,		"Length Required" },
+	{ G_OBEX_RSP_PRECONDITION_FAILED,	"Precondition Failed" },
+	{ G_OBEX_RSP_REQ_ENTITY_TOO_LARGE,	"Request Entity Too Large" },
+	{ G_OBEX_RSP_REQ_URL_TOO_LARGE,		"Request URL Too Large" },
+	{ G_OBEX_RSP_UNSUPPORTED_MEDIA_TYPE,	"Unsupported Media Type" },
+	{ G_OBEX_RSP_INTERNAL_SERVER_ERROR,	"Internal Server Error" },
+	{ G_OBEX_RSP_NOT_IMPLEMENTED,		"Not Implemented" },
+	{ G_OBEX_RSP_BAD_GATEWAY,		"Bad Gateway" },
+	{ G_OBEX_RSP_SERVICE_UNAVAILABLE,	"Service Unavailable" },
+	{ G_OBEX_RSP_GATEWAY_TIMEOUT,		"Gateway Timeout" },
+	{ G_OBEX_RSP_VERSION_NOT_SUPPORTED,	"Version Not Supported" },
+	{ G_OBEX_RSP_DATABASE_FULL,		"Database Full" },
+	{ G_OBEX_RSP_DATABASE_LOCKED,		"Database Locked" },
+	{ 0x00,					NULL }
+};
+
+const char *g_obex_strerror(guint8 err_code)
+{
+	struct error_code *error;
+
+	for (error = obex_errors; error->name != NULL; error++)
+		if (error->code == err_code)
+			return error->name;
+
+	return "<unknown>";
+}
+
 static ssize_t req_header_offset(guint8 opcode)
 {
 	switch (opcode) {
diff --git a/gobex/gobex.h b/gobex/gobex.h
index 1b20333..81981ea 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -119,4 +119,6 @@ guint g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
 
 gboolean g_obex_cancel_transfer(guint id);
 
+const char *g_obex_strerror(guint8 err_code);
+
 #endif /* __GOBEX_H */
-- 
1.7.4.1

