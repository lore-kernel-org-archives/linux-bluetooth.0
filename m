Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/11] audio: Remove Control.Connect and Control.Disconnect
Date: Mon, 26 Nov 2012 15:09:15 +0200
Message-Id: <1353935362-8666-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
References: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These method are no longer necessary as Device interface has similar
functionality.
---
 doc/control-api.txt      | 10 +---------
 profiles/audio/control.c | 47 -----------------------------------------------
 profiles/audio/device.c  |  6 ++++--
 3 files changed, 5 insertions(+), 58 deletions(-)

diff --git a/doc/control-api.txt b/doc/control-api.txt
index 0d25512..a16ee7d 100644
--- a/doc/control-api.txt
+++ b/doc/control-api.txt
@@ -12,15 +12,7 @@ Service		org.bluez
 Interface	org.bluez.Control
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
-Methods		void Connect()
-
-			Connect to remote device.
-
-		void Disconnect()
-
-			Disconnect from remote device.
-
-		void Play()
+Methods		void Play()
 
 			Resume playback.
 
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 29cf3bb..0013f8d 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -153,38 +153,6 @@ int control_connect(struct audio_device *dev, audio_device_cb cb, void *data)
 	return 0;
 }
 
-static void generic_cb(struct audio_device *dev, int err, void *data)
-{
-	DBusMessage *msg = data;
-	DBusMessage *reply;
-
-	if (err < 0) {
-		reply = btd_error_failed(msg, strerror(-err));
-		g_dbus_send_message(btd_get_dbus_connection(), reply);
-		dbus_message_unref(msg);
-		return;
-	}
-
-	g_dbus_send_reply(btd_get_dbus_connection(), msg, DBUS_TYPE_INVALID);
-
-	dbus_message_unref(msg);
-}
-
-static DBusMessage *connect_control(DBusConnection *conn, DBusMessage *msg,
-								void *data)
-{
-	struct audio_device *device = data;
-	int err;
-
-	err = control_connect(device, generic_cb, msg);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
-
-	dbus_message_ref(msg);
-
-	return NULL;
-}
-
 int control_disconnect(struct audio_device *dev, audio_device_cb cb,
 								void *data)
 {
@@ -208,19 +176,6 @@ int control_disconnect(struct audio_device *dev, audio_device_cb cb,
 
 }
 
-static DBusMessage *disconnect_control(DBusConnection *conn, DBusMessage *msg,
-								void *data)
-{
-	struct audio_device *device = data;
-	int err;
-
-	err = control_disconnect(device, NULL, NULL);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
-
-	return dbus_message_new_method_return(msg);
-}
-
 static DBusMessage *key_pressed(DBusConnection *conn, DBusMessage *msg,
 						uint8_t op, void *data)
 {
@@ -296,8 +251,6 @@ static gboolean control_property_get_connected(
 }
 
 static const GDBusMethodTable control_methods[] = {
-	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, connect_control) },
-	{ GDBUS_METHOD("Disconnect", NULL, NULL, disconnect_control) },
 	{ GDBUS_METHOD("Play", NULL, NULL, control_play) },
 	{ GDBUS_METHOD("Pause", NULL, NULL, control_pause) },
 	{ GDBUS_METHOD("Stop", NULL, NULL, control_stop) },
diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index b14f75b..fef2bea 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -298,6 +298,8 @@ struct audio_device *audio_device_register(struct btd_device *device,
 {
 	struct audio_device *dev;
 
+	DBG("%s", device_get_path(device));
+
 	dev = g_new0(struct audio_device, 1);
 
 	dev->btd_dev = btd_device_ref(device);
@@ -306,8 +308,6 @@ struct audio_device *audio_device_register(struct btd_device *device,
 	dev->priv = g_new0(struct dev_priv, 1);
 	dev->priv->state = AUDIO_STATE_DISCONNECTED;
 
-	DBG("%s", device_get_path(dev->btd_dev));
-
 	if (sink_callback_id == 0)
 		sink_callback_id = sink_add_state_cb(device_sink_cb, NULL);
 
@@ -341,6 +341,8 @@ gboolean audio_device_is_active(struct audio_device *dev,
 
 void audio_device_unregister(struct audio_device *device)
 {
+	DBG("%s", device_get_path(device->btd_dev));
+
 	if (device->hs_preauth_id) {
 		g_source_remove(device->hs_preauth_id);
 		device->hs_preauth_id = 0;
-- 
1.7.11.7

