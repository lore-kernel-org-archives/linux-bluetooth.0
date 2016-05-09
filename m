Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 BlueZ 6/6] tools/gatt-service: Update to use new GATT API
Date: Mon,  9 May 2016 16:51:23 +0300
Message-Id: <1462801883-6361-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1462801883-6361-1-git-send-email-luiz.dentz@gmail.com>
References: <1462801883-6361-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This update use of ReadValue and WriteValue to include the options
introduced in the API.
---
 tools/gatt-service.c | 159 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 126 insertions(+), 33 deletions(-)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index 329d1af..0c78c4d 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -29,6 +29,7 @@
 #include <stdio.h>
 #include <stdbool.h>
 #include <unistd.h>
+#include <string.h>
 #include <sys/signalfd.h>
 
 #include <glib.h>
@@ -127,32 +128,48 @@ static gboolean desc_get_value(const GDBusPropertyTable *property,
 	return desc_read(desc, iter);
 }
 
-static void desc_write(struct descriptor *desc, DBusMessageIter *iter)
+static void desc_write(struct descriptor *desc, const uint8_t *value, int len)
 {
-	DBusMessageIter array;
-	const uint8_t *value;
-	int vlen;
-
-	dbus_message_iter_recurse(iter, &array);
-	dbus_message_iter_get_fixed_array(&array, &value, &vlen);
-
 	g_free(desc->value);
-	desc->value = g_memdup(value, vlen);
-	desc->vlen = vlen;
+	desc->value = g_memdup(value, len);
+	desc->vlen = len;
 
 	g_dbus_emit_property_changed(connection, desc->path,
 					GATT_DESCRIPTOR_IFACE, "Value");
 }
 
+static int parse_value(DBusMessageIter *iter, const uint8_t **value, int *len)
+{
+	DBusMessageIter array;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
+		return -EINVAL;
+
+	dbus_message_iter_recurse(iter, &array);
+	dbus_message_iter_get_fixed_array(&array, value, len);
+
+	return 0;
+}
+
 static void desc_set_value(const GDBusPropertyTable *property,
 				DBusMessageIter *iter,
 				GDBusPendingPropertySet id, void *user_data)
 {
 	struct descriptor *desc = user_data;
+	const uint8_t *value;
+	int len;
 
 	printf("Descriptor(%s): Set(\"Value\", ...)\n", desc->uuid);
 
-	desc_write(desc, iter);
+	if (parse_value(iter, &value, &len)) {
+		printf("Invalid value for Set('Value'...)\n");
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+		return;
+	}
+
+	desc_write(desc, value, len);
 
 	g_dbus_pending_property_success(id);
 }
@@ -249,15 +266,8 @@ static gboolean chr_get_props(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static void chr_write(struct characteristic *chr, DBusMessageIter *iter)
+static void chr_write(struct characteristic *chr, const uint8_t *value, int len)
 {
-	DBusMessageIter array;
-	uint8_t *value;
-	int len;
-
-	dbus_message_iter_recurse(iter, &array);
-	dbus_message_iter_get_fixed_array(&array, &value, &len);
-
 	g_free(chr->value);
 	chr->value = g_memdup(value, len);
 	chr->vlen = len;
@@ -271,10 +281,12 @@ static void chr_set_value(const GDBusPropertyTable *property,
 				GDBusPendingPropertySet id, void *user_data)
 {
 	struct characteristic *chr = user_data;
+	const uint8_t *value;
+	int len;
 
 	printf("Characteristic(%s): Set('Value', ...)\n", chr->uuid);
 
-	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY) {
+	if (!parse_value(iter, &value, &len)) {
 		printf("Invalid value for Set('Value'...)\n");
 		g_dbus_pending_property_error(id,
 					ERROR_INTERFACE ".InvalidArguments",
@@ -282,7 +294,7 @@ static void chr_set_value(const GDBusPropertyTable *property,
 		return;
 	}
 
-	chr_write(chr, iter);
+	chr_write(chr, value, len);
 
 	g_dbus_pending_property_success(id);
 }
@@ -368,12 +380,53 @@ static void desc_iface_destroy(gpointer user_data)
 	g_free(desc);
 }
 
+static int parse_options(DBusMessageIter *iter, const char **device)
+{
+	DBusMessageIter dict;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
+		return -EINVAL;
+
+	dbus_message_iter_recurse(iter, &dict);
+
+	while (dbus_message_iter_get_arg_type(&dict) == DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+		DBusMessageIter value, entry;
+		int var;
+
+		dbus_message_iter_recurse(&dict, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		var = dbus_message_iter_get_arg_type(&value);
+		if (strcasecmp(key, "device") == 0) {
+			if (var != DBUS_TYPE_OBJECT_PATH)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, device);
+			printf("Device: %s\n", *device);
+		}
+	}
+
+	return 0;
+}
+
 static DBusMessage *chr_read_value(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
 	struct characteristic *chr = user_data;
 	DBusMessage *reply;
 	DBusMessageIter iter;
+	const char *device;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return g_dbus_create_error(msg, DBUS_ERROR_INVALID_ARGS,
+							"Invalid arguments");
+
+	if (parse_options(&iter, &device))
+		return g_dbus_create_error(msg, DBUS_ERROR_INVALID_ARGS,
+							"Invalid arguments");
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
@@ -392,10 +445,21 @@ static DBusMessage *chr_write_value(DBusConnection *conn, DBusMessage *msg,
 {
 	struct characteristic *chr = user_data;
 	DBusMessageIter iter;
+	const uint8_t *value;
+	int len;
+	const char *device;
 
 	dbus_message_iter_init(msg, &iter);
 
-	chr_write(chr, &iter);
+	if (parse_value(&iter, &value, &len))
+		return g_dbus_create_error(msg, DBUS_ERROR_INVALID_ARGS,
+							"Invalid arguments");
+
+	if (parse_options(&iter, &device))
+		return g_dbus_create_error(msg, DBUS_ERROR_INVALID_ARGS,
+							"Invalid arguments");
+
+	chr_write(chr, value, len);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -415,10 +479,12 @@ static DBusMessage *chr_stop_notify(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable chr_methods[] = {
-	{ GDBUS_ASYNC_METHOD("ReadValue", NULL, GDBUS_ARGS({ "value", "ay" }),
-						chr_read_value) },
-	{ GDBUS_ASYNC_METHOD("WriteValue", GDBUS_ARGS({ "value", "ay" }),
-						NULL, chr_write_value) },
+	{ GDBUS_ASYNC_METHOD("ReadValue", GDBUS_ARGS({ "options", "a{sv}" }),
+					GDBUS_ARGS({ "value", "ay" }),
+					chr_read_value) },
+	{ GDBUS_ASYNC_METHOD("WriteValue", GDBUS_ARGS({ "value", "ay" },
+						{ "options", "a{sv}" }),
+					NULL, chr_write_value) },
 	{ GDBUS_ASYNC_METHOD("StartNotify", NULL, NULL, chr_start_notify) },
 	{ GDBUS_METHOD("StopNotify", NULL, NULL, chr_stop_notify) },
 	{ }
@@ -430,6 +496,15 @@ static DBusMessage *desc_read_value(DBusConnection *conn, DBusMessage *msg,
 	struct descriptor *desc = user_data;
 	DBusMessage *reply;
 	DBusMessageIter iter;
+	const char *device;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return g_dbus_create_error(msg, DBUS_ERROR_INVALID_ARGS,
+							"Invalid arguments");
+
+	if (parse_options(&iter, &device))
+		return g_dbus_create_error(msg, DBUS_ERROR_INVALID_ARGS,
+							"Invalid arguments");
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
@@ -438,6 +513,10 @@ static DBusMessage *desc_read_value(DBusConnection *conn, DBusMessage *msg,
 
 	dbus_message_iter_init_append(reply, &iter);
 
+	if (parse_options(&iter, &device))
+		return g_dbus_create_error(msg, DBUS_ERROR_INVALID_ARGS,
+							"Invalid arguments");
+
 	desc_read(desc, &iter);
 
 	return reply;
@@ -448,20 +527,34 @@ static DBusMessage *desc_write_value(DBusConnection *conn, DBusMessage *msg,
 {
 	struct descriptor *desc = user_data;
 	DBusMessageIter iter;
+	const char *device;
+	const uint8_t *value;
+	int len;
 
-	dbus_message_iter_init(msg, &iter);
+	if (!dbus_message_iter_init(msg, &iter))
+		return g_dbus_create_error(msg, DBUS_ERROR_INVALID_ARGS,
+							"Invalid arguments");
+
+	if (parse_value(&iter, &value, &len))
+		return g_dbus_create_error(msg, DBUS_ERROR_INVALID_ARGS,
+							"Invalid arguments");
+
+	if (parse_options(&iter, &device))
+		return g_dbus_create_error(msg, DBUS_ERROR_INVALID_ARGS,
+							"Invalid arguments");
 
-	desc_write(desc, &iter);
+	desc_write(desc, value, len);
 
 	return dbus_message_new_method_return(msg);
 }
 
 static const GDBusMethodTable desc_methods[] = {
-	{ GDBUS_ASYNC_METHOD("ReadValue", NULL, GDBUS_ARGS({ "value", "ay" }),
-						desc_read_value) },
-	{ GDBUS_ASYNC_METHOD("WriteValue", GDBUS_ARGS({ "value", "ay" }),
-						NULL,
-						desc_write_value) },
+	{ GDBUS_ASYNC_METHOD("ReadValue", GDBUS_ARGS({ "options", "a{sv}" }),
+					GDBUS_ARGS({ "value", "ay" }),
+					desc_read_value) },
+	{ GDBUS_ASYNC_METHOD("WriteValue", GDBUS_ARGS({ "value", "ay" },
+						{ "options", "a{sv}" }),
+					NULL, desc_write_value) },
 	{ }
 };
 
-- 
2.5.5

