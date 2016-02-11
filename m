Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] tools/gatt-service: Add missing methods
Date: Thu, 11 Feb 2016 13:44:41 +0200
Message-Id: <1455191081-24550-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1455191081-24550-1-git-send-email-luiz.dentz@gmail.com>
References: <1455191081-24550-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the missing methods of GattCharacteristic and GattDescriptor
interfaces.
---
 tools/gatt-service.c | 185 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 153 insertions(+), 32 deletions(-)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index 80980f7..329d1af 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -101,14 +101,10 @@ static gboolean desc_get_characteristic(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean desc_get_value(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *user_data)
+static bool desc_read(struct descriptor *desc, DBusMessageIter *iter)
 {
-	struct descriptor *desc = user_data;
 	DBusMessageIter array;
 
-	printf("Descriptor(%s): Get(\"Value\")\n", desc->uuid);
-
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 					DBUS_TYPE_BYTE_AS_STRING, &array);
 
@@ -118,20 +114,25 @@ static gboolean desc_get_value(const GDBusPropertyTable *property,
 
 	dbus_message_iter_close_container(iter, &array);
 
-	return TRUE;
+	return true;
 }
 
-static void desc_set_value(const GDBusPropertyTable *property,
-				DBusMessageIter *iter,
-				GDBusPendingPropertySet id, void *user_data)
+static gboolean desc_get_value(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
 {
 	struct descriptor *desc = user_data;
+
+	printf("Descriptor(%s): Get(\"Value\")\n", desc->uuid);
+
+	return desc_read(desc, iter);
+}
+
+static void desc_write(struct descriptor *desc, DBusMessageIter *iter)
+{
 	DBusMessageIter array;
 	const uint8_t *value;
 	int vlen;
 
-	printf("Descriptor(%s): Set(\"Value\", ...)\n", desc->uuid);
-
 	dbus_message_iter_recurse(iter, &array);
 	dbus_message_iter_get_fixed_array(&array, &value, &vlen);
 
@@ -139,11 +140,21 @@ static void desc_set_value(const GDBusPropertyTable *property,
 	desc->value = g_memdup(value, vlen);
 	desc->vlen = vlen;
 
-	g_dbus_pending_property_success(id);
-
 	g_dbus_emit_property_changed(connection, desc->path,
 					GATT_DESCRIPTOR_IFACE, "Value");
+}
+
+static void desc_set_value(const GDBusPropertyTable *property,
+				DBusMessageIter *iter,
+				GDBusPendingPropertySet id, void *user_data)
+{
+	struct descriptor *desc = user_data;
+
+	printf("Descriptor(%s): Set(\"Value\", ...)\n", desc->uuid);
 
+	desc_write(desc, iter);
+
+	g_dbus_pending_property_success(id);
 }
 
 static gboolean desc_get_props(const GDBusPropertyTable *property,
@@ -194,14 +205,10 @@ static gboolean chr_get_service(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean chr_get_value(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *user_data)
+static bool chr_read(struct characteristic *chr, DBusMessageIter *iter)
 {
-	struct characteristic *chr = user_data;
 	DBusMessageIter array;
 
-	printf("Characteristic(%s): Get(\"Value\")\n", chr->uuid);
-
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 					DBUS_TYPE_BYTE_AS_STRING, &array);
 
@@ -210,7 +217,17 @@ static gboolean chr_get_value(const GDBusPropertyTable *property,
 
 	dbus_message_iter_close_container(iter, &array);
 
-	return TRUE;
+	return true;
+}
+
+static gboolean chr_get_value(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct characteristic *chr = user_data;
+
+	printf("Characteristic(%s): Get(\"Value\")\n", chr->uuid);
+
+	return chr_read(chr, iter);
 }
 
 static gboolean chr_get_props(const GDBusPropertyTable *property,
@@ -232,14 +249,28 @@ static gboolean chr_get_props(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static void chr_write(struct characteristic *chr, DBusMessageIter *iter)
+{
+	DBusMessageIter array;
+	uint8_t *value;
+	int len;
+
+	dbus_message_iter_recurse(iter, &array);
+	dbus_message_iter_get_fixed_array(&array, &value, &len);
+
+	g_free(chr->value);
+	chr->value = g_memdup(value, len);
+	chr->vlen = len;
+
+	g_dbus_emit_property_changed(connection, chr->path, GATT_CHR_IFACE,
+								"Value");
+}
+
 static void chr_set_value(const GDBusPropertyTable *property,
 				DBusMessageIter *iter,
 				GDBusPendingPropertySet id, void *user_data)
 {
 	struct characteristic *chr = user_data;
-	DBusMessageIter array;
-	uint8_t *value;
-	int len;
 
 	printf("Characteristic(%s): Set('Value', ...)\n", chr->uuid);
 
@@ -251,16 +282,9 @@ static void chr_set_value(const GDBusPropertyTable *property,
 		return;
 	}
 
-	dbus_message_iter_recurse(iter, &array);
-	dbus_message_iter_get_fixed_array(&array, &value, &len);
-
-	g_free(chr->value);
-	chr->value = g_memdup(value, len);
-	chr->vlen = len;
+	chr_write(chr, iter);
 
 	g_dbus_pending_property_success(id);
-	g_dbus_emit_property_changed(connection, chr->path,
-						GATT_CHR_IFACE, "Value");
 }
 
 static const GDBusPropertyTable chr_properties[] = {
@@ -344,6 +368,103 @@ static void desc_iface_destroy(gpointer user_data)
 	g_free(desc);
 }
 
+static DBusMessage *chr_read_value(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct characteristic *chr = user_data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return g_dbus_create_error(msg, DBUS_ERROR_NO_MEMORY,
+							"No Memory");
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	chr_read(chr, &iter);
+
+	return reply;
+}
+
+static DBusMessage *chr_write_value(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct characteristic *chr = user_data;
+	DBusMessageIter iter;
+
+	dbus_message_iter_init(msg, &iter);
+
+	chr_write(chr, &iter);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *chr_start_notify(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	return g_dbus_create_error(msg, DBUS_ERROR_NOT_SUPPORTED,
+							"Not Supported");
+}
+
+static DBusMessage *chr_stop_notify(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	return g_dbus_create_error(msg, DBUS_ERROR_NOT_SUPPORTED,
+							"Not Supported");
+}
+
+static const GDBusMethodTable chr_methods[] = {
+	{ GDBUS_ASYNC_METHOD("ReadValue", NULL, GDBUS_ARGS({ "value", "ay" }),
+						chr_read_value) },
+	{ GDBUS_ASYNC_METHOD("WriteValue", GDBUS_ARGS({ "value", "ay" }),
+						NULL, chr_write_value) },
+	{ GDBUS_ASYNC_METHOD("StartNotify", NULL, NULL, chr_start_notify) },
+	{ GDBUS_METHOD("StopNotify", NULL, NULL, chr_stop_notify) },
+	{ }
+};
+
+static DBusMessage *desc_read_value(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct descriptor *desc = user_data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return g_dbus_create_error(msg, DBUS_ERROR_NO_MEMORY,
+							"No Memory");
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	desc_read(desc, &iter);
+
+	return reply;
+}
+
+static DBusMessage *desc_write_value(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct descriptor *desc = user_data;
+	DBusMessageIter iter;
+
+	dbus_message_iter_init(msg, &iter);
+
+	desc_write(desc, &iter);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static const GDBusMethodTable desc_methods[] = {
+	{ GDBUS_ASYNC_METHOD("ReadValue", NULL, GDBUS_ARGS({ "value", "ay" }),
+						desc_read_value) },
+	{ GDBUS_ASYNC_METHOD("WriteValue", GDBUS_ARGS({ "value", "ay" }),
+						NULL,
+						desc_write_value) },
+	{ }
+};
+
 static gboolean register_characteristic(const char *chr_uuid,
 						const uint8_t *value, int vlen,
 						const char **props,
@@ -364,7 +485,7 @@ static gboolean register_characteristic(const char *chr_uuid,
 	chr->path = g_strdup_printf("%s/characteristic%d", service_path, id++);
 
 	if (!g_dbus_register_interface(connection, chr->path, GATT_CHR_IFACE,
-					NULL, NULL, chr_properties,
+					chr_methods, NULL, chr_properties,
 					chr, chr_iface_destroy)) {
 		printf("Couldn't register characteristic interface\n");
 		chr_iface_destroy(chr);
@@ -382,7 +503,7 @@ static gboolean register_characteristic(const char *chr_uuid,
 
 	if (!g_dbus_register_interface(connection, desc->path,
 					GATT_DESCRIPTOR_IFACE,
-					NULL, NULL, desc_properties,
+					desc_methods, NULL, desc_properties,
 					desc, desc_iface_destroy)) {
 		printf("Couldn't register descriptor interface\n");
 		g_dbus_unregister_interface(connection, chr->path,
-- 
2.5.0

