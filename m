Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 4/6] core: Add DBus.Properties getters for Device interface
Date: Sat,  6 Oct 2012 04:10:46 -0300
Message-Id: <1349507448-9595-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1349507448-9595-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1349507448-9595-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

---
 src/device.c | 407 ++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 319 insertions(+), 88 deletions(-)

diff --git a/src/device.c b/src/device.c
index 3658eeb..95543cb 100644
--- a/src/device.c
+++ b/src/device.c
@@ -310,128 +310,332 @@ gboolean device_is_trusted(struct btd_device *device)
 	return device->trusted;
 }
 
-static DBusMessage *get_properties(DBusConnection *conn,
-				DBusMessage *msg, void *user_data)
+static gboolean dev_property_get_address(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
-	struct btd_device *device = user_data;
-	struct btd_adapter *adapter = device->adapter;
-	DBusMessage *reply;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
+	struct btd_device *device = data;
 	char dstaddr[18];
-	char **str;
-	const char *ptr, *icon = NULL;
-	dbus_bool_t boolean;
-	uint32_t class;
-	uint16_t app;
-	int i;
-	GSList *l;
+	const char *ptr = dstaddr;
 
 	ba2str(&device->bdaddr, dstaddr);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
 
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
+	return TRUE;
+}
 
-	dbus_message_iter_init_append(reply, &iter);
+static gboolean dev_property_get_name(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	const char *empty = "", *ptr;
 
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+	ptr = device->name ?: empty;
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
 
-	/* Address */
-	ptr = dstaddr;
-	dict_append_entry(&dict, "Address", DBUS_TYPE_STRING, &ptr);
+	return TRUE;
+}
 
-	/* Name */
-	ptr = device->name;
-	dict_append_entry(&dict, "Name", DBUS_TYPE_STRING, &ptr);
+static gboolean dev_property_get_alias(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	char dstaddr[18];
+	const char *ptr;
 
 	/* Alias (fallback to name or address) */
 	if (device->alias != NULL)
 		ptr = device->alias;
-	else if (strlen(ptr) == 0) {
+	else if (strlen(device->name) > 0) {
+		ptr = device->name;
+	} else {
+		ba2str(&device->bdaddr, dstaddr);
 		g_strdelimit(dstaddr, ":", '-');
 		ptr = dstaddr;
 	}
 
-	dict_append_entry(&dict, "Alias", DBUS_TYPE_STRING, &ptr);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
+
+	return TRUE;
+}
+
+static gboolean get_class(const GDBusPropertyTable *property, void *data,
+							uint32_t *class)
+{
+	struct btd_device *device = data;
+
+	if (read_remote_class(adapter_get_address(device->adapter),
+						&device->bdaddr, class) == 0)
+		return TRUE;
+
+	return FALSE;
+}
+
+static gboolean dev_property_exists_class(const GDBusPropertyTable *property,
+								void *data)
+{
+	uint32_t class;
+
+	return get_class(property, data, &class);
+}
+
+static gboolean dev_property_get_class(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	uint32_t class;
+
+	if (!get_class(property, data, &class))
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &class);
+
+	return TRUE;
+}
+
+static gboolean get_appearance(const GDBusPropertyTable *property, void *data,
+							uint16_t *appearance)
+{
+	struct btd_device *device = data;
+
+	if (dev_property_exists_class(property, data))
+		return FALSE;
+
+	if (read_remote_appearance(adapter_get_address(device->adapter),
+					&device->bdaddr, device->bdaddr_type,
+					appearance) == 0)
+		return TRUE;
+
+	return FALSE;
+}
+
+static gboolean dev_property_exists_appearance(
+			const GDBusPropertyTable *property, void *data)
+{
+	uint16_t appearance;
+
+	return get_appearance(property, data, &appearance);
+}
+
+static gboolean dev_property_get_appearance(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	uint16_t appearance;
+
+	if (!get_appearance(property, data, &appearance))
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &appearance);
+
+	return TRUE;
+}
+
+static const char *get_icon(const GDBusPropertyTable *property, void *data)
+{
+	const char *icon = NULL;
+	uint32_t class;
+	uint16_t appearance;
 
-	/* Class */
-	if (read_remote_class(adapter_get_address(adapter),
-				&device->bdaddr, &class) == 0) {
+	if (get_class(property, data, &class))
 		icon = class_to_icon(class);
+	else if (get_appearance(property, data, &appearance))
+		icon = gap_appearance_to_icon(appearance);
 
-		dict_append_entry(&dict, "Class", DBUS_TYPE_UINT32, &class);
-	} else if (read_remote_appearance(adapter_get_address(adapter),
-			&device->bdaddr, device->bdaddr_type, &app) == 0) {
-		/* Appearance */
-		icon = gap_appearance_to_icon(app);
+	return icon;
+}
 
-		dict_append_entry(&dict, "Appearance", DBUS_TYPE_UINT16, &app);
-	}
+static gboolean dev_property_exists_icon(
+			const GDBusPropertyTable *property, void *data)
+{
+	return get_icon(property, data) != NULL;
+}
+
+static gboolean dev_property_get_icon(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	const char *icon;
+
+	icon = get_icon(property, data);
+	if (icon == NULL)
+		return FALSE;
 
-	if (icon != NULL)
-		dict_append_entry(&dict, "Icon", DBUS_TYPE_STRING, &icon);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &icon);
 
-	/* Vendor */
-	if (device->vendor)
-		dict_append_entry(&dict, "Vendor", DBUS_TYPE_UINT16,
+	return TRUE;
+}
+
+static gboolean dev_property_exists_vendor(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct btd_device *device = data;
+
+	return !!device->vendor;
+}
+
+static gboolean dev_property_get_vendor(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+
+	if (!device->vendor)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
 							&device->vendor);
+	return TRUE;
+}
+
+static gboolean dev_property_exists_vendor_src(
+				const GDBusPropertyTable *property, void *data)
+{
+	struct btd_device *device = data;
+
+	return !!device->vendor_src;
+}
+
+static gboolean dev_property_get_vendor_src(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+
+	if (!device->vendor_src)
+		return FALSE;
 
-	/* Vendor Source*/
-	if (device->vendor_src)
-		dict_append_entry(&dict, "VendorSource", DBUS_TYPE_UINT16,
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
 							&device->vendor_src);
+	return TRUE;
+}
+
+static gboolean dev_property_exists_product(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct btd_device *device = data;
+
+	return !!device->product;
+}
+
+static gboolean dev_property_get_product(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+
+	if (!device->product)
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean dev_property_exists_version(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct btd_device *device = data;
+
+	return !!device->version;
+}
+
+static gboolean dev_property_get_version(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
 
-	/* Product */
-	if (device->product)
-		dict_append_entry(&dict, "Product", DBUS_TYPE_UINT16,
-							&device->product);
+	if (!device->version)
+		return FALSE;
 
-	/* Version */
-	if (device->version)
-		dict_append_entry(&dict, "Version", DBUS_TYPE_UINT16,
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
 							&device->version);
+	return TRUE;
+}
+
+static gboolean dev_property_get_paired(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	gboolean val = device_is_paired(device);
 
-	/* Paired */
-	boolean = device_is_paired(device);
-	dict_append_entry(&dict, "Paired", DBUS_TYPE_BOOLEAN, &boolean);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
 
-	/* Trusted */
-	boolean = device_is_trusted(device);
-	dict_append_entry(&dict, "Trusted", DBUS_TYPE_BOOLEAN, &boolean);
+	return TRUE;
+}
+
+static gboolean dev_property_get_trusted(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	gboolean val = device_is_trusted(device);
 
-	/* Blocked */
-	boolean = device->blocked;
-	dict_append_entry(&dict, "Blocked", DBUS_TYPE_BOOLEAN, &boolean);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
 
-	/* Connected */
-	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN,
+	return TRUE;
+}
+
+static gboolean dev_property_get_blocked(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+							&device->blocked);
+
+	return TRUE;
+}
+
+static gboolean dev_property_get_connected(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
 							&device->connected);
 
-	/* UUIDs */
-	str = g_new0(char *, g_slist_length(device->uuids) + 1);
-	for (i = 0, l = device->uuids; l; l = l->next, i++)
-		str[i] = l->data;
-	dict_append_array(&dict, "UUIDs", DBUS_TYPE_STRING, &str, i);
-	g_free(str);
+	return TRUE;
+}
 
-	/* Services */
-	str = g_new0(char *, g_slist_length(device->services) + 1);
-	for (i = 0, l = device->services; l; l = l->next, i++)
-		str[i] = l->data;
-	dict_append_array(&dict, "Services", DBUS_TYPE_OBJECT_PATH, &str, i);
-	g_free(str);
+static gboolean dev_property_get_uuids(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	DBusMessageIter entry;
+	GSList *l;
 
-	/* Adapter */
-	ptr = adapter_get_path(adapter);
-	dict_append_entry(&dict, "Adapter", DBUS_TYPE_OBJECT_PATH, &ptr);
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_STRING_AS_STRING, &entry);
 
-	dbus_message_iter_close_container(&iter, &dict);
+	for (l = device->uuids; l != NULL; l = l->next)
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+							&l->data);
+
+	dbus_message_iter_close_container(iter, &entry);
 
-	return reply;
+	return TRUE;
+}
+
+static gboolean dev_property_get_services(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	DBusMessageIter entry;
+	GSList *l;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_OBJECT_PATH_AS_STRING, &entry);
+
+	for (l = device->services; l != NULL; l = l->next)
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH,
+							&l->data);
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
+
+static gboolean dev_property_get_adapter(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	const char *str = adapter_get_path(device->adapter);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &str);
+
+	return TRUE;
 }
 
 static DBusMessage *set_alias(DBusMessage *msg, const char *alias, void *data)
@@ -954,9 +1158,6 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable device_methods[] = {
-	{ GDBUS_METHOD("GetProperties",
-				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-				get_properties) },
 	{ GDBUS_METHOD("SetProperty",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
 			set_property) },
@@ -977,6 +1178,35 @@ static const GDBusSignalTable device_signals[] = {
 	{ }
 };
 
+
+static const GDBusPropertyTable device_properties[] = {
+	{ "Address", "s", dev_property_get_address },
+	{ "Name", "s", dev_property_get_name },
+	{ "Alias", "s", dev_property_get_alias },
+	{ "Class", "u", dev_property_get_class, NULL,
+					dev_property_exists_class },
+	{ "Appearance", "q", dev_property_get_appearance, NULL,
+					dev_property_exists_appearance },
+	{ "Icon", "s", dev_property_get_icon, NULL,
+					dev_property_exists_icon },
+	{ "Vendor", "q", dev_property_get_vendor, NULL,
+					dev_property_exists_vendor },
+	{ "VendorSource", "q", dev_property_get_vendor_src, NULL,
+					dev_property_exists_vendor_src },
+	{ "Product", "q", dev_property_get_product, NULL,
+					dev_property_exists_product },
+	{ "Version", "q", dev_property_get_version, NULL,
+					dev_property_exists_version },
+	{ "Paired", "b", dev_property_get_paired },
+	{ "Trusted", "b", dev_property_get_trusted },
+	{ "Blocked", "b", dev_property_get_blocked },
+	{ "Connected", "b", dev_property_get_connected },
+	{ "UUIDs", "as", dev_property_get_uuids },
+	{ "Services", "ao", dev_property_get_services },
+	{ "Adapter", "o", dev_property_get_adapter },
+	{ }
+};
+
 gboolean device_is_connected(struct btd_device *device)
 {
 	return device->connected;
@@ -1139,8 +1369,9 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
 					device->path, DEVICE_INTERFACE,
-					device_methods, device_signals, NULL,
-					device, device_free) == FALSE) {
+					device_methods, device_signals,
+					device_properties, device,
+					device_free) == FALSE) {
 		device_free(device);
 		return NULL;
 	}
-- 
1.7.12.2

