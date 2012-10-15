Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 16/16] control: Add Control.Disconnect method
Date: Mon, 15 Oct 2012 16:05:36 +0200
Message-Id: <1350309936-31588-16-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
References: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This method can be used to disconnect AVRCP.
---
 audio/control.c     | 31 +++++++++++++++++++++++++++++++
 doc/control-api.txt |  4 ++++
 2 files changed, 35 insertions(+)

diff --git a/audio/control.c b/audio/control.c
index e15e9ba..8bb085a 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -62,6 +62,7 @@ struct control {
 	struct avctp *session;
 	gboolean target;
 	DBusMessage *connect;
+	DBusMessage *disconnect;
 };
 
 static void state_changed(struct audio_device *dev, avctp_state_t old_state,
@@ -83,6 +84,13 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 			control->connect = NULL;
 		}
 
+		if (control->disconnect) {
+			g_dbus_send_reply(conn, control->disconnect,
+							DBUS_TYPE_INVALID);
+			dbus_message_unref(control->disconnect);
+			control->disconnect = NULL;
+		}
+
 		if (old_state != AVCTP_STATE_CONNECTED)
 			break;
 
@@ -164,6 +172,25 @@ static DBusMessage *control_connect(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static DBusMessage *control_disconnect(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct audio_device *device = data;
+	struct control *control = device->control;
+
+	if (!control->session)
+		return btd_error_not_connected(msg);
+
+	if (control->disconnect)
+		return btd_error_in_progress(msg);
+
+	avctp_disconnect(control->session);
+
+	control->disconnect = dbus_message_ref(msg);
+
+	return NULL;
+}
+
 static DBusMessage *key_pressed(DBusConnection *conn, DBusMessage *msg,
 						uint8_t op, void *data)
 {
@@ -243,6 +270,7 @@ static const GDBusMethodTable control_methods[] = {
 				NULL, GDBUS_ARGS({ "connected", "b" }),
 				control_is_connected) },
 	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, control_connect) },
+	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, control_disconnect) },
 	{ GDBUS_METHOD("Play", NULL, NULL, control_play) },
 	{ GDBUS_METHOD("Pause", NULL, NULL, control_pause) },
 	{ GDBUS_METHOD("Stop", NULL, NULL, control_stop) },
@@ -278,6 +306,9 @@ static void path_unregister(void *data)
 	if (control->connect)
 		dbus_message_unref(control->connect);
 
+	if (control->disconnect)
+		dbus_message_unref(control->disconnect);
+
 	g_free(control);
 	dev->control = NULL;
 }
diff --git a/doc/control-api.txt b/doc/control-api.txt
index 61069ea..5391a8a 100644
--- a/doc/control-api.txt
+++ b/doc/control-api.txt
@@ -25,6 +25,10 @@ Methods		boolean IsConnected() {deprecated}
 
 			Connect to remote device.
 
+		void Disconnect()
+
+			Disconnect from remote device.
+
 		void Play()
 
 			Resume playback.
-- 
1.7.11.4

