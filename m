Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/11] audio: Remove AudioSource interface
Date: Mon, 26 Nov 2012 15:09:13 +0200
Message-Id: <1353935362-8666-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
References: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This interface is no longer needed as Device interface can now connect
the profiles and the state can be tracked using MediaTransport interface.
---
 doc/audio-api.txt       |  54 ------------------
 profiles/audio/source.c | 146 ++++--------------------------------------------
 2 files changed, 11 insertions(+), 189 deletions(-)

diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index 47ea4b6..6fd8dfc 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -49,57 +49,3 @@ Properties	string State
 
 			"connected" -> "disconnected"
 				Disconnected from the remote device
-
-
-AudioSource hierarchy
-=====================
-
-Service		org.bluez
-Interface	org.bluez.AudioSource
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
-
-Methods		void Connect()
-
-			Connect and setup a stream to a A2DP source on the
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
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 902b4d4..157a4e8 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -81,37 +81,23 @@ static GSList *source_callbacks = NULL;
 
 static unsigned int avdtp_callback_id = 0;
 
-static const char *state2str(source_state_t state)
-{
-	switch (state) {
-	case SOURCE_STATE_DISCONNECTED:
-		return "disconnected";
-	case SOURCE_STATE_CONNECTING:
-		return "connecting";
-	case SOURCE_STATE_CONNECTED:
-		return "connected";
-	case SOURCE_STATE_PLAYING:
-		return "playing";
-	default:
-		error("Invalid source state %d", state);
-		return NULL;
-	}
-}
+static char *str_state[] = {
+	"SOURCE_STATE_DISCONNECTED",
+	"SOURCE_STATE_CONNECTING",
+	"SOURCE_STATE_CONNECTED",
+	"SOURCE_STATE_PLAYING",
+};
 
 static void source_set_state(struct audio_device *dev, source_state_t new_state)
 {
 	struct source *source = dev->source;
-	const char *state_str;
 	source_state_t old_state = source->state;
 	GSList *l;
 
 	source->state = new_state;
 
-	state_str = state2str(new_state);
-	if (state_str)
-		emit_property_changed(device_get_path(dev->btd_dev),
-					AUDIO_SOURCE_INTERFACE, "State",
-					DBUS_TYPE_STRING, &state_str);
+	DBG("State changed %s: %s -> %s", device_get_path(dev->btd_dev),
+				str_state[old_state], str_state[new_state]);
 
 	for (l = source_callbacks; l != NULL; l = l->next) {
 		struct source_state_callback *cb = l->data;
@@ -356,38 +342,6 @@ gboolean source_setup_stream(struct source *source, struct avdtp *session)
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
-static DBusMessage *connect_source(DBusConnection *conn,
-				DBusMessage *msg, void *data)
-{
-	struct audio_device *dev = data;
-	int err;
-
-	err = source_connect(dev, generic_cb, msg);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
-
-	dbus_message_ref(msg);
-
-	return NULL;
-}
-
 int source_connect(struct audio_device *dev, audio_device_cb cb, void *data)
 {
 	struct source *source = dev->source;
@@ -423,67 +377,6 @@ int source_connect(struct audio_device *dev, audio_device_cb cb, void *data)
 	return 0;
 }
 
-static DBusMessage *disconnect_source(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	struct audio_device *dev = data;
-	int err;
-
-	err = source_disconnect(dev, FALSE, generic_cb, msg);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
-
-	dbus_message_ref(msg);
-
-	return NULL;
-}
-
-static DBusMessage *source_get_properties(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	struct audio_device *device = data;
-	struct source *source = device->source;
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
-	state = state2str(source->state);
-	if (state)
-		dict_append_entry(&dict, "State", DBUS_TYPE_STRING, &state);
-
-	dbus_message_iter_close_container(&iter, &dict);
-
-	return reply;
-}
-
-static const GDBusMethodTable source_methods[] = {
-	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, connect_source) },
-	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, disconnect_source) },
-	{ GDBUS_METHOD("GetProperties",
-				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-				source_get_properties) },
-	{ }
-};
-
-static const GDBusSignalTable source_signals[] = {
-	{ GDBUS_SIGNAL("PropertyChanged",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
-	{ }
-};
-
 static void source_free(struct audio_device *dev)
 {
 	struct source *source = dev->source;
@@ -508,35 +401,18 @@ static void source_free(struct audio_device *dev)
 	dev->source = NULL;
 }
 
-static void path_unregister(void *data)
+void source_unregister(struct audio_device *dev)
 {
-	struct audio_device *dev = data;
-
-	DBG("Unregistered interface %s on path %s",
-			AUDIO_SOURCE_INTERFACE, device_get_path(dev->btd_dev));
+	DBG("%s", device_get_path(dev->btd_dev));
 
 	source_free(dev);
 }
 
-void source_unregister(struct audio_device *dev)
-{
-	g_dbus_unregister_interface(btd_get_dbus_connection(),
-			device_get_path(dev->btd_dev), AUDIO_SOURCE_INTERFACE);
-}
-
 struct source *source_init(struct audio_device *dev)
 {
 	struct source *source;
 
-	if (!g_dbus_register_interface(btd_get_dbus_connection(),
-					device_get_path(dev->btd_dev),
-					AUDIO_SOURCE_INTERFACE,
-					source_methods, source_signals, NULL,
-					dev, path_unregister))
-		return NULL;
-
-	DBG("Registered interface %s on path %s",
-			AUDIO_SOURCE_INTERFACE, device_get_path(dev->btd_dev));
+	DBG("%s", device_get_path(dev->btd_dev));
 
 	if (avdtp_callback_id == 0)
 		avdtp_callback_id = avdtp_add_state_cb(avdtp_state_callback,
-- 
1.7.11.7

