Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v3 14/15] control: Use DBus.Properties
Date: Sat, 18 Aug 2012 03:51:01 -0300
Message-Id: <1345272662-2850-15-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c | 56 +++++++++++++++++---------------------------------------
 1 file changed, 17 insertions(+), 39 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 187f838..dc15ca4 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -68,7 +68,6 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 				avctp_state_t new_state, void *user_data)
 {
 	struct control *control = dev->control;
-	gboolean value;
 
 	switch (new_state) {
 	case AVCTP_STATE_DISCONNECTED:
@@ -77,13 +76,11 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		if (old_state != AVCTP_STATE_CONNECTED)
 			break;
 
-		value = FALSE;
 		g_dbus_emit_signal(dev->conn, dev->path,
 					AUDIO_CONTROL_INTERFACE,
 					"Disconnected", DBUS_TYPE_INVALID);
-		emit_property_changed(dev->conn, dev->path,
-					AUDIO_CONTROL_INTERFACE, "Connected",
-					DBUS_TYPE_BOOLEAN, &value);
+		g_dbus_emit_property_changed(dev->conn, dev->path,
+					AUDIO_CONTROL_INTERFACE, "Connected");
 
 		break;
 	case AVCTP_STATE_CONNECTING:
@@ -94,13 +91,11 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 
 		break;
 	case AVCTP_STATE_CONNECTED:
-		value = TRUE;
 		g_dbus_emit_signal(dev->conn, dev->path,
 				AUDIO_CONTROL_INTERFACE, "Connected",
 				DBUS_TYPE_INVALID);
-		emit_property_changed(dev->conn, dev->path,
-				AUDIO_CONTROL_INTERFACE, "Connected",
-				DBUS_TYPE_BOOLEAN, &value);
+		g_dbus_emit_property_changed(dev->conn, dev->path,
+				AUDIO_CONTROL_INTERFACE, "Connected");
 		break;
 	default:
 		return;
@@ -168,42 +163,21 @@ static DBusMessage *volume_down(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
-static DBusMessage *control_get_properties(DBusConnection *conn,
-					DBusMessage *msg, void *data)
+static gboolean control_prop_get_connected(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
 	struct audio_device *device = data;
-	DBusMessage *reply;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
-	gboolean value;
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
+	dbus_bool_t value =  (device->control->session != NULL);
 
-	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
 
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
-
-	/* Connected */
-	value = (device->control->session != NULL);
-	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN, &value);
-
-	dbus_message_iter_close_container(&iter, &dict);
-
-	return reply;
+	return TRUE;
 }
 
 static const GDBusMethodTable control_methods[] = {
 	{ GDBUS_DEPRECATED_METHOD("IsConnected",
 				NULL, GDBUS_ARGS({ "connected", "b" }),
 				control_is_connected) },
-	{ GDBUS_METHOD("GetProperties",
-				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-				control_get_properties) },
 	{ GDBUS_METHOD("VolumeUp", NULL, NULL, volume_up) },
 	{ GDBUS_METHOD("VolumeDown", NULL, NULL, volume_down) },
 	{ }
@@ -212,11 +186,14 @@ static const GDBusMethodTable control_methods[] = {
 static const GDBusSignalTable control_signals[] = {
 	{ GDBUS_DEPRECATED_SIGNAL("Connected", NULL) },
 	{ GDBUS_DEPRECATED_SIGNAL("Disconnected", NULL) },
-	{ GDBUS_SIGNAL("PropertyChanged",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 
+static const GDBusPropertyTable control_properties[] = {
+	{ "Connected", "b", control_prop_get_connected },
+	{}
+};
+
 static void path_unregister(void *data)
 {
 	struct audio_device *dev = data;
@@ -250,8 +227,9 @@ struct control *control_init(struct audio_device *dev, uint16_t uuid16)
 
 	if (!g_dbus_register_interface(dev->conn, dev->path,
 					AUDIO_CONTROL_INTERFACE,
-					control_methods, control_signals, NULL,
-					dev, path_unregister))
+					control_methods, control_signals,
+					control_properties, dev,
+					path_unregister))
 		return NULL;
 
 	DBG("Registered interface %s on path %s",
-- 
1.7.11.5

