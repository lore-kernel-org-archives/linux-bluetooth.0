Return-Path: <cyrus@holtmann.org>
From: Henrique Dante de Almeida <hdante@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Henrique Dante de Almeida <hdante@profusion.mobi>
Subject: [PATCH RFC 4/4] device: implement DBus.Properties
Date: Fri, 27 Apr 2012 18:54:06 -0300
Message-Id: <1335563646-9944-5-git-send-email-hdante@profusion.mobi>
In-Reply-To: <1335563646-9944-1-git-send-email-hdante@profusion.mobi>
References: <1335563646-9944-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |  384 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 380 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index 567ece1..a2d91cd 100644
--- a/src/device.c
+++ b/src/device.c
@@ -314,6 +314,314 @@ gboolean device_is_trusted(struct btd_device *device)
 	return device->trusted;
 }
 
+static gboolean get_property_address(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	char dstaddr[18];
+
+	ba2str(&device->bdaddr, dstaddr);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &dstaddr);
+
+	return TRUE;
+}
+
+static gboolean get_property_name(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &device->name);
+	return TRUE;
+}
+
+static gboolean get_property_alias(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	const char *ptr = device->name;
+	char dstaddr[18];
+
+	ba2str(&device->bdaddr, dstaddr);
+
+	if (device->alias != NULL)
+		ptr = device->alias;
+	else if (strlen(ptr) == 0) {
+		g_strdelimit(dstaddr, ":", '-');
+		ptr = dstaddr;
+	}
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
+	return TRUE;
+}
+
+static gboolean get_property_class(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	struct btd_adapter *adapter = device->adapter;
+	uint32_t class;
+	bdaddr_t src;
+
+	adapter_get_address(adapter, &src);
+
+	if (read_remote_class(&src, &device->bdaddr, &class) == 0) {
+		dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &class);
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+static gboolean get_property_icon(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	struct btd_adapter *adapter = device->adapter;
+	uint32_t class;
+	uint16_t app;
+	const char *icon;
+	bdaddr_t src;
+
+	adapter_get_address(adapter, &src);
+
+	if (read_remote_class(&src, &device->bdaddr, &class) == 0) {
+		icon = class_to_icon(class);
+	} else if (read_remote_appearance(&src, &device->bdaddr, &app) == 0) {
+		icon = gap_appearance_to_icon(app);
+	}
+	else {
+		return FALSE;
+	}
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &icon);
+	return TRUE;
+}
+
+static gboolean get_property_vendor(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &device->vendor);
+	return TRUE;
+}
+
+static gboolean get_property_vendor_source(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+							&device->vendor_src);
+	return TRUE;
+}
+
+static gboolean get_property_product(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+							&device->product);
+	return TRUE;
+}
+
+static gboolean get_property_version(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+							&device->version);
+	return TRUE;
+}
+
+static gboolean get_property_paired(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	dbus_bool_t boolean;
+
+	boolean = device_is_paired(device);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &boolean);
+	return TRUE;
+}
+
+static gboolean get_property_trusted(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	dbus_bool_t boolean;
+
+	boolean = device_is_trusted(device);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &boolean);
+	return TRUE;
+}
+
+static gboolean get_property_blocked(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+							&device->blocked);
+	return TRUE;
+}
+
+static gboolean get_property_connected(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+							&device->connected);
+	return TRUE;
+}
+
+static gboolean get_property_uuids(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *variant, void *data)
+{
+	struct btd_device *device = data;
+	char **str;
+	GSList *l;
+	DBusMessageIter iter;
+	int i;
+
+	dbus_message_iter_open_container(variant, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &iter);
+	str = g_new0(char *, g_slist_length(device->uuids) + 1);
+
+	for (i = 0, l = device->uuids; l; l = l->next, i++) {
+		str[i] = l->data;
+		dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
+								&(str[i]));
+	}
+
+	dbus_message_iter_close_container(variant, &iter);
+	g_free(str);
+
+	return TRUE;
+}
+
+static gboolean get_property_services(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *variant, void *data)
+{
+	struct btd_device *device = data;
+	char **str;
+	GSList *l;
+	DBusMessageIter iter;
+	int i;
+
+	dbus_message_iter_open_container(variant, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_OBJECT_PATH_AS_STRING, &iter);
+	str = g_new0(char *, g_slist_length(device->services) + 1);
+
+	for (i = 0, l = device->services; l; l = l->next, i++) {
+		str[i] = l->data;
+		dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
+								&str[i]);
+	}
+
+	dbus_message_iter_close_container(variant, &iter);
+	g_free(str);
+
+	return TRUE;
+}
+
+static gboolean get_property_adapter(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	struct btd_adapter *adapter = device->adapter;
+	const char *ptr;
+
+	ptr = adapter_get_path(adapter);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
+	return TRUE;
+}
+
+gboolean property_class_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct btd_device *device = data;
+	struct btd_adapter *adapter = device->adapter;
+	uint32_t class;
+	bdaddr_t src;
+
+	adapter_get_address(adapter, &src);
+
+	if (read_remote_class(&src, &device->bdaddr, &class) == 0) {
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+gboolean property_icon_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct btd_device *device = data;
+	struct btd_adapter *adapter = device->adapter;
+	uint32_t class;
+	uint16_t app;
+	bdaddr_t src;
+
+	adapter_get_address(adapter, &src);
+
+	if (read_remote_class(&src, &device->bdaddr, &class) == 0) {
+		return TRUE;
+	} else if (read_remote_appearance(&src, &device->bdaddr, &app) == 0) {
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+gboolean property_vendor_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct btd_device *device = data;
+
+	return (device->vendor != 0);
+}
+
+gboolean property_vendor_source_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct btd_device *device = data;
+
+	return (device->vendor_src != 0);
+}
+
+gboolean property_product_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct btd_device *device = data;
+
+	return (device->product != 0);
+}
+
+gboolean property_version_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct btd_device *device = data;
+
+	return (device->version != 0);
+}
+
 static DBusMessage *get_properties(DBusConnection *conn,
 				DBusMessage *msg, void *user_data)
 {
@@ -613,6 +921,48 @@ static DBusMessage *set_blocked(DBusConnection *conn, DBusMessage *msg,
 	}
 }
 
+DBusMessage *set_property_alias(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	const char *alias;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(message);
+
+	dbus_message_iter_get_basic(iter, &alias);
+
+	return set_alias(connection, message, alias, data);
+}
+
+DBusMessage *set_property_trusted(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	dbus_bool_t value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
+		return btd_error_invalid_args(message);
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	return set_trust(connection, message, value, data);
+}
+
+DBusMessage *set_property_blocked(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	dbus_bool_t value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
+		return btd_error_invalid_args(message);
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	return set_blocked(connection, message, value, data);
+}
+
 static DBusMessage *set_property(DBusConnection *conn,
 				DBusMessage *msg, void *data)
 {
@@ -631,6 +981,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
 		return btd_error_invalid_args(msg);
+
 	dbus_message_iter_recurse(&iter, &sub);
 
 	if (g_str_equal("Trusted", property)) {
@@ -878,8 +1229,10 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable device_methods[] = {
-	{ "GetProperties",	"",	"a{sv}[properties]", get_properties },
-	{ "SetProperty", "s[name]v[value]", "",		set_property	},
+	{ "GetProperties",	"",	"a{sv}[properties]", get_properties,
+						G_DBUS_METHOD_FLAG_DEPRECATED },
+	{ "SetProperty", "s[name]v[value]", "",		set_property,
+						G_DBUS_METHOD_FLAG_DEPRECATED },
 	{ "DiscoverServices", "s[pattern]", "a{us}[services]", discover_services,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ "CancelDiscovery",	"",	"",		cancel_discover	},
@@ -894,6 +1247,29 @@ static const GDBusSignalTable device_signals[] = {
 	{ }
 };
 
+static const GDBusPropertyTable device_properties[] = {
+	{ "Address", "s", 0, get_property_address },
+	{ "Name", "s", 0, get_property_name },
+	{ "Alias", "s", 0, get_property_alias, set_property_alias },
+	{ "Class", "u", 0, get_property_class, NULL, property_class_exists },
+	{ "Icon", "s", 0, get_property_icon, NULL, property_icon_exists },
+	{ "Vendor", "q", 0, get_property_vendor, NULL, property_vendor_exists },
+	{ "VendorSource", "q", 0, get_property_vendor_source, NULL,
+						property_vendor_source_exists },
+	{ "Product", "q", 0, get_property_product, NULL,
+						property_product_exists },
+	{ "Version", "q", 0, get_property_version, NULL,
+						property_version_exists },
+	{ "Paired", "b", 0, get_property_paired },
+	{ "Trusted", "b", 0, get_property_trusted, set_property_trusted },
+	{ "Blocked", "b", 0, get_property_blocked, set_property_blocked },
+	{ "Connected", "b", 0, get_property_connected },
+	{ "UUIDs", "as", 0, get_property_uuids },
+	{ "Services", "ao", 0, get_property_services },
+	{ "Adapter", "o", 0, get_property_adapter },
+	{ }
+};
+
 gboolean device_is_connected(struct btd_device *device)
 {
 	return device->connected;
@@ -1057,8 +1433,8 @@ struct btd_device *device_create(DBusConnection *conn,
 	DBG("Creating device %s", device->path);
 
 	if (g_dbus_register_interface(conn, device->path, DEVICE_INTERFACE,
-				device_methods, device_signals, NULL,
-				device, device_free) == FALSE) {
+			device_methods, device_signals, device_properties,
+			device, device_free) == FALSE) {
 		device_free(device);
 		return NULL;
 	}
-- 
1.7.5.4

