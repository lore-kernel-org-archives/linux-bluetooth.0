Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/4] Add initial support for OBEX Action command
Date: Fri, 17 Jun 2011 09:26:44 +0300
Message-Id: <1308292007-2111-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/mimetype.h  |    2 +
 src/obex-priv.h |    2 +
 src/obex.c      |  142 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/obex.h      |    6 ++
 src/service.h   |    2 +
 5 files changed, 154 insertions(+), 0 deletions(-)

diff --git a/src/mimetype.h b/src/mimetype.h
index 8472684..f3a2b34 100644
--- a/src/mimetype.h
+++ b/src/mimetype.h
@@ -36,6 +36,8 @@ struct obex_mime_type_driver {
 	ssize_t (*read) (void *object, void *buf, size_t count, uint8_t *hi);
 	ssize_t (*write) (void *object, const void *buf, size_t count);
 	int (*flush) (void *object);
+	int (*copy) (const char *name, const char *destname);
+	int (*move) (const char *name, const char *destname);
 	int (*remove) (const char *name);
 	int (*set_io_watch) (void *object, obex_object_io_func func,
 				void *user_data);
diff --git a/src/obex-priv.h b/src/obex-priv.h
index 0caa0dd..8fcd5d1 100644
--- a/src/obex-priv.h
+++ b/src/obex-priv.h
@@ -28,7 +28,9 @@ struct obex_session {
 	uint16_t tx_mtu;
 	uint16_t rx_mtu;
 	uint8_t cmd;
+	uint8_t action_id;
 	char *name;
+	char *destname;
 	char *type;
 	char *path;
 	time_t time;
diff --git a/src/obex.c b/src/obex.c
index e6585ca..49d9c18 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -52,6 +52,13 @@
 #include "transport.h"
 #include "btio.h"
 
+#ifndef OBEX_CMD_ACTION
+#define OBEX_CMD_ACTION 0x06
+#define OBEX_HDR_ACTION_ID 0x94
+#define OBEX_HDR_DESTNAME 0x15
+#define OBEX_HDR_PERMISSIONS 0xD6
+#endif /* OBEX_CMD_ACTION */
+
 /* Default MTU's */
 #define DEFAULT_RX_MTU 32767
 #define DEFAULT_TX_MTU 32767
@@ -128,6 +135,7 @@ static struct {
 	{ OBEX_CMD_SETPATH,	"SETPATH"	},
 	{ OBEX_CMD_SESSION,	"SESSION"	},
 	{ OBEX_CMD_ABORT,	"ABORT"		},
+	{ OBEX_CMD_ACTION,	"ACTION"	},
 	{ OBEX_FINAL,		"FINAL"		},
 	{ 0xFF,			NULL		},
 };
@@ -1096,6 +1104,104 @@ static void cmd_put(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 	}
 }
 
+static void cmd_action(struct obex_session *os, obex_t *obex,
+							obex_object_t *obj)
+{
+	obex_headerdata_t hd;
+	unsigned int hlen;
+	uint8_t hi;
+	int err;
+
+	if (!os->service) {
+		OBEX_ObjectSetRsp(obj, OBEX_RSP_FORBIDDEN, OBEX_RSP_FORBIDDEN);
+		return;
+	} else if (!os->service->action) {
+		OBEX_ObjectSetRsp(obj, OBEX_RSP_NOT_IMPLEMENTED,
+				OBEX_RSP_NOT_IMPLEMENTED);
+		return;
+	}
+
+	g_return_if_fail(chk_cid(obex, obj, os->cid));
+
+	if (os->name) {
+		g_free(os->name);
+		os->name = NULL;
+	}
+
+	if (os->destname) {
+		g_free(os->destname);
+		os->destname = NULL;
+	}
+
+	while (OBEX_ObjectGetNextHeader(obex, obj, &hi, &hd, &hlen)) {
+		switch (hi) {
+		case OBEX_HDR_NAME:
+			if (os->name) {
+				DBG("Ignoring multiple name headers");
+				break;
+			}
+
+			if (hlen == 0)
+				continue;
+
+			os->name = g_convert((const char *) hd.bs, hlen,
+					"UTF8", "UTF16BE", NULL, NULL, NULL);
+			DBG("OBEX_HDR_NAME: %s", os->name);
+			break;
+
+		case OBEX_HDR_DESTNAME:
+			if (os->destname) {
+				DBG("Ignoring multiple destination headers");
+				break;
+			}
+
+			if (hlen == 0)
+				continue;
+
+			os->destname = g_convert((const char *) hd.bs, hlen,
+					"UTF8", "UTF16BE", NULL, NULL, NULL);
+			DBG("OBEX_HDR_DESTNAME: %s", os->destname);
+			break;
+
+		case OBEX_HDR_ACTION_ID:
+			if (hlen == 0)
+				continue;
+
+			os->action_id = hd.bq1;
+
+			DBG("OBEX_HDR_ACTIONID: %u", os->action_id);
+			break;
+
+		case OBEX_HDR_PERMISSIONS:
+			if (hlen == 0)
+				continue;
+
+			DBG("OBEX_HDR_PERMISSIONS: %d", hd.bq4);
+			break;
+		}
+	}
+
+	os->driver = obex_mime_type_driver_find(os->service->target,
+						os->service->target_size,
+						NULL,
+						os->service->who,
+						os->service->who_size);
+
+	if (!os->driver || !os->service->action) {
+		OBEX_ObjectSetRsp(obj, OBEX_RSP_NOT_IMPLEMENTED,
+				OBEX_RSP_NOT_IMPLEMENTED);
+		return;
+	}
+
+	err = os->service->action(os, obj, os->service_data);
+	if (err < 0) {
+		os_set_response(obj, err);
+		return;
+	}
+
+	return;
+}
+
 static void obex_event_cb(obex_t *obex, obex_object_t *obj, int mode,
 					int evt, int cmd, int rsp)
 {
@@ -1141,6 +1247,7 @@ static void obex_event_cb(obex_t *obex, obex_object_t *obj, int mode,
 		case OBEX_CMD_SETPATH:
 		case OBEX_CMD_CONNECT:
 		case OBEX_CMD_DISCONNECT:
+		case OBEX_CMD_ACTION:
 			OBEX_ObjectSetRsp(obj, OBEX_RSP_CONTINUE,
 					OBEX_RSP_SUCCESS);
 			break;
@@ -1176,6 +1283,9 @@ static void obex_event_cb(obex_t *obex, obex_object_t *obj, int mode,
 		case OBEX_CMD_PUT:
 			cmd_put(os, obex, obj);
 			break;
+		case OBEX_CMD_ACTION:
+			cmd_action(os, obex, obj);
+			break;
 		default:
 			DBG("Unknown request: 0x%X", cmd);
 			OBEX_ObjectSetRsp(obj, OBEX_RSP_NOT_IMPLEMENTED,
@@ -1309,6 +1419,11 @@ const char *obex_get_name(struct obex_session *os)
 	return os->name;
 }
 
+const char *obex_get_destname(struct obex_session *os)
+{
+	return os->destname;
+}
+
 void obex_set_name(struct obex_session *os, const char *name)
 {
 	g_free(os->name);
@@ -1359,6 +1474,33 @@ int obex_remove(struct obex_session *os, const char *path)
 	return os->driver->remove(path);
 }
 
+int obex_copy(struct obex_session *os, const char *source,
+						const char *destination)
+{
+	if (os->driver == NULL || os->driver->copy == NULL)
+		return -EINVAL;
+
+	DBG("%s %s", source, destination);
+
+	return os->driver->copy(source, destination);
+}
+
+int obex_move(struct obex_session *os, const char *source,
+						const char *destination)
+{
+	if (os->driver == NULL || os->driver->move == NULL)
+		return -EINVAL;
+
+	DBG("%s %s", source, destination);
+
+	return os->driver->move(source, destination);
+}
+
+uint8_t obex_get_action_id(struct obex_session *os)
+{
+	return os->action_id;
+}
+
 /* TODO: find a way to do this for tty or fix syncevolution */
 char *obex_get_id(struct obex_session *os)
 {
diff --git a/src/obex.h b/src/obex.h
index 94274c2..03243f1 100644
--- a/src/obex.h
+++ b/src/obex.h
@@ -47,6 +47,7 @@ void obex_connect_cb(GIOChannel *io, GError *err, void *user_data);
 int obex_get_stream_start(struct obex_session *os, const char *filename);
 int obex_put_stream_start(struct obex_session *os, const char *filename);
 const char *obex_get_name(struct obex_session *os);
+const char *obex_get_destname(struct obex_session *os);
 void obex_set_name(struct obex_session *os, const char *name);
 ssize_t obex_get_size(struct obex_session *os);
 const char *obex_get_type(struct obex_session *os);
@@ -56,6 +57,11 @@ gboolean obex_get_symlinks(struct obex_session *os);
 const char *obex_get_capability_path(struct obex_session *os);
 gboolean obex_get_auto_accept(struct obex_session *os);
 int obex_remove(struct obex_session *os, const char *path);
+int obex_copy(struct obex_session *os, const char *source,
+						const char *destination);
+int obex_move(struct obex_session *os, const char *source,
+						const char *destination);
+uint8_t obex_get_action_id(struct obex_session *os);
 char *obex_get_id(struct obex_session *os);
 ssize_t obex_aparam_read(struct obex_session *os, obex_object_t *obj,
 						const uint8_t **buffer);
diff --git a/src/service.h b/src/service.h
index a844885..61c0dcc 100644
--- a/src/service.h
+++ b/src/service.h
@@ -39,6 +39,8 @@ struct obex_service_driver {
 	int (*chkput) (struct obex_session *os, void *user_data);
 	int (*setpath) (struct obex_session *os, obex_object_t *obj,
 							void *user_data);
+	int (*action) (struct obex_session *os, obex_object_t *obj,
+							void *user_data);
 	void (*disconnect) (struct obex_session *os, void *user_data);
 	void (*reset) (struct obex_session *os, void *user_data);
 };
-- 
1.7.5.4

