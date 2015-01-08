Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 10/14] profiles/gap: Fix probe/accept behavior.
Date: Wed,  7 Jan 2015 21:48:24 -0800
Message-Id: <1420696108-29699-11-git-send-email-armansito@chromium.org>
In-Reply-To: <1420696108-29699-1-git-send-email-armansito@chromium.org>
References: <1420696108-29699-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the GAP profile so that it assumes that there will be
one btd_service instance per-device rather than per-service-per-device.
---
 profiles/gap/gas.c | 124 +++++++++++++++++++++++++++++------------------------
 1 file changed, 68 insertions(+), 56 deletions(-)

diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index 01b6ec2..0014fc8 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -43,21 +43,25 @@
 #include "src/service.h"
 #include "src/log.h"
 
+#define GAP_UUID16 0x1800
+
 /* Generic Attribute/Access Service */
 struct gas {
 	struct btd_device *device;
 	struct gatt_db *db;
+	unsigned int db_id;
 	struct bt_gatt_client *client;
-	uint16_t start_handle, end_handle;
+	struct gatt_db_attribute *attr;
 };
 
 static GSList *devices;
 
 static void gas_free(struct gas *gas)
 {
-	btd_device_unref(gas->device);
+	gatt_db_unregister(gas->db, gas->db_id);
 	gatt_db_unref(gas->db);
 	bt_gatt_client_unref(gas->client);
+	btd_device_unref(gas->device);
 	g_free(gas);
 }
 
@@ -183,48 +187,31 @@ static void handle_characteristic(struct gatt_db_attribute *attr,
 
 static void handle_gap_service(struct gas *gas)
 {
-	struct gatt_db_attribute *attr;
-
-	attr = gatt_db_get_attribute(gas->db, gas->start_handle);
-	if (!attr) {
-		error("Service with handle 0x%04x not found in db",
-							gas->start_handle);
-		return;
-	}
-
-	gatt_db_service_foreach_char(attr, handle_characteristic, gas);
+	gatt_db_service_foreach_char(gas->attr, handle_characteristic, gas);
 }
 
 static int gap_driver_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct gas *gas;
-	uint16_t start_handle, end_handle;
 	GSList *l;
 	char addr[18];
 
-	if (!btd_service_get_gatt_handles(service, &start_handle, &end_handle))
-		return -1;
-
 	ba2str(device_get_address(device), addr);
-	DBG("GAP profile probe (%s): start: 0x%04x, end 0x%04x", addr,
-						start_handle, end_handle);
+	DBG("GAP profile probe (%s)", addr);
 
-	/*
-	 * There can't be more than one instance of the GAP service on the same
-	 * device.
-	 */
+	/* Ignore, if we were probed for this device already */
 	l = g_slist_find_custom(devices, device, cmp_device);
 	if (l) {
-		error("More than one GAP service exists on device");
+		error("Profile probed twice for the same device!");
 		return -1;
 	}
 
 	gas = g_new0(struct gas, 1);
+	if (!gas)
+		return -1;
 
 	gas->device = btd_device_ref(device);
-	gas->start_handle = start_handle;
-	gas->end_handle = end_handle;
 	devices = g_slist_append(devices, gas);
 
 	return 0;
@@ -234,19 +221,11 @@ static void gap_driver_remove(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct gas *gas;
-	uint16_t start_handle, end_handle;
 	GSList *l;
 	char addr[18];
 
-	if (!btd_service_get_gatt_handles(service, &start_handle,
-								&end_handle)) {
-		error("Removed service is not a GATT service");
-		return;
-	}
-
 	ba2str(device_get_address(device), addr);
-	DBG("GAP profile remove (%s): start: 0x%04x, end 0x%04x", addr,
-						start_handle, end_handle);
+	DBG("GAP profile remove (%s)", addr);
 
 	l = g_slist_find_custom(devices, device, cmp_device);
 	if (!l) {
@@ -256,14 +235,55 @@ static void gap_driver_remove(struct btd_service *service)
 
 	gas = l->data;
 
-	if (gas->start_handle != start_handle ||
-						gas->end_handle != end_handle) {
-		error("Removed unknown GAP service");
+	devices = g_slist_remove(devices, gas);
+	gas_free(gas);
+}
+
+static void foreach_gap_service(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct gas *gas = user_data;
+
+	if (gas->attr) {
+		error("More than one GAP service exists for this device");
 		return;
 	}
 
-	devices = g_slist_remove(devices, gas);
-	gas_free(gas);
+	gas->attr = attr;
+	handle_gap_service(gas);
+}
+
+static void service_added(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct gas *gas = user_data;
+	bt_uuid_t uuid, gap_uuid;
+
+	gatt_db_attribute_get_service_uuid(attr, &uuid);
+	bt_uuid16_create(&gap_uuid, GAP_UUID16);
+
+	if (bt_uuid_cmp(&uuid, &gap_uuid))
+		return;
+
+	if (gas->attr) {
+		error("More than one GAP service added to device");
+		return;
+	}
+
+	DBG("GAP service added");
+
+	gas->attr = attr;
+	handle_gap_service(gas);
+}
+
+static void service_removed(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct gas *gas = user_data;
+
+	if (gas->attr != attr)
+		return;
+
+	DBG("GAP service removed");
+
+	gas->attr = NULL;
 }
 
 static int gap_driver_accept(struct btd_service *service)
@@ -272,19 +292,12 @@ static int gap_driver_accept(struct btd_service *service)
 	struct gatt_db *db = btd_device_get_gatt_db(device);
 	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
 	struct gas *gas;
-	uint16_t start_handle, end_handle;
 	GSList *l;
 	char addr[18];
-
-	if (!btd_service_get_gatt_handles(service, &start_handle,
-								&end_handle)) {
-		error("Service is not a GATT service");
-		return -1;
-	}
+	bt_uuid_t gap_uuid;
 
 	ba2str(device_get_address(device), addr);
-	DBG("GAP profile accept (%s): start: 0x%04x, end 0x%04x", addr,
-						start_handle, end_handle);
+	DBG("GAP profile accept (%s)", addr);
 
 	l = g_slist_find_custom(devices, device, cmp_device);
 	if (!l) {
@@ -294,21 +307,20 @@ static int gap_driver_accept(struct btd_service *service)
 
 	gas = l->data;
 
-	if (gas->start_handle != start_handle ||
-						gas->end_handle != end_handle) {
-		error("Accepting unknown GAP service");
-		return -1;
-	}
-
 	/* Clean-up any old client/db and acquire the new ones */
+	gas->attr = NULL;
+	gatt_db_unregister(gas->db, gas->db_id);
 	gatt_db_unref(gas->db);
 	bt_gatt_client_unref(gas->client);
 
 	gas->db = gatt_db_ref(db);
 	gas->client = bt_gatt_client_ref(client);
+	gas->db_id = gatt_db_register(db, service_added, service_removed, gas,
+									NULL);
 
-	/* Handle the service */
-	handle_gap_service(gas);
+	/* Handle the GAP services */
+	bt_uuid16_create(&gap_uuid, GAP_UUID16);
+	gatt_db_foreach_service(db, &gap_uuid, foreach_gap_service, gas);
 
 	return 0;
 }
-- 
2.2.0.rc0.207.ga3a616c

