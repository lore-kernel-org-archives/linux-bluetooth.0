Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/10] input: use btd_error_failed()
Date: Mon, 13 Dec 2010 19:33:04 -0200
Message-Id: <1292275987-13799-8-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1292275987-13799-7-git-send-email-padovan@profusion.mobi>
References: <1292275987-13799-1-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-2-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-3-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-4-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-5-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-6-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-7-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/device.c |   31 ++++++++-----------------------
 1 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/input/device.c b/input/device.c
index dee943b..0543fe6 100644
--- a/input/device.c
+++ b/input/device.c
@@ -315,14 +315,6 @@ failed:
 	return FALSE;
 }
 
-static inline DBusMessage *connection_attempt_failed(DBusMessage *msg,
-							const char *err)
-{
-	return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".ConnectionAttemptFailed",
-				"%s", err ? err : "Connection attempt failed");
-}
-
 static void rfcomm_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct input_conn *iconn = user_data;
@@ -331,8 +323,7 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	DBusMessage *reply;
 
 	if (err) {
-		reply = connection_attempt_failed(iconn->pending_connect,
-								err->message);
+		reply = btd_error_failed(iconn->pending_connect, err->message);
 		goto failed;
 	}
 
@@ -345,7 +336,7 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	fake->uinput = uinput_create(idev->name);
 	if (fake->uinput < 0) {
 		g_io_channel_shutdown(chan, TRUE, NULL);
-		reply = connection_attempt_failed(iconn->pending_connect,
+		reply = btd_error_failed(iconn->pending_connect,
 							strerror(errno));
 		goto failed;
 	}
@@ -834,7 +825,7 @@ static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 
 failed:
 	error("%s", err_msg);
-	reply = connection_attempt_failed(iconn->pending_connect, err_msg);
+	reply = btd_error_failed(iconn->pending_connect, err_msg);
 	g_dbus_send_message(idev->conn, reply);
 
 	if (iconn->ctrl_io)
@@ -859,8 +850,8 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
 
 	if (conn_err) {
 		error("%s", conn_err->message);
-		reply = connection_attempt_failed(iconn->pending_connect,
-							conn_err->message);
+		reply = btd_error_failed(iconn->pending_connect,
+						conn_err->message);
 		goto failed;
 	}
 
@@ -874,7 +865,7 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
 				BT_IO_OPT_INVALID);
 	if (!io) {
 		error("%s", err->message);
-		reply = connection_attempt_failed(iconn->pending_connect,
+		reply = btd_error_failed(iconn->pending_connect,
 							err->message);
 		g_error_free(err);
 		g_io_channel_shutdown(chan, TRUE, NULL);
@@ -960,17 +951,11 @@ static DBusMessage *input_device_connect(DBusConnection *conn,
 	error("%s", err->message);
 	dbus_message_unref(iconn->pending_connect);
 	iconn->pending_connect = NULL;
-	reply = connection_attempt_failed(msg, err->message);
+	reply = btd_error_failed(msg, err->message);
 	g_error_free(err);
 	return reply;
 }
 
-static DBusMessage *create_errno_message(DBusMessage *msg, int err)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-							"%s", strerror(err));
-}
-
 static DBusMessage *input_device_disconnect(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
@@ -979,7 +964,7 @@ static DBusMessage *input_device_disconnect(DBusConnection *conn,
 
 	err = disconnect(idev, 0);
 	if (err < 0)
-		return create_errno_message(msg, -err);
+		return btd_error_failed(msg, strerror(-err));
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
-- 
1.7.3.2

