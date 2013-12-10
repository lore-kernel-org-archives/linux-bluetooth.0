Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/8] android/bluetooth: Rename functions to match adapter properties names
Date: Tue, 10 Dec 2013 16:06:15 +0100
Message-Id: <1386687982-1799-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This match adapter properties handling functions with properties names.
Will make code easier to understand and avoid clashes with remote
device properties functions.
---
 android/bluetooth.c | 72 ++++++++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index a3145cb..f8df473 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1128,7 +1128,7 @@ static void uuid16_to_uint128(uint16_t uuid, uint128_t *u128)
 	ntoh128(&uuid128.value.uuid128, u128);
 }
 
-static uint8_t get_uuids(void)
+static uint8_t get_adapter_uuids(void)
 {
 	struct hal_ev_adapter_props_changed *ev;
 	GSList *list = adapter.uuids;
@@ -1178,7 +1178,7 @@ static void remove_uuid_complete(uint8_t status, uint16_t length,
 
 	mgmt_dev_class_changed_event(adapter.index, length, param, NULL);
 
-	get_uuids();
+	get_adapter_uuids();
 }
 
 static void remove_uuid(uint16_t uuid)
@@ -1204,7 +1204,7 @@ static void add_uuid_complete(uint8_t status, uint16_t length,
 
 	mgmt_dev_class_changed_event(adapter.index, length, param, NULL);
 
-	get_uuids();
+	get_adapter_uuids();
 }
 
 static void add_uuid(uint8_t svc_hint, uint16_t uuid)
@@ -1373,7 +1373,7 @@ static uint8_t set_adapter_name(const uint8_t *name, uint16_t len)
 	return HAL_STATUS_FAILED;
 }
 
-static uint8_t set_discoverable_timeout(const void *buf, uint16_t len)
+static uint8_t set_adapter_discoverable_timeout(const void *buf, uint16_t len)
 {
 	const uint32_t *timeout = buf;
 
@@ -1686,7 +1686,7 @@ static bool set_discoverable(uint8_t mode, uint16_t timeout)
 	return false;
 }
 
-static uint8_t get_address(void)
+static uint8_t get_adapter_address(void)
 {
 	uint8_t buf[BASELEN_PROP_CHANGED + sizeof(bdaddr_t)];
 	struct hal_ev_adapter_props_changed *ev = (void *) buf;
@@ -1704,7 +1704,7 @@ static uint8_t get_address(void)
 	return HAL_STATUS_SUCCESS;
 }
 
-static uint8_t get_name(void)
+static uint8_t get_adapter_name(void)
 {
 	if (!adapter.name)
 		return HAL_STATUS_FAILED;
@@ -1715,7 +1715,7 @@ static uint8_t get_name(void)
 }
 
 
-static uint8_t get_class(void)
+static uint8_t get_adapter_class(void)
 {
 	DBG("");
 
@@ -1724,7 +1724,7 @@ static uint8_t get_class(void)
 	return HAL_STATUS_SUCCESS;
 }
 
-static uint8_t get_type(void)
+static uint8_t get_adapter_type(void)
 {
 	DBG("Not implemented");
 
@@ -1733,7 +1733,7 @@ static uint8_t get_type(void)
 	return HAL_STATUS_FAILED;
 }
 
-static uint8_t get_service(void)
+static uint8_t get_adapter_service_rec(void)
 {
 	DBG("Not implemented");
 
@@ -1742,7 +1742,7 @@ static uint8_t get_service(void)
 	return HAL_STATUS_FAILED;
 }
 
-static uint8_t get_scan_mode(void)
+static uint8_t get_adapter_scan_mode(void)
 {
 	DBG("");
 
@@ -1751,7 +1751,7 @@ static uint8_t get_scan_mode(void)
 	return HAL_STATUS_SUCCESS;
 }
 
-static uint8_t get_devices(void)
+static uint8_t get_adapter_bonded_devices(void)
 {
 	DBG("Not implemented");
 
@@ -1760,7 +1760,7 @@ static uint8_t get_devices(void)
 	return HAL_STATUS_FAILED;
 }
 
-static uint8_t get_discoverable_timeout(void)
+static uint8_t get_adapter_discoverable_timeout(void)
 {
 	struct hal_ev_adapter_props_changed *ev;
 	uint8_t buf[BASELEN_PROP_CHANGED + sizeof(uint32_t)];
@@ -1789,31 +1789,31 @@ static void handle_get_adapter_prop_cmd(const void *buf, uint16_t len)
 
 	switch (cmd->type) {
 	case HAL_PROP_ADAPTER_ADDR:
-		status = get_address();
+		status = get_adapter_address();
 		break;
 	case HAL_PROP_ADAPTER_NAME:
-		status = get_name();
+		status = get_adapter_name();
 		break;
 	case HAL_PROP_ADAPTER_UUIDS:
-		status = get_uuids();
+		status = get_adapter_uuids();
 		break;
 	case HAL_PROP_ADAPTER_CLASS:
-		status = get_class();
+		status = get_adapter_class();
 		break;
 	case HAL_PROP_ADAPTER_TYPE:
-		status = get_type();
+		status = get_adapter_type();
 		break;
 	case HAL_PROP_ADAPTER_SERVICE_REC:
-		status = get_service();
+		status = get_adapter_service_rec();
 		break;
 	case HAL_PROP_ADAPTER_SCAN_MODE:
-		status = get_scan_mode();
+		status = get_adapter_scan_mode();
 		break;
 	case HAL_PROP_ADAPTER_BONDED_DEVICES:
-		status = get_devices();
+		status = get_adapter_bonded_devices();
 		break;
 	case HAL_PROP_ADAPTER_DISC_TIMEOUT:
-		status = get_discoverable_timeout();
+		status = get_adapter_discoverable_timeout();
 		break;
 	default:
 		status = HAL_STATUS_FAILED;
@@ -1823,17 +1823,17 @@ static void handle_get_adapter_prop_cmd(const void *buf, uint16_t len)
 	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_ADAPTER_PROP, status);
 }
 
-static void get_properties(void)
+static void get_adapter_properties(void)
 {
-	get_address();
-	get_name();
-	get_uuids();
-	get_class();
-	get_type();
-	get_service();
-	get_scan_mode();
-	get_devices();
-	get_discoverable_timeout();
+	get_adapter_address();
+	get_adapter_name();
+	get_adapter_uuids();
+	get_adapter_class();
+	get_adapter_type();
+	get_adapter_service_rec();
+	get_adapter_scan_mode();
+	get_adapter_bonded_devices();
+	get_adapter_discoverable_timeout();
 }
 
 static bool start_discovery(void)
@@ -1876,7 +1876,7 @@ static bool stop_discovery(void)
 	return false;
 }
 
-static uint8_t set_scan_mode(const void *buf, uint16_t len)
+static uint8_t set_adapter_scan_mode(const void *buf, uint16_t len)
 {
 	const uint8_t *mode = buf;
 	bool conn, disc, cur_conn, cur_disc;
@@ -1953,13 +1953,13 @@ static void handle_set_adapter_prop_cmd(const void *buf, uint16_t len)
 
 	switch (cmd->type) {
 	case HAL_PROP_ADAPTER_SCAN_MODE:
-		status = set_scan_mode(cmd->val, cmd->len);
+		status = set_adapter_scan_mode(cmd->val, cmd->len);
 		break;
 	case HAL_PROP_ADAPTER_NAME:
 		status = set_adapter_name(cmd->val, cmd->len);
 		break;
 	case HAL_PROP_ADAPTER_DISC_TIMEOUT:
-		status = set_discoverable_timeout(cmd->val, cmd->len);
+		status = set_adapter_discoverable_timeout(cmd->val, cmd->len);
 		break;
 	default:
 		DBG("Unhandled property type 0x%x", cmd->type);
@@ -2222,7 +2222,7 @@ static void handle_enable_cmd(const void *buf, uint16_t len)
 
 	/* Framework expects all properties to be emitted while
 	 * enabling adapter */
-	get_properties();
+	get_adapter_properties();
 
 	if (adapter.current_settings & MGMT_SETTING_POWERED) {
 		status = HAL_STATUS_DONE;
@@ -2260,7 +2260,7 @@ failed:
 
 static void handle_get_adapter_props_cmd(const void *buf, uint16_t len)
 {
-	get_properties();
+	get_adapter_properties();
 
 	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_ADAPTER_PROPS,
 							HAL_STATUS_SUCCESS);
-- 
1.8.3.2

