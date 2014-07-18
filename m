Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 04/11] android/tester-ng: Improve variable's names
Date: Fri, 18 Jul 2014 13:51:13 +0200
Message-Id: <1405684280-1017-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405684280-1017-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405684280-1017-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some variables are specific to emulator device type and remote device type.
This patch makes names more descriptive.
---
 android/tester-bluetooth.c | 177 +++++++++++++++++++++++----------------------
 1 file changed, 89 insertions(+), 88 deletions(-)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 24d6dcb..020bbe2 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -56,11 +56,11 @@ static bt_property_t prop_emu_cod = {
 	.len = sizeof(emu_cod_val),
 };
 
-static bt_device_type_t emu_tod_val = BT_DEVICE_DEVTYPE_DUAL;
-static bt_property_t prop_emu_tod = {
+static bt_device_type_t emu_tod_dual_val = BT_DEVICE_DEVTYPE_DUAL;
+static bt_property_t prop_emu_dual_tod = {
 	.type = BT_PROPERTY_TYPE_OF_DEVICE,
-	.val = &emu_tod_val,
-	.len = sizeof(emu_tod_val),
+	.val = &emu_tod_dual_val,
+	.len = sizeof(emu_tod_dual_val),
 };
 
 static bt_scan_mode_t emu_scan_mode_val = BT_SCAN_MODE_NONE;
@@ -86,112 +86,113 @@ static bt_property_t prop_emu_bonded_devs = {
 static bt_bdaddr_t emu_remote_bdaddr_val = {
 	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
 };
-static struct bt_action_data prop_emu_ble_remote_bdaddr_req = {
+static struct bt_action_data prop_emu_remote_ble_bdaddr_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_BDADDR,
 };
 
-static uint32_t emu_remote_type_val = BT_DEVICE_DEVTYPE_BLE;
-static bt_property_t prop_emu_ble_remote_tod_prop = {
+static uint32_t emu_remote_tod_ble_val = BT_DEVICE_DEVTYPE_BLE;
+static bt_property_t prop_emu_remote_ble_tod_prop = {
 	.type = BT_PROPERTY_TYPE_OF_DEVICE,
-	.val = &emu_remote_type_val,
-	.len = sizeof(emu_remote_type_val),
+	.val = &emu_remote_tod_ble_val,
+	.len = sizeof(emu_remote_tod_ble_val),
 };
-static struct bt_action_data prop_emu_ble_remote_tod_req = {
+static struct bt_action_data prop_emu_remote_ble_tod_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_TYPE_OF_DEVICE,
 };
 
-static int32_t emu_remote_rssi_val = 127;
-static bt_property_t prop_emu_ble_remote_rssi_prop = {
+static int32_t emu_remote_ble_rssi_val = 127;
+static bt_property_t prop_emu_remote_ble_rssi_prop = {
 	.type = BT_PROPERTY_REMOTE_RSSI,
-	.val = &emu_remote_rssi_val,
-	.len = sizeof(emu_remote_rssi_val),
+	.val = &emu_remote_ble_rssi_val,
+	.len = sizeof(emu_remote_ble_rssi_val),
 };
-static struct bt_action_data prop_emu_ble_remote_rssi_req = {
+static struct bt_action_data prop_emu_remote_ble_rssi_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_REMOTE_RSSI,
 };
 
 static const char emu_remote_bdname_val[] = "00:AA:01:01:00:00";
-static bt_property_t prop_emu_ble_remote_bdname_prop = {
+static bt_property_t prop_emu_remote_ble_bdname_prop = {
 	.type = BT_PROPERTY_BDNAME,
 	.val = &emu_remote_bdname_val,
 	.len = sizeof(emu_remote_bdname_val) - 1,
 };
-static struct bt_action_data prop_emu_ble_remote_bdname_req = {
+static struct bt_action_data prop_emu_remote_ble_bdname_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_BDNAME,
 };
 
 static uint32_t emu_remote_cod_val = 0;
-static bt_property_t prop_emu_ble_remote_cod_prop = {
+static bt_property_t prop_emu_remote_ble_cod_prop = {
 	.type = BT_PROPERTY_CLASS_OF_DEVICE,
 	.val = &emu_remote_cod_val,
 	.len = sizeof(emu_remote_cod_val),
 };
-static struct bt_action_data prop_emu_ble_remote_cod_req = {
+static struct bt_action_data prop_emu_remote_ble_cod_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_CLASS_OF_DEVICE,
 };
 
-static bt_property_t prop_emu_ble_remote_uuids_prop = {
+static bt_property_t prop_emu_remote_ble_uuids_prop = {
 	.type = BT_PROPERTY_UUIDS,
 	.val = NULL,
 	.len = 0,
 };
-static struct bt_action_data prop_emu_ble_remote_uuids_req = {
+static struct bt_action_data prop_emu_remote_ble_uuids_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_UUIDS,
 };
 
-static bt_property_t prop_emu_ble_remote_timestamp_prop = {
+static bt_property_t prop_emu_remote_ble_timestamp_prop = {
 	.type = BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP,
 	.val = NULL,
 	.len = 4,
 };
-static struct bt_action_data prop_emu_ble_remote_timestamp_req = {
+static struct bt_action_data prop_emu_remote_ble_timestamp_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP,
 };
 
-static struct bt_action_data prop_emu_ble_remote_scan_mode_req = {
+static struct bt_action_data prop_emu_remote_ble_scan_mode_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_ADAPTER_SCAN_MODE,
 };
 
-static struct bt_action_data prop_emu_ble_remote_bondeddev_req = {
+static struct bt_action_data prop_emu_remote_ble_bondeddev_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
 };
 
-static struct bt_action_data prop_emu_ble_remote_disctimeout_req = {
+static struct bt_action_data prop_emu_remote_ble_disctimeout_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
 };
 
-static struct bt_action_data prop_emu_ble_remote_verinfo_req = {
+static struct bt_action_data prop_emu_remote_ble_verinfo_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_REMOTE_VERSION_INFO,
 };
 
 static const char prop_test_fname_val[] = "FriendlyTestName";
-static bt_property_t prop_emu_ble_remote_fname_prop = {
+static bt_property_t prop_emu_remote_ble_fname_prop = {
 	.type = BT_PROPERTY_REMOTE_FRIENDLY_NAME,
 	.val = &prop_test_fname_val,
 	.len = sizeof(prop_test_fname_val) - 1,
 };
-static struct bt_action_data prop_emu_ble_remote_fname_req = {
+static struct bt_action_data prop_emu_remote_ble_fname_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_REMOTE_FRIENDLY_NAME,
-	.prop = &prop_emu_ble_remote_fname_prop,
+	.prop = &prop_emu_remote_ble_fname_prop,
 };
 
 static bt_property_t prop_emu_default_set[] = {
 	{ BT_PROPERTY_BDADDR, sizeof(emu_bdaddr_val), NULL },
 	{ BT_PROPERTY_BDNAME, sizeof(emu_bdname_val) - 1, &emu_bdname_val },
 	{ BT_PROPERTY_CLASS_OF_DEVICE, sizeof(uint32_t), NULL },
-	{ BT_PROPERTY_TYPE_OF_DEVICE, sizeof(emu_tod_val), &emu_tod_val },
+	{ BT_PROPERTY_TYPE_OF_DEVICE, sizeof(emu_tod_dual_val),
+							&emu_tod_dual_val },
 	{ BT_PROPERTY_ADAPTER_SCAN_MODE, sizeof(emu_scan_mode_val),
 							&emu_scan_mode_val },
 	{ BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT, sizeof(emu_disc_timeout_val),
@@ -200,22 +201,22 @@ static bt_property_t prop_emu_default_set[] = {
 	{ BT_PROPERTY_UUIDS, sizeof(emu_uuids_val), &emu_uuids_val },
 };
 
-static bt_property_t prop_emu_ble_remotes_default_set[] = {
+static bt_property_t prop_emu_remote_bles_default_set[] = {
 	{ BT_PROPERTY_BDADDR, sizeof(emu_remote_bdaddr_val),
 						&emu_remote_bdaddr_val },
-	{ BT_PROPERTY_TYPE_OF_DEVICE, sizeof(emu_remote_type_val),
-							&emu_remote_type_val },
-	{ BT_PROPERTY_REMOTE_RSSI, sizeof(emu_remote_rssi_val),
-							&emu_remote_rssi_val },
+	{ BT_PROPERTY_TYPE_OF_DEVICE, sizeof(emu_remote_tod_ble_val),
+						&emu_remote_tod_ble_val },
+	{ BT_PROPERTY_REMOTE_RSSI, sizeof(emu_remote_ble_rssi_val),
+						&emu_remote_ble_rssi_val },
 };
 
-static bt_property_t prop_emu_ble_remotes_query_set[] = {
-	{ BT_PROPERTY_TYPE_OF_DEVICE, sizeof(emu_remote_type_val),
-							&emu_remote_type_val },
+static bt_property_t prop_emu_remote_bles_query_set[] = {
+	{ BT_PROPERTY_TYPE_OF_DEVICE, sizeof(emu_remote_tod_ble_val),
+						&emu_remote_tod_ble_val },
 	{ BT_PROPERTY_CLASS_OF_DEVICE, sizeof(emu_remote_cod_val),
 							&emu_remote_cod_val },
-	{ BT_PROPERTY_REMOTE_RSSI, sizeof(emu_remote_rssi_val),
-							&emu_remote_rssi_val },
+	{ BT_PROPERTY_REMOTE_RSSI, sizeof(emu_remote_ble_rssi_val),
+						&emu_remote_ble_rssi_val },
 	{ BT_PROPERTY_BDNAME, sizeof(emu_remote_bdname_val) - 1,
 						&emu_remote_bdname_val },
 	{ BT_PROPERTY_UUIDS, 0, NULL },
@@ -228,7 +229,7 @@ static bt_property_t prop_test_bdname = {
 	.val = test_bdname,
 	.len = sizeof(test_bdname) - 1,
 };
-static struct bt_action_data prop_test_ble_remote_bdname_req = {
+static struct bt_action_data prop_test_remote_ble_bdname_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_BDNAME,
 	.prop = &prop_test_bdname,
@@ -248,7 +249,7 @@ static bt_property_t prop_test_disctimeout = {
 	.val = &test_disctimeout_val,
 	.len = sizeof(test_disctimeout_val),
 };
-static struct bt_action_data prop_test_ble_remote_disc_timeout_req = {
+static struct bt_action_data prop_test_remote_ble_disc_timeout_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
 	.prop = &prop_test_disctimeout,
@@ -262,7 +263,7 @@ static bt_property_t prop_test_uuid = {
 	.val = &test_uuids_val,
 	.len = sizeof(test_uuids_val),
 };
-static struct bt_action_data prop_test_ble_remote_uuids_req = {
+static struct bt_action_data prop_test_remote_ble_uuids_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_UUIDS,
 	.prop = &prop_test_uuid,
@@ -274,7 +275,7 @@ static bt_property_t prop_test_cod = {
 	.val = &test_cod_val,
 	.len = sizeof(test_cod_val),
 };
-static struct bt_action_data prop_test_ble_remote_cod_req = {
+static struct bt_action_data prop_test_remote_ble_cod_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_CLASS_OF_DEVICE,
 	.prop = &prop_test_cod,
@@ -286,7 +287,7 @@ static bt_property_t prop_test_tod = {
 	.val = &test_tod_val,
 	.len = sizeof(test_tod_val),
 };
-static struct bt_action_data prop_test_ble_remote_tod_req = {
+static struct bt_action_data prop_test_remote_ble_tod_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_TYPE_OF_DEVICE,
 	.prop = &prop_test_tod,
@@ -298,7 +299,7 @@ static bt_property_t prop_test_remote_rssi = {
 	.val = &test_remote_rssi_val,
 	.len = sizeof(test_remote_rssi_val),
 };
-static struct bt_action_data prop_test_ble_remote_rssi_req = {
+static struct bt_action_data prop_test_remote_ble_rssi_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_REMOTE_RSSI,
 	.prop = &prop_test_remote_rssi,
@@ -314,7 +315,7 @@ static bt_property_t prop_test_srvc_record = {
 	.val = &test_srvc_record_val,
 	.len = sizeof(test_srvc_record_val),
 };
-static struct bt_action_data prop_test_ble_remote_srvc_record_req = {
+static struct bt_action_data prop_test_remote_ble_srvc_record_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_SERVICE_RECORD,
 	.prop = &prop_test_srvc_record,
@@ -328,7 +329,7 @@ static bt_property_t prop_test_bdaddr = {
 	.val = &test_bdaddr_val,
 	.len = sizeof(test_bdaddr_val),
 };
-static struct bt_action_data prop_test_ble_remote_bdaddr_req = {
+static struct bt_action_data prop_test_remote_ble_bdaddr_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_BDADDR,
 	.prop = &prop_test_bdaddr,
@@ -348,7 +349,7 @@ static bt_property_t prop_test_scan_mode_none = {
 	.val = &test_scan_mode_none_val,
 	.len = sizeof(test_scan_mode_none_val),
 };
-static struct bt_action_data prop_test_ble_remote_scanmode_req = {
+static struct bt_action_data prop_test_remote_ble_scanmode_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_ADAPTER_SCAN_MODE,
 	.prop = &prop_test_scan_mode_none,
@@ -369,15 +370,15 @@ static struct bt_action_data prop_test_ble_bonded_dev_req = {
 };
 
 static long test_remote_timestamp_val = 0x7f3d79965adf;
-static bt_property_t prop_test_ble_remote_timestamp_prop = {
+static bt_property_t prop_test_remote_ble_timestamp_prop = {
 	.type = BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP,
 	.val = &test_remote_timestamp_val,
 	.len = sizeof(test_remote_timestamp_val),
 };
-static struct bt_action_data prop_test_ble_remote_timestamp_req = {
+static struct bt_action_data prop_test_remote_ble_timestamp_req = {
 	.addr = &emu_remote_bdaddr_val,
 	.prop_type = BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP,
-	.prop = &prop_test_ble_remote_timestamp_prop,
+	.prop = &prop_test_remote_ble_timestamp_prop,
 };
 
 static struct test_case test_cases[] = {
@@ -483,8 +484,8 @@ static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("Bt. Get TYPE_OF_DEVICE - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_SUCCESS(bt_get_property_action, &prop_emu_tod),
-		CALLBACK_ADAPTER_PROPS(&prop_emu_tod, 1),
+		ACTION_SUCCESS(bt_get_property_action, &prop_emu_dual_tod),
+		CALLBACK_ADAPTER_PROPS(&prop_emu_dual_tod, 1),
 	),
 	TEST_CASE_BREDRLE("Bt. Get SCAN_MODE - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -560,7 +561,7 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bt_start_discovery_action, NULL),
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STARTED),
-		CALLBACK_DEVICE_FOUND(prop_emu_ble_remotes_default_set, 3),
+		CALLBACK_DEVICE_FOUND(prop_emu_remote_bles_default_set, 3),
 		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
@@ -577,7 +578,7 @@ static struct test_case test_cases[] = {
 							BT_DISCOVERY_STOPPED),
 		ACTION_SUCCESS(bt_get_device_props_action,
 							&emu_remote_bdaddr_val),
-		CALLBACK_DEVICE_PROPS(prop_emu_ble_remotes_query_set, 6),
+		CALLBACK_DEVICE_PROPS(prop_emu_remote_bles_query_set, 6),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Get BDNAME - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -590,8 +591,8 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_SUCCESS(bt_get_device_prop_action,
-					&prop_emu_ble_remote_bdname_req),
-		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_bdname_prop, 1),
+					&prop_emu_remote_ble_bdname_req),
+		CALLBACK_DEVICE_PROPS(&prop_emu_remote_ble_bdname_prop, 1),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Get UUIDS - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -604,8 +605,8 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_SUCCESS(bt_get_device_prop_action,
-						&prop_emu_ble_remote_uuids_req),
-		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_uuids_prop, 1),
+						&prop_emu_remote_ble_uuids_req),
+		CALLBACK_DEVICE_PROPS(&prop_emu_remote_ble_uuids_prop, 1),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Get COD - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -618,8 +619,8 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_SUCCESS(bt_get_device_prop_action,
-						&prop_emu_ble_remote_cod_req),
-		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_cod_prop, 1),
+						&prop_emu_remote_ble_cod_req),
+		CALLBACK_DEVICE_PROPS(&prop_emu_remote_ble_cod_prop, 1),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Get TOD - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -632,8 +633,8 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_SUCCESS(bt_get_device_prop_action,
-						&prop_emu_ble_remote_tod_req),
-		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_tod_prop, 1),
+						&prop_emu_remote_ble_tod_req),
+		CALLBACK_DEVICE_PROPS(&prop_emu_remote_ble_tod_prop, 1),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Get RSSI - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -646,8 +647,8 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_SUCCESS(bt_get_device_prop_action,
-						&prop_emu_ble_remote_rssi_req),
-		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_rssi_prop, 1),
+						&prop_emu_remote_ble_rssi_req),
+		CALLBACK_DEVICE_PROPS(&prop_emu_remote_ble_rssi_prop, 1),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Get TIMESTAMP - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -660,8 +661,8 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_SUCCESS(bt_get_device_prop_action,
-					&prop_emu_ble_remote_timestamp_req),
-		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_timestamp_prop, 1),
+					&prop_emu_remote_ble_timestamp_req),
+		CALLBACK_DEVICE_PROPS(&prop_emu_remote_ble_timestamp_prop, 1),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Get BDADDR - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -674,7 +675,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_FAIL(bt_get_device_prop_action,
-					&prop_emu_ble_remote_bdaddr_req),
+					&prop_emu_remote_ble_bdaddr_req),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Get SCAN_MODE - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -687,7 +688,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_FAIL(bt_get_device_prop_action,
-					&prop_emu_ble_remote_scan_mode_req),
+					&prop_emu_remote_ble_scan_mode_req),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Get BONDED_DEVICES - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -700,7 +701,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_FAIL(bt_get_device_prop_action,
-					&prop_emu_ble_remote_bondeddev_req),
+					&prop_emu_remote_ble_bondeddev_req),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Get DISCOVERY_TIMEOUT - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -713,7 +714,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_FAIL(bt_get_device_prop_action,
-					&prop_emu_ble_remote_disctimeout_req),
+					&prop_emu_remote_ble_disctimeout_req),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Get VERSION_INFO - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -726,7 +727,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_FAIL(bt_get_device_prop_action,
-					&prop_emu_ble_remote_verinfo_req),
+					&prop_emu_remote_ble_verinfo_req),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Get FRIENDLY_NAME - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -739,7 +740,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_FAIL(bt_get_device_prop_action,
-						&prop_emu_ble_remote_fname_req),
+						&prop_emu_remote_ble_fname_req),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Set FRIENDLY_NAME - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -752,10 +753,10 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_SUCCESS(bt_set_device_prop_action,
-						&prop_emu_ble_remote_fname_req),
+						&prop_emu_remote_ble_fname_req),
 		ACTION_SUCCESS(bt_get_device_prop_action,
-						&prop_emu_ble_remote_fname_req),
-		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_fname_prop, 1),
+						&prop_emu_remote_ble_fname_req),
+		CALLBACK_DEVICE_PROPS(&prop_emu_remote_ble_fname_prop, 1),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Set BDNAME - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -768,7 +769,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_FAIL(bt_set_device_prop_action,
-					&prop_test_ble_remote_bdname_req),
+					&prop_test_remote_ble_bdname_req),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Set UUIDS - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -781,7 +782,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_FAIL(bt_set_device_prop_action,
-					&prop_test_ble_remote_uuids_req),
+					&prop_test_remote_ble_uuids_req),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Set COD - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -794,7 +795,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_FAIL(bt_set_device_prop_action,
-						&prop_test_ble_remote_cod_req),
+						&prop_test_remote_ble_cod_req),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Set TOD - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -807,7 +808,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_FAIL(bt_set_device_prop_action,
-						&prop_test_ble_remote_tod_req),
+						&prop_test_remote_ble_tod_req),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Set RSSI - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -820,7 +821,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_FAIL(bt_set_device_prop_action,
-						&prop_test_ble_remote_rssi_req),
+						&prop_test_remote_ble_rssi_req),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Set TIMESTAMP - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -833,7 +834,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_FAIL(bt_set_device_prop_action,
-					&prop_test_ble_remote_timestamp_req),
+					&prop_test_remote_ble_timestamp_req),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Set BDADDR - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -846,7 +847,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_FAIL(bt_set_device_prop_action,
-					&prop_test_ble_remote_bdaddr_req),
+					&prop_test_remote_ble_bdaddr_req),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Set SERVICE_RECORD - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -859,7 +860,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_FAIL(bt_set_device_prop_action,
-					&prop_test_ble_remote_srvc_record_req),
+					&prop_test_remote_ble_srvc_record_req),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Set SCAN_MODE - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -872,7 +873,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_FAIL(bt_set_device_prop_action,
-					&prop_test_ble_remote_scanmode_req),
+					&prop_test_remote_ble_scanmode_req),
 	),
 	TEST_CASE_BREDRLE("Bt. Device Set BONDED_DEVICES - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -898,7 +899,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 		ACTION_FAIL(bt_set_device_prop_action,
-					&prop_test_ble_remote_disc_timeout_req),
+					&prop_test_remote_ble_disc_timeout_req),
 	),
 };
 
-- 
1.9.1

