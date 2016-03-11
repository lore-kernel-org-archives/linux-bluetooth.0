Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc/device-api: Replace GattServices with ServicesDiscovered property
Date: Fri, 11 Mar 2016 16:32:25 +0200
Message-Id: <1457706745-14511-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

GattServices is not really doing was it was meant to do which was to
track progress of service discovery since it only worked for the very
first time a device is connected but since we no longer remove the
attributes an application would have the false impression the service are
all resolved by the time it reconnects when in fact the service may have
changed.

Furthermore object tracking like it is doing has been obsolete by
ObjectManager so this propose to replace the service discovery tracking
with a boolean property which works both with SDP as well as GATT
discovery.
---
 doc/device-api.txt |  9 +++----
 src/device.c       | 79 +++++++++++++++++-------------------------------------
 2 files changed, 28 insertions(+), 60 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index a8076a2..96832e8 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -212,10 +212,7 @@ Properties	string Address [readonly]
 			Service advertisement data. Keys are the UUIDs in
 			string format followed by its byte array value.
 
-		array{object} GattServices [readonly, optional]
+		bool ServicesResolved [readonly, experimental]
 
-			List of GATT service object paths. Each referenced
-			object exports the org.bluez.GattService1 interface and
-			represents a remote GATT service. This property will be
-			updated once all remote GATT services of this device
-			have been discovered and exported over D-Bus.
+			Indicate whether or not service discovery has been
+			resolved.
diff --git a/src/device.c b/src/device.c
index 14e850e..72e8e22 100644
--- a/src/device.c
+++ b/src/device.c
@@ -238,7 +238,6 @@ struct btd_device {
 	 * attribute cache support can be built.
 	 */
 	struct gatt_db *db;			/* GATT db cache */
-	bool gatt_cache_used;			/* true if discovery skipped */
 	struct bt_gatt_client *client;		/* GATT client instance */
 	struct bt_gatt_server *server;		/* GATT server instance */
 
@@ -949,38 +948,14 @@ static gboolean dev_property_exists_tx_power(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static void append_service_path(const char *path, void *user_data)
-{
-	DBusMessageIter *array = user_data;
-
-	dbus_message_iter_append_basic(array, DBUS_TYPE_OBJECT_PATH, &path);
-}
-
-static gboolean dev_property_get_gatt_services(
-					const GDBusPropertyTable *property,
+static gboolean
+dev_property_get_svc_resolved(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
-	struct btd_device *dev = data;
-	DBusMessageIter array;
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "o", &array);
-
-	btd_gatt_client_foreach_service(dev->client_dbus, append_service_path,
-									&array);
-
-	dbus_message_iter_close_container(iter, &array);
-
-	return TRUE;
-}
-
-static gboolean dev_property_exists_gatt_services(
-					const GDBusPropertyTable *property,
-					void *data)
-{
-	struct btd_device *dev = data;
+	struct btd_device *device = data;
+	gboolean val = device->svc_refreshed;
 
-	if (!dev->client || !bt_gatt_client_is_ready(dev->client))
-		return FALSE;
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
 
 	return TRUE;
 }
@@ -2176,6 +2151,17 @@ done:
 	browse_request_free(req);
 }
 
+static void device_set_svc_refreshed(struct btd_device *device, bool value)
+{
+	if (device->svc_refreshed == value)
+		return;
+
+	device->svc_refreshed = value;
+
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "ServicesResolved");
+}
+
 static void device_svc_resolved(struct btd_device *dev, uint8_t bdaddr_type,
 								int err)
 {
@@ -2191,7 +2177,7 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t bdaddr_type,
 	 * device.
 	 */
 	if (state->connected)
-		dev->svc_refreshed = true;
+		device_set_svc_refreshed(dev, true);
 
 	g_slist_free_full(dev->eir_uuids, g_free);
 	dev->eir_uuids = NULL;
@@ -2533,8 +2519,7 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "TxPower", "n", dev_property_get_tx_power, NULL,
 					dev_property_exists_tx_power,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "GattServices", "ao", dev_property_get_gatt_services, NULL,
-					dev_property_exists_gatt_services,
+	{ "ServicesResolved", "b", dev_property_get_svc_resolved, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 
 	{ }
@@ -2586,9 +2571,10 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 		return;
 
 	state->connected = false;
-	device->svc_refreshed = false;
 	device->general_connect = FALSE;
 
+	device_set_svc_refreshed(device, false);
+
 	if (device->disconn_timer > 0) {
 		g_source_remove(device->disconn_timer);
 		device->disconn_timer = 0;
@@ -4550,19 +4536,6 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 	register_gatt_services(device);
 
 	btd_gatt_client_ready(device->client_dbus);
-
-	/*
-	 * Update the GattServices property. Do this asynchronously since this
-	 * should happen after the "Characteristics" and "Descriptors"
-	 * properties of all services have been asynchronously updated by
-	 * btd_gatt_client.
-	 *
-	 * Service discovery will be skipped and exported objects won't change
-	 * if the attribute cache was populated when bt_gatt_client gets
-	 * initialized, so no need to to send this signal if that's the case.
-	 */
-	if (!device->gatt_cache_used)
-		g_idle_add(gatt_services_changed, device);
 }
 
 static void gatt_client_service_changed(uint16_t start_handle,
@@ -4615,8 +4588,6 @@ static void gatt_client_init(struct btd_device *device)
 		return;
 	}
 
-	device->gatt_cache_used = !gatt_db_isempty(device->db);
-
 	btd_gatt_client_connected(device->client_dbus);
 }
 
@@ -4792,10 +4763,10 @@ done:
 		bonding_request_free(device->bonding);
 	}
 
-	if (device->connect) {
-		if (!device->le_state.svc_resolved && !err)
-			device_browse_gatt(device, NULL);
+	if (!err)
+		device_browse_gatt(device, NULL);
 
+	if (device->connect) {
 		if (err < 0)
 			reply = btd_error_failed(device->connect,
 							strerror(-err));
@@ -4941,12 +4912,12 @@ static int device_browse_gatt(struct btd_device *device, DBusMessage *msg)
 	if (!req)
 		return -EBUSY;
 
-	if (device->attrib) {
+	if (device->client) {
 		/*
 		 * If discovery has not yet completed, then wait for gatt-client
 		 * to become ready.
 		 */
-		if (!device->le_state.svc_resolved)
+		if (!bt_gatt_client_is_ready(device->client))
 			return 0;
 
 		/*
-- 
2.5.0

