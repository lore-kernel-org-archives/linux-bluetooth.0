Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ] input: Convert to DBus.Properties
Date: Thu, 11 Oct 2012 15:57:48 -0300
Message-Id: <1349981868-1263-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/input/device.c | 44 +++++++++++++-------------------------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 92e1fa9..997235b 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -729,33 +729,18 @@ static void device_unregister(void *data)
 	input_device_free(idev);
 }
 
-static DBusMessage *input_device_get_properties(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	struct input_device *idev = data;
-	DBusMessage *reply;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
-	dbus_bool_t connected;
 
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
 
-	dbus_message_iter_init_append(reply, &iter);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
-
-	/* Connected */
-	connected = is_connected(idev);
-	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN, &connected);
+static gboolean input_device_property_get_connected(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct input_device *idev = data;
+	dbus_bool_t connected = is_connected(idev);
 
-	dbus_message_iter_close_container(&iter, &dict);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &connected);
 
-	return reply;
+	return TRUE;
 }
 
 static const GDBusMethodTable device_methods[] = {
@@ -763,15 +748,11 @@ static const GDBusMethodTable device_methods[] = {
 				NULL, NULL, local_connect) },
 	{ GDBUS_METHOD("Disconnect",
 				NULL, NULL, input_device_disconnect) },
-	{ GDBUS_METHOD("GetProperties",
-			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			input_device_get_properties) },
 	{ }
 };
 
-static const GDBusSignalTable device_signals[] = {
-	{ GDBUS_SIGNAL("PropertyChanged",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+static const GDBusPropertyTable device_properties[] = {
+	{ "Connected", "b", input_device_property_get_connected },
 	{ }
 };
 
@@ -800,8 +781,9 @@ static struct input_device *input_device_new(struct btd_device *device,
 
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
 					idev->path, INPUT_DEVICE_INTERFACE,
-					device_methods, device_signals, NULL,
-					idev, device_unregister) == FALSE) {
+					device_methods, NULL,
+					device_properties, idev,
+					device_unregister) == FALSE) {
 		error("Failed to register interface %s on path %s",
 			INPUT_DEVICE_INTERFACE, path);
 		input_device_free(idev);
-- 
1.7.12.2

