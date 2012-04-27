Return-Path: <cyrus@holtmann.org>
From: Henrique Dante de Almeida <hdante@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Henrique Dante de Almeida <hdante@profusion.mobi>
Subject: [PATCH RFC 3/4] adapter: implement DBus.Properties
Date: Fri, 27 Apr 2012 18:54:05 -0300
Message-Id: <1335563646-9944-4-git-send-email-hdante@profusion.mobi>
In-Reply-To: <1335563646-9944-1-git-send-email-hdante@profusion.mobi>
References: <1335563646-9944-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |  280 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 280 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 772c926..4c9b639 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1071,6 +1071,179 @@ static DBusMessage *adapter_stop_discovery(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static gboolean get_property_address(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter = data;
+	char srcaddr[18];
+
+	ba2str(&adapter->bdaddr, srcaddr);
+
+	if (check_address(srcaddr) < 0)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &srcaddr);
+
+	return TRUE;
+}
+
+static gboolean get_property_name(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter = data;
+	const char *name;
+
+	name = adapter->name ? : "";
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &name);
+
+	return TRUE;
+}
+
+static gboolean get_property_class(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
+							&adapter->dev_class);
+
+	return TRUE;
+}
+
+static gboolean get_property_powered(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter = data;
+	gboolean value;
+
+	value = (adapter->up && !adapter->off_requested) ? TRUE : FALSE;
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+
+	return TRUE;
+}
+
+static gboolean get_property_discoverable(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter = data;
+	gboolean value;
+
+	value = adapter->scan_mode & SCAN_INQUIRY ? TRUE : FALSE;
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+
+	return TRUE;
+}
+
+static gboolean get_property_pairable(DBusConnection *connection,
+	DBusMessage *message, const GDBusPropertyTable *property,
+	DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+							&adapter->pairable);
+
+	return TRUE;
+}
+
+static gboolean get_property_discoverable_timeout(DBusConnection *connection,
+	DBusMessage *message, const GDBusPropertyTable *property,
+	DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
+						&adapter->discov_timeout);
+
+	return TRUE;
+}
+
+static gboolean get_property_pairable_timeout(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
+						&adapter->pairable_timeout);
+
+	return TRUE;
+}
+
+static gboolean get_property_discovering(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+							&adapter->discovering);
+
+	return TRUE;
+}
+
+static gboolean get_property_devices(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *variant, void *data)
+{
+	DBusMessageIter iter;
+	struct btd_adapter *adapter = data;
+	GSList *l;
+
+	dbus_message_iter_open_container(variant, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_OBJECT_PATH_AS_STRING, &iter);
+
+	for (l = adapter->devices; l; l = l->next) {
+		struct btd_device *dev = l->data;
+		const char *device_path = device_get_path(dev);
+		dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
+							&device_path);
+	}
+
+	dbus_message_iter_close_container(variant, &iter);
+
+	return TRUE;
+}
+
+static gboolean get_property_uuids(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *variant, void *data)
+{
+	DBusMessageIter iter;
+	struct btd_adapter *adapter = data;
+	sdp_list_t *list;
+	char **uuids;
+	int i;
+
+	dbus_message_iter_open_container(variant, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &iter);
+
+	uuids = g_new0(char *, sdp_list_len(adapter->services) + 1);
+
+	for (i = 0, list = adapter->services; list; list = list->next) {
+		sdp_record_t *rec = list->data;
+		char *uuid = bt_uuid2string(&rec->svclass);
+
+		if (uuid) {
+			dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
+									&uuid);
+			uuids[i++] = uuid;
+		}
+
+	}
+
+	g_strfreev(uuids);
+	dbus_message_iter_close_container(variant, &iter);
+
+	return TRUE;
+}
+
 static DBusMessage *get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -1171,6 +1344,95 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	return reply;
 }
 
+static DBusMessage *set_property_name(DBusConnection *connection,
+					DBusMessage *message,
+					const GDBusPropertyTable *property,
+					DBusMessageIter *value, void *data)
+{
+	const char *name;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(message);
+	dbus_message_iter_get_basic(value, &name);
+
+	return set_name(connection, message, name, data);
+}
+
+static DBusMessage *set_property_powered(DBusConnection *connection,
+					DBusMessage *message,
+					const GDBusPropertyTable *property,
+					DBusMessageIter *value, void *data)
+{
+	gboolean powered;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
+		return btd_error_invalid_args(message);
+
+	dbus_message_iter_get_basic(value, &powered);
+
+	return set_powered(connection, message, powered, data);
+}
+
+static DBusMessage *set_property_discoverable(DBusConnection *connection,
+					DBusMessage *message,
+					const GDBusPropertyTable *property,
+					DBusMessageIter *value, void *data)
+{
+	gboolean discoverable;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
+		return btd_error_invalid_args(message);
+
+	dbus_message_iter_get_basic(value, &discoverable);
+
+	return set_discoverable(connection, message, discoverable, data);
+}
+
+static DBusMessage *set_property_discoverable_timeout(DBusConnection *connection,
+					DBusMessage *message,
+					const GDBusPropertyTable *property,
+					DBusMessageIter *value, void *data)
+{
+	uint32_t timeout;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT32)
+		return btd_error_invalid_args(message);
+
+	dbus_message_iter_get_basic(value, &timeout);
+
+	return set_discoverable_timeout(connection, message, timeout, data);
+}
+
+static DBusMessage *set_property_pairable(DBusConnection *connection,
+					DBusMessage *message,
+					const GDBusPropertyTable *property,
+					DBusMessageIter *value, void *data)
+{
+	gboolean pairable;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
+		return btd_error_invalid_args(message);
+
+	dbus_message_iter_get_basic(value, &pairable);
+
+	return set_pairable(connection, message, pairable, data);
+}
+
+static DBusMessage *set_property_pairable_timeout(DBusConnection *connection,
+					DBusMessage *message,
+					const GDBusPropertyTable *property,
+					DBusMessageIter *value, void *data)
+{
+	uint32_t timeout;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT32)
+		return btd_error_invalid_args(message);
+
+	dbus_message_iter_get_basic(value, &timeout);
+
+	return set_pairable_timeout(connection, message, timeout, data);
+}
+
 static DBusMessage *set_property(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -1694,6 +1956,24 @@ static const GDBusSignalTable adapter_signals[] = {
 	{ }
 };
 
+static const GDBusPropertyTable adapter_properties[] = {
+	{ "Address", "s", 0, get_property_address },
+	{ "Name", "s", 0, get_property_name, set_property_name },
+	{ "Class", "u", 0,  get_property_class },
+	{ "Powered", "b", 0, get_property_powered, set_property_powered },
+	{ "Discoverable", "b", 0, get_property_discoverable,
+						set_property_discoverable },
+	{ "Pairable", "b", 0, get_property_pairable, set_property_pairable },
+	{ "DiscoverableTimeout", "u", 0, get_property_discoverable_timeout,
+					set_property_discoverable_timeout },
+	{ "PairableTimeout", "u", 0, get_property_pairable_timeout,
+					set_property_pairable_timeout },
+	{ "Discovering", "b", 0, get_property_discovering },
+	{ "Devices", "ao", 0, get_property_devices },
+	{ "UUIDs", "s", 0, get_property_uuids },
+	{ }
+};
+
 static void create_stored_device_from_profiles(char *key, char *value,
 						void *user_data)
 {
-- 
1.7.5.4

