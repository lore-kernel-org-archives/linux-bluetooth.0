Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/11] audio: Remove AudioSink interface
Date: Mon, 26 Nov 2012 15:09:12 +0200
Message-Id: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This interface is no longer needed as Device interface can now connect
the profiles and the state can be tracked using MediaTransport interface.
---
 doc/audio-api.txt     |  53 -------------------
 profiles/audio/sink.c | 141 ++------------------------------------------------
 2 files changed, 3 insertions(+), 191 deletions(-)

diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index 9ace681..47ea4b6 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -51,59 +51,6 @@ Properties	string State
 				Disconnected from the remote device
 
 
-AudioSink hierarchy
-===================
-
-Service		org.bluez
-Interface	org.bluez.AudioSink
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
-
-Methods		void Connect()
-
-			Connect and setup a stream to a A2DP sink on the
-			remote device.
-
-		void Disconnect()
-
-			Disconnect from the remote device.
-
-		dict GetProperties()
-
-			Returns all properties for the interface. See the
-			properties section for available properties.
-
-			Possible Errors: org.bluez.Error.InvalidArguments
-
-Signals		PropertyChanged(string name, variant value)
-
-			This signal indicates a changed value of the given
-			property.
-
-properties	string State [readonly]
-
-			Possible values: "disconnected", "connecting",
-			"connected", "playing"
-
-			"disconnected" -> "connecting"
-				Either an incoming or outgoing connection
-				attempt ongoing.
-
-			"connecting" -> "disconnected"
-				Connection attempt failed
-
-			"connecting" -> "connected"
-				Successfully connected
-
-			"connected" -> "playing"
-				Audio stream active
-
-			"playing" -> "connected"
-				Audio stream suspended
-
-			"connected" -> "disconnected"
-			"playing" -> "disconnected"
-				Disconnected from the remote device
-
 AudioSource hierarchy
 =====================
 
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 257cb2f..466c0a8 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -87,38 +87,14 @@ static char *str_state[] = {
 	"SINK_STATE_PLAYING",
 };
 
-static const char *state2str(sink_state_t state)
-{
-	switch (state) {
-	case SINK_STATE_DISCONNECTED:
-		return "disconnected";
-	case SINK_STATE_CONNECTING:
-		return "connecting";
-	case SINK_STATE_CONNECTED:
-		return "connected";
-	case SINK_STATE_PLAYING:
-		return "playing";
-	default:
-		error("Invalid sink state %d", state);
-		return NULL;
-	}
-}
-
 static void sink_set_state(struct audio_device *dev, sink_state_t new_state)
 {
 	struct sink *sink = dev->sink;
-	const char *state_str;
 	sink_state_t old_state = sink->state;
 	GSList *l;
 
 	sink->state = new_state;
 
-	state_str = state2str(new_state);
-	if (state_str)
-		emit_property_changed(device_get_path(dev->btd_dev),
-					AUDIO_SINK_INTERFACE, "State",
-					DBUS_TYPE_STRING, &state_str);
-
 	DBG("State changed %s: %s -> %s", device_get_path(dev->btd_dev),
 				str_state[old_state], str_state[new_state]);
 
@@ -366,38 +342,6 @@ gboolean sink_setup_stream(struct sink *sink, struct avdtp *session)
 	return TRUE;
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
-static DBusMessage *connect_sink(DBusConnection *conn,
-				DBusMessage *msg, void *data)
-{
-	struct audio_device *dev = data;
-	int err;
-
-	err = sink_connect(dev, generic_cb, msg);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
-
-	dbus_message_ref(msg);
-
-	return NULL;
-}
-
 int sink_connect(struct audio_device *dev, audio_device_cb cb, void *data)
 {
 	struct sink *sink = dev->sink;
@@ -434,67 +378,6 @@ int sink_connect(struct audio_device *dev, audio_device_cb cb, void *data)
 	return 0;
 }
 
-static DBusMessage *disconnect_sink(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	struct audio_device *dev = data;
-	int err;
-
-	err = sink_disconnect(dev, FALSE, generic_cb, msg);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
-
-	dbus_message_ref(msg);
-
-	return NULL;
-}
-
-static DBusMessage *sink_get_properties(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	struct audio_device *device = data;
-	struct sink *sink = device->sink;
-	DBusMessage *reply;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
-	const char *state;
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	dbus_message_iter_init_append(reply, &iter);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
-
-	/* State */
-	state = state2str(sink->state);
-	if (state)
-		dict_append_entry(&dict, "State", DBUS_TYPE_STRING, &state);
-
-	dbus_message_iter_close_container(&iter, &dict);
-
-	return reply;
-}
-
-static const GDBusMethodTable sink_methods[] = {
-	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, connect_sink) },
-	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, disconnect_sink) },
-	{ GDBUS_METHOD("GetProperties",
-				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-				sink_get_properties) },
-	{ }
-};
-
-static const GDBusSignalTable sink_signals[] = {
-	{ GDBUS_SIGNAL("PropertyChanged",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
-	{ }
-};
-
 static void sink_free(struct audio_device *dev)
 {
 	struct sink *sink = dev->sink;
@@ -519,35 +402,17 @@ static void sink_free(struct audio_device *dev)
 	dev->sink = NULL;
 }
 
-static void path_unregister(void *data)
-{
-	struct audio_device *dev = data;
-
-	DBG("Unregistered interface %s on path %s",
-			AUDIO_SINK_INTERFACE, device_get_path(dev->btd_dev));
-
-	sink_free(dev);
-}
-
 void sink_unregister(struct audio_device *dev)
 {
-	g_dbus_unregister_interface(btd_get_dbus_connection(),
-			device_get_path(dev->btd_dev), AUDIO_SINK_INTERFACE);
+	DBG("%s", device_get_path(dev->btd_dev));
+	sink_free(dev);
 }
 
 struct sink *sink_init(struct audio_device *dev)
 {
 	struct sink *sink;
 
-	if (!g_dbus_register_interface(btd_get_dbus_connection(),
-					device_get_path(dev->btd_dev),
-					AUDIO_SINK_INTERFACE,
-					sink_methods, sink_signals, NULL,
-					dev, path_unregister))
-		return NULL;
-
-	DBG("Registered interface %s on path %s",
-			AUDIO_SINK_INTERFACE, device_get_path(dev->btd_dev));
+	DBG("%s", device_get_path(dev->btd_dev));
 
 	if (avdtp_callback_id == 0)
 		avdtp_callback_id = avdtp_add_state_cb(avdtp_state_callback,
-- 
1.7.11.7

