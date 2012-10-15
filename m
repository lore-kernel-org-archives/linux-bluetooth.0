Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 14/16] control: Add basic support for AVRCP 1.0 controller
Date: Mon, 15 Oct 2012 16:05:34 +0200
Message-Id: <1350309936-31588-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
References: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 audio/control.c     | 61 ++++++++++++++++++++++++++++++++++++++---------------
 doc/control-api.txt | 24 +++++++++++++++++++++
 2 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 926bdfb..b77c4cb 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -123,8 +123,8 @@ static DBusMessage *control_is_connected(DBusConnection *conn,
 	return reply;
 }
 
-static DBusMessage *volume_up(DBusConnection *conn, DBusMessage *msg,
-								void *data)
+static DBusMessage *key_pressed(DBusConnection *conn, DBusMessage *msg,
+						uint8_t op, void *data)
 {
 	struct audio_device *device = data;
 	struct control *control = device->control;
@@ -136,31 +136,53 @@ static DBusMessage *volume_up(DBusConnection *conn, DBusMessage *msg,
 	if (!control->target)
 		return btd_error_not_supported(msg);
 
-	err = avctp_send_passthrough(control->session, AVC_VOLUME_UP);
+	err = avctp_send_passthrough(control->session, op);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
 	return dbus_message_new_method_return(msg);
 }
 
-static DBusMessage *volume_down(DBusConnection *conn, DBusMessage *msg,
+static DBusMessage *control_volume_up(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
-	struct audio_device *device = data;
-	struct control *control = device->control;
-	int err;
+	return key_pressed(conn, msg, AVC_VOLUME_UP, data);
+}
 
-	if (!control->session)
-		return btd_error_not_connected(msg);
+static DBusMessage *control_volume_down(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	return key_pressed(conn, msg, AVC_VOLUME_DOWN, data);
+}
 
-	if (!control->target)
-		return btd_error_not_supported(msg);
+static DBusMessage *control_play(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	return key_pressed(conn, msg, AVC_PLAY, data);
+}
 
-	err = avctp_send_passthrough(control->session, AVC_VOLUME_DOWN);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
+static DBusMessage *control_pause(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	return key_pressed(conn, msg, AVC_PAUSE, data);
+}
 
-	return dbus_message_new_method_return(msg);
+static DBusMessage *control_stop(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	return key_pressed(conn, msg, AVC_STOP, data);
+}
+
+static DBusMessage *control_next(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	return key_pressed(conn, msg, AVC_FORWARD, data);
+}
+
+static DBusMessage *control_previous(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	return key_pressed(conn, msg, AVC_BACKWARD, data);
 }
 
 static gboolean control_property_get_connected(
@@ -179,8 +201,13 @@ static const GDBusMethodTable control_methods[] = {
 	{ GDBUS_DEPRECATED_METHOD("IsConnected",
 				NULL, GDBUS_ARGS({ "connected", "b" }),
 				control_is_connected) },
-	{ GDBUS_METHOD("VolumeUp", NULL, NULL, volume_up) },
-	{ GDBUS_METHOD("VolumeDown", NULL, NULL, volume_down) },
+	{ GDBUS_METHOD("Play", NULL, NULL, control_play) },
+	{ GDBUS_METHOD("Pause", NULL, NULL, control_pause) },
+	{ GDBUS_METHOD("Stop", NULL, NULL, control_stop) },
+	{ GDBUS_METHOD("Next", NULL, NULL, control_next) },
+	{ GDBUS_METHOD("Previous", NULL, NULL, control_previous) },
+	{ GDBUS_METHOD("VolumeUp", NULL, NULL, control_volume_up) },
+	{ GDBUS_METHOD("VolumeDown", NULL, NULL, control_volume_down) },
 	{ }
 };
 
diff --git a/doc/control-api.txt b/doc/control-api.txt
index eacfbcd..3792dfa 100644
--- a/doc/control-api.txt
+++ b/doc/control-api.txt
@@ -21,6 +21,30 @@ Methods		boolean IsConnected() {deprecated}
 			Returns all properties for the interface. See the
 			properties section for available properties.
 
+		void Play()
+
+			Resume playback.
+
+		void Pause()
+
+			Pause playback.
+
+		void Stop()
+
+			Stop playback.
+
+		void Next()
+
+			Next item.
+
+		void Previous()
+
+			Previous item.
+
+		void VolumeDown()
+
+			Adjust remote volume one step down
+
 		void VolumeUp()
 
 			Adjust remote volume one step up
-- 
1.7.11.4

