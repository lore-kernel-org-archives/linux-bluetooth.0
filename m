Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/11] control: Fix Control.Disconnect not generating any reply
Date: Thu, 25 Oct 2012 16:59:04 +0300
Message-Id: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

avctp_disconnect does disconnect immediatelly so there is no time to
set the pending message.
---
 audio/control.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 37b027b..1620128 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -65,7 +65,6 @@ struct control {
 	struct avctp *session;
 	gboolean target;
 	DBusMessage *connect;
-	DBusMessage *disconnect;
 };
 
 static void state_changed(struct audio_device *dev, avctp_state_t old_state,
@@ -88,13 +87,6 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 			control->connect = NULL;
 		}
 
-		if (control->disconnect) {
-			g_dbus_send_reply(conn, control->disconnect,
-							DBUS_TYPE_INVALID);
-			dbus_message_unref(control->disconnect);
-			control->disconnect = NULL;
-		}
-
 		if (old_state != AVCTP_STATE_CONNECTED)
 			break;
 
@@ -184,14 +176,9 @@ static DBusMessage *control_disconnect(DBusConnection *conn, DBusMessage *msg,
 	if (!control->session)
 		return btd_error_not_connected(msg);
 
-	if (control->disconnect)
-		return btd_error_in_progress(msg);
-
 	avctp_disconnect(control->session);
 
-	control->disconnect = dbus_message_ref(msg);
-
-	return NULL;
+	return dbus_message_new_method_return(msg);
 }
 
 static DBusMessage *key_pressed(DBusConnection *conn, DBusMessage *msg,
@@ -273,7 +260,7 @@ static const GDBusMethodTable control_methods[] = {
 				NULL, GDBUS_ARGS({ "connected", "b" }),
 				control_is_connected) },
 	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, control_connect) },
-	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, control_disconnect) },
+	{ GDBUS_METHOD("Disconnect", NULL, NULL, control_disconnect) },
 	{ GDBUS_METHOD("Play", NULL, NULL, control_play) },
 	{ GDBUS_METHOD("Pause", NULL, NULL, control_pause) },
 	{ GDBUS_METHOD("Stop", NULL, NULL, control_stop) },
@@ -309,9 +296,6 @@ static void path_unregister(void *data)
 	if (control->connect)
 		dbus_message_unref(control->connect);
 
-	if (control->disconnect)
-		dbus_message_unref(control->disconnect);
-
 	g_free(control);
 	dev->control = NULL;
 }
-- 
1.7.11.7

