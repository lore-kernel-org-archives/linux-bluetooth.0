Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] remove error_common_reply()
Date: Wed, 15 Dec 2010 20:07:01 -0200
Message-Id: <1292450823-17640-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1292450823-17640-1-git-send-email-padovan@profusion.mobi>
References: <1292450823-17640-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove old dbus error report function. This patch doesn't make things
really really better, but is a start.
---
 audio/gateway.c |   18 ++++++++++--------
 audio/headset.c |   37 +++++++++++++++----------------------
 audio/sink.c    |    7 ++++---
 audio/source.c  |    7 ++++---
 src/error.c     |   18 ------------------
 src/error.h     |    3 ---
 6 files changed, 33 insertions(+), 57 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 6a095ca..da899a0 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -254,10 +254,11 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
 	return;
 
 fail:
-	if (gw->msg)
-		error_common_reply(dev->conn, gw->msg,
-						ERROR_INTERFACE ".Failed",
-						"Connection attempt failed");
+	if (gw->msg) {
+		DBusMessage *reply;
+		reply = btd_error_failed(gw->msg, "Connect failed");
+		g_dbus_send_message(dev->conn, reply);
+	}
 
 	change_state(dev, GATEWAY_STATE_DISCONNECTED);
 }
@@ -333,10 +334,11 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 	return;
 
 fail:
-	if (gw->msg)
-		error_common_reply(dev->conn, gw->msg,
-					ERROR_INTERFACE ".NotSupported",
-					"Not supported");
+	if (gw->msg) {
+		DBusMessage *reply = btd_error_failed(gw->msg,
+					gerr ? gerr->message : strerror(-err));
+		g_dbus_send_message(dev->conn, reply);
+	}
 
 	change_state(dev, GATEWAY_STATE_DISCONNECTED);
 
diff --git a/audio/headset.c b/audio/headset.c
index 34b2b89..55bdc61 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -176,19 +176,12 @@ struct event {
 
 static GSList *headset_callbacks = NULL;
 
-static DBusHandlerResult error_not_supported(DBusConnection *conn,
-							DBusMessage *msg)
+static void error_connect_failed(DBusConnection *conn, DBusMessage *msg,
+								int err)
 {
-	return error_common_reply(conn, msg, ERROR_INTERFACE ".NotSupported",
-							"Not supported");
-}
-
-static DBusHandlerResult error_connection_attempt_failed(DBusConnection *conn,
-						DBusMessage *msg, int err)
-{
-	return error_common_reply(conn, msg,
-			ERROR_INTERFACE ".ConnectionAttemptFailed",
-			err < 0 ? strerror(-err) : "Connection attempt failed");
+	DBusMessage *reply = btd_error_failed(msg,
+			err < 0 ? strerror(-err) : "Connect failed");
+	g_dbus_send_message(conn, reply);
 }
 
 static int rfcomm_connect(struct audio_device *device, headset_stream_cb_t cb,
@@ -567,9 +560,7 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		if (p != NULL) {
 			p->err = -errno;
 			if (p->msg)
-				error_connection_attempt_failed(dev->conn,
-								p->msg,
-								p->err);
+				error_connect_failed(dev->conn, p->msg, p->err);
 			pending_connect_finalize(dev);
 		}
 
@@ -679,7 +670,7 @@ static void hfp_slc_complete(struct audio_device *dev)
 	p->err = sco_connect(dev, NULL, NULL, NULL);
 	if (p->err < 0) {
 		if (p->msg)
-			error_connection_attempt_failed(dev->conn, p->msg, p->err);
+			error_connect_failed(dev->conn, p->msg, p->err);
 		pending_connect_finalize(dev);
 	}
 }
@@ -1397,7 +1388,7 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 failed:
 	if (p && p->msg)
-		error_connection_attempt_failed(dev->conn, p->msg, p->err);
+		error_connect_failed(dev->conn, p->msg, p->err);
 	pending_connect_finalize(dev);
 	if (hs->rfcomm)
 		headset_set_state(dev, HEADSET_STATE_CONNECTED);
@@ -1454,7 +1445,7 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 		error("Unable to get service record: %s (%d)",
 							strerror(-err), -err);
 		p->err = -err;
-		error_connection_attempt_failed(dev->conn, p->msg, p->err);
+		error_connect_failed(dev->conn, p->msg, p->err);
 		goto failed;
 	}
 
@@ -1503,7 +1494,7 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 	if (err < 0) {
 		error("Unable to connect: %s (%d)", strerror(-err), -err);
 		p->err = -err;
-		error_connection_attempt_failed(dev->conn, p->msg, p->err);
+		error_connect_failed(dev->conn, p->msg, p->err);
 		goto failed;
 	}
 
@@ -1513,8 +1504,10 @@ failed_not_supported:
 	if (p->svclass == HANDSFREE_SVCLASS_ID &&
 			get_records(dev, NULL, NULL, NULL) == 0)
 		return;
-	if (p->msg)
-		error_not_supported(dev->conn, p->msg);
+	if (p->msg) {
+		DBusMessage *reply = btd_error_not_supported(p->msg);
+		g_dbus_send_message(dev->conn, reply);
+	}
 failed:
 	p->svclass = 0;
 	pending_connect_finalize(dev);
@@ -2667,7 +2660,7 @@ void headset_shutdown(struct audio_device *dev)
 	struct pending_connect *p = dev->headset->pending;
 
 	if (p && p->msg)
-		error_connection_attempt_failed(dev->conn, p->msg, ECANCELED);
+		error_connect_failed(dev->conn, p->msg, ECANCELED);
 
 	pending_connect_finalize(dev);
 	headset_set_state(dev, HEADSET_STATE_DISCONNECTED);
diff --git a/audio/sink.c b/audio/sink.c
index 5746c55..2d5db18 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -253,10 +253,11 @@ static void stream_state_changed(struct avdtp_stream *stream,
 	sink->stream_state = new_state;
 }
 
-static DBusHandlerResult error_failed(DBusConnection *conn,
-					DBusMessage *msg, const char * desc)
+static void error_failed(DBusConnection *conn, DBusMessage *msg,
+							const char *desc)
 {
-	return error_common_reply(conn, msg, ERROR_INTERFACE ".Failed", desc);
+	DBusMessage *reply = btd_error_failed(msg, desc);
+	g_dbus_send_message(conn, reply);
 }
 
 static gboolean stream_setup_retry(gpointer user_data)
diff --git a/audio/source.c b/audio/source.c
index 29ceb0f..6d266f2 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -206,10 +206,11 @@ static void stream_state_changed(struct avdtp_stream *stream,
 	source->stream_state = new_state;
 }
 
-static DBusHandlerResult error_failed(DBusConnection *conn,
-					DBusMessage *msg, const char * desc)
+static void error_failed(DBusConnection *conn, DBusMessage *msg,
+							const char *desc)
 {
-	return error_common_reply(conn, msg, ERROR_INTERFACE ".Failed", desc);
+	DBusMessage *reply = btd_error_failed(msg, desc);
+	g_dbus_send_message(conn, reply);
 }
 
 static gboolean stream_setup_retry(gpointer user_data)
diff --git a/src/error.c b/src/error.c
index 25f89f6..7d3afd4 100644
--- a/src/error.c
+++ b/src/error.c
@@ -31,24 +31,6 @@
 
 #include "error.h"
 
-/* Helper function - internal use only */
-DBusHandlerResult error_common_reply(DBusConnection *conn, DBusMessage *msg,
-					const char *name, const char *descr)
-{
-	DBusMessage *derr;
-
-	if (!conn || !msg)
-		return DBUS_HANDLER_RESULT_HANDLED;
-
-	derr = dbus_message_new_error(msg, name, descr);
-	if (!derr)
-		return DBUS_HANDLER_RESULT_NEED_MEMORY;
-
-	g_dbus_send_message(conn, derr);
-
-	return DBUS_HANDLER_RESULT_HANDLED;
-}
-
 DBusMessage *btd_error_invalid_args(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
diff --git a/src/error.h b/src/error.h
index 0f2eb22..b8c06ce 100644
--- a/src/error.h
+++ b/src/error.h
@@ -27,9 +27,6 @@
 
 #define ERROR_INTERFACE "org.bluez.Error"
 
-DBusHandlerResult error_common_reply(DBusConnection *conn, DBusMessage *msg,
-					const char *name, const char *descr);
-
 DBusMessage *btd_error_invalid_args(DBusMessage *msg);
 DBusMessage *btd_error_busy(DBusMessage *msg);
 DBusMessage *btd_error_already_exists(DBusMessage *msg);
-- 
1.7.3.2

