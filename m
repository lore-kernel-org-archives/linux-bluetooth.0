Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 8/9] android/tester-ng: Add remote device set property fail cases
Date: Fri, 18 Jul 2014 11:50:20 +0200
Message-Id: <1405677021-18877-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405677021-18877-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405677021-18877-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those set property requests should fail as they request to set remotes
adapter properties.
---
 android/tester-bluetooth.c | 205 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 205 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 480c92e..c36b507 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -228,6 +228,11 @@ static bt_property_t prop_test_bdname = {
 	.val = test_bdname,
 	.len = sizeof(test_bdname) - 1,
 };
+static struct bt_action_data prop_test_ble_remote_bdname_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_BDNAME,
+	.prop = &prop_test_bdname,
+};
 
 static bt_scan_mode_t test_scan_mode_connectable_discoverable =
 					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE;
@@ -243,6 +248,11 @@ static bt_property_t prop_test_disctimeout = {
 	.val = &test_disctimeout_val,
 	.len = sizeof(test_disctimeout_val),
 };
+static struct bt_action_data prop_test_ble_remote_disc_timeout_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
+	.prop = &prop_test_disctimeout,
+};
 
 static unsigned char test_uuids_val[] = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00,
 			0x00, 0x80, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -252,6 +262,11 @@ static bt_property_t prop_test_uuid = {
 	.val = &test_uuids_val,
 	.len = sizeof(test_uuids_val),
 };
+static struct bt_action_data prop_test_ble_remote_uuids_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_UUIDS,
+	.prop = &prop_test_uuid,
+};
 
 static uint32_t test_cod_val = 0;
 static bt_property_t prop_test_cod = {
@@ -259,6 +274,11 @@ static bt_property_t prop_test_cod = {
 	.val = &test_cod_val,
 	.len = sizeof(test_cod_val),
 };
+static struct bt_action_data prop_test_ble_remote_cod_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_CLASS_OF_DEVICE,
+	.prop = &prop_test_cod,
+};
 
 static uint32_t test_tod_val = BT_DEVICE_DEVTYPE_BLE;
 static bt_property_t prop_test_tod = {
@@ -266,6 +286,11 @@ static bt_property_t prop_test_tod = {
 	.val = &test_tod_val,
 	.len = sizeof(test_tod_val),
 };
+static struct bt_action_data prop_test_ble_remote_tod_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_TYPE_OF_DEVICE,
+	.prop = &prop_test_tod,
+};
 
 static int32_t test_remote_rssi_val = -9;
 static bt_property_t prop_test_remote_rssi = {
@@ -273,6 +298,11 @@ static bt_property_t prop_test_remote_rssi = {
 	.val = &test_remote_rssi_val,
 	.len = sizeof(test_remote_rssi_val),
 };
+static struct bt_action_data prop_test_ble_remote_rssi_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_REMOTE_RSSI,
+	.prop = &prop_test_remote_rssi,
+};
 
 static bt_service_record_t test_srvc_record_val =  {
 	.uuid = { {0x00} },
@@ -284,6 +314,11 @@ static bt_property_t prop_test_srvc_record = {
 	.val = &test_srvc_record_val,
 	.len = sizeof(test_srvc_record_val),
 };
+static struct bt_action_data prop_test_ble_remote_srvc_record_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_SERVICE_RECORD,
+	.prop = &prop_test_srvc_record,
+};
 
 static bt_bdaddr_t test_bdaddr_val = {
 	.address = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
@@ -293,6 +328,11 @@ static bt_property_t prop_test_bdaddr = {
 	.val = &test_bdaddr_val,
 	.len = sizeof(test_bdaddr_val),
 };
+static struct bt_action_data prop_test_ble_remote_bdaddr_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_BDADDR,
+	.prop = &prop_test_bdaddr,
+};
 
 static bt_scan_mode_t setprop_scan_mode_conn_val = BT_SCAN_MODE_CONNECTABLE;
 
@@ -308,6 +348,11 @@ static bt_property_t prop_test_scan_mode_none = {
 	.val = &test_scan_mode_none_val,
 	.len = sizeof(test_scan_mode_none_val),
 };
+static struct bt_action_data prop_test_ble_remote_scanmode_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.prop = &prop_test_scan_mode_none,
+};
 
 static bt_bdaddr_t test_bonded_dev_addr_val = {
 	.address = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 },
@@ -317,6 +362,23 @@ static bt_property_t prop_test_bonded_dev_addr = {
 	.val = &test_bonded_dev_addr_val,
 	.len = sizeof(test_bonded_dev_addr_val),
 };
+static struct bt_action_data prop_test_ble_bonded_dev_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
+	.prop = &prop_test_bonded_dev_addr,
+};
+
+static long test_remote_timestamp_val = 0x7f3d79965adf;
+static bt_property_t prop_test_ble_remote_timestamp_prop = {
+	.type = BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP,
+	.val = &test_remote_timestamp_val,
+	.len = sizeof(test_remote_timestamp_val),
+};
+static struct bt_action_data prop_test_ble_remote_timestamp_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP,
+	.prop = &prop_test_ble_remote_timestamp_prop,
+};
 
 static struct test_case test_cases[] = {
 	TEST_CASE("Bluetooth Init",
@@ -695,6 +757,149 @@ static struct test_case test_cases[] = {
 						&prop_emu_ble_remote_fname_req),
 		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_fname_prop, 1),
 	),
+	TEST_CASE("Bluetooth Device Set BDNAME - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_FAIL(bt_set_device_prop_action,
+					&prop_test_ble_remote_bdname_req),
+	),
+	TEST_CASE("Bluetooth Device Set UUIDS - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_FAIL(bt_set_device_prop_action,
+					&prop_test_ble_remote_uuids_req),
+	),
+	TEST_CASE("Bluetooth Device Set COD - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_FAIL(bt_set_device_prop_action,
+						&prop_test_ble_remote_cod_req),
+	),
+	TEST_CASE("Bluetooth Device Set TOD - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_FAIL(bt_set_device_prop_action,
+						&prop_test_ble_remote_tod_req),
+	),
+	TEST_CASE("Bluetooth Device Set RSSI - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_FAIL(bt_set_device_prop_action,
+						&prop_test_ble_remote_rssi_req),
+	),
+	TEST_CASE("Bluetooth Device Set TIMESTAMP - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_FAIL(bt_set_device_prop_action,
+					&prop_test_ble_remote_timestamp_req),
+	),
+	TEST_CASE("Bluetooth Device Set BDADDR - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_FAIL(bt_set_device_prop_action,
+					&prop_test_ble_remote_bdaddr_req),
+	),
+	TEST_CASE("Bluetooth Device Set SERVICE_RECORD - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_FAIL(bt_set_device_prop_action,
+					&prop_test_ble_remote_srvc_record_req),
+	),
+	TEST_CASE("Bluetooth Device Set SCAN_MODE - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_FAIL(bt_set_device_prop_action,
+					&prop_test_ble_remote_scanmode_req),
+	),
+	TEST_CASE("Bluetooth Device Set BONDED_DEVICES - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_FAIL(bt_set_device_prop_action,
+						&prop_test_ble_bonded_dev_req),
+	),
+	TEST_CASE("Bluetooth Device Set DISCOVERY_TIMEOUT - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_FAIL(bt_set_device_prop_action,
+					&prop_test_ble_remote_disc_timeout_req),
+	),
 };
 
 struct queue *get_bluetooth_tests(void)
-- 
1.9.1

