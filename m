Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Fix not fetching current usb mode when obexd starts
Date: Fri, 28 Jan 2011 15:17:38 +0200
Message-Id: <1296220659-24165-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Cable may be already plugged when obexd starts
---
 plugins/usb.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/plugins/usb.c b/plugins/usb.c
index 949e94f..580e7b8 100644
--- a/plugins/usb.c
+++ b/plugins/usb.c
@@ -173,20 +173,27 @@ static void sig_usb(int sig)
 {
 }
 
+static void usb_set_mode(struct obex_server *server, const char *mode)
+{
+	DBG("%s", mode);
+
+	if (g_str_equal(mode, "ovi_suite") == TRUE)
+		usb_connect(server);
+	else if (g_str_equal(mode, "USB disconnected") == TRUE)
+		usb_disconnect(server);
+}
+
 static gboolean handle_signal(DBusConnection *connection,
 				DBusMessage *message, void *user_data)
 {
 	struct obex_server *server = user_data;
-	const char *state;
+	const char *mode;
 
 	dbus_message_get_args(message, NULL,
-				DBUS_TYPE_STRING, &state,
+				DBUS_TYPE_STRING, &mode,
 				DBUS_TYPE_INVALID);
 
-	if (g_str_equal(state, "ovi_suite") == TRUE)
-		usb_connect(server);
-	else if (g_str_equal(state, "USB disconnected") == TRUE)
-		usb_disconnect(server);
+	usb_set_mode(server, mode);
 
 	return TRUE;
 }
@@ -197,18 +204,64 @@ static void usb_stop(void *data)
 	g_source_remove(id);
 }
 
+static void mode_request_reply(DBusPendingCall *call, void *user_data)
+{
+	struct obex_server *server = user_data;
+	DBusMessage *reply = dbus_pending_call_steal_reply(call);
+	DBusError derr;
+
+	dbus_error_init(&derr);
+	if (dbus_set_error_from_message(&derr, reply)) {
+		error("usb: Replied with an error: %s, %s",
+				derr.name, derr.message);
+		dbus_error_free(&derr);
+	} else {
+		const char *mode;
+		dbus_message_get_args(reply, NULL,
+				DBUS_TYPE_STRING, &mode,
+				DBUS_TYPE_INVALID);
+
+		usb_set_mode(server, mode);
+	}
+
+	dbus_message_unref(reply);
+}
+
 static void *usb_start(struct obex_server *server, int *err)
 {
 	guint id;
+	DBusMessage *msg;
+	DBusPendingCall *call;
+
+	msg = dbus_message_new_method_call("com.meego.usb_moded",
+						"/com/meego/usb_moded",
+						"com.meego.usb_moded",
+						"mode_request");
+
+	if (dbus_connection_send_with_reply(connection,
+					msg, &call, -1) == FALSE) {
+		error("usb: unable to send mode_request");
+		goto fail;
+	}
+
+	dbus_pending_call_set_notify(call, mode_request_reply, server, NULL);
+	dbus_pending_call_unref(call);
 
 	id = g_dbus_add_signal_watch(connection, NULL, NULL,
 					"com.meego.usb_moded",
 					"sig_usb_state_ind",
 					handle_signal, server, NULL);
+
 	if (err != NULL)
 		*err = 0;
 
 	return GUINT_TO_POINTER(id);
+
+fail:
+	if (err != NULL)
+		*err = -1;
+
+	return NULL;
 }
 
 static struct obex_transport_driver driver = {
-- 
1.7.1

