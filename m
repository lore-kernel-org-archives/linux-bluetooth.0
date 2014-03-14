Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [RFC BlueZ v1 1/2] gatt-dbus: Add remote GATT service objects.
Date: Fri, 14 Mar 2014 16:30:10 -0700
Message-Id: <1394839811-5746-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1394839811-5746-1-git-send-email-armansito@chromium.org>
References: <1394839811-5746-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the initial GATT client D-Bus API support for remote primary
GATT services. Characteristics, descriptors, and included services are not yet
handled.
---
 src/device.c    | 35 +++++++++++++++++++++
 src/gatt-dbus.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 src/gatt-dbus.h | 24 +++++++++++++++
 3 files changed, 150 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index e624445..ce895b2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -61,10 +61,12 @@
 #include "uuid-helper.h"
 #include "sdp-client.h"
 #include "attrib/gatt.h"
+#include "gatt-dbus.h"
 #include "agent.h"
 #include "textfile.h"
 #include "storage.h"
 #include "attrib-server.h"
+#include "gatt.h"
 
 #define IO_CAPABILITY_NOINPUTNOOUTPUT	0x03
 
@@ -186,6 +188,7 @@ struct btd_device {
 	GSList		*uuids;
 	GSList		*primaries;		/* List of primary services */
 	GSList		*services;		/* List of btd_service */
+	GSList		*gatt_services;		/* List of GATT DBus Services */
 	GSList		*pending;		/* Pending services */
 	GSList		*watches;		/* List of disconnect_data */
 	gboolean	temporary;
@@ -511,11 +514,18 @@ static void svc_dev_remove(gpointer user_data)
 	g_free(cb);
 }
 
+static void gatt_dbus_service_free(gpointer user_data)
+{
+	struct btd_gatt_dbus_service *service = user_data;
+	btd_gatt_dbus_service_unregister(service);
+}
+
 static void device_free(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
 	g_slist_free_full(device->uuids, g_free);
+	g_slist_free_full(device->gatt_services, gatt_dbus_service_free);
 	g_slist_free_full(device->primaries, g_free);
 	g_slist_free_full(device->attios, g_free);
 	g_slist_free_full(device->attios_offline, g_free);
@@ -3317,6 +3327,29 @@ done:
 	return FALSE;
 }
 
+static void expose_btd_dbus_gatt_services(struct btd_device *device)
+{
+	GSList *l;
+
+	/* Clear current list of GATT services. */
+	g_slist_free_full(device->gatt_services, gatt_dbus_service_free);
+	device->gatt_services = NULL;
+
+	for (l = device->primaries; l; l = g_slist_next(l)) {
+		struct gatt_primary *prim = l->data;
+		struct btd_gatt_dbus_service *service;
+
+		service = btd_gatt_dbus_service_register(device, prim);
+		if (service == NULL) {
+			error("Failed to register a GATT D-Bus service.");
+			continue;
+		}
+
+		device->gatt_services = g_slist_append(device->gatt_services,
+								service);
+	}
+}
+
 static void register_all_services(struct browse_req *req, GSList *services)
 {
 	struct btd_device *device = req->device;
@@ -3329,6 +3362,8 @@ static void register_all_services(struct browse_req *req, GSList *services)
 
 	device_register_primaries(device, g_slist_copy(services), -1);
 
+	expose_btd_dbus_gatt_services(device);
+
 	device_probe_profiles(device, req->profiles_added);
 
 	if (device->attios == NULL && device->attios_offline == NULL)
diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index c5f1597..3937e17 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -37,6 +37,9 @@
 #include "lib/uuid.h"
 #include "dbus-common.h"
 #include "log.h"
+#include "attrib/att.h"
+#include "attrib/gattrib.h"
+#include "attrib/gatt.h"
 
 #include "error.h"
 #include "gatt.h"
@@ -47,6 +50,12 @@
 #define GATT_CHR_IFACE			"org.bluez.GattCharacteristic1"
 #define GATT_DESCRIPTOR_IFACE		"org.bluez.GattDescriptor1"
 
+struct btd_gatt_dbus_service {
+	bt_uuid_t uuid;
+	struct btd_device *device;
+	char *path;
+};
+
 struct external_app {
 	char *owner;
 	char *path;
@@ -436,7 +445,7 @@ static DBusMessage *unregister_service(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
-static const GDBusMethodTable methods[] = {
+static const GDBusMethodTable manager_methods[] = {
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterService",
 				GDBUS_ARGS({ "service", "o"},
 						{ "options", "a{sv}"}),
@@ -450,8 +459,8 @@ static const GDBusMethodTable methods[] = {
 gboolean gatt_dbus_manager_register(void)
 {
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
-				"/org/bluez", GATT_MGR_IFACE,
-				methods, NULL, NULL, NULL, NULL) == FALSE)
+				"/org/bluez", GATT_MGR_IFACE, manager_methods,
+				NULL, NULL, NULL, NULL) == FALSE)
 		return FALSE;
 
 	proxy_hash = g_hash_table_new_full(g_direct_hash, g_direct_equal,
@@ -468,3 +477,82 @@ void gatt_dbus_manager_unregister(void)
 	g_dbus_unregister_interface(btd_get_dbus_connection(), "/org/bluez",
 							GATT_MGR_IFACE);
 }
+
+static gboolean service_property_get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	char uuid[MAX_LEN_UUID_STR + 1];
+	const char *ptr = uuid;
+	struct btd_gatt_dbus_service *service = data;
+
+	bt_uuid_to_string(&service->uuid, uuid, sizeof(uuid));
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable service_properties[] = {
+	{ "UUID", "s", service_property_get_uuid, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{}
+};
+
+static void service_free(gpointer user_data)
+{
+	struct btd_gatt_dbus_service *service = user_data;
+
+	g_free(service->path);
+	g_free(service);
+}
+
+struct btd_gatt_dbus_service *btd_gatt_dbus_service_register(
+						struct btd_device *device,
+						struct gatt_primary *primary)
+{
+	struct btd_gatt_dbus_service *service;
+	bt_uuid_t uuid;
+	const char *device_path = device_get_path(device);
+
+	DBG("GATT service UUID: %s", primary->uuid);
+
+	service = g_try_new0(struct btd_gatt_dbus_service, 1);
+	if (service == NULL)
+		return NULL;
+
+	service->path = g_strdup_printf("%s/service%04X", device_path,
+							primary->range.start);
+
+	if (bt_string_to_uuid(&uuid, primary->uuid)) {
+		error("Primary has invalid UUID: %s", primary->uuid);
+		goto fail;
+	}
+
+	bt_uuid_to_uuid128(&uuid, &service->uuid);
+
+	DBG("Creating GATT service %s", service->path);
+
+	if (g_dbus_register_interface(btd_get_dbus_connection(),
+					service->path, GATT_SERVICE_IFACE,
+					NULL, NULL, service_properties,
+					service,
+					service_free) == FALSE) {
+		char device_addr[18];
+		ba2str(device_get_address(device), device_addr);
+		error("Unable to register GATT service: UUID: %s, device: %s",
+			primary->uuid, device_addr);
+		goto fail;
+	}
+
+	service->device = device;
+	return service;
+
+fail:
+	service_free(service);
+	return NULL;
+}
+
+void btd_gatt_dbus_service_unregister(struct btd_gatt_dbus_service *service)
+{
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+					service->path, GATT_SERVICE_IFACE);
+}
diff --git a/src/gatt-dbus.h b/src/gatt-dbus.h
index 310cfa9..c09b7fb 100644
--- a/src/gatt-dbus.h
+++ b/src/gatt-dbus.h
@@ -21,5 +21,29 @@
  *
  */
 
+struct btd_gatt_dbus_service;
+
 gboolean gatt_dbus_manager_register(void);
 void gatt_dbus_manager_unregister(void);
+
+/*
+ * btd_gatt_dbus_service_create - Create a GATT service that represents a remote
+ * primary GATT service and expose it via D-Bus.
+ *
+ * @device:	The remote device that hosts the GATT service.
+ * @primary:	The primary GATT service.
+ *
+ * Returns a reference to the GATT service object. In case of error, NULL is
+ * returned.
+ */
+struct btd_gatt_dbus_service *btd_gatt_dbus_service_register(
+						struct btd_device *device,
+						struct gatt_primary *primary);
+
+/*
+ * btd_gatt_dbus_service_free - Unregister a GATT service as a D-Bus object and
+ * free up its memory.
+ *
+ * @service: The GATT service object to remove.
+ */
+void btd_gatt_dbus_service_unregister(struct btd_gatt_dbus_service *service);
-- 
1.9.0.279.gdc9e3eb

