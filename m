Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] attrib: Convert properties to DBus.Properties
Date: Fri, 9 Nov 2012 17:48:38 +0100
Message-ID: <1352479718-16803-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c | 258 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 131 insertions(+), 127 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index c7bceed..5cec0fe 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -287,38 +287,6 @@ static int watcher_cmp(gconstpointer a, gconstpointer b)
 	return g_strcmp0(watcher->path, match->path);
 }
 
-static void append_char_dict(DBusMessageIter *iter, struct characteristic *chr)
-{
-	DBusMessageIter dict;
-	const char *name;
-	char *uuid;
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
-
-	uuid = g_strdup(chr->type);
-	dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING, &uuid);
-	g_free(uuid);
-
-	name = get_char_name(chr->type);
-	if (name)
-		dict_append_entry(&dict, "Name", DBUS_TYPE_STRING, &name);
-
-	if (chr->desc)
-		dict_append_entry(&dict, "Description", DBUS_TYPE_STRING,
-								&chr->desc);
-
-	if (chr->value)
-		dict_append_array(&dict, "Value", DBUS_TYPE_BYTE, &chr->value,
-								chr->vlen);
-
-	/* FIXME: Missing Format, Value and Representation */
-
-	dbus_message_iter_close_container(iter, &dict);
-}
-
 static void watcher_exit(DBusConnection *conn, void *user_data)
 {
 	struct watcher *watcher = user_data;
@@ -538,92 +506,135 @@ static DBusMessage *unregister_watcher(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
-static DBusMessage *set_value(DBusMessage *msg,
-			DBusMessageIter *iter, struct characteristic *chr)
+static gboolean property_get_char_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
-	struct gatt_service *gatt = chr->gatt;
-	DBusMessageIter sub;
-	uint8_t *value;
-	int len;
+	struct characteristic *ch = data;
+	const char *uuid = ch->type;
 
-	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY ||
-			dbus_message_iter_get_element_type(iter) != DBUS_TYPE_BYTE)
-		return btd_error_invalid_args(msg);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
 
-	dbus_message_iter_recurse(iter, &sub);
+	return TRUE;
+}
 
-	dbus_message_iter_get_fixed_array(&sub, &value, &len);
+static gboolean property_get_char_name(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct characteristic *ch = data;
+	const char *name;
 
-	characteristic_set_value(chr, value, len);
+	name = get_char_name(ch->type);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &name);
 
-	if (gatt->attioid == 0)
-		gatt->attioid = btd_device_add_attio_callback(gatt->dev,
-							attio_connected,
-							attio_disconnected,
-							gatt);
+	return TRUE;
+}
 
-	if (gatt->attrib)
-		gatt_write_cmd(gatt->attrib, chr->handle, value, len,
-								NULL, NULL);
-	else
-		gatt->offline_chars = g_slist_append(gatt->offline_chars, chr);
+static gboolean property_exists_char_name(
+				const GDBusPropertyTable *property, void *data)
+{
+	struct characteristic *ch = data;
 
-	return dbus_message_new_method_return(msg);
+	if (get_char_name(ch->type) == NULL)
+		return FALSE;
+
+	return TRUE;
 }
 
-static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
-								void *data)
+static gboolean property_get_char_description(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
-	struct characteristic *chr = data;
-	DBusMessage *reply;
-	DBusMessageIter iter;
+	struct characteristic *ch = data;
+	const char *desc = ch->desc;
 
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &desc);
 
-	dbus_message_iter_init_append(reply, &iter);
+	return TRUE;
+}
 
-	append_char_dict(&iter, chr);
+static gboolean property_exists_char_description(
+				const GDBusPropertyTable *property, void *data)
+{
+	struct characteristic *ch = data;
 
-	return reply;
+	if (ch->desc == NULL)
+		return FALSE;
+
+	return TRUE;
 }
 
-static DBusMessage *set_property(DBusConnection *conn,
-					DBusMessage *msg, void *data)
+static gboolean property_get_char_value(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
-	struct characteristic *chr = data;
-	DBusMessageIter iter;
-	DBusMessageIter sub;
-	const char *property;
+	struct characteristic *ch = data;
+	DBusMessageIter entry;
 
-	if (!dbus_message_iter_init(msg, &iter))
-		return btd_error_invalid_args(msg);
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_BYTE_AS_STRING, &entry);
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-		return btd_error_invalid_args(msg);
+	dbus_message_iter_append_fixed_array(&entry, DBUS_TYPE_BYTE,
+							&ch->value, ch->vlen);
 
-	dbus_message_iter_get_basic(&iter, &property);
-	dbus_message_iter_next(&iter);
+	dbus_message_iter_close_container(iter, &entry);
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
-		return btd_error_invalid_args(msg);
+	return TRUE;
+}
+
+static void property_set_char_value(const GDBusPropertyTable *property,
+		DBusMessageIter *iter, GDBusPendingPropertySet id, void *data)
+{
+	struct characteristic *ch = data;
+	struct gatt_service *gatt = ch->gatt;
+	DBusMessageIter entry;
+	uint8_t *value;
+	int len;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY ||
+		dbus_message_iter_get_element_type(iter) != DBUS_TYPE_BYTE)
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+
+	dbus_message_iter_recurse(iter, &entry);
+
+	dbus_message_iter_get_fixed_array(&entry, &value, &len);
 
-	dbus_message_iter_recurse(&iter, &sub);
+	characteristic_set_value(ch, value, len);
+
+	if (gatt->attioid == 0)
+		gatt->attioid = btd_device_add_attio_callback(gatt->dev,
+							attio_connected,
+							attio_disconnected,
+							gatt);
+
+	if (gatt->attrib)
+		gatt_write_cmd(gatt->attrib, ch->handle, value, len,
+								NULL, NULL);
+	else
+		gatt->offline_chars = g_slist_append(gatt->offline_chars, ch);
+
+	g_dbus_pending_property_success(id);
+}
+
+static gboolean property_exists_char_value(
+				const GDBusPropertyTable *property, void *data)
+{
+	struct characteristic *ch = data;
 
-	if (g_str_equal("Value", property))
-		return set_value(msg, &sub, chr);
+	if (ch->value == NULL)
+		return FALSE;
 
-	return btd_error_invalid_args(msg);
+	return TRUE;
 }
 
-static const GDBusMethodTable char_methods[] = {
-	{ GDBUS_METHOD("GetProperties",
-			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			get_properties) },
-	{ GDBUS_ASYNC_METHOD("SetProperty",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
-			set_property) },
+static const GDBusPropertyTable char_properties[] = {
+	{ "UUID", "s", property_get_char_uuid },
+	{ "Name", "s", property_get_char_name, NULL,
+					property_exists_char_name },
+	{ "Description", "s", property_get_char_description, NULL,
+					property_exists_char_description },
+	{ "Value", "ay", property_get_char_value, property_set_char_value,
+					property_exists_char_value },
 	{ }
 };
 
@@ -673,7 +684,7 @@ static void register_characteristic(gpointer data, gpointer user_data)
 
 	g_dbus_register_interface(btd_get_dbus_connection(),
 					chr->path, CHAR_INTERFACE,
-					char_methods, NULL, NULL, chr, NULL);
+					NULL, NULL, char_properties, chr, NULL);
 
 	DBG("Registered: %s", chr->path);
 }
@@ -1091,48 +1102,45 @@ static DBusMessage *discover_char(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
-static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
-								void *data)
+static gboolean property_get_prim_characteristics(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
 	struct gatt_service *gatt = data;
-	DBusMessage *reply;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
+	DBusMessageIter entry;
 	GSList *l;
-	char **chars;
-	const char *uuid;
-	int i;
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
 
-	chars = g_new0(char *, g_slist_length(gatt->chars) + 1);
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_OBJECT_PATH_AS_STRING, &entry);
 
-	for (i = 0, l = gatt->chars; l; l = l->next, i++) {
-		struct characteristic *chr = l->data;
-		chars[i] = chr->path;
+	for (l = gatt->chars; l != NULL; l = l->next) {
+		struct characteristic *ch = l->data;
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH,
+							&ch->path);
 	}
 
-	dict_append_array(&dict, "Characteristics", DBUS_TYPE_OBJECT_PATH,
-								&chars, i);
-	uuid = gatt->prim->uuid;
-	dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING, &uuid);
+	dbus_message_iter_close_container(iter, &entry);
 
-	g_free(chars);
+	return TRUE;
+}
 
-	dbus_message_iter_close_container(&iter, &dict);
+static gboolean property_get_prim_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct gatt_service *gatt = data;
+	const char *uuid = gatt->prim->uuid;
 
-	return reply;
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
+
+	return TRUE;
 }
 
+static const GDBusPropertyTable prim_properties[] = {
+	{ "Characteristics", "ao", property_get_prim_characteristics },
+	{ "UUID", "s", property_get_prim_uuid },
+	{ }
+};
+
 static const GDBusMethodTable prim_methods[] = {
 	{ GDBUS_ASYNC_METHOD("DiscoverCharacteristics",
 			NULL, GDBUS_ARGS({ "characteristics", "ao" }),
@@ -1143,10 +1151,6 @@ static const GDBusMethodTable prim_methods[] = {
 	{ GDBUS_METHOD("UnregisterCharacteristicsWatcher",
 			GDBUS_ARGS({ "agent", "o" }), NULL,
 			unregister_watcher) },
-	{ GDBUS_METHOD("GetProperties",
-			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			prim_get_properties) },
-	{ }
 };
 
 static struct gatt_service *primary_register(struct btd_device *device,
@@ -1167,7 +1171,7 @@ static struct gatt_service *primary_register(struct btd_device *device,
 
 	g_dbus_register_interface(btd_get_dbus_connection(), gatt->path,
 					CHAR_INTERFACE, prim_methods,
-					NULL, NULL, gatt, NULL);
+					NULL, prim_properties, gatt, NULL);
 	gatt->chars = load_characteristics(gatt, prim->range.start);
 	g_slist_foreach(gatt->chars, register_characteristic, gatt->path);
 
-- 
1.8.0

