Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/9] android/tester-ng: Use array of statics instead of case pointers
Date: Thu, 17 Jul 2014 10:29:50 +0200
Message-Id: <1405585796-12301-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405585796-12301-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405585796-12301-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is yet another macro that hides the test implementation details and
shortens the amount of code that needs to be written for each test case.
---
 android/tester-bluetooth.c | 347 ++++++++++++++++++---------------------------
 android/tester-gatt.c      |  13 +-
 android/tester-hidhost.c   |  13 +-
 android/tester-main.h      |   6 +-
 android/tester-socket.c    |  13 +-
 5 files changed, 158 insertions(+), 234 deletions(-)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 86f5e5c..57d6a10 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -19,11 +19,6 @@
 
 static struct queue *list; /* List of bluetooth test cases */
 
-TEST_CASE(bluetooth_init,
-	"Bluetooth Init",
-	ACTION_SUCCESS(dummy_action, NULL),
-);
-
 static bt_bdaddr_t enable_bdaddr_val = {
 	.address = { 0x00, 0xaa, 0x01, 0x00, 0x00, 0x00 },
 };
@@ -56,29 +51,6 @@ static bt_property_t enable_props[] = {
 	{ BT_PROPERTY_UUIDS, sizeof(enable_uuids_val), &enable_uuids_val },
 };
 
-TEST_CASE(bluetooth_enable_success_tc,
-	"Bluetooth Enable - Success",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_ADAPTER_PROPS(enable_props, 8),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-);
-
-TEST_CASE(bluetooth_enable_success2_tc,
-	"Bluetooth Enable - Success 2",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_ADAPTER_PROPS(enable_props, 8),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-);
-
-TEST_CASE(bluetooth_disable_success_tc,
-	"Bluetooth Disable - Success",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_SUCCESS(bluetooth_disable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
-);
-
 static char test_set_bdname[] = "test_bdname_set";
 
 static bt_property_t setprop_bdname_prop = {
@@ -87,14 +59,6 @@ static bt_property_t setprop_bdname_prop = {
 	.len = sizeof(test_set_bdname) - 1,
 };
 
-TEST_CASE(bluetooth_setprop_bdname_success_tc,
-	"Bluetooth Set BDNAME - Success",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_SUCCESS(bt_set_property_action, &setprop_bdname_prop),
-	CALLBACK_ADAPTER_PROPS(&setprop_bdname_prop, 1),
-);
-
 static bt_scan_mode_t test_setprop_scanmode_val =
 					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE;
 
@@ -104,14 +68,6 @@ static bt_property_t setprop_scanmode_prop = {
 	.len = sizeof(bt_scan_mode_t),
 };
 
-TEST_CASE(bluetooth_setprop_scanmode_success_tc,
-	"Bluetooth Set SCAN_MODE - Success",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_SUCCESS(bt_set_property_action, &setprop_scanmode_prop),
-	CALLBACK_ADAPTER_PROPS(&setprop_scanmode_prop, 1),
-);
-
 static uint32_t test_setprop_disctimeout_val = 600;
 
 static bt_property_t setprop_disctimeout_prop = {
@@ -120,14 +76,6 @@ static bt_property_t setprop_disctimeout_prop = {
 	.len = sizeof(test_setprop_disctimeout_val),
 };
 
-TEST_CASE(bluetooth_setprop_disctimeout_success_tc,
-	"Bluetooth Set DISCOVERY_TIMEOUT - Success",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_SUCCESS(bt_set_property_action, &setprop_disctimeout_prop),
-	CALLBACK_ADAPTER_PROPS(&setprop_disctimeout_prop, 1),
-);
-
 static bt_bdaddr_t test_getprop_bdaddr_val = {
 	{0x00, 0xaa, 0x01, 0x00, 0x00, 0x00},
 };
@@ -138,14 +86,6 @@ static bt_property_t getprop_bdaddr_prop = {
 	.len = sizeof(test_getprop_bdaddr_val),
 };
 
-TEST_CASE(bluetooth_getprop_bdaddr_success_tc,
-	"Bluetooth Get BDADDR - Success",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_SUCCESS(bt_get_property_action, &getprop_bdaddr_prop),
-	CALLBACK_ADAPTER_PROPS(&getprop_bdaddr_prop, 1),
-);
-
 static const char test_getprop_bdname_val[] = "BlueZ for Android";
 
 static bt_property_t getprop_bdname_prop = {
@@ -154,14 +94,6 @@ static bt_property_t getprop_bdname_prop = {
 	.len = sizeof(test_getprop_bdname_val) - 1,
 };
 
-TEST_CASE(bluetooth_getprop_bdname_success_tc,
-	"Bluetooth Get BDNAME - Success",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_SUCCESS(bt_get_property_action, &getprop_bdname_prop),
-	CALLBACK_ADAPTER_PROPS(&getprop_bdname_prop, 1),
-);
-
 static unsigned char setprop_uuids[] = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00,
 			0x00, 0x80, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00,
 			0x00, 0x00 };
@@ -172,13 +104,6 @@ static bt_property_t setprop_uuid_prop = {
 	.len = sizeof(setprop_uuids),
 };
 
-TEST_CASE(bluetooth_setprop_uuid_fail_tc,
-	"Bluetooth Set UUID - Fail",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_FAIL(bt_set_property_action, &setprop_uuid_prop),
-);
-
 static uint32_t setprop_cod_val = 0;
 
 static bt_property_t setprop_cod_prop = {
@@ -187,13 +112,6 @@ static bt_property_t setprop_cod_prop = {
 	.len = sizeof(setprop_cod_val),
 };
 
-TEST_CASE(bluetooth_setprop_cod_fail_tc,
-	"Bluetooth Set CLASS_OF_DEVICE - Fail",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_FAIL(bt_set_property_action, &setprop_cod_prop),
-);
-
 static uint32_t setprop_tod_val = BT_DEVICE_DEVTYPE_DUAL;
 
 static bt_property_t setprop_tod_prop = {
@@ -202,13 +120,6 @@ static bt_property_t setprop_tod_prop = {
 	.len = sizeof(setprop_tod_val),
 };
 
-TEST_CASE(bluetooth_setprop_tod_fail_tc,
-	"Bluetooth Set TYPE_OF_DEVICE - Fail",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_FAIL(bt_set_property_action, &setprop_tod_prop),
-);
-
 static int32_t setprop_remote_rssi_val = -9;
 
 static bt_property_t setprop_remote_rssi_prop = {
@@ -217,13 +128,6 @@ static bt_property_t setprop_remote_rssi_prop = {
 	.len = sizeof(setprop_remote_rssi_val),
 };
 
-TEST_CASE(bluetooth_setprop_remote_rssi_fail_tc,
-	"Bluetooth Set REMOTE_RSSI - Fail",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_FAIL(bt_set_property_action, &setprop_remote_rssi_prop),
-);
-
 static bt_service_record_t setprop_srvc_record_val =  {
 	.uuid = { {0x00} },
 	.channel = 12,
@@ -236,13 +140,6 @@ static bt_property_t setprop_srvc_record_prop = {
 	.len = sizeof(setprop_srvc_record_val),
 };
 
-TEST_CASE(bluetooth_setprop_srvc_record_fail_tc,
-	"Bluetooth Set SERVICE_RECORD - Fail",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_FAIL(bt_set_property_action, &setprop_srvc_record_prop),
-);
-
 static bt_bdaddr_t setprop_bdaddr_val = {
 	.address = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
 };
@@ -253,13 +150,6 @@ static bt_property_t setprop_bdaddr_prop = {
 	.len = sizeof(setprop_bdaddr_val),
 };
 
-TEST_CASE(bluetooth_setprop_bdaddr_fail_tc,
-	"Bluetooth Set BDADDR - Fail",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_FAIL(bt_set_property_action, &setprop_bdaddr_prop),
-);
-
 static bt_bdaddr_t setprop_bonded_dev_val = {
 	.address = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 },
 };
@@ -270,13 +160,6 @@ static bt_property_t setprop_bonded_dev_prop = {
 	.len = sizeof(setprop_bonded_dev_val),
 };
 
-TEST_CASE(bluetooth_setprop_bonded_dev_fail_tc,
-	"Bluetooth Set BONDED_DEVICES - Fail",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_FAIL(bt_set_property_action, &setprop_bonded_dev_prop),
-);
-
 static bt_scan_mode_t setprop_scan_mode_conn_val = BT_SCAN_MODE_CONNECTABLE;
 
 static bt_property_t setprop_scan_mode_conn_prop = {
@@ -285,14 +168,6 @@ static bt_property_t setprop_scan_mode_conn_prop = {
 	.len = sizeof(setprop_scan_mode_conn_val),
 };
 
-TEST_CASE(bluetooth_setprop_scan_mode_conn_success_tc,
-	"Bluetooth Set SCAN_MODE_CONNECTABLE - SUCCESS",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_SUCCESS(bt_set_property_action, &setprop_scan_mode_conn_prop),
-	CALLBACK_ADAPTER_PROPS(&setprop_scan_mode_conn_prop, 1),
-);
-
 static uint32_t test_getprop_cod_val = 0x00020c;
 
 static bt_property_t getprop_cod_prop = {
@@ -301,14 +176,6 @@ static bt_property_t getprop_cod_prop = {
 	.len = sizeof(test_getprop_cod_val),
 };
 
-TEST_CASE(bluetooth_getprop_cod_success_tc,
-	"Bluetooth Get CLASS_OF_DEVICE - Success",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_SUCCESS(bt_get_property_action, &getprop_cod_prop),
-	CALLBACK_ADAPTER_PROPS(&getprop_cod_prop, 1),
-);
-
 static bt_device_type_t test_getprop_tod_val = BT_DEVICE_DEVTYPE_DUAL;
 
 static bt_property_t getprop_tod_prop = {
@@ -317,14 +184,6 @@ static bt_property_t getprop_tod_prop = {
 	.len = sizeof(test_getprop_tod_val),
 };
 
-TEST_CASE(bluetooth_getprop_tod_success_tc,
-	"Bluetooth Get TYPE_OF_DEVICE - Success",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_SUCCESS(bt_get_property_action, &getprop_tod_prop),
-	CALLBACK_ADAPTER_PROPS(&getprop_tod_prop, 1),
-);
-
 static bt_scan_mode_t test_getprop_scan_mode_val = BT_SCAN_MODE_NONE;
 
 static bt_property_t getprop_scan_mode_prop = {
@@ -333,14 +192,6 @@ static bt_property_t getprop_scan_mode_prop = {
 	.len = sizeof(test_getprop_scan_mode_val),
 };
 
-TEST_CASE(bluetooth_getprop_scan_mode_success_tc,
-	"Bluetooth Get SCAN_MODE - Success",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_SUCCESS(bt_get_property_action, &getprop_scan_mode_prop),
-	CALLBACK_ADAPTER_PROPS(&getprop_scan_mode_prop, 1),
-);
-
 static uint32_t test_getprop_disc_timeout_val = 120;
 
 static bt_property_t getprop_disc_timeout_prop = {
@@ -349,14 +200,6 @@ static bt_property_t getprop_disc_timeout_prop = {
 	.len = sizeof(test_getprop_disc_timeout_val),
 };
 
-TEST_CASE(bluetooth_getprop_disc_timeout_success_tc,
-	"Bluetooth Get DISCOVERY_TIMEOUT - Success",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_SUCCESS(bt_get_property_action, &getprop_disc_timeout_prop),
-	CALLBACK_ADAPTER_PROPS(&getprop_disc_timeout_prop, 1),
-);
-
 static const char test_getprop_uuids_val[] = {
 	/* Multi profile UUID */
 	0x00, 0x00, 0x11, 0x3b, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
@@ -372,28 +215,12 @@ static bt_property_t getprop_uuids_prop = {
 	.len = sizeof(test_getprop_uuids_val),
 };
 
-TEST_CASE(bluetooth_getprop_uuids_success_tc,
-	"Bluetooth Get BONDED_DEVICES - Success",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_SUCCESS(bt_get_property_action, &getprop_uuids_prop),
-	CALLBACK_ADAPTER_PROPS(&getprop_uuids_prop, 1),
-);
-
 static bt_property_t getprop_bonded_devs_prop = {
 	.type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
 	.val = NULL,
 	.len = 0,
 };
 
-TEST_CASE(bluetooth_getprop_bonded_devs_success_tc,
-	"Bluetooth Get BONDED_DEVICES - Success",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_SUCCESS(bt_get_property_action, &getprop_bonded_devs_prop),
-	CALLBACK_ADAPTER_PROPS(&getprop_bonded_devs_prop, 1),
-);
-
 static bt_scan_mode_t test_setprop_scanmode_val2 = BT_SCAN_MODE_NONE;
 
 static bt_property_t setprop_scan_mode2_prop = {
@@ -402,39 +229,145 @@ static bt_property_t setprop_scan_mode2_prop = {
 	.len = sizeof(test_setprop_scanmode_val2),
 };
 
-TEST_CASE(bluetooth_setprop_scan_mode2_success_tc,
-	"Bluetooth Set SCAN_MODE - Success 2",
-	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-	ACTION_SUCCESS(bt_set_property_action, &setprop_scan_mode2_prop),
-	CALLBACK_ADAPTER_PROPS(&setprop_scan_mode2_prop, 1),
-);
-
-static struct test_case *test_cases[] = {
-	&bluetooth_init,
-	&bluetooth_enable_success_tc,
-	&bluetooth_enable_success2_tc,
-	&bluetooth_disable_success_tc,
-	&bluetooth_setprop_bdname_success_tc,
-	&bluetooth_setprop_scanmode_success_tc,
-	&bluetooth_setprop_disctimeout_success_tc,
-	&bluetooth_getprop_bdaddr_success_tc,
-	&bluetooth_getprop_bdname_success_tc,
-	&bluetooth_setprop_uuid_fail_tc,
-	&bluetooth_setprop_cod_fail_tc,
-	&bluetooth_setprop_tod_fail_tc,
-	&bluetooth_setprop_remote_rssi_fail_tc,
-	&bluetooth_setprop_srvc_record_fail_tc,
-	&bluetooth_setprop_bdaddr_fail_tc,
-	&bluetooth_setprop_bonded_dev_fail_tc,
-	&bluetooth_setprop_scan_mode_conn_success_tc,
-	&bluetooth_getprop_cod_success_tc,
-	&bluetooth_getprop_tod_success_tc,
-	&bluetooth_getprop_scan_mode_success_tc,
-	&bluetooth_getprop_disc_timeout_success_tc,
-	&bluetooth_getprop_uuids_success_tc,
-	&bluetooth_getprop_bonded_devs_success_tc,
-	&bluetooth_setprop_scan_mode2_success_tc,
+static struct test_case test_cases[] = {
+	TEST_CASE("Bluetooth Init",
+		ACTION_SUCCESS(dummy_action, NULL),
+	),
+	TEST_CASE("Bluetooth Enable - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_ADAPTER_PROPS(enable_props, 8),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	),
+	TEST_CASE("Bluetooth Enable - Success 2",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_ADAPTER_PROPS(enable_props, 8),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	),
+	TEST_CASE("Bluetooth Disable - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
+	TEST_CASE("Bluetooth Set BDNAME - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_set_property_action, &setprop_bdname_prop),
+		CALLBACK_ADAPTER_PROPS(&setprop_bdname_prop, 1),
+	),
+	TEST_CASE("Bluetooth Set SCAN_MODE - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_set_property_action, &setprop_scanmode_prop),
+		CALLBACK_ADAPTER_PROPS(&setprop_scanmode_prop, 1),
+	),
+	TEST_CASE("Bluetooth Set DISCOVERY_TIMEOUT - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_set_property_action,
+						&setprop_disctimeout_prop),
+		CALLBACK_ADAPTER_PROPS(&setprop_disctimeout_prop, 1),
+	),
+	TEST_CASE("Bluetooth Get BDADDR - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_get_property_action, &getprop_bdaddr_prop),
+		CALLBACK_ADAPTER_PROPS(&getprop_bdaddr_prop, 1),
+	),
+	TEST_CASE("Bluetooth Get BDNAME - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_get_property_action, &getprop_bdname_prop),
+		CALLBACK_ADAPTER_PROPS(&getprop_bdname_prop, 1),
+	),
+	TEST_CASE("Bluetooth Set UUID - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_FAIL(bt_set_property_action, &setprop_uuid_prop),
+	),
+	TEST_CASE("Bluetooth Set CLASS_OF_DEVICE - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_FAIL(bt_set_property_action, &setprop_cod_prop),
+	),
+	TEST_CASE("Bluetooth Set TYPE_OF_DEVICE - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_FAIL(bt_set_property_action, &setprop_tod_prop),
+	),
+	TEST_CASE("Bluetooth Set REMOTE_RSSI - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_FAIL(bt_set_property_action, &setprop_remote_rssi_prop),
+	),
+	TEST_CASE("Bluetooth Set SERVICE_RECORD - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_FAIL(bt_set_property_action, &setprop_srvc_record_prop),
+	),
+	TEST_CASE("Bluetooth Set BDADDR - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_FAIL(bt_set_property_action, &setprop_bdaddr_prop),
+	),
+	TEST_CASE("Bluetooth Set SCAN_MODE_CONNECTABLE - SUCCESS",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_set_property_action,
+						&setprop_scan_mode_conn_prop),
+		CALLBACK_ADAPTER_PROPS(&setprop_scan_mode_conn_prop, 1),
+	),
+	TEST_CASE("Bluetooth Set BONDED_DEVICES - Fail",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_FAIL(bt_set_property_action, &setprop_bonded_dev_prop),
+	),
+	TEST_CASE("Bluetooth Get CLASS_OF_DEVICE - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_get_property_action, &getprop_cod_prop),
+		CALLBACK_ADAPTER_PROPS(&getprop_cod_prop, 1),
+	),
+	TEST_CASE("Bluetooth Get TYPE_OF_DEVICE - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_get_property_action, &getprop_tod_prop),
+		CALLBACK_ADAPTER_PROPS(&getprop_tod_prop, 1),
+	),
+	TEST_CASE("Bluetooth Get SCAN_MODE - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_get_property_action, &getprop_scan_mode_prop),
+		CALLBACK_ADAPTER_PROPS(&getprop_scan_mode_prop, 1),
+	),
+	TEST_CASE("Bluetooth Get DISCOVERY_TIMEOUT - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_get_property_action,
+						&getprop_disc_timeout_prop),
+		CALLBACK_ADAPTER_PROPS(&getprop_disc_timeout_prop, 1),
+	),
+	TEST_CASE("Bluetooth Get BONDED_DEVICES - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_get_property_action, &getprop_uuids_prop),
+		CALLBACK_ADAPTER_PROPS(&getprop_uuids_prop, 1),
+	),
+	TEST_CASE("Bluetooth Get BONDED_DEVICES - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_get_property_action,
+						&getprop_bonded_devs_prop),
+		CALLBACK_ADAPTER_PROPS(&getprop_bonded_devs_prop, 1),
+	),
+	TEST_CASE("Bluetooth Set SCAN_MODE - Success 2",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_set_property_action,
+						&setprop_scan_mode2_prop),
+		CALLBACK_ADAPTER_PROPS(&setprop_scan_mode2_prop, 1),
+	),
 };
 
 struct queue *get_bluetooth_tests(void)
@@ -444,7 +377,7 @@ struct queue *get_bluetooth_tests(void)
 	list = queue_new();
 
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, test_cases[i]))
+		if (!queue_push_tail(list, &test_cases[i]))
 			return NULL;
 
 	return list;
diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 87a11a1..a55fbe0 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -19,13 +19,10 @@
 
 static struct queue *list; /* List of gatt test cases */
 
-TEST_CASE(gatt_init,
-	"Gatt Init",
-	ACTION_SUCCESS(dummy_action, NULL),
-);
-
-static struct test_case *test_cases[] = {
-	&gatt_init,
+static struct test_case test_cases[] = {
+	TEST_CASE("Gatt Init",
+		ACTION_SUCCESS(dummy_action, NULL),
+	),
 };
 
 struct queue *get_gatt_tests(void)
@@ -35,7 +32,7 @@ struct queue *get_gatt_tests(void)
 	list = queue_new();
 
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, test_cases[i]))
+		if (!queue_push_tail(list, &test_cases[i]))
 			return NULL;
 
 	return list;
diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index 6260825..b00a4e9 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -19,13 +19,10 @@
 
 static struct queue *list; /* List of hidhost test cases */
 
-TEST_CASE(hidhost_init,
-	"Hidhost Init",
-	ACTION_SUCCESS(dummy_action, NULL),
-);
-
-static struct test_case *test_cases[] = {
-	&hidhost_init,
+static struct test_case test_cases[] = {
+	TEST_CASE("Hidhost Init",
+		ACTION_SUCCESS(dummy_action, NULL),
+	),
 };
 
 struct queue *get_hidhost_tests(void)
@@ -35,7 +32,7 @@ struct queue *get_hidhost_tests(void)
 	list = queue_new();
 
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, test_cases[i]))
+		if (!queue_push_tail(list, &test_cases[i]))
 			return NULL;
 
 	return list;
diff --git a/android/tester-main.h b/android/tester-main.h
index f838831..066615a 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -50,10 +50,10 @@
 #include <hardware/bt_gatt_client.h>
 #include <hardware/bt_gatt_server.h>
 
-#define TEST_CASE(decl_name, text, ...) static struct test_case decl_name = { \
+#define TEST_CASE(text, ...) { \
 		text, \
 		sizeof((struct step[]) {__VA_ARGS__}) / sizeof(struct step), \
-		{__VA_ARGS__}, \
+		(struct step[]) {__VA_ARGS__}, \
 	}
 
 #define ACTION_SUCCESS(act_fun, data_set) { \
@@ -198,7 +198,7 @@ struct step {
 struct test_case {
 	char *title;
 	uint16_t step_num;
-	struct step step[];
+	const struct step const *step;
 };
 
 /* Get, remove test cases API */
diff --git a/android/tester-socket.c b/android/tester-socket.c
index ba283fa..254b539 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -19,13 +19,10 @@
 
 static struct queue *list; /* List of socket test cases */
 
-TEST_CASE(socket_init,
-	"Socket Init",
-	ACTION_SUCCESS(dummy_action, NULL),
-);
-
-static struct test_case *test_cases[] = {
-	&socket_init,
+static struct test_case test_cases[] = {
+	TEST_CASE("Socket Init",
+		ACTION_SUCCESS(dummy_action, NULL),
+	),
 };
 
 struct queue *get_socket_tests(void)
@@ -35,7 +32,7 @@ struct queue *get_socket_tests(void)
 	list = queue_new();
 
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, test_cases[i]))
+		if (!queue_push_tail(list, &test_cases[i]))
 			return NULL;
 
 	return list;
-- 
1.9.1

