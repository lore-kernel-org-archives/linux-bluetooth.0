Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/2] Port core daemon to gobex
Date: Tue, 29 Nov 2011 11:09:04 +0200
Message-Id: <1322557745-14542-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/manager.c   |   26 +-
 src/obex-priv.h |   12 +-
 src/obex.c      | 1395 ++++++++++++++++++++++---------------------------------
 src/server.c    |    4 +-
 4 files changed, 577 insertions(+), 860 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index b151a21..846f8a0 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -33,7 +33,7 @@
 #include <sys/socket.h>
 #include <inttypes.h>
 
-#include <openobex/obex.h>
+#include <gobex.h>
 
 #include "obexd.h"
 #include "obex.h"
@@ -381,7 +381,7 @@ void manager_cleanup(void)
 
 void manager_emit_transfer_started(struct obex_session *os)
 {
-	char *path = g_strdup_printf("/transfer%u", os->cid);
+	char *path = g_strdup_printf("/transfer%u", os->id);
 
 	g_dbus_emit_signal(connection, OPENOBEX_MANAGER_PATH,
 			OPENOBEX_MANAGER_INTERFACE, "TransferStarted",
@@ -391,9 +391,9 @@ void manager_emit_transfer_started(struct obex_session *os)
 	g_free(path);
 }
 
-static void emit_transfer_completed(uint32_t id, gboolean success)
+static void emit_transfer_completed(struct obex_session *os, gboolean success)
 {
-	char *path = g_strdup_printf("/transfer%u", id);
+	char *path = g_strdup_printf("/transfer%u", os->id);
 
 	g_dbus_emit_signal(connection, OPENOBEX_MANAGER_PATH,
 			OPENOBEX_MANAGER_INTERFACE, "TransferCompleted",
@@ -404,10 +404,10 @@ static void emit_transfer_completed(uint32_t id, gboolean success)
 	g_free(path);
 }
 
-static void emit_transfer_progress(uint32_t id, uint32_t total,
+static void emit_transfer_progress(struct obex_session *os, uint32_t total,
 							uint32_t transfered)
 {
-	char *path = g_strdup_printf("/transfer%u", id);
+	char *path = g_strdup_printf("/transfer%u", os->id);
 
 	g_dbus_emit_signal(connection, path,
 			TRANSFER_INTERFACE, "Progress",
@@ -420,7 +420,7 @@ static void emit_transfer_progress(uint32_t id, uint32_t total,
 
 void manager_register_transfer(struct obex_session *os)
 {
-	char *path = g_strdup_printf("/transfer%u", os->cid);
+	char *path = g_strdup_printf("/transfer%u", os->id);
 
 	if (!g_dbus_register_interface(connection, path,
 				TRANSFER_INTERFACE,
@@ -436,11 +436,11 @@ void manager_register_transfer(struct obex_session *os)
 
 void manager_unregister_transfer(struct obex_session *os)
 {
-	char *path = g_strdup_printf("/transfer%u", os->cid);
+	char *path = g_strdup_printf("/transfer%u", os->id);
 
 	/* Got an error during a transfer. */
 	if (os->object)
-		emit_transfer_completed(os->cid, os->offset == os->size);
+		emit_transfer_completed(os, os->offset == os->size);
 
 	g_dbus_unregister_interface(connection, path,
 				TRANSFER_INTERFACE);
@@ -600,7 +600,7 @@ int manager_request_authorization(struct obex_session *os, int32_t time,
 
 void manager_register_session(struct obex_session *os)
 {
-	char *path = g_strdup_printf("/session%u", os->cid);
+	char *path = g_strdup_printf("/session%u", GPOINTER_TO_UINT(os));
 
 	if (!g_dbus_register_interface(connection, path,
 				SESSION_INTERFACE,
@@ -621,7 +621,7 @@ void manager_register_session(struct obex_session *os)
 
 void manager_unregister_session(struct obex_session *os)
 {
-	char *path = g_strdup_printf("/session%u", os->cid);
+	char *path = g_strdup_printf("/session%u", GPOINTER_TO_UINT(os));
 
 	g_dbus_emit_signal(connection, OPENOBEX_MANAGER_PATH,
 			OPENOBEX_MANAGER_INTERFACE, "SessionRemoved",
@@ -636,13 +636,13 @@ void manager_unregister_session(struct obex_session *os)
 
 void manager_emit_transfer_progress(struct obex_session *os)
 {
-	emit_transfer_progress(os->cid, os->size, os->offset);
+	emit_transfer_progress(os, os->size, os->offset);
 }
 
 void manager_emit_transfer_completed(struct obex_session *os)
 {
 	if (os->object)
-		emit_transfer_completed(os->cid, !os->aborted);
+		emit_transfer_completed(os, !os->aborted);
 }
 
 DBusConnection *manager_dbus_get_connection(void)
diff --git a/src/obex-priv.h b/src/obex-priv.h
index 6a439b4..ee03bf4 100644
--- a/src/obex-priv.h
+++ b/src/obex-priv.h
@@ -24,9 +24,7 @@
 
 struct obex_session {
 	GIOChannel *io;
-	uint32_t cid;
-	uint16_t tx_mtu;
-	uint16_t rx_mtu;
+	uint32_t id;
 	uint8_t cmd;
 	uint8_t action_id;
 	char *name;
@@ -36,8 +34,9 @@ struct obex_session {
 	time_t time;
 	uint8_t *apparam;
 	size_t apparam_len;
-	uint8_t *nonhdr;
+	const void *nonhdr;
 	size_t nonhdr_len;
+	guint get_rsp;
 	uint8_t *buf;
 	int64_t pending;
 	int64_t offset;
@@ -48,11 +47,8 @@ struct obex_session {
 	void *service_data;
 	struct obex_server *server;
 	gboolean checked;
-	obex_t *obex;
-	obex_object_t *obj;
+	GObex *obex;
 	struct obex_mime_type_driver *driver;
-	gboolean stream_open;
-	gboolean stream_suspended;
 	gboolean headers_sent;
 };
 
diff --git a/src/obex.c b/src/obex.c
index a88306d..6307eaa 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -37,10 +37,10 @@
 #include <sys/stat.h>
 #include <sys/statvfs.h>
 #include <fcntl.h>
+#include <inttypes.h>
 
 #include <glib.h>
-
-#include <openobex/obex.h>
+#include <gobex/gobex.h>
 
 #include "obexd.h"
 #include "log.h"
@@ -53,17 +53,6 @@
 #include "transport.h"
 #include "btio.h"
 
-#ifndef OBEX_CMD_ACTION
-#define OBEX_CMD_ACTION 0x06
-#define OBEX_HDR_ACTION_ID 0x94
-#define OBEX_HDR_DESTNAME 0x15
-#define OBEX_HDR_PERMISSIONS 0xD6
-#endif /* OBEX_CMD_ACTION */
-
-/* Default MTU's */
-#define DEFAULT_RX_MTU 32767
-#define DEFAULT_TX_MTU 32767
-
 /* Challenge request */
 #define NONCE_TAG 0x00
 #define OPTIONS_TAG 0x01 /* Optional */
@@ -76,9 +65,6 @@
 #define USER_ID_TAG 0x01 /* Optional */
 #define DIGEST_NONCE_TAG 0x02 /* Optional */
 
-/* Connection ID */
-static uint32_t cid = 0x0000;
-
 static GSList *sessions = NULL;
 
 typedef struct {
@@ -93,51 +79,19 @@ struct auth_header {
 	uint8_t val[0];
 } __attribute__ ((packed));
 
-static struct {
-	int evt;
-	const char *name;
-} obex_event[] = {
-	/* Progress has been made */
-	{ OBEX_EV_PROGRESS,	"PROGRESS"	},
-	/* An incoming request is about to come */
-	{ OBEX_EV_REQHINT,	"REQHINT"	},
-	/* An incoming request has arrived */
-	{ OBEX_EV_REQ,		"REQ"		},
-	/* Request has finished */
-	{ OBEX_EV_REQDONE,	"REQDONE"	},
-	/* Link has been disconnected */
-	{ OBEX_EV_LINKERR,	"LINKERR"	},
-	/* Malformed data encountered */
-	{ OBEX_EV_PARSEERR,	"PARSEERR"	},
-	/* Connection accepted */
-	{ OBEX_EV_ACCEPTHINT,	"ACCEPTHINT"	},
-	/* Request was aborted */
-	{ OBEX_EV_ABORT,	"ABORT"		},
-	/* Need to feed more data when sending a stream */
-	{ OBEX_EV_STREAMEMPTY,	"STREAMEMPTY"	},
-	/* Time to pick up data when receiving a stream */
-	{ OBEX_EV_STREAMAVAIL,	"STREAMAVAIL"	},
-	/* Unexpected data, not fatal */
-	{ OBEX_EV_UNEXPECTED,	"UNEXPECTED"	},
-	/* First packet of an incoming request has been parsed */
-	{ OBEX_EV_REQCHECK,	"REQCHECK"	},
-	{ 0xFF,			NULL		},
-};
-
 /* Possible commands */
 static struct {
 	int cmd;
 	const char *name;
 } obex_command[] = {
-	{ OBEX_CMD_CONNECT,	"CONNECT"	},
-	{ OBEX_CMD_DISCONNECT,	"DISCONNECT"	},
-	{ OBEX_CMD_PUT,		"PUT"		},
-	{ OBEX_CMD_GET,		"GET"		},
-	{ OBEX_CMD_SETPATH,	"SETPATH"	},
-	{ OBEX_CMD_SESSION,	"SESSION"	},
-	{ OBEX_CMD_ABORT,	"ABORT"		},
-	{ OBEX_CMD_ACTION,	"ACTION"	},
-	{ OBEX_FINAL,		"FINAL"		},
+	{ G_OBEX_OP_CONNECT,	"CONNECT"	},
+	{ G_OBEX_OP_DISCONNECT,	"DISCONNECT"	},
+	{ G_OBEX_OP_PUT,	"PUT"		},
+	{ G_OBEX_OP_GET,	"GET"		},
+	{ G_OBEX_OP_SETPATH,	"SETPATH"	},
+	{ G_OBEX_OP_SESSION,	"SESSION"	},
+	{ G_OBEX_OP_ABORT,	"ABORT"		},
+	{ G_OBEX_OP_ACTION,	"ACTION"	},
 	{ 0xFF,			NULL		},
 };
 
@@ -146,70 +100,61 @@ static struct {
 	int rsp;
 	const char *name;
 } obex_response[] = {
-	{ OBEX_RSP_CONTINUE,			"CONTINUE"		},
-	{ OBEX_RSP_SWITCH_PRO,			"SWITCH_PRO"		},
-	{ OBEX_RSP_SUCCESS,			"SUCCESS"		},
-	{ OBEX_RSP_CREATED,			"CREATED"		},
-	{ OBEX_RSP_ACCEPTED,			"ACCEPTED"		},
-	{ OBEX_RSP_NON_AUTHORITATIVE,		"NON_AUTHORITATIVE"	},
-	{ OBEX_RSP_NO_CONTENT,			"NO_CONTENT"		},
-	{ OBEX_RSP_RESET_CONTENT,		"RESET_CONTENT"		},
-	{ OBEX_RSP_PARTIAL_CONTENT,		"PARTIAL_CONTENT"	},
-	{ OBEX_RSP_MULTIPLE_CHOICES,		"MULTIPLE_CHOICES"	},
-	{ OBEX_RSP_MOVED_PERMANENTLY,		"MOVED_PERMANENTLY"	},
-	{ OBEX_RSP_MOVED_TEMPORARILY,		"MOVED_TEMPORARILY"	},
-	{ OBEX_RSP_SEE_OTHER,			"SEE_OTHER"		},
-	{ OBEX_RSP_NOT_MODIFIED,		"NOT_MODIFIED"		},
-	{ OBEX_RSP_USE_PROXY,			"USE_PROXY"		},
-	{ OBEX_RSP_BAD_REQUEST,			"BAD_REQUEST"		},
-	{ OBEX_RSP_UNAUTHORIZED,		"UNAUTHORIZED"		},
-	{ OBEX_RSP_PAYMENT_REQUIRED,		"PAYMENT_REQUIRED"	},
-	{ OBEX_RSP_FORBIDDEN,			"FORBIDDEN"		},
-	{ OBEX_RSP_NOT_FOUND,			"NOT_FOUND"		},
-	{ OBEX_RSP_METHOD_NOT_ALLOWED,		"METHOD_NOT_ALLOWED"	},
-	{ OBEX_RSP_NOT_ACCEPTABLE,		"NOT_ACCEPTABLE"	},
-	{ OBEX_RSP_PROXY_AUTH_REQUIRED,		"PROXY_AUTH_REQUIRED"	},
-	{ OBEX_RSP_REQUEST_TIME_OUT,		"REQUEST_TIME_OUT"	},
-	{ OBEX_RSP_CONFLICT,			"CONFLICT"		},
-	{ OBEX_RSP_GONE,			"GONE"			},
-	{ OBEX_RSP_LENGTH_REQUIRED,		"LENGTH_REQUIRED"	},
-	{ OBEX_RSP_PRECONDITION_FAILED,		"PRECONDITION_FAILED"	},
-	{ OBEX_RSP_REQ_ENTITY_TOO_LARGE,	"REQ_ENTITY_TOO_LARGE"	},
-	{ OBEX_RSP_REQ_URL_TOO_LARGE,		"REQ_URL_TOO_LARGE"	},
-	{ OBEX_RSP_UNSUPPORTED_MEDIA_TYPE,	"UNSUPPORTED_MEDIA_TYPE"},
-	{ OBEX_RSP_INTERNAL_SERVER_ERROR,	"INTERNAL_SERVER_ERROR"	},
-	{ OBEX_RSP_NOT_IMPLEMENTED,		"NOT_IMPLEMENTED"	},
-	{ OBEX_RSP_BAD_GATEWAY,			"BAD_GATEWAY"		},
-	{ OBEX_RSP_SERVICE_UNAVAILABLE,		"SERVICE_UNAVAILABLE"	},
-	{ OBEX_RSP_GATEWAY_TIMEOUT,		"GATEWAY_TIMEOUT"	},
-	{ OBEX_RSP_VERSION_NOT_SUPPORTED,	"VERSION_NOT_SUPPORTED"	},
-	{ OBEX_RSP_DATABASE_FULL,		"DATABASE_FULL"		},
-	{ OBEX_RSP_DATABASE_LOCKED,		"DATABASE_LOCKED"	},
+	{ G_OBEX_RSP_CONTINUE,			"CONTINUE"		},
+	{ G_OBEX_RSP_SUCCESS,			"SUCCESS"		},
+	{ G_OBEX_RSP_CREATED,			"CREATED"		},
+	{ G_OBEX_RSP_ACCEPTED,			"ACCEPTED"		},
+	{ G_OBEX_RSP_NON_AUTHORITATIVE,		"NON_AUTHORITATIVE"	},
+	{ G_OBEX_RSP_NO_CONTENT,		"NO_CONTENT"		},
+	{ G_OBEX_RSP_RESET_CONTENT,		"RESET_CONTENT"		},
+	{ G_OBEX_RSP_PARTIAL_CONTENT,		"PARTIAL_CONTENT"	},
+	{ G_OBEX_RSP_MULTIPLE_CHOICES,		"MULTIPLE_CHOICES"	},
+	{ G_OBEX_RSP_MOVED_PERMANENTLY,		"MOVED_PERMANENTLY"	},
+	{ G_OBEX_RSP_MOVED_TEMPORARILY,		"MOVED_TEMPORARILY"	},
+	{ G_OBEX_RSP_SEE_OTHER,			"SEE_OTHER"		},
+	{ G_OBEX_RSP_NOT_MODIFIED,		"NOT_MODIFIED"		},
+	{ G_OBEX_RSP_USE_PROXY,			"USE_PROXY"		},
+	{ G_OBEX_RSP_BAD_REQUEST,		"BAD_REQUEST"		},
+	{ G_OBEX_RSP_UNAUTHORIZED,		"UNAUTHORIZED"		},
+	{ G_OBEX_RSP_PAYMENT_REQUIRED,		"PAYMENT_REQUIRED"	},
+	{ G_OBEX_RSP_FORBIDDEN,			"FORBIDDEN"		},
+	{ G_OBEX_RSP_NOT_FOUND,			"NOT_FOUND"		},
+	{ G_OBEX_RSP_METHOD_NOT_ALLOWED,	"METHOD_NOT_ALLOWED"	},
+	{ G_OBEX_RSP_NOT_ACCEPTABLE,		"NOT_ACCEPTABLE"	},
+	{ G_OBEX_RSP_PROXY_AUTH_REQUIRED,	"PROXY_AUTH_REQUIRED"	},
+	{ G_OBEX_RSP_REQUEST_TIME_OUT,		"REQUEST_TIME_OUT"	},
+	{ G_OBEX_RSP_CONFLICT,			"CONFLICT"		},
+	{ G_OBEX_RSP_GONE,			"GONE"			},
+	{ G_OBEX_RSP_LENGTH_REQUIRED,		"LENGTH_REQUIRED"	},
+	{ G_OBEX_RSP_PRECONDITION_FAILED,	"PRECONDITION_FAILED"	},
+	{ G_OBEX_RSP_REQ_ENTITY_TOO_LARGE,	"REQ_ENTITY_TOO_LARGE"	},
+	{ G_OBEX_RSP_REQ_URL_TOO_LARGE,		"REQ_URL_TOO_LARGE"	},
+	{ G_OBEX_RSP_UNSUPPORTED_MEDIA_TYPE,	"UNSUPPORTED_MEDIA_TYPE"},
+	{ G_OBEX_RSP_INTERNAL_SERVER_ERROR,	"INTERNAL_SERVER_ERROR"	},
+	{ G_OBEX_RSP_NOT_IMPLEMENTED,		"NOT_IMPLEMENTED"	},
+	{ G_OBEX_RSP_BAD_GATEWAY,		"BAD_GATEWAY"		},
+	{ G_OBEX_RSP_SERVICE_UNAVAILABLE,	"SERVICE_UNAVAILABLE"	},
+	{ G_OBEX_RSP_GATEWAY_TIMEOUT,		"GATEWAY_TIMEOUT"	},
+	{ G_OBEX_RSP_VERSION_NOT_SUPPORTED,	"VERSION_NOT_SUPPORTED"	},
+	{ G_OBEX_RSP_DATABASE_FULL,		"DATABASE_FULL"		},
+	{ G_OBEX_RSP_DATABASE_LOCKED,		"DATABASE_LOCKED"	},
 	{ 0xFF,					NULL			},
 };
 
-static void print_event(int evt, int cmd, int rsp)
+static gboolean handle_async_io(void *object, int flags, int err,
+						void *user_data);
+
+static void print_event(int cmd, int rsp)
 {
-	const char *evtstr = NULL, *cmdstr = NULL, *rspstr = NULL;
+	const char *cmdstr = NULL, *rspstr = NULL;
 	int i;
-	static int lastevt, lastcmd;
-
-	if (evt < 0)
-		evt = lastevt;
-	else
-		lastevt = evt;
+	static int lastcmd;
 
 	if (cmd < 0)
 		cmd = lastcmd;
 	else
 		lastcmd = cmd;
 
-	for (i = 0; obex_event[i].evt != 0xFF; i++) {
-		if (obex_event[i].evt != evt)
-			continue;
-		evtstr = obex_event[i].name;
-	}
-
 	for (i = 0; obex_command[i].cmd != 0xFF; i++) {
 		if (obex_command[i].cmd != cmd)
 			continue;
@@ -222,54 +167,44 @@ static void print_event(int evt, int cmd, int rsp)
 		rspstr = obex_response[i].name;
 	}
 
-	obex_debug("%s(0x%x), %s(0x%x), %s(0x%x)", evtstr, evt, cmdstr, cmd,
-								rspstr, rsp);
+	obex_debug("%s(0x%x), %s(0x%x)", cmdstr, cmd, rspstr, rsp);
 }
 
-static void os_set_response(obex_object_t *obj, int err)
+static void os_set_response(struct obex_session *os, int err)
 {
 	uint8_t rsp;
-	uint8_t lastrsp;
 
 	switch (err) {
 	case 0:
-		rsp = OBEX_RSP_CONTINUE;
-		lastrsp = OBEX_RSP_SUCCESS;
+		rsp = G_OBEX_RSP_SUCCESS;
 		break;
 	case -EPERM:
 	case -EACCES:
-		rsp = OBEX_RSP_FORBIDDEN;
-		lastrsp = OBEX_RSP_FORBIDDEN;
+		rsp = G_OBEX_RSP_FORBIDDEN;
 		break;
 	case -ENOENT:
-		rsp = OBEX_RSP_NOT_FOUND;
-		lastrsp = OBEX_RSP_NOT_FOUND;
+		rsp = G_OBEX_RSP_NOT_FOUND;
 		break;
 	case -EBADR:
-		rsp = OBEX_RSP_BAD_REQUEST;
-		lastrsp = OBEX_RSP_BAD_REQUEST;
+		rsp = G_OBEX_RSP_BAD_REQUEST;
 		break;
 	case -EFAULT:
-		rsp = OBEX_RSP_SERVICE_UNAVAILABLE;
-		lastrsp = OBEX_RSP_SERVICE_UNAVAILABLE;
+		rsp = G_OBEX_RSP_SERVICE_UNAVAILABLE;
 		break;
 	case -EINVAL:
-		rsp = OBEX_RSP_NOT_IMPLEMENTED;
-		lastrsp = OBEX_RSP_NOT_IMPLEMENTED;
+		rsp = G_OBEX_RSP_NOT_IMPLEMENTED;
 		break;
 	case -ENOTEMPTY:
 	case -EEXIST:
-		rsp = OBEX_RSP_PRECONDITION_FAILED;
-		lastrsp = OBEX_RSP_PRECONDITION_FAILED;
+		rsp = G_OBEX_RSP_PRECONDITION_FAILED;
 		break;
 	default:
-		rsp = OBEX_RSP_INTERNAL_SERVER_ERROR;
-		lastrsp = OBEX_RSP_INTERNAL_SERVER_ERROR;
+		rsp = G_OBEX_RSP_INTERNAL_SERVER_ERROR;
 	}
 
-	print_event(-1, -1, rsp);
+	print_event(-1, rsp);
 
-	OBEX_ObjectSetRsp(obj, rsp, lastrsp);
+	g_obex_send_rsp(os->obex, rsp, NULL, G_OBEX_HDR_INVALID);
 }
 
 static void os_session_mark_aborted(struct obex_session *os)
@@ -288,7 +223,7 @@ static void os_reset_session(struct obex_session *os)
 	if (os->object) {
 		os->driver->set_io_watch(os->object, NULL, NULL);
 		os->driver->close(os->object);
-		if (os->aborted && os->cmd == OBEX_CMD_PUT && os->path &&
+		if (os->aborted && os->cmd == G_OBEX_OP_PUT && os->path &&
 				os->driver->remove)
 			os->driver->remove(os->path);
 	}
@@ -318,16 +253,18 @@ static void os_reset_session(struct obex_session *os)
 		os->apparam_len = 0;
 	}
 
+	if (os->get_rsp > 0) {
+		g_obex_remove_request_function(os->obex, os->get_rsp);
+		os->get_rsp = 0;
+	}
+
 	os->object = NULL;
-	os->obj = NULL;
 	os->driver = NULL;
 	os->aborted = FALSE;
 	os->pending = 0;
 	os->offset = 0;
 	os->size = OBJECT_SIZE_DELETE;
 	os->headers_sent = FALSE;
-	os->stream_open = FALSE;
-	os->stream_suspended = FALSE;
 }
 
 static void obex_session_free(struct obex_session *os)
@@ -337,6 +274,9 @@ static void obex_session_free(struct obex_session *os)
 	if (os->io)
 		g_io_channel_unref(os->io);
 
+	if (os->obex)
+		g_obex_unref(os->obex);
+
 	g_free(os);
 }
 
@@ -434,195 +374,131 @@ static uint8_t *challenge_response(const uint8_t *nonce)
 	return result;
 }
 
-static void cmd_connect(struct obex_session *os,
-			obex_t *obex, obex_object_t *obj)
+static void parse_service(struct obex_session *os, GObexPacket *req)
 {
-	obex_connect_hdr_t *nonhdr;
-	obex_headerdata_t hd;
-	uint8_t *buffer;
-	unsigned int hlen, newsize;
-	uint16_t mtu;
-	uint8_t hi;
-	const uint8_t *target = NULL, *who = NULL, *nonce = NULL;
-	unsigned int target_size = 0, who_size = 0;
-	int err;
+	GObexHeader *hdr;
+	const guint8 *target = NULL, *who = NULL;
+	gsize target_size = 0, who_size = 0;
 
-	if (OBEX_ObjectGetNonHdrData(obj, &buffer) != sizeof(*nonhdr)) {
-		OBEX_ObjectSetRsp(obj, OBEX_RSP_FORBIDDEN, OBEX_RSP_FORBIDDEN);
-		DBG("Invalid OBEX CONNECT packet");
-		return;
-	}
-
-	nonhdr = (obex_connect_hdr_t *) buffer;
-	mtu = g_ntohs(nonhdr->mtu);
-	DBG("Version: 0x%02x. Flags: 0x%02x  OBEX packet length: %d",
-			nonhdr->version, nonhdr->flags, mtu);
-	/* Leave space for headers */
-	newsize = mtu - 200;
-
-	os->tx_mtu = newsize;
+	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_WHO);
+	if (hdr == NULL)
+		goto target;
 
-	DBG("Resizing stream chunks to %d", newsize);
+	g_obex_header_get_bytes(hdr, &who, &who_size);
 
-	/* connection id will be used to track the sessions, even for OPP */
-	os->cid = ++cid;
+target:
+	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_TARGET);
+	if (hdr == NULL)
+		goto probe;
 
-	while (OBEX_ObjectGetNextHeader(obex, obj, &hi, &hd, &hlen)) {
-		switch (hi) {
-		case OBEX_HDR_WHO:
-			who = hd.bs;
-			who_size = hlen;
-			break;
-		case OBEX_HDR_TARGET:
-			target = hd.bs;
-			target_size = hlen;
-			break;
-		case OBEX_HDR_AUTHCHAL:
-			if (nonce) {
-				DBG("Ignoring multiple challenge headers");
-				break;
-			}
-
-			nonce = extract_nonce(hd.bs, hlen);
-			DBG("AUTH CHALLENGE REQUEST");
-			break;
-		}
-	}
+	g_obex_header_get_bytes(hdr, &target, &target_size);
 
+probe:
 	os->service = obex_service_driver_find(os->server->drivers,
 						target, target_size,
 						who, who_size);
-	if (os->service == NULL) {
-		error("Connect attempt to a non-supported target");
-		OBEX_ObjectSetRsp(obj, OBEX_RSP_FORBIDDEN, OBEX_RSP_FORBIDDEN);
+}
 
+static void parse_authchal(struct obex_session *session, GObexPacket *req,
+							GObexPacket *rsp)
+{
+	GObexHeader *hdr;
+	const guint8 *data, *nonce = NULL;
+	gsize len;
+	uint8_t challenge[18];
+	struct auth_header *auth = (struct auth_header *) challenge;
+	uint8_t *response;
+
+	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_AUTHCHAL);
+	if (hdr == NULL)
 		return;
-	}
 
-	DBG("Selected driver: %s", os->service->name);
-
-	if (!os->service->connect) {
-		OBEX_ObjectSetRsp(obj, OBEX_RSP_FORBIDDEN, OBEX_RSP_FORBIDDEN);
+	if (!g_obex_header_get_bytes(hdr, &data, &len))
 		return;
-	}
-
-	os->service_data = os->service->connect(os, &err);
-	if (err == 0 && os->service->target) {
-		hd.bs = os->service->target;
-		OBEX_ObjectAddHeader(obex, obj,
-				OBEX_HDR_WHO, hd, os->service->target_size,
-				OBEX_FL_FIT_ONE_PACKET);
-		hd.bq4 = os->cid;
-		OBEX_ObjectAddHeader(obex, obj,
-				OBEX_HDR_CONNECTION, hd, 4,
-				OBEX_FL_FIT_ONE_PACKET);
-	}
-
-	if (err == 0 && nonce) {
-		uint8_t challenge[18];
-		struct auth_header *hdr = (struct auth_header *) challenge;
-		uint8_t *response = challenge_response(nonce);
 
-		hdr->tag = DIGEST_TAG;
-		hdr->len = NONCE_LEN;
-		memcpy(hdr->val, response, NONCE_LEN);
+	nonce = extract_nonce(data, len);
+	DBG("AUTH CHALLENGE REQUEST");
 
-		g_free(response);
+	response = challenge_response(nonce);
+	auth->tag = DIGEST_TAG;
+	auth->len = NONCE_LEN;
+	memcpy(auth->val, response, NONCE_LEN);
 
-		hd.bs = challenge;
-		OBEX_ObjectAddHeader(obex, obj, OBEX_HDR_AUTHRESP, hd, 18, 0);
-	}
-
-	os_set_response(obj, err);
+	hdr = g_obex_header_new_bytes(G_OBEX_HDR_AUTHRESP, challenge,
+							sizeof(challenge));
+	g_obex_packet_add_header(rsp, hdr);
 }
 
-static gboolean chk_cid(obex_t *obex, obex_object_t *obj, uint32_t cid)
+static void cmd_connect(GObex *obex, GObexPacket *req, void *user_data)
 {
-	struct obex_session *os;
-	obex_headerdata_t hd;
-	unsigned int hlen;
-	uint8_t hi;
-	gboolean ret = FALSE;
+	struct obex_session *os = user_data;
+	GObexPacket *rsp;
+	GObexHeader *hdr;
+	int err;
 
-	os = OBEX_GetUserData(obex);
+	DBG("");
 
-	/* Object Push doesn't provide a connection id. */
-	if (os->service->service == OBEX_OPP)
-		return TRUE;
+	print_event(G_OBEX_OP_CONNECT, -1);
 
-	while (OBEX_ObjectGetNextHeader(obex, obj, &hi, &hd, &hlen)) {
-		if (hi == OBEX_HDR_CONNECTION && hlen == 4) {
-			ret = (hd.bq4 == cid ? TRUE : FALSE);
-			break;
-		}
+	parse_service(os, req);
+
+	if (os->service == NULL || os->service->connect == NULL) {
+		error("Connect attempt to a non-supported target");
+		os_set_response(os, -EPERM);
+		return;
 	}
 
-	OBEX_ObjectReParseHeaders(obex, obj);
+	DBG("Selected driver: %s", os->service->name);
 
-	if (ret == FALSE)
-		OBEX_ObjectSetRsp(obj, OBEX_RSP_SERVICE_UNAVAILABLE,
-				OBEX_RSP_SERVICE_UNAVAILABLE);
+	os->service_data = os->service->connect(os, &err);
+	if (err < 0) {
+		os_set_response(os, err);
+		return;
+	}
 
-	return ret;
-}
+	rsp = g_obex_packet_new(G_OBEX_RSP_SUCCESS, TRUE, G_OBEX_HDR_INVALID);
 
-static int obex_read_stream(struct obex_session *os, obex_t *obex,
-						obex_object_t *obj)
-{
-	int size;
-	ssize_t len = 0;
-	const uint8_t *buffer;
+	parse_authchal(os, req, rsp);
 
-	DBG("name=%s type=%s rx_mtu=%d file=%p",
-		os->name ? os->name : "", os->type ? os->type : "",
-		os->rx_mtu, os->object);
+	if (os->service->target) {
+		hdr = g_obex_header_new_bytes(G_OBEX_HDR_WHO,
+						os->service->target,
+						os->service->target_size);
+		g_obex_packet_add_header(rsp, hdr);
+	}
 
-	if (os->aborted)
-		return -EPERM;
+	g_obex_send(obex, rsp, NULL);
 
-	/* workaround: client didn't send the object lenght */
-	if (os->size == OBJECT_SIZE_DELETE)
-		os->size = OBJECT_SIZE_UNKNOWN;
+	print_event(-1, 0);
+}
 
-	/* If there's something to write and we are able to write it */
-	if (os->pending > 0 && os->driver && os->object)
-		goto write;
+static void cmd_disconnect(GObex *obex, GObexPacket *req, void *user_data)
+{
+	struct obex_session *os = user_data;
 
-	size = OBEX_ObjectReadStream(obex, obj, &buffer);
-	if (size < 0) {
-		error("Error on OBEX stream");
-		return -EIO;
-	}
+	DBG("session %p", os);
 
-	if (size > os->rx_mtu) {
-		error("Received more data than RX_MAX");
-		return -EIO;
-	}
+	print_event(G_OBEX_OP_DISCONNECT, -1);
 
-	os->buf = g_realloc(os->buf, os->pending + size);
-	memcpy(os->buf + os->pending, buffer, size);
-	os->pending += size;
+	os_set_response(os, 0);
+}
 
-	/* only write if both object and driver are valid */
-	if (os->object == NULL || os->driver == NULL) {
-		DBG("Stored %" PRIu64 " bytes into temporary buffer",
-								os->pending);
-		return 0;
-	}
+static ssize_t driver_write(struct obex_session *os)
+{
+	ssize_t len = 0;
 
-write:
 	while (os->pending > 0) {
 		ssize_t w;
 
-		w = os->driver->write(os->object, os->buf + len,
-					os->pending);
+		w = os->driver->write(os->object, os->buf + len, os->pending);
 		if (w < 0) {
+			error("write(): %s (%zd)", strerror(-w), -w);
 			if (w == -EINTR)
 				continue;
-			else {
+			else if (w == -EINVAL)
 				memmove(os->buf, os->buf + len, os->pending);
-				return w;
-			}
+
+			return w;
 		}
 
 		len += w;
@@ -630,71 +506,103 @@ write:
 		os->pending -= w;
 	}
 
-	return 0;
-}
+	DBG("%zd written", len);
 
-static int obex_write_stream(struct obex_session *os,
-			obex_t *obex, obex_object_t *obj)
-{
-	obex_headerdata_t hd;
-	ssize_t len;
+	if (os->service->progress != NULL)
+		os->service->progress(os, os->service_data);
 
-	DBG("name=%s type=%s tx_mtu=%d file=%p",
-		os->name ? os->name : "", os->type ? os->type : "",
-		os->tx_mtu, os->object);
+	return len;
+}
 
-	if (os->aborted)
-		return -EPERM;
+static gssize driver_read(struct obex_session *os, void *buf, gsize size)
+{
+	gssize len;
 
 	if (os->object == NULL)
 		return -EIO;
 
-	len = os->driver->read(os->object, os->buf, os->tx_mtu);
+	if (os->service->progress != NULL)
+		os->service->progress(os, os->service_data);
+
+	len = os->driver->read(os->object, buf, size);
 	if (len < 0) {
 		error("read(): %s (%zd)", strerror(-len), -len);
+		if (len == -ENOSTR)
+			return 0;
 		if (len == -EAGAIN)
-			return len;
+			os->driver->set_io_watch(os->object, handle_async_io,
+									os);
+	}
 
-		g_free(os->buf);
-		os->buf = NULL;
+	os->offset += len;
 
-		if (len == -ENOSTR)
-			return 0;
+	DBG("%zd read", len);
 
-		return len;
-	}
+	return len;
+}
+
+static gssize send_data(void *buf, gsize size, gpointer user_data)
+{
+	struct obex_session *os = user_data;
+
+	DBG("name=%s type=%s file=%p size=%zu", os->name, os->type, os->object,
+									size);
 
-	if (!os->stream_open) {
-		hd.bs = NULL;
-		OBEX_ObjectAddHeader(obex, obj, OBEX_HDR_BODY, hd, 0,
-						OBEX_FL_STREAM_START);
-		os->stream_open = TRUE;
+	if (os->aborted)
+		return -EPERM;
+
+	return driver_read(os, buf, size);
+}
+
+static void transfer_complete(GObex *obex, GError *err, gpointer user_data)
+{
+	struct obex_session *os = user_data;
+
+	DBG("");
+
+	if (err != NULL) {
+		error("transfer failed: %s\n", err->message);
+		return;
 	}
 
-	if (len == 0) {
-		hd.bs = NULL;
-		OBEX_ObjectAddHeader(obex, obj, OBEX_HDR_BODY, hd, 0,
-						OBEX_FL_STREAM_DATAEND);
-		g_free(os->buf);
-		os->buf = NULL;
+	if (os->object && os->driver && os->driver->flush) {
+		if (os->driver->flush(os->object) == -EAGAIN) {
+			g_obex_suspend(os->obex);
+			os->driver->set_io_watch(os->object, handle_async_io,
+									os);
+		}
 	}
+}
 
-	hd.bs = os->buf;
-	OBEX_ObjectAddHeader(obex, obj, OBEX_HDR_BODY, hd, len,
-						OBEX_FL_STREAM_DATA);
+static void cmd_get_rsp(GObex *obex, GObexPacket *req, gpointer user_data)
+{
+	struct obex_session *os = user_data;
 
-	return 0;
+	DBG("");
+
+	print_event(G_OBEX_OP_GET, -1);
+
+	if (os->size != OBJECT_SIZE_UNKNOWN && os->size < UINT32_MAX)
+		g_obex_get_rsp(os->obex, send_data, transfer_complete,
+						os, NULL,
+						G_OBEX_HDR_LENGTH, os->size,
+						G_OBEX_HDR_INVALID);
+	else
+		g_obex_get_rsp(os->obex, send_data, transfer_complete,
+						os, NULL,
+						G_OBEX_HDR_INVALID);
+
+	print_event(G_OBEX_OP_GET, G_OBEX_RSP_CONTINUE);
 }
 
-static int obex_write(struct obex_session *os, obex_t *obex, obex_object_t *obj)
+static gssize driver_get_headers(struct obex_session *os)
 {
-	obex_headerdata_t hd;
-	ssize_t len;
-	uint8_t hi;
+	GObexPacket *rsp;
+	gssize len, total = 0;
+	guint8 data[255];
+	guint8 id;
 
-	DBG("name=%s type=%s tx_mtu=%d file=%p",
-		os->name ? os->name : "", os->type ? os->type : "",
-		os->tx_mtu, os->object);
+	DBG("name=%s type=%s object=%p", os->name, os->type, os->object);
 
 	if (os->aborted)
 		return -EPERM;
@@ -703,17 +611,24 @@ static int obex_write(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 		return -EIO;
 
 	if (os->headers_sent)
-		return obex_write_stream(os, obex, obj);
+		return 0;
+
+	if (os->driver->get_next_header == NULL) {
+		os->headers_sent = TRUE;
+		return 0;
+	}
 
-	if (!os->driver->get_next_header)
-		goto skip;
+	rsp = g_obex_packet_new(G_OBEX_RSP_CONTINUE, TRUE, G_OBEX_HDR_INVALID);
+	while ((len = os->driver->get_next_header(os->object, &data,
+							sizeof(data), &id))) {
+		GObexHeader *hdr;
 
-	while ((len = os->driver->get_next_header(os->object, os->buf,
-					os->tx_mtu, &hi)) != 0) {
 		if (len < 0) {
 			error("get_next_header(): %s (%zd)", strerror(-len),
 								-len);
 
+			g_obex_packet_free(rsp);
+
 			if (len == -EAGAIN)
 				return len;
 
@@ -723,218 +638,231 @@ static int obex_write(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 			return len;
 		}
 
-		hd.bs = os->buf;
-		OBEX_ObjectAddHeader(obex, obj, hi, hd, len, 0);
+		hdr = g_obex_header_new_bytes(id, data, len);
+		g_obex_packet_add_header(rsp, hdr);
+		total += len;
 	}
 
-skip:
+	if (total == 0) {
+		g_obex_packet_free(rsp);
+		return 0;
+	}
+
+	g_obex_send(os->obex, rsp, NULL);
+
+	os->get_rsp = g_obex_add_request_function(os->obex, G_OBEX_OP_GET,
+							cmd_get_rsp, os);
+
 	os->headers_sent = TRUE;
 
-	return obex_write_stream(os, obex, obj);
+	print_event(-1, G_OBEX_RSP_CONTINUE);
+
+	return total;
 }
 
 static gboolean handle_async_io(void *object, int flags, int err,
 						void *user_data)
 {
 	struct obex_session *os = user_data;
-	int ret = 0;
 
-	if (err < 0) {
-		ret = err;
-		goto proceed;
-	}
-
-	if (flags & (G_IO_IN | G_IO_PRI))
-		ret = obex_write(os, os->obex, os->obj);
-	else if ((flags & G_IO_OUT) && os->pending > 0)
-		ret = obex_read_stream(os, os->obex, os->obj);
+	if (err < 0)
+		goto done;
 
-proceed:
-	os->stream_suspended = FALSE;
+	if (flags & G_IO_OUT)
+		err = driver_write(os);
+	if ((flags & G_IO_IN) && !os->headers_sent)
+		err = driver_get_headers(os);
 
-	if (ret == -EAGAIN) {
+	if (err == -EAGAIN)
 		return TRUE;
-	} else if (ret < 0) {
-		os_set_response(os->obj, ret);
-		OBEX_CancelRequest(os->obex, TRUE);
-	} else {
-		OBEX_ResumeRequest(os->obex);
-	}
 
-	return os->stream_suspended;
+done:
+	if (err < 0)
+		os_set_response(os, err);
+
+	g_obex_resume(os->obex);
+
+	return FALSE;
 }
 
-static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
+static gboolean recv_data(const void *buf, gsize size, gpointer user_data)
 {
-	obex_headerdata_t hd;
-	unsigned int hlen;
-	uint8_t hi;
-	int err;
+	struct obex_session *os = user_data;
+	ssize_t ret;
 
-	if (!os->service) {
-		OBEX_ObjectSetRsp(obj, OBEX_RSP_FORBIDDEN, OBEX_RSP_FORBIDDEN);
-		return;
-	} else if (!os->service->get) {
-		OBEX_ObjectSetRsp(obj, OBEX_RSP_NOT_IMPLEMENTED,
-				OBEX_RSP_NOT_IMPLEMENTED);
-		return;
+	DBG("name=%s type=%s file=%p size=%zu", os->name, os->type, os->object,
+									size);
+
+	if (os->aborted)
+		return FALSE;
+
+	/* workaround: client didn't send the object lenght */
+	if (os->size == OBJECT_SIZE_DELETE)
+		os->size = OBJECT_SIZE_UNKNOWN;
+
+	os->buf = g_realloc(os->buf, os->pending + size);
+	memcpy(os->buf + os->pending, buf, size);
+	os->pending += size;
+
+	/* only write if both object and driver are valid */
+	if (os->object == NULL || os->driver == NULL) {
+		DBG("Stored %" PRIu64 " bytes into temporary buffer",
+								os->pending);
+		return TRUE;
 	}
 
-	g_return_if_fail(chk_cid(obex, obj, os->cid));
+	ret = driver_write(os);
+	if (ret >= 0)
+		return TRUE;
 
-	os->headers_sent = FALSE;
-	os->stream_open = FALSE;
+	if (ret == -EAGAIN) {
+		g_obex_suspend(os->obex);
+		os->driver->set_io_watch(os->object, handle_async_io, os);
+		return TRUE;
+	}
 
-	while (OBEX_ObjectGetNextHeader(obex, obj, &hi, &hd, &hlen)) {
-		switch (hi) {
-		case OBEX_HDR_NAME:
-			if (os->name) {
-				DBG("Ignoring multiple name headers");
-				break;
-			}
+	return FALSE;
+}
 
-			if (hlen == 0)
-				continue;
+static void parse_type(struct obex_session *os, GObexPacket *req)
+{
+	GObexHeader *hdr;
+	const guint8 *type;
+	gsize len;
 
-			os->name = g_convert((const char *) hd.bs, hlen,
-					"UTF8", "UTF16BE", NULL, NULL, NULL);
-			DBG("OBEX_HDR_NAME: %s", os->name);
-			break;
-		case OBEX_HDR_TYPE:
-			if (os->type) {
-				DBG("Ignoring multiple type headers");
-				break;
-			}
+	g_free(os->type);
+	os->type = NULL;
 
-			if (hlen == 0)
-				continue;
+	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_TYPE);
+	if (hdr == NULL)
+		goto probe;
 
-			/* Ensure null termination */
-			if (hd.bs[hlen - 1] != '\0')
-				break;
+	if (!g_obex_header_get_bytes(hdr, &type, &len))
+		goto probe;
 
-			if (!g_utf8_validate((const char *) hd.bs, -1, NULL)) {
-				DBG("Invalid type header: %s", hd.bs);
-				break;
-			}
+	/* Ensure null termination */
+	if (type[len - 1] != '\0')
+		goto probe;
 
-			/* FIXME: x-obex/folder-listing - type is mandatory */
+	os->type = g_strndup((const char *) type, len);
+	DBG("TYPE: %s", os->type);
 
-			os->type = g_strndup((const char *) hd.bs, hlen);
-			DBG("OBEX_HDR_TYPE: %s", os->type);
-			os->driver = obex_mime_type_driver_find(
-						os->service->target,
+probe:
+	os->driver = obex_mime_type_driver_find(os->service->target,
 						os->service->target_size,
 						os->type,
 						os->service->who,
 						os->service->who_size);
-			break;
-		}
+}
 
-		if (hi == OBEX_HDR_APPARAM) {
-			os->apparam = g_memdup(hd.bs, hlen);
-			os->apparam_len = hlen;
-		}
-	}
+static void parse_name(struct obex_session *os, GObexPacket *req)
+{
+	GObexHeader *hdr;
+	const char *name;
 
-	if (os->type == NULL)
-		os->driver = obex_mime_type_driver_find(os->service->target,
-							os->service->target_size,
-							NULL,
-							os->service->who,
-							os->service->who_size);
+	g_free(os->name);
+	os->name = NULL;
 
-	if (!os->driver) {
-		error("No driver found");
-		OBEX_ObjectSetRsp(obj, OBEX_RSP_NOT_IMPLEMENTED,
-					OBEX_RSP_NOT_IMPLEMENTED);
+	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_NAME);
+	if (hdr == NULL)
 		return;
-	}
 
-	err = os->service->get(os, os->service_data);
+	if (!g_obex_header_get_unicode(hdr, &name))
+		return;
 
-	if (err < 0)
-		goto done;
+	os->name = g_strdup(name);
+	DBG("NAME: %s", os->name);
+}
 
-	if (os->size != OBJECT_SIZE_UNKNOWN && os->size < UINT32_MAX) {
-		hd.bq4 = os->size;
-		OBEX_ObjectAddHeader(obex, obj,
-				OBEX_HDR_LENGTH, hd, 4, 0);
-	}
+static void parse_apparam(struct obex_session *os, GObexPacket *req)
+{
+	GObexHeader *hdr;
+	const guint8 *apparam;
+	gsize len;
 
-	/* Add body header */
-	hd.bs = NULL;
-	if (os->size == 0) {
-		OBEX_ObjectAddHeader(obex, obj, OBEX_HDR_BODY, hd, 0,
-						OBEX_FL_FIT_ONE_PACKET);
-		goto done;
-	}
+	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_APPARAM);
+	if (hdr == NULL)
+		return;
 
-	/* Try to write to stream and suspend the stream immediately
-	 * if no data available to send. */
-	err = obex_write(os, obex, obj);
-	if (err == -EAGAIN) {
-		OBEX_SuspendRequest(obex, obj);
-		os->obj = obj;
-		os->driver->set_io_watch(os->object, handle_async_io, os);
+	if (!g_obex_header_get_bytes(hdr, &apparam, &len))
 		return;
-	}
 
-done:
-	os_set_response(obj, err);
+	os->apparam = g_memdup(apparam, len);
+	os->apparam_len = len;
+	DBG("APPARAM");
 }
 
-static void cmd_setpath(struct obex_session *os,
-			obex_t *obex, obex_object_t *obj)
+static void cmd_get(GObex *obex, GObexPacket *req, gpointer user_data)
 {
-	obex_headerdata_t hd;
-	uint32_t hlen;
+	struct obex_session *os = user_data;
 	int err;
-	uint8_t hi;
 
-	if (!os->service) {
-		OBEX_ObjectSetRsp(obj, OBEX_RSP_FORBIDDEN, OBEX_RSP_FORBIDDEN);
+	DBG("session %p", os);
+
+	print_event(G_OBEX_OP_GET, -1);
+
+	if (os->service == NULL) {
+		os_set_response(os, -EPERM);
 		return;
-	} else if (!os->service->setpath) {
-		OBEX_ObjectSetRsp(obj, OBEX_RSP_NOT_IMPLEMENTED,
-				OBEX_RSP_NOT_IMPLEMENTED);
+	}
+
+	if (os->service->get == NULL) {
+		os_set_response(os, -EINVAL);
 		return;
 	}
 
-	g_return_if_fail(chk_cid(obex, obj, os->cid));
+	os->headers_sent = FALSE;
 
-	if (os->name) {
-		g_free(os->name);
-		os->name = NULL;
+	if (os->type) {
+		g_free(os->type);
+		os->type = NULL;
 	}
 
-	while (OBEX_ObjectGetNextHeader(obex, obj, &hi, &hd, &hlen)) {
-		if (hi != OBEX_HDR_NAME)
-			continue;
+	parse_type(os, req);
 
-		if (os->name) {
-			DBG("Ignoring multiple name headers");
-			break;
-		}
+	if (!os->driver) {
+		error("No driver found");
+		os_set_response(os, -EINVAL);
+		return;
+	}
 
-		/* This is because OBEX_UnicodeToChar() accesses the string
-		 * even if its size is zero */
-		if (hlen == 0) {
-			os->name = g_strdup("");
-			break;
-		}
+	parse_name(os, req);
 
-		os->name = g_convert((const char *) hd.bs, hlen,
-				"UTF8", "UTF16BE", NULL, NULL, NULL);
+	parse_apparam(os, req);
 
-		DBG("Set path name: %s", os->name);
-		break;
+	err = os->service->get(os, os->service_data);
+	if (err == 0)
+		return;
+
+	os_set_response(os, err);
+}
+
+static void cmd_setpath(GObex *obex, GObexPacket *req, gpointer user_data)
+{
+	struct obex_session *os = user_data;
+	int err;
+
+	DBG("");
+
+	print_event(G_OBEX_OP_SETPATH, -1);
+
+	if (os->service == NULL) {
+		err = -EPERM;
+		goto done;
+	}
+
+	if (os->service->setpath == NULL) {
+		err = -EINVAL;
+		goto done;
 	}
 
-	os->nonhdr_len = OBEX_ObjectGetNonHdrData(obj, &os->nonhdr);
+	parse_name(os, req);
+
+	os->nonhdr = g_obex_packet_get_data(req, &os->nonhdr_len);
 
 	err = os->service->setpath(os, os->service_data);
-	os_set_response(obj, err);
+done:
+	os_set_response(os, err);
 }
 
 int obex_get_stream_start(struct obex_session *os, const char *filename)
@@ -954,8 +882,27 @@ int obex_get_stream_start(struct obex_session *os, const char *filename)
 	os->offset = 0;
 	os->size = size;
 
-	if (size > 0)
-		os->buf = g_malloc0(os->tx_mtu);
+	err = driver_get_headers(os);
+	if (err == -EAGAIN) {
+		g_obex_suspend(os->obex);
+		os->driver->set_io_watch(os->object, handle_async_io, os);
+		return 0;
+	} else if (err < 0) {
+		return err;
+	} else if (err > 0)
+		return 0;
+
+	if (os->size != OBJECT_SIZE_UNKNOWN && os->size < UINT32_MAX)
+		g_obex_get_rsp(os->obex, send_data, transfer_complete,
+						os, NULL,
+						G_OBEX_HDR_LENGTH, os->size,
+						G_OBEX_HDR_INVALID);
+	else
+		g_obex_get_rsp(os->obex, send_data, transfer_complete,
+						os, NULL,
+						G_OBEX_HDR_INVALID);
+
+	print_event(G_OBEX_OP_GET, G_OBEX_RSP_SUCCESS);
 
 	return 0;
 }
@@ -975,113 +922,49 @@ int obex_put_stream_start(struct obex_session *os, const char *filename)
 
 	os->path = g_strdup(filename);
 
-	if (!os->buf) {
-		DBG("PUT request checked, no buffered data");
-		return 0;
-	}
-
-	if (os->pending == 0)
-		return 0;
-
-	return obex_read_stream(os, os->obex, NULL);
+	return 0;
 }
 
-static gboolean check_put(obex_t *obex, obex_object_t *obj)
+static void parse_length(struct obex_session *os, GObexPacket *req)
 {
-	struct obex_session *os;
-	obex_headerdata_t hd;
-	unsigned int hlen;
-	uint8_t hi;
-	int ret;
-
-	os = OBEX_GetUserData(obex);
-
-	if (os->type) {
-		g_free(os->type);
-		os->type = NULL;
-	}
-
-	if (os->name) {
-		g_free(os->name);
-		os->name = NULL;
-	}
-
-	while (OBEX_ObjectGetNextHeader(obex, obj, &hi, &hd, &hlen)) {
-		switch (hi) {
-		case OBEX_HDR_NAME:
-			if (os->name) {
-				DBG("Ignoring multiple name headers");
-				break;
-			}
-
-			if (hlen == 0)
-				continue;
-
-			os->name = g_convert((const char *) hd.bs, hlen,
-					"UTF8", "UTF16BE", NULL, NULL, NULL);
-			DBG("OBEX_HDR_NAME: %s", os->name);
-			break;
-
-		case OBEX_HDR_TYPE:
-			if (os->type) {
-				DBG("Ignoring multiple type headers");
-				break;
-			}
+	GObexHeader *hdr;
+	guint32 size;
 
-			if (hlen == 0)
-				continue;
+	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_LENGTH);
+	if (hdr == NULL)
+		return;
 
-			/* Ensure null termination */
-			if (hd.bs[hlen - 1] != '\0')
-				break;
+	if (!g_obex_header_get_uint32(hdr, &size))
+		return;
 
-			if (!g_utf8_validate((const char *) hd.bs, -1, NULL)) {
-				DBG("Invalid type header: %s", hd.bs);
-				break;
-			}
+	os->size = size;
+	DBG("LENGTH: %" PRIu64, os->size);
+}
 
-			os->type = g_strndup((const char *) hd.bs, hlen);
-			DBG("OBEX_HDR_TYPE: %s", os->type);
-			os->driver = obex_mime_type_driver_find(
-						os->service->target,
-						os->service->target_size,
-						os->type,
-						os->service->who,
-						os->service->who_size);
-			break;
+static void parse_time(struct obex_session *os, GObexPacket *req)
+{
+	GObexHeader *hdr;
+	const guint8 *time;
+	gsize len;
 
-		case OBEX_HDR_BODY:
-			if (os->size < 0)
-				os->size = OBJECT_SIZE_UNKNOWN;
-			break;
+	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_TIME);
+	if (hdr == NULL)
+		return;
 
-		case OBEX_HDR_LENGTH:
-			os->size = hd.bq4;
-			DBG("OBEX_HDR_LENGTH: %" PRIu64, os->size);
-			break;
-		case OBEX_HDR_TIME:
-			os->time = parse_iso8610((const char *) hd.bs, hlen);
-			break;
-		}
-	}
 
-	OBEX_ObjectReParseHeaders(obex, obj);
+	if (!g_obex_header_get_bytes(hdr, &time, &len))
+		return;
 
-	if (os->type == NULL)
-		os->driver = obex_mime_type_driver_find(os->service->target,
-							os->service->target_size,
-							NULL,
-							os->service->who,
-							os->service->who_size);
+	os->time = parse_iso8610((const char *) time, len);
+	DBG("TIME: %s", ctime(&os->time));
+}
 
-	if (!os->driver) {
-		error("No driver found");
-		OBEX_ObjectSetRsp(obj, OBEX_RSP_NOT_IMPLEMENTED,
-					OBEX_RSP_NOT_IMPLEMENTED);
-		return FALSE;
-	}
+static gboolean check_put(GObex *obex, GObexPacket *req, void *user_data)
+{
+	struct obex_session *os = user_data;
+	int ret;
 
-	if (!os->service->chkput)
+	if (os->service->chkput == NULL)
 		goto done;
 
 	ret = os->service->chkput(os, os->service_data);
@@ -1089,20 +972,16 @@ static gboolean check_put(obex_t *obex, obex_object_t *obj)
 	case 0:
 		break;
 	case -EAGAIN:
-		OBEX_SuspendRequest(obex, obj);
-		os->obj = obj;
+		g_obex_suspend(os->obex);
 		os->driver->set_io_watch(os->object, handle_async_io, os);
 		return TRUE;
 	default:
-		os_set_response(obj, ret);
+		os_set_response(os, ret);
 		return FALSE;
-
 	}
 
-	if (os->size == OBJECT_SIZE_DELETE || os->size == OBJECT_SIZE_UNKNOWN) {
+	if (os->size == OBJECT_SIZE_DELETE || os->size == OBJECT_SIZE_UNKNOWN)
 		DBG("Got a PUT without a Length");
-		goto done;
-	}
 
 done:
 	os->checked = TRUE;
@@ -1110,351 +989,193 @@ done:
 	return TRUE;
 }
 
-static void cmd_put(struct obex_session *os, obex_t *obex, obex_object_t *obj)
+static void cmd_put(GObex *obex, GObexPacket *req, gpointer user_data)
 {
+	struct obex_session *os = user_data;
 	int err;
 
-	if (!os->service) {
-		OBEX_ObjectSetRsp(obj, OBEX_RSP_FORBIDDEN, OBEX_RSP_FORBIDDEN);
+	DBG("");
+
+	print_event(G_OBEX_OP_PUT, -1);
+
+	if (os->service == NULL) {
+		os_set_response(os, -EPERM);
+		return;
+	}
+
+	parse_type(os, req);
+
+	if (os->driver == NULL) {
+		error("No driver found");
+		os_set_response(os, -EINVAL);
 		return;
 	}
 
-	g_return_if_fail(chk_cid(obex, obj, os->cid));
+	parse_name(os, req);
+	parse_length(os, req);
+	parse_time(os, req);
 
 	if (!os->checked) {
-		if (!check_put(obex, obj))
+		if (!check_put(obex, req, user_data))
 			return;
 	}
 
-	if (!os->service->put) {
-		OBEX_ObjectSetRsp(obj, OBEX_RSP_NOT_IMPLEMENTED,
-				OBEX_RSP_NOT_IMPLEMENTED);
+	if (os->service->put == NULL) {
+		os_set_response(os, -EINVAL);
 		return;
 	}
 
 	err = os->service->put(os, os->service_data);
-	if (err < 0) {
-		os_set_response(obj, err);
+	if (err == 0) {
+		g_obex_put_rsp(obex, req, recv_data, transfer_complete, os,
+						NULL, G_OBEX_HDR_INVALID);
+		print_event(G_OBEX_OP_PUT, G_OBEX_RSP_CONTINUE);
 		return;
 	}
 
-	if (os->object && os->driver && os->driver->flush) {
-		err = os->driver->flush(os->object);
-		if (err == -EAGAIN) {
-			OBEX_SuspendRequest(obex, obj);
-			os->obj = obj;
-			os->driver->set_io_watch(os->object,
-							handle_async_io, os);
-		} else if (err < 0) {
-			os_set_response(obj, err);
-		}
-	}
+	os_set_response(os, err);
 }
 
-static void cmd_action(struct obex_session *os, obex_t *obex,
-							obex_object_t *obj)
+static void parse_destname(struct obex_session *os, GObexPacket *req)
 {
-	obex_headerdata_t hd;
-	unsigned int hlen;
-	uint8_t hi;
-	int err;
-
-	if (!os->service) {
-		OBEX_ObjectSetRsp(obj, OBEX_RSP_FORBIDDEN, OBEX_RSP_FORBIDDEN);
-		return;
-	} else if (!os->service->action) {
-		OBEX_ObjectSetRsp(obj, OBEX_RSP_NOT_IMPLEMENTED,
-				OBEX_RSP_NOT_IMPLEMENTED);
-		return;
-	}
+	GObexHeader *hdr;
+	const char *destname;
 
-	g_return_if_fail(chk_cid(obex, obj, os->cid));
+	g_free(os->destname);
+	os->destname = NULL;
 
-	if (os->name) {
-		g_free(os->name);
-		os->name = NULL;
-	}
-
-	if (os->destname) {
-		g_free(os->destname);
-		os->destname = NULL;
-	}
+	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_DESTNAME);
+	if (hdr == NULL)
+		return;
 
-	while (OBEX_ObjectGetNextHeader(obex, obj, &hi, &hd, &hlen)) {
-		switch (hi) {
-		case OBEX_HDR_NAME:
-			if (os->name) {
-				DBG("Ignoring multiple name headers");
-				break;
-			}
+	if (!g_obex_header_get_unicode(hdr, &destname))
+		return;
 
-			if (hlen == 0)
-				continue;
+	os->destname = g_strdup(destname);
+	DBG("DESTNAME: %s", os->destname);
+}
 
-			os->name = g_convert((const char *) hd.bs, hlen,
-					"UTF8", "UTF16BE", NULL, NULL, NULL);
-			DBG("OBEX_HDR_NAME: %s", os->name);
-			break;
+static void parse_action(struct obex_session *os, GObexPacket *req)
+{
+	GObexHeader *hdr;
+	guint8 id;
 
-		case OBEX_HDR_DESTNAME:
-			if (os->destname) {
-				DBG("Ignoring multiple destination headers");
-				break;
-			}
+	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_ACTION);
+	if (hdr == NULL)
+		return;
 
-			if (hlen == 0)
-				continue;
+	if (!g_obex_header_get_uint8(hdr, &id))
+		return;
 
-			os->destname = g_convert((const char *) hd.bs, hlen,
-					"UTF8", "UTF16BE", NULL, NULL, NULL);
-			DBG("OBEX_HDR_DESTNAME: %s", os->destname);
-			break;
+	os->action_id = id;
+	DBG("ACTION: 0x%02x", os->action_id);
+}
 
-		case OBEX_HDR_ACTION_ID:
-			if (hlen == 0)
-				continue;
+static void cmd_action(GObex *obex, GObexPacket *req, gpointer user_data)
+{
+	struct obex_session *os = user_data;
+	int err;
 
-			os->action_id = hd.bq1;
+	DBG("");
 
-			DBG("OBEX_HDR_ACTIONID: %u", os->action_id);
-			break;
+	print_event(G_OBEX_OP_ACTION, -1);
 
-		case OBEX_HDR_PERMISSIONS:
-			if (hlen == 0)
-				continue;
+	if (os->service == NULL) {
+		err = -EPERM;
+		goto done;
+	}
 
-			DBG("OBEX_HDR_PERMISSIONS: %d", hd.bq4);
-			break;
-		}
+	if (os->service->action == NULL) {
+		err = -EINVAL;
+		goto done;
 	}
 
+	parse_name(os, req);
+	parse_destname(os, req);
+	parse_action(os, req);
+
 	os->driver = obex_mime_type_driver_find(os->service->target,
 						os->service->target_size,
 						NULL,
 						os->service->who,
 						os->service->who_size);
-
-	if (!os->driver || !os->service->action) {
-		OBEX_ObjectSetRsp(obj, OBEX_RSP_NOT_IMPLEMENTED,
-				OBEX_RSP_NOT_IMPLEMENTED);
-		return;
+	if (os->driver == NULL) {
+		err = -EINVAL;
+		goto done;
 	}
 
 	err = os->service->action(os, os->service_data);
-	if (err < 0) {
-		os_set_response(obj, err);
-		return;
-	}
-
-	return;
+done:
+	os_set_response(os, err);
 }
 
-static void obex_event_cb(obex_t *obex, obex_object_t *obj, int mode,
-					int evt, int cmd, int rsp)
+static void cmd_abort(GObex *obex, GObexPacket *req, gpointer user_data)
 {
-	struct obex_session *os;
-	int err;
-
-	print_event(evt, cmd, rsp);
-
-	os = OBEX_GetUserData(obex);
+	struct obex_session *os = user_data;
 
-	switch (evt) {
-	case OBEX_EV_PROGRESS:
-		if (os->service && os->service->progress)
-			os->service->progress(os, os->service_data);
-		break;
-	case OBEX_EV_ABORT:
-		os->aborted = TRUE;
-		os_reset_session(os);
-		OBEX_ObjectSetRsp(obj, OBEX_RSP_SUCCESS, OBEX_RSP_SUCCESS);
-		break;
-	case OBEX_EV_REQDONE:
-		switch (cmd) {
-		case OBEX_CMD_CONNECT:
-			break;
-		case OBEX_CMD_DISCONNECT:
-			OBEX_TransportDisconnect(obex);
-			break;
-		case OBEX_CMD_PUT:
-		case OBEX_CMD_GET:
-		case OBEX_CMD_SETPATH:
-		default:
-			os_reset_session(os);
-			break;
-		}
-		break;
-	case OBEX_EV_REQHINT:
-		os->cmd = cmd;
-		switch (cmd) {
-		case OBEX_CMD_PUT:
-			os->checked = FALSE;
-			OBEX_ObjectReadStream(obex, obj, NULL);
-		case OBEX_CMD_GET:
-		case OBEX_CMD_SETPATH:
-		case OBEX_CMD_CONNECT:
-		case OBEX_CMD_DISCONNECT:
-		case OBEX_CMD_ACTION:
-			OBEX_ObjectSetRsp(obj, OBEX_RSP_CONTINUE,
-					OBEX_RSP_SUCCESS);
-			break;
-		default:
-			OBEX_ObjectSetRsp(obj, OBEX_RSP_NOT_IMPLEMENTED,
-					OBEX_RSP_NOT_IMPLEMENTED);
-			break;
-		}
-		break;
-	case OBEX_EV_REQCHECK:
-		switch (cmd) {
-		case OBEX_CMD_PUT:
-			if (os->service)
-				check_put(obex, obj);
-			break;
-		default:
-			break;
-		}
-		break;
-	case OBEX_EV_REQ:
-		switch (cmd) {
-		case OBEX_CMD_DISCONNECT:
-			break;
-		case OBEX_CMD_CONNECT:
-			cmd_connect(os, obex, obj);
-			break;
-		case OBEX_CMD_SETPATH:
-			cmd_setpath(os, obex, obj);
-			break;
-		case OBEX_CMD_GET:
-			cmd_get(os, obex, obj);
-			break;
-		case OBEX_CMD_PUT:
-			cmd_put(os, obex, obj);
-			break;
-		case OBEX_CMD_ACTION:
-			cmd_action(os, obex, obj);
-			break;
-		default:
-			DBG("Unknown request: 0x%X", cmd);
-			OBEX_ObjectSetRsp(obj, OBEX_RSP_NOT_IMPLEMENTED,
-						OBEX_RSP_NOT_IMPLEMENTED);
-			break;
-		}
-		break;
-	case OBEX_EV_STREAMAVAIL:
-		err = obex_read_stream(os, obex, obj);
-		if (err == -EAGAIN) {
-			OBEX_SuspendRequest(obex, obj);
-			os->obj = obj;
-			os->driver->set_io_watch(os->object, handle_async_io,
-									os);
-		} else if (err < 0)
-			os_set_response(obj, err);
+	DBG("");
 
-		break;
-	case OBEX_EV_STREAMEMPTY:
-		err = obex_write_stream(os, obex, obj);
-		if (err == -EAGAIN) {
-			OBEX_SuspendRequest(obex, obj);
-			os->stream_suspended = TRUE;
-			os->obj = obj;
-			os->driver->set_io_watch(os->object, handle_async_io,
-									os);
-		} else if (err < 0)
-			os_set_response(obj, err);
+	print_event(G_OBEX_OP_ABORT, -1);
 
-		break;
-	case OBEX_EV_LINKERR:
-		break;
-	case OBEX_EV_PARSEERR:
-		break;
-	case OBEX_EV_UNEXPECTED:
-		break;
+	os_reset_session(os);
 
-	default:
-		DBG("Unknown evt %d", evt);
-		break;
-	}
+	os_set_response(os, 0);
 }
 
-static void obex_handle_destroy(void *user_data)
+static void obex_session_destroy(struct obex_session *os)
 {
-	struct obex_session *os;
-	obex_t *obex = user_data;
-
 	DBG("");
 
-	os = OBEX_GetUserData(obex);
-
 	os_reset_session(os);
 
 	if (os->service && os->service->disconnect)
 		os->service->disconnect(os, os->service_data);
 
 	obex_session_free(os);
-
-	OBEX_Cleanup(obex);
 }
 
-static gboolean obex_handle_input(GIOChannel *io,
-				GIOCondition cond, void *user_data)
+static void disconn_func(GObex *obex, GError *err, gpointer user_data)
 {
-	obex_t *obex = user_data;
-
-	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
-		error("obex_handle_input: poll event %s%s%s",
-				(cond & G_IO_HUP) ? "HUP " : "",
-				(cond & G_IO_ERR) ? "ERR " : "",
-				(cond & G_IO_NVAL) ? "NVAL " : "");
-		return FALSE;
-	}
-
-	if (OBEX_HandleInput(obex, 1) < 0) {
-		error("Handle input error");
-		return FALSE;
-	}
+	struct obex_session *os = user_data;
 
-	return TRUE;
+	error("disconnected: %s\n", err ? err->message : "<no err>");
+	obex_session_destroy(os);
 }
 
 int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,
 			struct obex_server *server)
 {
 	struct obex_session *os;
-	obex_t *obex;
-	int ret, fd;
+	GObex *obex;
+	static uint32_t id = 0;
+
+	DBG("");
 
 	os = g_new0(struct obex_session, 1);
+	os->id = ++id;
 
 	os->service = obex_service_driver_find(server->drivers, NULL,
 							0, NULL, 0);
 	os->server = server;
-	os->rx_mtu = rx_mtu != 0 ? rx_mtu : DEFAULT_RX_MTU;
-	os->tx_mtu = tx_mtu != 0 ? tx_mtu : DEFAULT_TX_MTU;
 	os->size = OBJECT_SIZE_DELETE;
 
-	obex = OBEX_Init(OBEX_TRANS_FD, obex_event_cb, 0);
+	obex = g_obex_new(io, G_OBEX_TRANSPORT_STREAM, rx_mtu, tx_mtu);
 	if (!obex) {
 		obex_session_free(os);
 		return -EIO;
 	}
 
-	OBEX_SetUserData(obex, os);
-	os->obex = obex;
-
-	OBEX_SetTransportMTU(obex, os->rx_mtu, os->tx_mtu);
-
-	fd = g_io_channel_unix_get_fd(io);
-
-	ret = FdOBEX_TransportSetup(obex, fd, fd, 0);
-	if (ret < 0) {
-		obex_session_free(os);
-		OBEX_Cleanup(obex);
-		return ret;
-	}
+	g_obex_set_disconnect_function(obex, disconn_func, os);
+	g_obex_add_request_function(obex, G_OBEX_OP_CONNECT, cmd_connect, os);
+	g_obex_add_request_function(obex, G_OBEX_OP_DISCONNECT, cmd_disconnect,
+									os);
+	g_obex_add_request_function(obex, G_OBEX_OP_PUT, cmd_put, os);
+	g_obex_add_request_function(obex, G_OBEX_OP_GET, cmd_get, os);
+	g_obex_add_request_function(obex, G_OBEX_OP_SETPATH, cmd_setpath, os);
+	g_obex_add_request_function(obex, G_OBEX_OP_ACTION, cmd_action, os);
+	g_obex_add_request_function(obex, G_OBEX_OP_ABORT, cmd_abort, os);
 
-	g_io_add_watch_full(io, G_PRIORITY_DEFAULT,
-			G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-			obex_handle_input, obex, obex_handle_destroy);
+	os->obex = obex;
 	os->io = g_io_channel_ref(io);
 
 	sessions = g_slist_prepend(sessions, os);
diff --git a/src/server.c b/src/server.c
index f91a622..e5dc22d 100644
--- a/src/server.c
+++ b/src/server.c
@@ -33,10 +33,10 @@
 #include <fcntl.h>
 #include <errno.h>
 #include <string.h>
+#include <inttypes.h>
 
 #include <glib.h>
-
-#include <openobex/obex.h>
+#include <gobex.h>
 
 #include "log.h"
 #include "obex.h"
-- 
1.7.7.3

