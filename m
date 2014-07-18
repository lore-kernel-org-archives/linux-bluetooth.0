Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 6/9] android/tester-ng: Add get remote property failing cases
Date: Fri, 18 Jul 2014 11:50:18 +0200
Message-Id: <1405677021-18877-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405677021-18877-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405677021-18877-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those properties requests should fails as those are adapter specific
ones and does not apply to remote devices.
---
 android/tester-bluetooth.c | 107 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 497691f..91c5a1a 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -86,6 +86,10 @@ static bt_property_t prop_emu_bonded_devs = {
 static bt_bdaddr_t emu_remote_bdaddr_val = {
 	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
 };
+static struct bt_action_data prop_emu_ble_remote_bdaddr_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_BDADDR,
+};
 
 static uint32_t emu_remote_type_val = BT_DEVICE_DEVTYPE_BLE;
 static bt_property_t prop_emu_ble_remote_tod_prop = {
@@ -151,6 +155,31 @@ static struct bt_action_data prop_emu_ble_remote_timestamp_req = {
 	.prop_type = BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP,
 };
 
+static struct bt_action_data prop_emu_ble_remote_scan_mode_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+};
+
+static struct bt_action_data prop_emu_ble_remote_bondeddev_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
+};
+
+static struct bt_action_data prop_emu_ble_remote_disctimeout_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
+};
+
+static struct bt_action_data prop_emu_ble_remote_verinfo_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_REMOTE_VERSION_INFO,
+};
+
+static struct bt_action_data prop_emu_ble_remote_fname_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_REMOTE_FRIENDLY_NAME,
+};
+
 static bt_property_t prop_emu_default_set[] = {
 	{ BT_PROPERTY_BDADDR, sizeof(emu_bdaddr_val), NULL },
 	{ BT_PROPERTY_BDNAME, sizeof(emu_bdname_val) - 1, &emu_bdname_val },
@@ -565,6 +594,84 @@ static struct test_case test_cases[] = {
 					&prop_emu_ble_remote_timestamp_req),
 		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_timestamp_prop, 1),
 	),
+	TEST_CASE("Bluetooth Device Get BDADDR - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_FAIL(bt_get_device_prop_action,
+					&prop_emu_ble_remote_bdaddr_req),
+	),
+	TEST_CASE("Bluetooth Device Get SCAN_MODE - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_FAIL(bt_get_device_prop_action,
+					&prop_emu_ble_remote_scan_mode_req),
+	),
+	TEST_CASE("Bluetooth Device Get BONDED_DEVICES - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_FAIL(bt_get_device_prop_action,
+					&prop_emu_ble_remote_bondeddev_req),
+	),
+	TEST_CASE("Bluetooth Device Get DISCOVERY_TIMEOUT - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_FAIL(bt_get_device_prop_action,
+					&prop_emu_ble_remote_disctimeout_req),
+	),
+	TEST_CASE("Bluetooth Device Get VERSION_INFO - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_FAIL(bt_get_device_prop_action,
+					&prop_emu_ble_remote_verinfo_req),
+	),
+	TEST_CASE("Bluetooth Device Get FRIENDLY_NAME - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_FAIL(bt_get_device_prop_action,
+						&prop_emu_ble_remote_fname_req),
+	),
 };
 
 struct queue *get_bluetooth_tests(void)
-- 
1.9.1

