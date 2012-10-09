Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 1/8] adapter: Add DBus.Properties getters
Date: Tue,  9 Oct 2012 04:59:49 -0300
Message-Id: <1349769596-6050-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

---
 src/adapter.c | 221 +++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 149 insertions(+), 72 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2f8c8a3..eb5fc83 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1113,106 +1113,169 @@ static DBusMessage *adapter_stop_discovery(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
-static DBusMessage *get_properties(DBusConnection *conn,
-					DBusMessage *msg, void *data)
+static gboolean adapter_property_get_address(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
 	struct btd_adapter *adapter = data;
-	const char *property;
-	DBusMessage *reply;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
 	char srcaddr[18];
-	gboolean value;
-	char **devices, **uuids;
-	int i;
-	GSList *l;
-	sdp_list_t *list;
+	const char *ptr;
 
 	ba2str(&adapter->bdaddr, srcaddr);
+	ptr = srcaddr;
 
-	if (check_address(srcaddr) < 0)
-		return btd_error_invalid_args(msg);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
 
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
+	return TRUE;
+}
 
-	dbus_message_iter_init_append(reply, &iter);
+static gboolean adapter_property_get_name(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter = data;
+	const char *ptr;
 
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+	ptr = adapter->name ?: "";
 
-	/* Address */
-	property = srcaddr;
-	dict_append_entry(&dict, "Address", DBUS_TYPE_STRING, &property);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
 
-	/* Name */
-	property = adapter->name ? : "";
+	return TRUE;
+}
 
-	dict_append_entry(&dict, "Name", DBUS_TYPE_STRING, &property);
+static gboolean adapter_property_get_class(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter = data;
 
-	/* Class */
-	dict_append_entry(&dict, "Class",
-				DBUS_TYPE_UINT32, &adapter->dev_class);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
+							&adapter->dev_class);
+
+	return TRUE;
+}
+
+static gboolean adapter_property_get_powered(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter = data;
+	dbus_bool_t value;
 
-	/* Powered */
 	value = (adapter->up && !adapter->off_requested) ? TRUE : FALSE;
-	dict_append_entry(&dict, "Powered", DBUS_TYPE_BOOLEAN, &value);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+
+	return TRUE;
+}
+
+static gboolean adapter_property_get_discoverable(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter = data;
+	dbus_bool_t value;
 
-	/* Discoverable */
 	value = adapter->scan_mode & SCAN_INQUIRY ? TRUE : FALSE;
-	dict_append_entry(&dict, "Discoverable", DBUS_TYPE_BOOLEAN, &value);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
 
-	/* Pairable */
-	dict_append_entry(&dict, "Pairable", DBUS_TYPE_BOOLEAN,
-				&adapter->pairable);
+	return TRUE;
+}
 
-	/* DiscoverableTimeout */
-	dict_append_entry(&dict, "DiscoverableTimeout",
-				DBUS_TYPE_UINT32, &adapter->discov_timeout);
+static gboolean adapter_property_get_pairable(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter = data;
 
-	/* PairableTimeout */
-	dict_append_entry(&dict, "PairableTimeout",
-				DBUS_TYPE_UINT32, &adapter->pairable_timeout);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+							&adapter->pairable);
+	return TRUE;
+}
 
+static gboolean adapter_property_get_discoverable_timeout(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter = data;
 
-	/* Discovering */
-	dict_append_entry(&dict, "Discovering", DBUS_TYPE_BOOLEAN,
-							&adapter->discovering);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
+						&adapter->discov_timeout);
 
-	/* Devices */
-	devices = g_new0(char *, g_slist_length(adapter->devices) + 1);
-	for (i = 0, l = adapter->devices; l; l = l->next, i++) {
-		struct btd_device *dev = l->data;
-		devices[i] = (char *) device_get_path(dev);
+	return TRUE;
+}
+
+static gboolean adapter_property_get_pairable_timeout(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
+						&adapter->pairable_timeout);
+
+	return TRUE;
+}
+
+static gboolean adapter_property_get_discovering(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+						&adapter->discovering);
+
+	return TRUE;
+}
+
+static gboolean adapter_property_get_devices(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter = data;
+	DBusMessageIter entry;
+	GSList *l;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_OBJECT_PATH_AS_STRING, &entry);
+
+	for (l = adapter->devices; l != NULL; l = l->next) {
+		const char *path = device_get_path(l->data);
+
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH,
+								&path);
 	}
-	dict_append_array(&dict, "Devices", DBUS_TYPE_OBJECT_PATH,
-								&devices, i);
-	g_free(devices);
 
-	/* UUIDs */
-	uuids = g_new0(char *, sdp_list_len(adapter->services) + 1);
+	dbus_message_iter_close_container(iter, &entry);
 
-	for (i = 0, list = adapter->services; list; list = list->next) {
-		sdp_record_t *rec = list->data;
+	return TRUE;
+}
+
+static gboolean adapter_property_get_uuids(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter = data;
+	DBusMessageIter entry;
+	sdp_list_t *l;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &entry);
+
+	for (l = adapter->services; l != NULL; l = l->next) {
+		sdp_record_t *rec = l->data;
 		char *uuid;
 
 		uuid = bt_uuid2string(&rec->svclass);
-		if (uuid)
-			uuids[i++] = uuid;
-	}
-
-	dict_append_array(&dict, "UUIDs", DBUS_TYPE_STRING, &uuids, i);
+		if (uuid == NULL)
+			continue;
 
-	g_strfreev(uuids);
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+								&uuid);
+		g_free(uuid);
+	}
 
-	dbus_message_iter_close_container(&iter, &dict);
+	dbus_message_iter_close_container(iter, &entry);
 
-	return reply;
+	return TRUE;
 }
-
 static DBusMessage *set_property(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -1656,9 +1719,6 @@ static DBusMessage *unregister_agent(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable adapter_methods[] = {
-	{ GDBUS_METHOD("GetProperties",
-			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			get_properties) },
 	{ GDBUS_ASYNC_METHOD("SetProperty",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
 			set_property) },
@@ -1714,6 +1774,22 @@ static const GDBusSignalTable adapter_signals[] = {
 	{ }
 };
 
+static const GDBusPropertyTable adapter_properties[] = {
+	{ "Address", "s", adapter_property_get_address },
+	{ "Name", "s", adapter_property_get_name },
+	{ "Class", "u", adapter_property_get_class },
+	{ "Powered", "b", adapter_property_get_powered },
+	{ "Discoverable", "b", adapter_property_get_discoverable },
+	{ "Pairable", "b", adapter_property_get_pairable },
+	{ "DiscoverableTimeout", "u",
+			adapter_property_get_discoverable_timeout },
+	{ "PairableTimeout", "u", adapter_property_get_pairable_timeout },
+	{ "Discovering", "b", adapter_property_get_discovering },
+	{ "Devices", "ao", adapter_property_get_devices },
+	{ "UUIDs", "as", adapter_property_get_uuids },
+	{ }
+};
+
 static void create_stored_device_from_profiles(char *key, char *value,
 						void *user_data)
 {
@@ -2624,8 +2700,9 @@ struct btd_adapter *adapter_create(int id)
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					path, ADAPTER_INTERFACE,
-					adapter_methods, adapter_signals, NULL,
-					adapter, adapter_free)) {
+					adapter_methods, adapter_signals,
+					adapter_properties, adapter,
+					adapter_free)) {
 		error("Adapter interface init failed on path %s", path);
 		adapter_free(adapter);
 		return NULL;
-- 
1.7.12.2

