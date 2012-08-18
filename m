Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v3 15/15] audio: device: Use DBus.Properties
Date: Sat, 18 Aug 2012 03:51:02 -0300
Message-Id: <1345272662-2850-16-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/device.c | 48 ++++++++++++++++++------------------------------
 1 file changed, 18 insertions(+), 30 deletions(-)

diff --git a/audio/device.c b/audio/device.c
index 9507eac..ec6dc43 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -279,9 +279,8 @@ static void device_set_state(struct audio_device *dev, audio_state_t new_state)
 		g_dbus_send_message(dev->conn, reply);
 	}
 
-	emit_property_changed(dev->conn, dev->path,
-				AUDIO_INTERFACE, "State",
-				DBUS_TYPE_STRING, &state_str);
+	g_dbus_emit_property_changed(dev->conn, dev->path,
+						AUDIO_INTERFACE, "State");
 }
 
 static gboolean avdtp_connect_timeout(gpointer user_data)
@@ -586,48 +585,37 @@ static DBusMessage *dev_disconnect(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
-static DBusMessage *dev_get_properties(DBusConnection *conn, DBusMessage *msg,
+static gboolean dev_prop_exists_state(const GDBusPropertyTable *property,
 								void *data)
 {
 	struct audio_device *device = data;
-	DBusMessage *reply;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
-	const char *state;
+	const char *state = state2str(device->priv->state);
 
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	dbus_message_iter_init_append(reply, &iter);
+	return state != NULL;
+}
 
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+static gboolean dev_prop_get_state(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct audio_device *device = data;
+	const char *state = state2str(device->priv->state);
 
-	/* State */
-	state = state2str(device->priv->state);
-	if (state)
-		dict_append_entry(&dict, "State", DBUS_TYPE_STRING, &state);
+	if (state == NULL)
+		return FALSE;
 
-	dbus_message_iter_close_container(&iter, &dict);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &state);
 
-	return reply;
+	return TRUE;
 }
 
 static const GDBusMethodTable dev_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, dev_connect) },
 	{ GDBUS_METHOD("Disconnect", NULL, NULL, dev_disconnect) },
-	{ GDBUS_METHOD("GetProperties",
-		NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-		dev_get_properties) },
 	{ }
 };
 
-static const GDBusSignalTable dev_signals[] = {
-	{ GDBUS_SIGNAL("PropertyChanged",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+static const GDBusPropertyTable dev_properties[] = {
+	{ "State", "s", dev_prop_get_state, NULL, dev_prop_exists_state },
 	{ }
 };
 
@@ -653,7 +641,7 @@ struct audio_device *audio_device_register(DBusConnection *conn,
 
 	if (!g_dbus_register_interface(dev->conn, dev->path,
 					AUDIO_INTERFACE,
-					dev_methods, dev_signals, NULL,
+					dev_methods, NULL, dev_properties,
 					dev, NULL)) {
 		error("Unable to register %s on %s", AUDIO_INTERFACE,
 								dev->path);
-- 
1.7.11.5

