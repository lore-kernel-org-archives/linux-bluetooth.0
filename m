Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [RFC BlueZ v1 2/2] gatt-dbus: Add remote GATT characteristic objects.
Date: Fri, 14 Mar 2014 16:30:11 -0700
Message-Id: <1394839811-5746-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1394839811-5746-1-git-send-email-armansito@chromium.org>
References: <1394839811-5746-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds remote GATT characteristic objects to the D-Bus API. The
API only exposes the UUID; the characteristic value and permissions have
not yet been implemented.
---
 src/gatt-dbus.c | 195 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 191 insertions(+), 4 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 3937e17..0c89873 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -52,8 +52,24 @@
 
 struct btd_gatt_dbus_service {
 	bt_uuid_t uuid;
+	struct att_range range;
+	GAttrib *attrib;
+	guint attioid;
+	guint request;
+
 	struct btd_device *device;
 	char *path;
+	GSList *characteristics;
+};
+
+struct gatt_dbus_characteristic {
+	bt_uuid_t uuid;
+	uint16_t handle;
+	uint16_t value_handle;
+	uint8_t properties;
+
+	struct btd_gatt_dbus_service *service;
+	char *path;
 };
 
 struct external_app {
@@ -491,20 +507,186 @@ static gboolean service_property_get_uuid(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean characteristic_property_get_uuid(
+					const GDBusPropertyTable *table,
+					DBusMessageIter *iter, void *data)
+{
+	char uuid[MAX_LEN_UUID_STR + 1];
+	const char *ptr = uuid;
+	struct gatt_dbus_characteristic *chr = data;
+
+	bt_uuid_to_string(&chr->uuid, uuid, sizeof(uuid));
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
+
+	return TRUE;
+}
+
+static gboolean characteristic_property_get_service(
+					const GDBusPropertyTable *table,
+					DBusMessageIter *iter, void *data)
+{
+	struct gatt_dbus_characteristic *chr = data;
+	const char *str = chr->service->path;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &str);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable service_properties[] = {
 	{ "UUID", "s", service_property_get_uuid, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{}
 };
 
+static const GDBusPropertyTable characteristic_properties[] = {
+	{ "UUID", "s", characteristic_property_get_uuid, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Service", "o", characteristic_property_get_service, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{}
+};
+
+static void unregister_characteristic(gpointer user_data)
+{
+	struct gatt_dbus_characteristic *chr = user_data;
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+						chr->path, GATT_CHR_IFACE);
+}
+
+static void attio_cleanup(struct btd_gatt_dbus_service *service)
+{
+	GAttrib *attrib = service->attrib;
+
+	if (!service->attrib)
+		return;
+
+	service->attrib = NULL;
+
+	if (service->request) {
+		g_attrib_cancel(attrib, service->request);
+		service->request = 0;
+	}
+
+	g_attrib_unref(attrib);
+}
+
 static void service_free(gpointer user_data)
 {
 	struct btd_gatt_dbus_service *service = user_data;
 
+	g_slist_free_full(service->characteristics, unregister_characteristic);
+
+	if (service->attioid)
+		btd_device_remove_attio_callback(service->device,
+							service->attioid);
+
+	attio_cleanup(service);
 	g_free(service->path);
 	g_free(service);
 }
 
+static void characteristic_free(gpointer user_data)
+{
+	struct gatt_dbus_characteristic *characteristic = user_data;
+
+	g_free(characteristic->path);
+	g_free(characteristic);
+}
+
+static struct gatt_dbus_characteristic *characteristic_create(
+					struct btd_gatt_dbus_service *service,
+					struct gatt_char *chr)
+{
+	struct gatt_dbus_characteristic *characteristic;
+	bt_uuid_t uuid;
+
+	DBG("GATT characteristic UUID: %s", chr->uuid);
+
+	characteristic = g_try_new0(struct gatt_dbus_characteristic, 1);
+	if (characteristic == NULL)
+		return NULL;
+
+	characteristic->path = g_strdup_printf("%s/char%04X", service->path,
+								chr->handle);
+	characteristic->service = service;
+	characteristic->handle = chr->handle;
+	characteristic->value_handle = chr->value_handle;
+	characteristic->properties = chr->properties;
+
+	if (bt_string_to_uuid(&uuid, chr->uuid)) {
+		error("Characteristic has invalid UUID: %s", chr->uuid);
+		goto fail;
+	}
+
+	bt_uuid_to_uuid128(&uuid, &characteristic->uuid);
+
+	DBG("Creating GATT characteristic %s", characteristic->path);
+
+	if (g_dbus_register_interface(btd_get_dbus_connection(),
+						characteristic->path,
+						GATT_CHR_IFACE, NULL, NULL,
+						characteristic_properties,
+						characteristic,
+						characteristic_free == FALSE)) {
+		error("Unable to register GATT characteristic: %s", chr->uuid);
+		goto fail;
+	}
+
+	return characteristic;
+
+fail:
+	characteristic_free(characteristic);
+	return NULL;
+}
+
+static void discover_char_cb(uint8_t status, GSList *chars, void *user_data)
+{
+	struct btd_gatt_dbus_service *service = user_data;
+
+	service->request = 0;
+
+	if (status) {
+		error("Characteristic discovery failed.");
+		return;
+	}
+
+	for (; chars; chars = chars->next) {
+		struct gatt_char *chr = chars->data;
+		struct gatt_dbus_characteristic *dbus_chr =
+					characteristic_create(service, chr);
+
+		if (dbus_chr == NULL) {
+			error("Failed to register GATT characteristic: %s",
+								chr->uuid);
+			continue;
+		}
+
+		service->characteristics = g_slist_append(
+					service->characteristics, dbus_chr);
+	}
+
+	attio_cleanup(service);
+}
+
+static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+{
+	struct btd_gatt_dbus_service *service = user_data;
+
+	service->attrib = g_attrib_ref(attrib);
+	service->request = gatt_discover_char(service->attrib,
+							service->range.start,
+							service->range.end,
+							NULL, discover_char_cb,
+							service);
+}
+
+static void attio_disconnected_cb(gpointer user_data)
+{
+	struct btd_gatt_dbus_service *service = user_data;
+	attio_cleanup(service);
+}
+
 struct btd_gatt_dbus_service *btd_gatt_dbus_service_register(
 						struct btd_device *device,
 						struct gatt_primary *primary)
@@ -521,6 +703,8 @@ struct btd_gatt_dbus_service *btd_gatt_dbus_service_register(
 
 	service->path = g_strdup_printf("%s/service%04X", device_path,
 							primary->range.start);
+	service->device = device;
+	service->range = primary->range;
 
 	if (bt_string_to_uuid(&uuid, primary->uuid)) {
 		error("Primary has invalid UUID: %s", primary->uuid);
@@ -531,19 +715,22 @@ struct btd_gatt_dbus_service *btd_gatt_dbus_service_register(
 
 	DBG("Creating GATT service %s", service->path);
 
-	if (g_dbus_register_interface(btd_get_dbus_connection(),
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					service->path, GATT_SERVICE_IFACE,
 					NULL, NULL, service_properties,
 					service,
-					service_free) == FALSE) {
+					service_free)) {
 		char device_addr[18];
 		ba2str(device_get_address(device), device_addr);
 		error("Unable to register GATT service: UUID: %s, device: %s",
-			primary->uuid, device_addr);
+						primary->uuid, device_addr);
 		goto fail;
 	}
 
-	service->device = device;
+	service->attioid = service->attioid = btd_device_add_attio_callback(
+					service->device, attio_connected_cb,
+					attio_disconnected_cb, service);
+
 	return service;
 
 fail:
-- 
1.9.0.279.gdc9e3eb

