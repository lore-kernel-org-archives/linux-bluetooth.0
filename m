Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 3/8] gatt-service: Provide service uuid in attrib_db_find_avail function
Date: Wed, 25 Jan 2012 11:03:05 +0100
Message-Id: <1327485790-26249-4-git-send-email-sancane@gmail.com>
In-Reply-To: <1327485790-26249-3-git-send-email-sancane@gmail.com>
References: <1327485790-26249-1-git-send-email-sancane@gmail.com>
 <1327485790-26249-2-git-send-email-sancane@gmail.com>
 <1327485790-26249-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need to provide the service uuid because of GATT server should group
16-bit uuid services together and 128-bit uuid services together,
(Bluetooth 4.0, Vol 3, Part G, 3.1).
---
 attrib/gatt-service.c  |    2 +-
 plugins/gatt-example.c |   16 ++++++++++------
 proximity/reporter.c   |    9 ++++++---
 src/attrib-server.c    |    3 ++-
 src/attrib-server.h    |    3 ++-
 5 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index a5e6dcb..4592a90 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -315,7 +315,7 @@ gboolean gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
 		size += info->num_attrs;
 	}
 
-	start_handle = attrib_db_find_avail(adapter, size);
+	start_handle = attrib_db_find_avail(adapter, svc_uuid, size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		goto fail;
diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index e791c53..cfa7f3e 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -132,7 +132,8 @@ static void register_termometer_service(struct gatt_example_adapter *adapter,
 	bt_uuid_t uuid;
 	int len;
 
-	start_handle = attrib_db_find_avail(adapter->adapter, svc_size);
+	bt_uuid16_create(&uuid, THERM_HUMIDITY_SVC_UUID);
+	start_handle = attrib_db_find_avail(adapter->adapter, &uuid, svc_size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		return;
@@ -253,7 +254,8 @@ static void register_manuf1_service(struct gatt_example_adapter *adapter,
 	bt_uuid_t uuid;
 	int len;
 
-	start_handle = attrib_db_find_avail(adapter->adapter, svc_size);
+	bt_uuid16_create(&uuid, MANUFACTURER_SVC_UUID);
+	start_handle = attrib_db_find_avail(adapter->adapter, &uuid, svc_size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		return;
@@ -316,7 +318,8 @@ static void register_manuf2_service(struct gatt_example_adapter *adapter,
 	bt_uuid_t uuid;
 	int len;
 
-	start_handle = attrib_db_find_avail(adapter->adapter, svc_size);
+	bt_uuid16_create(&uuid, MANUFACTURER_SVC_UUID);
+	start_handle = attrib_db_find_avail(adapter->adapter, &uuid, svc_size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		return;
@@ -376,7 +379,8 @@ static void register_vendor_service(struct gatt_example_adapter *adapter,
 	uint8_t atval[256];
 	bt_uuid_t uuid;
 
-	start_handle = attrib_db_find_avail(adapter->adapter, svc_size);
+	bt_uuid16_create(&uuid, VENDOR_SPECIFIC_SVC_UUID);
+	start_handle = attrib_db_find_avail(adapter->adapter, &uuid, svc_size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		return;
@@ -436,8 +440,8 @@ static void register_weight_service(struct gatt_example_adapter *adapter,
 	int len;
 
 	btoh128(&char_weight_uuid_btorder, &char_weight_uuid);
-
-	start_handle = attrib_db_find_avail(adapter->adapter, svc_size);
+	bt_uuid128_create(&uuid, prim_weight_uuid_btorder);
+	start_handle = attrib_db_find_avail(adapter->adapter, &uuid, svc_size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		return;
diff --git a/proximity/reporter.c b/proximity/reporter.c
index a139c7c..b29c75b 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -59,8 +59,9 @@ static void register_link_loss(void)
 	uint8_t atval[256];
 	bt_uuid_t uuid;
 
+	bt_uuid16_create(&uuid, LINK_LOSS_SVC_UUID);
 	/* FIXME: Provide the adapter in next function */
-	start_handle = attrib_db_find_avail(NULL, svc_size);
+	start_handle = attrib_db_find_avail(NULL, &uuid, svc_size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		return;
@@ -100,8 +101,9 @@ static void register_tx_power(void)
 	uint8_t atval[256];
 	bt_uuid_t uuid;
 
+	bt_uuid16_create(&uuid, TX_POWER_SVC_UUID);
 	/* FIXME: Provide the adapter in next function */
-	start_handle = attrib_db_find_avail(NULL, svc_size);
+	start_handle = attrib_db_find_avail(NULL, &uuid, svc_size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		return;
@@ -149,8 +151,9 @@ static void register_immediate_alert(void)
 	uint8_t atval[256];
 	bt_uuid_t uuid;
 
+	bt_uuid16_create(&uuid, IMMEDIATE_ALERT_SVC_UUID);
 	/* FIXME: Provide the adapter in next function */
-	start_handle = attrib_db_find_avail(NULL, svc_size);
+	start_handle = attrib_db_find_avail(NULL, &uuid, svc_size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		return;
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 36a398f..93b7216 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1270,7 +1270,8 @@ void attrib_free_sdp(uint32_t sdp_handle)
 	remove_record_from_server(sdp_handle);
 }
 
-uint16_t attrib_db_find_avail(struct btd_adapter *adapter, uint16_t nitems)
+uint16_t attrib_db_find_avail(struct btd_adapter *adapter, bt_uuid_t *svc_uuid,
+								uint16_t nitems)
 {
 	struct gatt_server *server;
 	uint16_t handle;
diff --git a/src/attrib-server.h b/src/attrib-server.h
index 2c6f428..fb4637c 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -22,7 +22,8 @@
  *
  */
 
-uint16_t attrib_db_find_avail(struct btd_adapter *adapter, uint16_t nitems);
+uint16_t attrib_db_find_avail(struct btd_adapter *adapter, bt_uuid_t *svc_uuid,
+							uint16_t nitems);
 struct attribute *attrib_db_add(struct btd_adapter *adapter, uint16_t handle,
 				bt_uuid_t *uuid, int read_reqs, int write_reqs,
 				const uint8_t *value, int len);
-- 
1.7.8.4

