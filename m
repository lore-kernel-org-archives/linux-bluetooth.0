Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/9] android/tester-ng: Use test case independent naming for props
Date: Thu, 17 Jul 2014 10:29:51 +0200
Message-Id: <1405585796-12301-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405585796-12301-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405585796-12301-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch abstracts out data from the specific test cases. Every data
that is sent through the hal (i.e. properties) and then the result is
verified is a test data thus uses 'test_prop_<dataname>' convention.
Data that is retrieved from the deamon and is adapter's default settings
use 'emu_prop_<dataname>' notation.

Data name now represents it's content and is no longer bound to specific
test case thus can be reused. Its also easier to actually see what the
test case do without browsing through its data set.
---
 android/tester-bluetooth.c | 325 ++++++++++++++++++++-------------------------
 1 file changed, 143 insertions(+), 182 deletions(-)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 57d6a10..d65917d 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -19,11 +19,23 @@
 
 static struct queue *list; /* List of bluetooth test cases */
 
-static bt_bdaddr_t enable_bdaddr_val = {
+static bt_bdaddr_t emu_bdaddr_val = {
 	.address = { 0x00, 0xaa, 0x01, 0x00, 0x00, 0x00 },
 };
-static const char enable_bdname_val[] = "BlueZ for Android";
-static const char enable_uuids_val[] = {
+static bt_property_t prop_emu_bdaddr = {
+	.type = BT_PROPERTY_BDADDR,
+	.val = &emu_bdaddr_val,
+	.len = sizeof(emu_bdaddr_val),
+};
+
+static const char emu_bdname_val[] = "BlueZ for Android";
+static bt_property_t prop_emu_bdname = {
+	.type = BT_PROPERTY_BDNAME,
+	.val = &emu_bdname_val,
+	.len = sizeof(emu_bdname_val) - 1,
+};
+
+static const char emu_uuids_val[] = {
 	/* Multi profile UUID */
 	0x00, 0x00, 0x11, 0x3b, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
 					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB,
@@ -31,202 +43,153 @@ static const char enable_uuids_val[] = {
 	0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
 					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB,
 };
-static bt_device_type_t enable_tod_val = BT_DEVICE_DEVTYPE_DUAL;
-static bt_scan_mode_t enable_scanmode_val = BT_SCAN_MODE_NONE;
-static uint32_t enable_disctimeout_val = 120;
-
-static bt_property_t enable_props[] = {
-	{ BT_PROPERTY_BDADDR, sizeof(enable_bdaddr_val), NULL },
-	{ BT_PROPERTY_BDNAME, sizeof(enable_bdname_val) - 1,
-						&enable_bdname_val },
-	{ BT_PROPERTY_CLASS_OF_DEVICE, sizeof(uint32_t), NULL },
-	{ BT_PROPERTY_TYPE_OF_DEVICE, sizeof(enable_tod_val),
-						&enable_tod_val },
-	{ BT_PROPERTY_ADAPTER_SCAN_MODE, sizeof(enable_scanmode_val),
-						&enable_scanmode_val },
-	{ BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
-						sizeof(enable_disctimeout_val),
-						&enable_disctimeout_val },
-	{ BT_PROPERTY_ADAPTER_BONDED_DEVICES, 0, NULL },
-	{ BT_PROPERTY_UUIDS, sizeof(enable_uuids_val), &enable_uuids_val },
+static bt_property_t prop_emu_uuids = {
+	.type = BT_PROPERTY_UUIDS,
+	.val = &emu_uuids_val,
+	.len = sizeof(emu_uuids_val),
 };
 
-static char test_set_bdname[] = "test_bdname_set";
-
-static bt_property_t setprop_bdname_prop = {
-	.type = BT_PROPERTY_BDNAME,
-	.val = test_set_bdname,
-	.len = sizeof(test_set_bdname) - 1,
+static uint32_t emu_cod_val = 0x00020c;
+static bt_property_t prop_emu_cod = {
+	.type = BT_PROPERTY_CLASS_OF_DEVICE,
+	.val = &emu_cod_val,
+	.len = sizeof(emu_cod_val),
 };
 
-static bt_scan_mode_t test_setprop_scanmode_val =
-					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE;
+static bt_device_type_t emu_tod_val = BT_DEVICE_DEVTYPE_DUAL;
+static bt_property_t prop_emu_tod = {
+	.type = BT_PROPERTY_TYPE_OF_DEVICE,
+	.val = &emu_tod_val,
+	.len = sizeof(emu_tod_val),
+};
 
-static bt_property_t setprop_scanmode_prop = {
+static bt_scan_mode_t emu_scan_mode_val = BT_SCAN_MODE_NONE;
+static bt_property_t prop_emu_scan_mode = {
 	.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
-	.val = &test_setprop_scanmode_val,
-	.len = sizeof(bt_scan_mode_t),
+	.val = &emu_scan_mode_val,
+	.len = sizeof(emu_scan_mode_val),
 };
 
-static uint32_t test_setprop_disctimeout_val = 600;
-
-static bt_property_t setprop_disctimeout_prop = {
+static uint32_t emu_disc_timeout_val = 120;
+static bt_property_t prop_emu_disc_timeout = {
 	.type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
-	.val = &test_setprop_disctimeout_val,
-	.len = sizeof(test_setprop_disctimeout_val),
+	.val = &emu_disc_timeout_val,
+	.len = sizeof(emu_disc_timeout_val),
 };
 
-static bt_bdaddr_t test_getprop_bdaddr_val = {
-	{0x00, 0xaa, 0x01, 0x00, 0x00, 0x00},
+static bt_property_t prop_emu_bonded_devs = {
+	.type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
+	.val = NULL,
+	.len = 0,
 };
 
-static bt_property_t getprop_bdaddr_prop = {
-	.type = BT_PROPERTY_BDADDR,
-	.val = &test_getprop_bdaddr_val,
-	.len = sizeof(test_getprop_bdaddr_val),
+static bt_property_t prop_emu_default_set[] = {
+	{ BT_PROPERTY_BDADDR, sizeof(emu_bdaddr_val), NULL },
+	{ BT_PROPERTY_BDNAME, sizeof(emu_bdname_val) - 1, &emu_bdname_val },
+	{ BT_PROPERTY_CLASS_OF_DEVICE, sizeof(uint32_t), NULL },
+	{ BT_PROPERTY_TYPE_OF_DEVICE, sizeof(emu_tod_val), &emu_tod_val },
+	{ BT_PROPERTY_ADAPTER_SCAN_MODE, sizeof(emu_scan_mode_val),
+							&emu_scan_mode_val },
+	{ BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT, sizeof(emu_disc_timeout_val),
+							&emu_disc_timeout_val},
+	{ BT_PROPERTY_ADAPTER_BONDED_DEVICES, 0, NULL },
+	{ BT_PROPERTY_UUIDS, sizeof(emu_uuids_val), &emu_uuids_val },
 };
 
-static const char test_getprop_bdname_val[] = "BlueZ for Android";
-
-static bt_property_t getprop_bdname_prop = {
+static char test_bdname[] = "test_bdname";
+static bt_property_t prop_test_bdname = {
 	.type = BT_PROPERTY_BDNAME,
-	.val = &test_getprop_bdname_val,
-	.len = sizeof(test_getprop_bdname_val) - 1,
+	.val = test_bdname,
+	.len = sizeof(test_bdname) - 1,
+};
+
+static bt_scan_mode_t test_scan_mode_connectable_discoverable =
+					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE;
+static bt_property_t prop_test_scanmode_conn_discov = {
+	.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.val = &test_scan_mode_connectable_discoverable,
+	.len = sizeof(bt_scan_mode_t),
 };
 
-static unsigned char setprop_uuids[] = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00,
+static uint32_t test_disctimeout_val = 600;
+static bt_property_t prop_test_disctimeout = {
+	.type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
+	.val = &test_disctimeout_val,
+	.len = sizeof(test_disctimeout_val),
+};
+
+static unsigned char test_uuids_val[] = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00,
 			0x00, 0x80, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00,
 			0x00, 0x00 };
-
-static bt_property_t setprop_uuid_prop = {
+static bt_property_t prop_test_uuid = {
 	.type = BT_PROPERTY_UUIDS,
-	.val = &setprop_uuids,
-	.len = sizeof(setprop_uuids),
+	.val = &test_uuids_val,
+	.len = sizeof(test_uuids_val),
 };
 
-static uint32_t setprop_cod_val = 0;
-
-static bt_property_t setprop_cod_prop = {
+static uint32_t test_cod_val = 0;
+static bt_property_t prop_test_cod = {
 	.type = BT_PROPERTY_CLASS_OF_DEVICE,
-	.val = &setprop_cod_val,
-	.len = sizeof(setprop_cod_val),
+	.val = &test_cod_val,
+	.len = sizeof(test_cod_val),
 };
 
-static uint32_t setprop_tod_val = BT_DEVICE_DEVTYPE_DUAL;
-
-static bt_property_t setprop_tod_prop = {
+static uint32_t test_tod_val = BT_DEVICE_DEVTYPE_BLE;
+static bt_property_t prop_test_tod = {
 	.type = BT_PROPERTY_TYPE_OF_DEVICE,
-	.val = &setprop_tod_val,
-	.len = sizeof(setprop_tod_val),
+	.val = &test_tod_val,
+	.len = sizeof(test_tod_val),
 };
 
-static int32_t setprop_remote_rssi_val = -9;
-
-static bt_property_t setprop_remote_rssi_prop = {
+static int32_t test_remote_rssi_val = -9;
+static bt_property_t prop_test_remote_rssi = {
 	.type = BT_PROPERTY_REMOTE_RSSI,
-	.val = &setprop_remote_rssi_val,
-	.len = sizeof(setprop_remote_rssi_val),
+	.val = &test_remote_rssi_val,
+	.len = sizeof(test_remote_rssi_val),
 };
 
-static bt_service_record_t setprop_srvc_record_val =  {
+static bt_service_record_t test_srvc_record_val =  {
 	.uuid = { {0x00} },
 	.channel = 12,
 	.name = "bt_name",
 };
-
-static bt_property_t setprop_srvc_record_prop = {
+static bt_property_t prop_test_srvc_record = {
 	.type = BT_PROPERTY_SERVICE_RECORD,
-	.val = &setprop_srvc_record_val,
-	.len = sizeof(setprop_srvc_record_val),
+	.val = &test_srvc_record_val,
+	.len = sizeof(test_srvc_record_val),
 };
 
-static bt_bdaddr_t setprop_bdaddr_val = {
+static bt_bdaddr_t test_bdaddr_val = {
 	.address = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
 };
-
-static bt_property_t setprop_bdaddr_prop = {
+static bt_property_t prop_test_bdaddr = {
 	.type = BT_PROPERTY_BDADDR,
-	.val = &setprop_bdaddr_val,
-	.len = sizeof(setprop_bdaddr_val),
-};
-
-static bt_bdaddr_t setprop_bonded_dev_val = {
-	.address = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 },
-};
-
-static bt_property_t setprop_bonded_dev_prop = {
-	.type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
-	.val = &setprop_bonded_dev_val,
-	.len = sizeof(setprop_bonded_dev_val),
+	.val = &test_bdaddr_val,
+	.len = sizeof(test_bdaddr_val),
 };
 
 static bt_scan_mode_t setprop_scan_mode_conn_val = BT_SCAN_MODE_CONNECTABLE;
 
-static bt_property_t setprop_scan_mode_conn_prop = {
+static bt_property_t prop_test_scan_mode_conn = {
 	.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
 	.val = &setprop_scan_mode_conn_val,
 	.len = sizeof(setprop_scan_mode_conn_val),
 };
 
-static uint32_t test_getprop_cod_val = 0x00020c;
-
-static bt_property_t getprop_cod_prop = {
-	.type = BT_PROPERTY_CLASS_OF_DEVICE,
-	.val = &test_getprop_cod_val,
-	.len = sizeof(test_getprop_cod_val),
-};
-
-static bt_device_type_t test_getprop_tod_val = BT_DEVICE_DEVTYPE_DUAL;
-
-static bt_property_t getprop_tod_prop = {
-	.type = BT_PROPERTY_TYPE_OF_DEVICE,
-	.val = &test_getprop_tod_val,
-	.len = sizeof(test_getprop_tod_val),
-};
-
-static bt_scan_mode_t test_getprop_scan_mode_val = BT_SCAN_MODE_NONE;
-
-static bt_property_t getprop_scan_mode_prop = {
+static bt_scan_mode_t test_scan_mode_none_val = BT_SCAN_MODE_NONE;
+static bt_property_t prop_test_scan_mode_none = {
 	.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
-	.val = &test_getprop_scan_mode_val,
-	.len = sizeof(test_getprop_scan_mode_val),
+	.val = &test_scan_mode_none_val,
+	.len = sizeof(test_scan_mode_none_val),
 };
 
-static uint32_t test_getprop_disc_timeout_val = 120;
-
-static bt_property_t getprop_disc_timeout_prop = {
-	.type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
-	.val = &test_getprop_disc_timeout_val,
-	.len = sizeof(test_getprop_disc_timeout_val),
-};
-
-static const char test_getprop_uuids_val[] = {
-	/* Multi profile UUID */
-	0x00, 0x00, 0x11, 0x3b, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
-					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB,
-	/* Device identification profile UUID */
-	0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
-					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB,
-};
-
-static bt_property_t getprop_uuids_prop = {
-	.type = BT_PROPERTY_UUIDS,
-	.val = &test_getprop_uuids_val,
-	.len = sizeof(test_getprop_uuids_val),
+static bt_bdaddr_t test_bonded_dev_addr_val = {
+	.address = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 },
 };
-
-static bt_property_t getprop_bonded_devs_prop = {
+static bt_property_t prop_test_bonded_dev_addr = {
 	.type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
-	.val = NULL,
-	.len = 0,
-};
-
-static bt_scan_mode_t test_setprop_scanmode_val2 = BT_SCAN_MODE_NONE;
-
-static bt_property_t setprop_scan_mode2_prop = {
-	.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
-	.val = &test_setprop_scanmode_val2,
-	.len = sizeof(test_setprop_scanmode_val2),
+	.val = &test_bonded_dev_addr_val,
+	.len = sizeof(test_bonded_dev_addr_val),
 };
 
 static struct test_case test_cases[] = {
@@ -235,12 +198,12 @@ static struct test_case test_cases[] = {
 	),
 	TEST_CASE("Bluetooth Enable - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
-		CALLBACK_ADAPTER_PROPS(enable_props, 8),
+		CALLBACK_ADAPTER_PROPS(prop_emu_default_set, 8),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	),
 	TEST_CASE("Bluetooth Enable - Success 2",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
-		CALLBACK_ADAPTER_PROPS(enable_props, 8),
+		CALLBACK_ADAPTER_PROPS(prop_emu_default_set, 8),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	),
@@ -253,120 +216,118 @@ static struct test_case test_cases[] = {
 	TEST_CASE("Bluetooth Set BDNAME - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_SUCCESS(bt_set_property_action, &setprop_bdname_prop),
-		CALLBACK_ADAPTER_PROPS(&setprop_bdname_prop, 1),
+		ACTION_SUCCESS(bt_set_property_action, &prop_test_bdname),
+		CALLBACK_ADAPTER_PROPS(&prop_test_bdname, 1),
 	),
 	TEST_CASE("Bluetooth Set SCAN_MODE - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_SUCCESS(bt_set_property_action, &setprop_scanmode_prop),
-		CALLBACK_ADAPTER_PROPS(&setprop_scanmode_prop, 1),
+		ACTION_SUCCESS(bt_set_property_action,
+					&prop_test_scanmode_conn_discov),
+		CALLBACK_ADAPTER_PROPS(&prop_test_scanmode_conn_discov, 1),
 	),
 	TEST_CASE("Bluetooth Set DISCOVERY_TIMEOUT - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_SUCCESS(bt_set_property_action,
-						&setprop_disctimeout_prop),
-		CALLBACK_ADAPTER_PROPS(&setprop_disctimeout_prop, 1),
+		ACTION_SUCCESS(bt_set_property_action, &prop_test_disctimeout),
+		CALLBACK_ADAPTER_PROPS(&prop_test_disctimeout, 1),
 	),
 	TEST_CASE("Bluetooth Get BDADDR - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_SUCCESS(bt_get_property_action, &getprop_bdaddr_prop),
-		CALLBACK_ADAPTER_PROPS(&getprop_bdaddr_prop, 1),
+		ACTION_SUCCESS(bt_get_property_action, &prop_emu_bdaddr),
+		CALLBACK_ADAPTER_PROPS(&prop_emu_bdaddr, 1),
 	),
 	TEST_CASE("Bluetooth Get BDNAME - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_SUCCESS(bt_get_property_action, &getprop_bdname_prop),
-		CALLBACK_ADAPTER_PROPS(&getprop_bdname_prop, 1),
+		ACTION_SUCCESS(bt_get_property_action, &prop_emu_bdname),
+		CALLBACK_ADAPTER_PROPS(&prop_emu_bdname, 1),
 	),
 	TEST_CASE("Bluetooth Set UUID - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_FAIL(bt_set_property_action, &setprop_uuid_prop),
+		ACTION_FAIL(bt_set_property_action, &prop_test_uuid),
 	),
 	TEST_CASE("Bluetooth Set CLASS_OF_DEVICE - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_FAIL(bt_set_property_action, &setprop_cod_prop),
+		ACTION_FAIL(bt_set_property_action, &prop_test_cod),
 	),
 	TEST_CASE("Bluetooth Set TYPE_OF_DEVICE - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_FAIL(bt_set_property_action, &setprop_tod_prop),
+		ACTION_FAIL(bt_set_property_action, &prop_test_tod),
 	),
 	TEST_CASE("Bluetooth Set REMOTE_RSSI - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_FAIL(bt_set_property_action, &setprop_remote_rssi_prop),
+		ACTION_FAIL(bt_set_property_action, &prop_test_remote_rssi),
 	),
 	TEST_CASE("Bluetooth Set SERVICE_RECORD - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_FAIL(bt_set_property_action, &setprop_srvc_record_prop),
+		ACTION_FAIL(bt_set_property_action, &prop_test_srvc_record),
 	),
 	TEST_CASE("Bluetooth Set BDADDR - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_FAIL(bt_set_property_action, &setprop_bdaddr_prop),
+		ACTION_FAIL(bt_set_property_action, &prop_test_bdaddr),
 	),
 	TEST_CASE("Bluetooth Set SCAN_MODE_CONNECTABLE - SUCCESS",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bt_set_property_action,
-						&setprop_scan_mode_conn_prop),
-		CALLBACK_ADAPTER_PROPS(&setprop_scan_mode_conn_prop, 1),
+						&prop_test_scan_mode_conn),
+		CALLBACK_ADAPTER_PROPS(&prop_test_scan_mode_conn, 1),
 	),
 	TEST_CASE("Bluetooth Set BONDED_DEVICES - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_FAIL(bt_set_property_action, &setprop_bonded_dev_prop),
+		ACTION_FAIL(bt_set_property_action, &prop_test_bonded_dev_addr),
 	),
 	TEST_CASE("Bluetooth Get CLASS_OF_DEVICE - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_SUCCESS(bt_get_property_action, &getprop_cod_prop),
-		CALLBACK_ADAPTER_PROPS(&getprop_cod_prop, 1),
+		ACTION_SUCCESS(bt_get_property_action, &prop_emu_cod),
+		CALLBACK_ADAPTER_PROPS(&prop_emu_cod, 1),
 	),
 	TEST_CASE("Bluetooth Get TYPE_OF_DEVICE - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_SUCCESS(bt_get_property_action, &getprop_tod_prop),
-		CALLBACK_ADAPTER_PROPS(&getprop_tod_prop, 1),
+		ACTION_SUCCESS(bt_get_property_action, &prop_emu_tod),
+		CALLBACK_ADAPTER_PROPS(&prop_emu_tod, 1),
 	),
 	TEST_CASE("Bluetooth Get SCAN_MODE - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_SUCCESS(bt_get_property_action, &getprop_scan_mode_prop),
-		CALLBACK_ADAPTER_PROPS(&getprop_scan_mode_prop, 1),
+		ACTION_SUCCESS(bt_get_property_action, &prop_emu_scan_mode),
+		CALLBACK_ADAPTER_PROPS(&prop_emu_scan_mode, 1),
 	),
 	TEST_CASE("Bluetooth Get DISCOVERY_TIMEOUT - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_SUCCESS(bt_get_property_action,
-						&getprop_disc_timeout_prop),
-		CALLBACK_ADAPTER_PROPS(&getprop_disc_timeout_prop, 1),
+		ACTION_SUCCESS(bt_get_property_action, &prop_emu_disc_timeout),
+		CALLBACK_ADAPTER_PROPS(&prop_emu_disc_timeout, 1),
 	),
-	TEST_CASE("Bluetooth Get BONDED_DEVICES - Success",
+	TEST_CASE("Bluetooth Get UUIDS - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_SUCCESS(bt_get_property_action, &getprop_uuids_prop),
-		CALLBACK_ADAPTER_PROPS(&getprop_uuids_prop, 1),
+		ACTION_SUCCESS(bt_get_property_action, &prop_emu_uuids),
+		CALLBACK_ADAPTER_PROPS(&prop_emu_uuids, 1),
 	),
 	TEST_CASE("Bluetooth Get BONDED_DEVICES - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-		ACTION_SUCCESS(bt_get_property_action,
-						&getprop_bonded_devs_prop),
-		CALLBACK_ADAPTER_PROPS(&getprop_bonded_devs_prop, 1),
+		ACTION_SUCCESS(bt_get_property_action, &prop_emu_bonded_devs),
+		CALLBACK_ADAPTER_PROPS(&prop_emu_bonded_devs, 1),
 	),
 	TEST_CASE("Bluetooth Set SCAN_MODE - Success 2",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bt_set_property_action,
-						&setprop_scan_mode2_prop),
-		CALLBACK_ADAPTER_PROPS(&setprop_scan_mode2_prop, 1),
+						&prop_test_scan_mode_none),
+		CALLBACK_ADAPTER_PROPS(&prop_test_scan_mode_none, 1),
 	),
 };
 
-- 
1.9.1

