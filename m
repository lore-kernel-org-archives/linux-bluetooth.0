Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 02/17] core: gatt: Export GATT services on D-Bus
Date: Fri, 19 Dec 2014 13:35:50 -0800
Message-Id: <1419024965-10375-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1419024965-10375-1-git-send-email-armansito@chromium.org>
References: <1419024965-10375-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds code that exports an object on D-Bus with the
org.bluez.GattService1 interface for each GATT service that is present
in bt_gatt_client.
---
 src/gatt-client.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 150 insertions(+), 3 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 462753c..05782ab 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -24,6 +24,9 @@
 #include <stdbool.h>
 #include <stdint.h>
 
+#include <dbus/dbus.h>
+#include <gdbus/gdbus.h>
+
 #include <bluetooth/bluetooth.h>
 
 #include "log.h"
@@ -36,6 +39,9 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/util.h"
 #include "gatt-client.h"
+#include "dbus-common.h"
+
+#define GATT_SERVICE_IFACE "org.bluez.GattService1"
 
 struct btd_gatt_client {
 	struct btd_device *device;
@@ -46,16 +52,151 @@ struct btd_gatt_client {
 	struct queue *services;
 };
 
+struct service {
+	struct btd_gatt_client *client;
+	bool primary;
+	uint16_t start_handle;
+	uint16_t end_handle;
+	bt_uuid_t uuid;
+	char *path;
+};
+
+static gboolean service_property_get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	char uuid[MAX_LEN_UUID_STR + 1];
+	const char *ptr = uuid;
+	struct service *service = data;
+
+	bt_uuid_to_string(&service->uuid, uuid, sizeof(uuid));
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
+
+	return TRUE;
+}
+
+static gboolean service_property_get_device(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct service *service = data;
+	const char *str = device_get_path(service->client->device);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &str);
+
+	return TRUE;
+}
+
+static gboolean service_property_get_primary(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct service *service = data;
+	dbus_bool_t primary;
+
+	primary = service->primary ? TRUE : FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &primary);
+
+	return TRUE;
+}
+
+static gboolean service_property_get_characteristics(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "o", &array);
+
+	/* TODO: Implement this once characteristics are exported */
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable service_properties[] = {
+	{ "UUID", "s", service_property_get_uuid },
+	{ "Device", "o", service_property_get_device },
+	{ "Primary", "b", service_property_get_primary },
+	{ "Characteristics", "ao", service_property_get_characteristics },
+	{ }
+};
+
 static void service_free(void *data)
 {
-	/* TODO */
+	struct service *service = data;
+
+	g_free(service->path);
+	free(service);
+}
+
+static struct service *service_create(struct gatt_db_attribute *attr,
+						struct btd_gatt_client *client)
+{
+	struct service *service;
+	const char *device_path = device_get_path(client->device);
+	bt_uuid_t uuid;
+
+	service = new0(struct service, 1);
+	if (!service)
+		return NULL;
+
+	service->client = client;
+
+	gatt_db_attribute_get_service_data(attr, &service->start_handle,
+							&service->end_handle,
+							&service->primary,
+							&uuid);
+	bt_uuid_to_uuid128(&uuid, &service->uuid);
+
+	service->path = g_strdup_printf("%s/service%04x", device_path,
+							service->start_handle);
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(), service->path,
+						GATT_SERVICE_IFACE,
+						NULL, NULL,
+						service_properties,
+						service, service_free)) {
+		error("Unable to register GATT service with handle 0x%04x for "
+							"device %s:",
+							service->start_handle,
+							client->devaddr);
+		service_free(service);
+
+		return NULL;
+	}
+
+	DBG("Exported GATT service: %s", service->path);
+
+	return service;
+}
+
+static void unregister_service(void *data)
+{
+	struct service *service = data;
+
+	DBG("Removing GATT service: %s", service->path);
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(), service->path,
+							GATT_SERVICE_IFACE);
+}
+
+static void export_service(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct btd_gatt_client *client = user_data;
+	struct service *service;
+
+	service = service_create(attr, client);
+	if (!service)
+		return;
+
+	queue_push_tail(client->services, service);
 }
 
 static void create_services(struct btd_gatt_client *client)
 {
 	DBG("Exporting objects for GATT services: %s", client->devaddr);
 
-	/* TODO */
+	gatt_db_foreach_service(client->db, NULL, export_service, client);
 }
 
 struct btd_gatt_client *btd_gatt_client_new(struct btd_device *device)
@@ -93,7 +234,7 @@ void btd_gatt_client_destroy(struct btd_gatt_client *client)
 	if (!client)
 		return;
 
-	queue_destroy(client->services, service_free);
+	queue_destroy(client->services, unregister_service);
 	bt_gatt_client_unref(client->gatt);
 	gatt_db_unref(client->db);
 	free(client);
@@ -137,6 +278,12 @@ void btd_gatt_client_disconnected(struct btd_gatt_client *client)
 
 	DBG("Device disconnected. Cleaning up");
 
+	/*
+	 * Remove all services. We'll recreate them when a new bt_gatt_client
+	 * becomes ready.
+	 */
+	queue_remove_all(client->services, NULL, NULL, unregister_service);
+
 	bt_gatt_client_unref(client->gatt);
 	client->gatt = NULL;
 }
-- 
2.2.0.rc0.207.ga3a616c

