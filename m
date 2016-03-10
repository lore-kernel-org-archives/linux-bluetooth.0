Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] doc/device-api: Replace GattServices with Discovering property
Date: Thu, 10 Mar 2016 18:16:44 +0200
Message-Id: <1457626604-5656-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

GattServices is not really doing was it was meant to do which was to
track progress of service discovery since it only worked for the very
first time a device is connected but since we no longer remove the
attributes an application would have the false impression the service are
all resolved by the time it reconnects when in fact the service may have
changed.

Futhermore object tracking like it is doing has been obsolete by
ObjectManager so this propose to replace the service discovery tracking
with a boolean property which works both with SDP as well as GATT
discovery.
---
 doc/device-api.txt |  9 +++------
 src/device.c       | 58 +++++++++++-------------------------------------------
 2 files changed, 14 insertions(+), 53 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index a8076a2..9e58664 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -212,10 +212,7 @@ Properties	string Address [readonly]
 			Service advertisement data. Keys are the UUIDs in
 			string format followed by its byte array value.
 
-		array{object} GattServices [readonly, optional]
+		bool Discovering [readonly, optional, experimental]
 
-			List of GATT service object paths. Each referenced
-			object exports the org.bluez.GattService1 interface and
-			represents a remote GATT service. This property will be
-			updated once all remote GATT services of this device
-			have been discovered and exported over D-Bus.
+			Indicate whether or not service discovery is in
+			progress.
diff --git a/src/device.c b/src/device.c
index 14e850e..4e49652 100644
--- a/src/device.c
+++ b/src/device.c
@@ -238,7 +238,6 @@ struct btd_device {
 	 * attribute cache support can be built.
 	 */
 	struct gatt_db *db;			/* GATT db cache */
-	bool gatt_cache_used;			/* true if discovery skipped */
 	struct bt_gatt_client *client;		/* GATT client instance */
 	struct bt_gatt_server *server;		/* GATT server instance */
 
@@ -534,6 +533,9 @@ static void browse_request_free(struct browse_req *req)
 	if (req->records)
 		sdp_list_free(req->records, (sdp_free_func_t) sdp_record_free);
 
+	g_dbus_emit_property_changed(dbus_conn, req->device->path,
+					DEVICE_INTERFACE, "Discovering");
+
 	g_free(req);
 }
 
@@ -949,38 +951,13 @@ static gboolean dev_property_exists_tx_power(const GDBusPropertyTable *property,
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
+static gboolean dev_property_get_discovering(const GDBusPropertyTable *property,
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
+	gboolean val = device->browse ? true : false;
 
-	if (!dev->client || !bt_gatt_client_is_ready(dev->client))
-		return FALSE;
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
 
 	return TRUE;
 }
@@ -2533,8 +2510,7 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "TxPower", "n", dev_property_get_tx_power, NULL,
 					dev_property_exists_tx_power,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "GattServices", "ao", dev_property_get_gatt_services, NULL,
-					dev_property_exists_gatt_services,
+	{ "Discovering", "b", dev_property_get_discovering, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 
 	{ }
@@ -4550,19 +4526,6 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
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
@@ -4615,8 +4578,6 @@ static void gatt_client_init(struct btd_device *device)
 		return;
 	}
 
-	device->gatt_cache_used = !gatt_db_isempty(device->db);
-
 	btd_gatt_client_connected(device->client_dbus);
 }
 
@@ -4914,6 +4875,9 @@ static struct browse_req *browse_request_new(struct btd_device *device,
 
 	device->browse = req;
 
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "Discovering");
+
 	if (!msg)
 		return req;
 
-- 
2.5.0

