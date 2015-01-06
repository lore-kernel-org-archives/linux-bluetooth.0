Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 1/8] core: gatt: Expose charac. extended properties.
Date: Mon,  5 Jan 2015 18:03:29 -0800
Message-Id: <1420509816-1376-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1420509816-1376-1-git-send-email-armansito@chromium.org>
References: <1420509816-1376-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch reads the extended properties for characteristics that have
the necessary descriptor. Updating the "Characteristics" property is
delayed for services until the extended properties have been read for
all of their characteristics that have them.
---
 src/gatt-client.c | 155 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 119 insertions(+), 36 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 47faf86..8bbb03d 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -42,6 +42,10 @@
 #include "gatt-client.h"
 #include "dbus-common.h"
 
+#ifndef NELEM
+#define NELEM(x) (sizeof(x) / sizeof((x)[0]))
+#endif
+
 #define GATT_SERVICE_IFACE		"org.bluez.GattService1"
 #define GATT_CHARACTERISTIC_IFACE	"org.bluez.GattCharacteristic1"
 #define GATT_DESCRIPTOR_IFACE		"org.bluez.GattDescriptor1"
@@ -64,6 +68,8 @@ struct service {
 	char *path;
 	struct queue *chrcs;
 	bool chrcs_ready;
+	struct queue *pending_ext_props;
+	guint idle_id;
 };
 
 struct characteristic {
@@ -72,6 +78,8 @@ struct characteristic {
 	uint16_t handle;
 	uint16_t value_handle;
 	uint8_t props;
+	uint16_t ext_props;
+	uint16_t ext_props_handle;
 	bt_uuid_t uuid;
 	char *path;
 
@@ -92,6 +100,15 @@ struct descriptor {
 	bool in_write;
 };
 
+static bool uuid_cmp(const bt_uuid_t *uuid, uint16_t u16)
+{
+	bt_uuid_t uuid16;
+
+	bt_uuid16_create(&uuid16, u16);
+
+	return bt_uuid_cmp(uuid, &uuid16) == 0;
+}
+
 static gboolean descriptor_get_uuid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -492,7 +509,6 @@ static DBusMessage *descriptor_write_value(DBusConnection *conn,
 	uint8_t *value = NULL;
 	size_t value_len = 0;
 	bool result;
-	bt_uuid_t uuid;
 
 	if (desc->in_write)
 		return btd_error_in_progress(msg);
@@ -505,8 +521,7 @@ static DBusMessage *descriptor_write_value(DBusConnection *conn,
 	 * descriptors. We achieve this through the StartNotify and StopNotify
 	 * methods on GattCharacteristic1.
 	 */
-	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
-	if (bt_uuid_cmp(&desc->uuid, &uuid))
+	if (uuid_cmp(&desc->uuid, GATT_CLIENT_CHARAC_CFG_UUID))
 		return btd_error_not_permitted(msg, "Write not permitted");
 
 	/*
@@ -590,6 +605,9 @@ static struct descriptor *descriptor_create(struct gatt_db_attribute *attr,
 
 	DBG("Exported GATT characteristic descriptor: %s", desc->path);
 
+	if (uuid_cmp(&desc->uuid, GATT_CHARAC_EXT_PROPER_UUID))
+		chrc->ext_props_handle = desc->handle;
+
 	return desc;
 }
 
@@ -668,10 +686,12 @@ static gboolean characteristic_get_notifying(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static struct {
+struct chrc_prop_data {
 	uint8_t prop;
 	char *str;
-} properties[] = {
+};
+
+struct chrc_prop_data chrc_props[] = {
 	/* Default Properties */
 	{ BT_GATT_CHRC_PROP_BROADCAST,		"broadcast" },
 	{ BT_GATT_CHRC_PROP_READ,		"read" },
@@ -680,7 +700,13 @@ static struct {
 	{ BT_GATT_CHRC_PROP_NOTIFY,		"notify" },
 	{ BT_GATT_CHRC_PROP_INDICATE,		"indicate" },
 	{ BT_GATT_CHRC_PROP_AUTH,		"authenticated-signed-writes" },
-	{ },
+	{ BT_GATT_CHRC_PROP_EXT_PROP,		"extended-properties" }
+};
+
+struct chrc_prop_data chrc_ext_props[] = {
+	/* Extended Properties */
+	{ BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE,	"reliable-write" },
+	{ BT_GATT_CHRC_EXT_PROP_WRITABLE_AUX,	"writable-auxiliaries" }
 };
 
 static gboolean characteristic_get_flags(const GDBusPropertyTable *property,
@@ -688,20 +714,21 @@ static gboolean characteristic_get_flags(const GDBusPropertyTable *property,
 {
 	struct characteristic *chrc = data;
 	DBusMessageIter array;
-	int i;
+	unsigned i;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "s", &array);
 
-	for (i = 0; properties[i].str; i++) {
-		if (chrc->props & properties[i].prop)
+	for (i = 0; i < NELEM(chrc_props); i++) {
+		if (chrc->props & chrc_props[i].prop)
 			dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING,
-							&properties[i].str);
+							&chrc_props[i].str);
 	}
 
-	/*
-	 * TODO: Handle extended properties if the descriptor is
-	 * present.
-	 */
+	for (i = 0; i < NELEM(chrc_ext_props); i++) {
+		if (chrc->ext_props & chrc_ext_props[i].prop)
+			dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING,
+							&chrc_ext_props[i].str);
+	}
 
 	dbus_message_iter_close_container(iter, &array);
 
@@ -1085,6 +1112,7 @@ static void service_free(void *data)
 	struct service *service = data;
 
 	queue_destroy(service->chrcs, NULL);  /* List should be empty here */
+	queue_destroy(service->pending_ext_props, NULL);
 	g_free(service->path);
 	free(service);
 }
@@ -1106,6 +1134,13 @@ static struct service *service_create(struct gatt_db_attribute *attr,
 		return NULL;
 	}
 
+	service->pending_ext_props = queue_new();
+	if (!service->pending_ext_props) {
+		queue_destroy(service->chrcs, NULL);
+		free(service);
+		return NULL;
+	}
+
 	service->client = client;
 
 	gatt_db_attribute_get_service_data(attr, &service->start_handle,
@@ -1142,12 +1177,24 @@ static void unregister_service(void *data)
 
 	DBG("Removing GATT service: %s", service->path);
 
+	if (service->idle_id)
+		g_source_remove(service->idle_id);
+
 	queue_remove_all(service->chrcs, NULL, NULL, unregister_characteristic);
 
 	g_dbus_unregister_interface(btd_get_dbus_connection(), service->path,
 							GATT_SERVICE_IFACE);
 }
 
+static void notify_chrcs(struct service *service)
+{
+	service->chrcs_ready = true;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), service->path,
+							GATT_SERVICE_IFACE,
+							"Characteristics");
+}
+
 struct export_data {
 	void *root;
 	bool failed;
@@ -1171,6 +1218,46 @@ static void export_desc(struct gatt_db_attribute *attr, void *user_data)
 	queue_push_tail(charac->descs, desc);
 }
 
+static void read_ext_props_cb(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
+{
+	struct characteristic *chrc = user_data;
+	struct service *service = chrc->service;
+
+	if (!success) {
+		error("Failed to obtain extended properties - error: 0x%02x",
+								att_ecode);
+		return;
+	}
+
+	if (!value || length != 2) {
+		error("Malformed extended properties value");
+		return;
+	}
+
+	chrc->ext_props = get_le16(value);
+	if (chrc->ext_props)
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						service->path,
+						GATT_SERVICE_IFACE, "Flags");
+
+	queue_remove(service->pending_ext_props, chrc);
+
+	if (queue_isempty(service->pending_ext_props))
+		notify_chrcs(service);
+}
+
+static void read_ext_props(void *data, void *user_data)
+{
+	struct characteristic *chrc = data;
+
+	bt_gatt_client_read_value(chrc->service->client->gatt,
+							chrc->ext_props_handle,
+							read_ext_props_cb,
+							chrc, NULL);
+}
+
 static bool create_descriptors(struct gatt_db_attribute *attr,
 					struct characteristic *charac)
 {
@@ -1204,6 +1291,9 @@ static void export_char(struct gatt_db_attribute *attr, void *user_data)
 
 	queue_push_tail(service->chrcs, charac);
 
+	if (charac->ext_props_handle)
+		queue_push_tail(service->pending_ext_props, charac);
+
 	return;
 
 fail:
@@ -1220,28 +1310,20 @@ static bool create_characteristics(struct gatt_db_attribute *attr,
 
 	gatt_db_service_foreach_char(attr, export_char, &data);
 
-	return !data.failed;
-}
-
-static void notify_chrcs(void *data, void *user_data)
-{
-	struct service *service = data;
+	if (data.failed)
+		return false;
 
-	service->chrcs_ready = true;
+	/* Obtain extended properties */
+	queue_foreach(service->pending_ext_props, read_ext_props, NULL);
 
-	g_dbus_emit_property_changed(btd_get_dbus_connection(), service->path,
-							GATT_SERVICE_IFACE,
-							"Characteristics");
+	return true;
 }
 
 static gboolean set_chrcs_ready(gpointer user_data)
 {
-	struct btd_gatt_client *client = user_data;
-
-	if (!client->gatt)
-		return FALSE;
+	struct service *service = user_data;
 
-	queue_foreach(client->services, notify_chrcs, NULL);
+	notify_chrcs(service);
 
 	return FALSE;
 }
@@ -1265,6 +1347,14 @@ static void export_service(struct gatt_db_attribute *attr, void *user_data)
 	}
 
 	queue_push_tail(client->services, service);
+
+	/*
+	 * Asynchronously update the "Characteristics" property of the service.
+	 * If there are any pending reads to obtain the value of the "Extended
+	 * Properties" descriptor then wait until they are complete.
+	 */
+	if (!service->chrcs_ready && queue_isempty(service->pending_ext_props))
+		service->idle_id = g_idle_add(set_chrcs_ready, service);
 }
 
 static void create_services(struct btd_gatt_client *client)
@@ -1272,13 +1362,6 @@ static void create_services(struct btd_gatt_client *client)
 	DBG("Exporting objects for GATT services: %s", client->devaddr);
 
 	gatt_db_foreach_service(client->db, NULL, export_service, client);
-
-	/*
-	 * Asynchronously update the "Characteristics" property of each service.
-	 * We do this so that users have a way to know that all characteristics
-	 * of a service have been exported.
-	 */
-	g_idle_add(set_chrcs_ready, client);
 }
 
 struct btd_gatt_client *btd_gatt_client_new(struct btd_device *device)
-- 
2.2.0.rc0.207.ga3a616c

