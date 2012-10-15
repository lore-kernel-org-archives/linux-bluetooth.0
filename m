Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 15/16] control: Add Control.Connect API
Date: Mon, 15 Oct 2012 16:05:35 +0200
Message-Id: <1350309936-31588-15-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
References: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This method can be used to manually connect AVRCP when acting as a
controller.
---
 audio/control.c     | 45 +++++++++++++++++++++++++++++++++++++++++++++
 doc/control-api.txt |  4 ++++
 2 files changed, 49 insertions(+)

diff --git a/audio/control.c b/audio/control.c
index b77c4cb..e15e9ba 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -61,6 +61,7 @@ static unsigned int avctp_id = 0;
 struct control {
 	struct avctp *session;
 	gboolean target;
+	DBusMessage *connect;
 };
 
 static void state_changed(struct audio_device *dev, avctp_state_t old_state,
@@ -73,6 +74,15 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 	case AVCTP_STATE_DISCONNECTED:
 		control->session = NULL;
 
+		if (control->connect) {
+			DBusMessage *reply = btd_error_failed(control->connect,
+							"Unable to connect");
+
+			g_dbus_send_message(btd_get_dbus_connection(), reply);
+			dbus_message_unref(control->connect);
+			control->connect = NULL;
+		}
+
 		if (old_state != AVCTP_STATE_CONNECTED)
 			break;
 
@@ -91,6 +101,13 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 
 		break;
 	case AVCTP_STATE_CONNECTED:
+		if (control->connect) {
+			g_dbus_send_reply(conn, control->connect,
+							DBUS_TYPE_INVALID);
+			dbus_message_unref(control->connect);
+			control->connect = NULL;
+		}
+
 		g_dbus_emit_signal(conn, dev->path,
 				AUDIO_CONTROL_INTERFACE, "Connected",
 				DBUS_TYPE_INVALID);
@@ -123,6 +140,30 @@ static DBusMessage *control_is_connected(DBusConnection *conn,
 	return reply;
 }
 
+static DBusMessage *control_connect(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct audio_device *device = data;
+	struct control *control = device->control;
+
+	if (control->session)
+		return btd_error_already_connected(msg);
+
+	if (!control->target)
+		return btd_error_not_supported(msg);
+
+	if (control->connect)
+		return btd_error_in_progress(msg);
+
+	control->session = avctp_connect(&device->src, &device->dst);
+	if (!control->session)
+		return btd_error_failed(msg, "Unable to connect");
+
+	control->connect = dbus_message_ref(msg);
+
+	return NULL;
+}
+
 static DBusMessage *key_pressed(DBusConnection *conn, DBusMessage *msg,
 						uint8_t op, void *data)
 {
@@ -201,6 +242,7 @@ static const GDBusMethodTable control_methods[] = {
 	{ GDBUS_DEPRECATED_METHOD("IsConnected",
 				NULL, GDBUS_ARGS({ "connected", "b" }),
 				control_is_connected) },
+	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, control_connect) },
 	{ GDBUS_METHOD("Play", NULL, NULL, control_play) },
 	{ GDBUS_METHOD("Pause", NULL, NULL, control_pause) },
 	{ GDBUS_METHOD("Stop", NULL, NULL, control_stop) },
@@ -233,6 +275,9 @@ static void path_unregister(void *data)
 	if (control->session)
 		avctp_disconnect(control->session);
 
+	if (control->connect)
+		dbus_message_unref(control->connect);
+
 	g_free(control);
 	dev->control = NULL;
 }
diff --git a/doc/control-api.txt b/doc/control-api.txt
index 3792dfa..61069ea 100644
--- a/doc/control-api.txt
+++ b/doc/control-api.txt
@@ -21,6 +21,10 @@ Methods		boolean IsConnected() {deprecated}
 			Returns all properties for the interface. See the
 			properties section for available properties.
 
+		void Connect()
+
+			Connect to remote device.
+
 		void Play()
 
 			Resume playback.
-- 
1.7.11.4

