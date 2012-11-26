Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/11] audio: Remove Audio interface
Date: Mon, 26 Nov 2012 15:09:14 +0200
Message-Id: <1353935362-8666-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
References: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This interface is no longer needed as Device interface can now connect
the profiles and the state can be tracked using MediaTransport interface.
---
 doc/audio-api.txt       |  51 ---------------
 profiles/audio/device.c | 160 +-----------------------------------------------
 2 files changed, 2 insertions(+), 209 deletions(-)
 delete mode 100644 doc/audio-api.txt

diff --git a/doc/audio-api.txt b/doc/audio-api.txt
deleted file mode 100644
index 6fd8dfc..0000000
--- a/doc/audio-api.txt
+++ /dev/null
@@ -1,51 +0,0 @@
-BlueZ D-Bus Audio API description
-*********************************
-
-Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
-Copyright (C) 2005-2007  Johan Hedberg <johan.hedberg@nokia.com>
-Copyright (C) 2005-2006  Brad Midgley <bmidgley@xmission.com>
-
-Audio hierarchy
-===============
-
-Service		org.bluez
-Interface	org.bluez.Audio
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
-
-This is a generic audio interface that abstracts the different audio profiles.
-
-Methods		void Connect()
-
-			Connect all supported audio profiles on the device.
-
-		void Disconnect()
-
-			Disconnect all audio profiles on the device
-
-		dict GetProperties()
-
-			Returns all properties for the interface. See the
-			properties section for available properties.
-
-Signals		void PropertyChanged(string name, variant value)
-
-			This signal indicates a changed value of the given
-			property.
-
-Properties	string State
-
-			Possible values: "disconnected", "connecting",
-			"connected"
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
-			"connected" -> "disconnected"
-				Disconnected from the remote device
diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index 4cce6ba..b14f75b 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -74,9 +74,6 @@ struct dev_priv {
 	sink_state_t sink_state;
 	avctp_state_t avctp_state;
 
-	DBusMessage *conn_req;
-	DBusMessage *dc_req;
-
 	guint control_timer;
 	guint avdtp_timer;
 	guint dc_id;
@@ -97,10 +94,6 @@ static void device_free(struct audio_device *dev)
 			g_source_remove(priv->control_timer);
 		if (priv->avdtp_timer)
 			g_source_remove(priv->avdtp_timer);
-		if (priv->dc_req)
-			dbus_message_unref(priv->dc_req);
-		if (priv->conn_req)
-			dbus_message_unref(priv->conn_req);
 		if (priv->dc_id)
 			device_remove_disconnect_watch(dev->btd_dev,
 							priv->dc_id);
@@ -198,10 +191,8 @@ static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
 
 static void device_set_state(struct audio_device *dev, audio_state_t new_state)
 {
-	DBusConnection *conn = btd_get_dbus_connection();
 	struct dev_priv *priv = dev->priv;
 	const char *state_str;
-	DBusMessage *reply = NULL;
 
 	state_str = state2str(new_state);
 	if (!state_str)
@@ -225,31 +216,8 @@ static void device_set_state(struct audio_device *dev, audio_state_t new_state)
 
 	dev->priv->state = new_state;
 
-	if (new_state == AUDIO_STATE_DISCONNECTED) {
-		if (priv->dc_req) {
-			reply = dbus_message_new_method_return(priv->dc_req);
-			dbus_message_unref(priv->dc_req);
-			priv->dc_req = NULL;
-			g_dbus_send_message(conn, reply);
-		}
+	if (new_state == AUDIO_STATE_DISCONNECTED)
 		priv->disconnecting = FALSE;
-	}
-
-	if (priv->conn_req && new_state != AUDIO_STATE_CONNECTING) {
-		if (new_state == AUDIO_STATE_CONNECTED)
-			reply = dbus_message_new_method_return(priv->conn_req);
-		else
-			reply = btd_error_failed(priv->conn_req,
-							"Connect Failed");
-
-		dbus_message_unref(priv->conn_req);
-		priv->conn_req = NULL;
-		g_dbus_send_message(conn, reply);
-	}
-
-	emit_property_changed(device_get_path(dev->btd_dev),
-				AUDIO_INTERFACE, "State",
-				DBUS_TYPE_STRING, &state_str);
 }
 
 static void device_avdtp_cb(struct audio_device *dev, struct avdtp *session,
@@ -324,115 +292,6 @@ static void device_avctp_cb(struct audio_device *dev,
 	}
 }
 
-static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
-								void *data)
-{
-	struct audio_device *dev = data;
-	struct dev_priv *priv = dev->priv;
-
-	if (priv->state == AUDIO_STATE_CONNECTING)
-		return btd_error_in_progress(msg);
-	else if (priv->state == AUDIO_STATE_CONNECTED)
-		return btd_error_already_connected(msg);
-
-	dev->auto_connect = TRUE;
-
-	if (priv->state != AUDIO_STATE_CONNECTING && dev->sink) {
-		struct avdtp *session = avdtp_get(&dev->src, &dev->dst);
-
-		if (!session)
-			return btd_error_failed(msg,
-					"Failed to get AVDTP session");
-
-		sink_setup_stream(dev->sink, session);
-		avdtp_unref(session);
-	}
-
-	/* The previous calls should cause a call to the state callback to
-	 * indicate AUDIO_STATE_CONNECTING */
-	if (priv->state != AUDIO_STATE_CONNECTING)
-		return btd_error_failed(msg, "Connect Failed");
-
-	priv->conn_req = dbus_message_ref(msg);
-
-	return NULL;
-}
-
-static DBusMessage *dev_disconnect(DBusConnection *conn, DBusMessage *msg,
-								void *data)
-{
-	struct audio_device *dev = data;
-	struct dev_priv *priv = dev->priv;
-
-	if (priv->state == AUDIO_STATE_DISCONNECTED)
-		return btd_error_not_connected(msg);
-
-	if (priv->dc_req)
-		return dbus_message_new_method_return(msg);
-
-	priv->dc_req = dbus_message_ref(msg);
-
-	if (dev->control) {
-		device_remove_control_timer(dev);
-		avrcp_disconnect(dev);
-	}
-
-	if (dev->sink && priv->sink_state != SINK_STATE_DISCONNECTED)
-		sink_disconnect(dev, TRUE, NULL, NULL);
-	else {
-		dbus_message_unref(priv->dc_req);
-		priv->dc_req = NULL;
-		return dbus_message_new_method_return(msg);
-	}
-
-	return NULL;
-}
-
-static DBusMessage *dev_get_properties(DBusConnection *conn, DBusMessage *msg,
-								void *data)
-{
-	struct audio_device *device = data;
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
-	state = state2str(device->priv->state);
-	if (state)
-		dict_append_entry(&dict, "State", DBUS_TYPE_STRING, &state);
-
-	dbus_message_iter_close_container(&iter, &dict);
-
-	return reply;
-}
-
-static const GDBusMethodTable dev_methods[] = {
-	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, dev_connect) },
-	{ GDBUS_METHOD("Disconnect", NULL, NULL, dev_disconnect) },
-	{ GDBUS_METHOD("GetProperties",
-		NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-		dev_get_properties) },
-	{ }
-};
-
-static const GDBusSignalTable dev_signals[] = {
-	{ GDBUS_SIGNAL("PropertyChanged",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
-	{ }
-};
-
 struct audio_device *audio_device_register(struct btd_device *device,
 							const bdaddr_t *src,
 							const bdaddr_t *dst)
@@ -447,18 +306,7 @@ struct audio_device *audio_device_register(struct btd_device *device,
 	dev->priv = g_new0(struct dev_priv, 1);
 	dev->priv->state = AUDIO_STATE_DISCONNECTED;
 
-	if (!g_dbus_register_interface(btd_get_dbus_connection(),
-					device_get_path(dev->btd_dev),
-					AUDIO_INTERFACE, dev_methods,
-					dev_signals, NULL, dev, NULL)) {
-		error("Unable to register %s on %s", AUDIO_INTERFACE,
-						device_get_path(dev->btd_dev));
-		device_free(dev);
-		return NULL;
-	}
-
-	DBG("Registered interface %s on path %s", AUDIO_INTERFACE,
-						device_get_path(dev->btd_dev));
+	DBG("%s", device_get_path(dev->btd_dev));
 
 	if (sink_callback_id == 0)
 		sink_callback_id = sink_add_state_cb(device_sink_cb, NULL);
@@ -507,9 +355,5 @@ void audio_device_unregister(struct audio_device *device)
 	if (device->control)
 		control_unregister(device);
 
-	g_dbus_unregister_interface(btd_get_dbus_connection(),
-					device_get_path(device->btd_dev),
-					AUDIO_INTERFACE);
-
 	device_free(device);
 }
-- 
1.7.11.7

