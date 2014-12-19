Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 04/17] core: gatt: Export GATT descriptors on D-Bus
Date: Fri, 19 Dec 2014 13:35:52 -0800
Message-Id: <1419024965-10375-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1419024965-10375-1-git-send-email-armansito@chromium.org>
References: <1419024965-10375-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds code that exports an object on D-Bus with the
org.bluez.GattDescriptor1 interface for each GATT descriptor that is
present in bt_gatt_client.
---
 src/gatt-client.c | 194 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 190 insertions(+), 4 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 1a0e1cf..bd3711a 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -44,6 +44,7 @@
 
 #define GATT_SERVICE_IFACE		"org.bluez.GattService1"
 #define GATT_CHARACTERISTIC_IFACE	"org.bluez.GattCharacteristic1"
+#define GATT_DESCRIPTOR_IFACE		"org.bluez.GattDescriptor1"
 
 struct btd_gatt_client {
 	struct btd_device *device;
@@ -72,8 +73,135 @@ struct characteristic {
 	uint8_t props;
 	bt_uuid_t uuid;
 	char *path;
+	struct queue *descs;
 };
 
+struct descriptor {
+	struct characteristic *chrc;
+	uint16_t handle;
+	bt_uuid_t uuid;
+	char *path;
+};
+
+static gboolean descriptor_property_get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	char uuid[MAX_LEN_UUID_STR + 1];
+	const char *ptr = uuid;
+	struct descriptor *desc = data;
+
+	bt_uuid_to_string(&desc->uuid, uuid, sizeof(uuid));
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
+
+	return TRUE;
+}
+
+static gboolean descriptor_property_get_characteristic(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct descriptor *desc = data;
+	const char *str = desc->chrc->path;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &str);
+
+	return TRUE;
+}
+
+static gboolean descriptor_property_get_value(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
+
+	/* TODO: Implement this once the value is cached */
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static DBusMessage *descriptor_read_value(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	/* TODO: Implement */
+	return btd_error_failed(msg, "Not implemented");
+}
+
+static DBusMessage *descriptor_write_value(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	/* TODO: Implement */
+	return btd_error_failed(msg, "Not implemented");
+}
+
+static const GDBusPropertyTable descriptor_properties[] = {
+	{ "UUID", "s", descriptor_property_get_uuid },
+	{ "Characteristic", "o", descriptor_property_get_characteristic },
+	{ "Value", "ay", descriptor_property_get_value },
+	{ }
+};
+
+static const GDBusMethodTable descriptor_methods[] = {
+	{ GDBUS_ASYNC_METHOD("ReadValue", NULL, GDBUS_ARGS({ "value", "ay" }),
+						descriptor_read_value) },
+	{ GDBUS_ASYNC_METHOD("WriteValue", GDBUS_ARGS({ "value", "ay" }),
+					NULL, descriptor_write_value) },
+	{ }
+};
+
+static void descriptor_free(void *data)
+{
+	struct descriptor *desc = data;
+
+	g_free(desc->path);
+	free(desc);
+}
+
+static struct descriptor *descriptor_create(struct gatt_db_attribute *attr,
+						struct characteristic *chrc)
+{
+	struct descriptor *desc;
+
+	desc = new0(struct descriptor, 1);
+	if (!desc)
+		return NULL;
+
+	desc->chrc = chrc;
+	desc->handle = gatt_db_attribute_get_handle(attr);
+
+	bt_uuid_to_uuid128(gatt_db_attribute_get_type(attr), &desc->uuid);
+
+	desc->path = g_strdup_printf("%s/desc%04x", chrc->path, desc->handle);
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(), desc->path,
+						GATT_DESCRIPTOR_IFACE,
+						descriptor_methods, NULL,
+						descriptor_properties,
+						desc, descriptor_free)) {
+		error("Unable to register GATT descriptor with handle 0x%04x",
+								desc->handle);
+		descriptor_free(desc);
+
+		return NULL;
+	}
+
+	DBG("Exported GATT characteristic descriptor: %s", desc->path);
+
+	return desc;
+}
+
+static void unregister_descriptor(void *data)
+{
+	struct descriptor *desc = data;
+
+	DBG("Removing GATT descriptor: %s", desc->path);
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(), desc->path,
+							GATT_DESCRIPTOR_IFACE);
+}
+
 static gboolean characteristic_property_get_uuid(
 					const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
@@ -205,15 +333,25 @@ static DBusMessage *characteristic_stop_notify(DBusConnection *conn,
 	return btd_error_failed(msg, "Not implemented");
 }
 
+static void append_desc_path(void *data, void *user_data)
+{
+	struct descriptor *desc = data;
+	DBusMessageIter *array = user_data;
+
+	dbus_message_iter_append_basic(array, DBUS_TYPE_OBJECT_PATH,
+								&desc->path);
+}
+
 static gboolean characteristic_property_get_descriptors(
 					const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
+	struct characteristic *chrc = data;
 	DBusMessageIter array;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "o", &array);
 
-	/* TODO: Implement this once descriptors are exported */
+	queue_foreach(chrc->descs, append_desc_path, &array);
 
 	dbus_message_iter_close_container(iter, &array);
 
@@ -245,6 +383,7 @@ static void characteristic_free(void *data)
 {
 	struct characteristic *chrc = data;
 
+	queue_destroy(chrc->descs, NULL);  /* List should be empty here */
 	g_free(chrc->path);
 	free(chrc);
 }
@@ -260,6 +399,12 @@ static struct characteristic *characteristic_create(
 	if (!chrc)
 		return NULL;
 
+	chrc->descs = queue_new();
+	if (!chrc->descs) {
+		free(chrc);
+		return NULL;
+	}
+
 	chrc->service = service;
 
 	gatt_db_attribute_get_char_data(attr, &chrc->handle,
@@ -293,6 +438,8 @@ static void unregister_characteristic(void *data)
 
 	DBG("Removing GATT characteristic: %s", chrc->path);
 
+	queue_remove_all(chrc->descs, NULL, NULL, unregister_descriptor);
+
 	g_dbus_unregister_interface(btd_get_dbus_connection(), chrc->path,
 						GATT_CHARACTERISTIC_IFACE);
 }
@@ -441,6 +588,37 @@ struct export_data {
 	bool failed;
 };
 
+static void export_desc(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct descriptor *desc;
+	struct export_data *data = user_data;
+	struct characteristic *charac = data->root;
+
+	if (data->failed)
+		return;
+
+	desc = descriptor_create(attr, charac);
+	if (!desc) {
+		data->failed = true;
+		return;
+	}
+
+	queue_push_tail(charac->descs, desc);
+}
+
+static bool create_descriptors(struct gatt_db_attribute *attr,
+					struct characteristic *charac)
+{
+	struct export_data data;
+
+	data.root = charac;
+	data.failed = false;
+
+	gatt_db_service_foreach_desc(attr, export_desc, &data);
+
+	return !data.failed;
+}
+
 static void export_char(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct characteristic *charac;
@@ -451,12 +629,20 @@ static void export_char(struct gatt_db_attribute *attr, void *user_data)
 		return;
 
 	charac = characteristic_create(attr, service);
-	if (!charac) {
-		data->failed = true;
-		return;
+	if (!charac)
+		goto fail;
+
+	if (!create_descriptors(attr, charac)) {
+		unregister_characteristic(charac);
+		goto fail;
 	}
 
 	queue_push_tail(service->chrcs, charac);
+
+	return;
+
+fail:
+	data->failed = true;
 }
 
 static bool create_characteristics(struct gatt_db_attribute *attr,
-- 
2.2.0.rc0.207.ga3a616c

