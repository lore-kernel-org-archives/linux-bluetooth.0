Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/9] android/tester-ng: Add test declaration helper macro
Date: Thu, 17 Jul 2014 10:29:49 +0200
Message-Id: <1405585796-12301-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405585796-12301-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405585796-12301-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This replaces test cases declaration with simplier macro call.
---
 android/tester-bluetooth.c | 256 +++++++++++++--------------------------------
 android/tester-gatt.c      |  10 +-
 android/tester-hidhost.c   |  10 +-
 android/tester-main.c      |   2 +-
 android/tester-main.h      |  18 ++--
 android/tester-socket.c    |  10 +-
 6 files changed, 93 insertions(+), 213 deletions(-)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 75df62d..86f5e5c 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -19,14 +19,10 @@
 
 static struct queue *list; /* List of bluetooth test cases */
 
-static struct step dummy_steps[] = {
+TEST_CASE(bluetooth_init,
+	"Bluetooth Init",
 	ACTION_SUCCESS(dummy_action, NULL),
-};
-static struct test_case bluetooth_init = {
-	.step = dummy_steps,
-	.title = "Bluetooth Init",
-	.step_num = get_test_case_step_num(dummy_steps),
-};
+);
 
 static bt_bdaddr_t enable_bdaddr_val = {
 	.address = { 0x00, 0xaa, 0x01, 0x00, 0x00, 0x00 },
@@ -60,40 +56,28 @@ static bt_property_t enable_props[] = {
 	{ BT_PROPERTY_UUIDS, sizeof(enable_uuids_val), &enable_uuids_val },
 };
 
-static struct step bluetooth_enable_success_steps[] = {
+TEST_CASE(bluetooth_enable_success_tc,
+	"Bluetooth Enable - Success",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_ADAPTER_PROPS(enable_props, 8),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-};
-static struct test_case bluetooth_enable_success_tc = {
-	.step = bluetooth_enable_success_steps,
-	.title = "Bluetooth Enable - Success",
-	.step_num = get_test_case_step_num(bluetooth_enable_success_steps),
-};
+);
 
-static struct step bluetooth_enable_success2_steps[] = {
+TEST_CASE(bluetooth_enable_success2_tc,
+	"Bluetooth Enable - Success 2",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_ADAPTER_PROPS(enable_props, 8),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
-};
-static struct test_case bluetooth_enable_success2_tc = {
-	.step = bluetooth_enable_success2_steps,
-	.title = "Bluetooth Enable - Success 2",
-	.step_num = get_test_case_step_num(bluetooth_enable_success2_steps),
-};
+);
 
-static struct step bluetooth_disable_success_steps[] = {
+TEST_CASE(bluetooth_disable_success_tc,
+	"Bluetooth Disable - Success",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_SUCCESS(bluetooth_disable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
-};
-static struct test_case bluetooth_disable_success_tc = {
-	.step = bluetooth_disable_success_steps,
-	.title = "Bluetooth Disable - Success",
-	.step_num = get_test_case_step_num(bluetooth_disable_success_steps),
-};
+);
 
 static char test_set_bdname[] = "test_bdname_set";
 
@@ -103,18 +87,13 @@ static bt_property_t setprop_bdname_prop = {
 	.len = sizeof(test_set_bdname) - 1,
 };
 
-static struct step bluetooth_setprop_bdname_success_steps[] = {
+TEST_CASE(bluetooth_setprop_bdname_success_tc,
+	"Bluetooth Set BDNAME - Success",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_SUCCESS(bt_set_property_action, &setprop_bdname_prop),
 	CALLBACK_ADAPTER_PROPS(&setprop_bdname_prop, 1),
-};
-static struct test_case bluetooth_setprop_bdname_success_tc = {
-	.step = bluetooth_setprop_bdname_success_steps,
-	.title = "Bluetooth Set BDNAME - Success",
-	.step_num =
-		get_test_case_step_num(bluetooth_setprop_bdname_success_steps),
-};
+);
 
 static bt_scan_mode_t test_setprop_scanmode_val =
 					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE;
@@ -125,18 +104,13 @@ static bt_property_t setprop_scanmode_prop = {
 	.len = sizeof(bt_scan_mode_t),
 };
 
-static struct step bluetooth_setprop_scanmode_success_steps[] = {
+TEST_CASE(bluetooth_setprop_scanmode_success_tc,
+	"Bluetooth Set SCAN_MODE - Success",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_SUCCESS(bt_set_property_action, &setprop_scanmode_prop),
 	CALLBACK_ADAPTER_PROPS(&setprop_scanmode_prop, 1),
-};
-static struct test_case bluetooth_setprop_scanmode_success_tc = {
-	.step = bluetooth_setprop_scanmode_success_steps,
-	.title = "Bluetooth Set SCAN_MODE - Success",
-	.step_num = get_test_case_step_num(
-				bluetooth_setprop_scanmode_success_steps),
-};
+);
 
 static uint32_t test_setprop_disctimeout_val = 600;
 
@@ -146,18 +120,13 @@ static bt_property_t setprop_disctimeout_prop = {
 	.len = sizeof(test_setprop_disctimeout_val),
 };
 
-static struct step bluetooth_setprop_disctimeout_success_steps[] = {
+TEST_CASE(bluetooth_setprop_disctimeout_success_tc,
+	"Bluetooth Set DISCOVERY_TIMEOUT - Success",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_SUCCESS(bt_set_property_action, &setprop_disctimeout_prop),
 	CALLBACK_ADAPTER_PROPS(&setprop_disctimeout_prop, 1),
-};
-static struct test_case bluetooth_setprop_disctimeout_success_tc = {
-	.step = bluetooth_setprop_disctimeout_success_steps,
-	.title = "Bluetooth Set DISCOVERY_TIMEOUT - Success",
-	.step_num = get_test_case_step_num(
-				bluetooth_setprop_disctimeout_success_steps),
-};
+);
 
 static bt_bdaddr_t test_getprop_bdaddr_val = {
 	{0x00, 0xaa, 0x01, 0x00, 0x00, 0x00},
@@ -169,18 +138,13 @@ static bt_property_t getprop_bdaddr_prop = {
 	.len = sizeof(test_getprop_bdaddr_val),
 };
 
-static struct step bluetooth_getprop_bdaddr_success_steps[] = {
+TEST_CASE(bluetooth_getprop_bdaddr_success_tc,
+	"Bluetooth Get BDADDR - Success",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_SUCCESS(bt_get_property_action, &getprop_bdaddr_prop),
 	CALLBACK_ADAPTER_PROPS(&getprop_bdaddr_prop, 1),
-};
-static struct test_case bluetooth_getprop_bdaddr_success_tc = {
-	.step = bluetooth_getprop_bdaddr_success_steps,
-	.title = "Bluetooth Get BDADDR - Success",
-	.step_num = get_test_case_step_num(
-					bluetooth_getprop_bdaddr_success_steps),
-};
+);
 
 static const char test_getprop_bdname_val[] = "BlueZ for Android";
 
@@ -190,19 +154,13 @@ static bt_property_t getprop_bdname_prop = {
 	.len = sizeof(test_getprop_bdname_val) - 1,
 };
 
-static struct step bluetooth_getprop_bdname_success_steps[] = {
+TEST_CASE(bluetooth_getprop_bdname_success_tc,
+	"Bluetooth Get BDNAME - Success",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_SUCCESS(bt_get_property_action, &getprop_bdname_prop),
 	CALLBACK_ADAPTER_PROPS(&getprop_bdname_prop, 1),
-};
-static struct test_case bluetooth_getprop_bdname_success_tc = {
-	.step = bluetooth_getprop_bdname_success_steps,
-	.title = "Bluetooth Get BDNAME - Success",
-	.step_num = get_test_case_step_num(
-					bluetooth_getprop_bdname_success_steps),
-};
-
+);
 
 static unsigned char setprop_uuids[] = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00,
 			0x00, 0x80, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -214,16 +172,12 @@ static bt_property_t setprop_uuid_prop = {
 	.len = sizeof(setprop_uuids),
 };
 
-static struct step bluetooth_setprop_uuid_fail_steps[] = {
+TEST_CASE(bluetooth_setprop_uuid_fail_tc,
+	"Bluetooth Set UUID - Fail",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_FAIL(bt_set_property_action, &setprop_uuid_prop),
-};
-static struct test_case bluetooth_setprop_uuid_fail_tc = {
-	.step = bluetooth_setprop_uuid_fail_steps,
-	.title = "Bluetooth Set UUID - Fail",
-	.step_num = get_test_case_step_num(bluetooth_setprop_uuid_fail_steps),
-};
+);
 
 static uint32_t setprop_cod_val = 0;
 
@@ -233,16 +187,12 @@ static bt_property_t setprop_cod_prop = {
 	.len = sizeof(setprop_cod_val),
 };
 
-static struct step bluetooth_setprop_cod_fail_steps[] = {
+TEST_CASE(bluetooth_setprop_cod_fail_tc,
+	"Bluetooth Set CLASS_OF_DEVICE - Fail",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_FAIL(bt_set_property_action, &setprop_cod_prop),
-};
-static struct test_case bluetooth_setprop_cod_fail_tc = {
-	.step = bluetooth_setprop_cod_fail_steps,
-	.title = "Bluetooth Set CLASS_OF_DEVICE - Fail",
-	.step_num = get_test_case_step_num(bluetooth_setprop_cod_fail_steps),
-};
+);
 
 static uint32_t setprop_tod_val = BT_DEVICE_DEVTYPE_DUAL;
 
@@ -252,16 +202,12 @@ static bt_property_t setprop_tod_prop = {
 	.len = sizeof(setprop_tod_val),
 };
 
-static struct step bluetooth_setprop_tod_fail_steps[] = {
+TEST_CASE(bluetooth_setprop_tod_fail_tc,
+	"Bluetooth Set TYPE_OF_DEVICE - Fail",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_FAIL(bt_set_property_action, &setprop_tod_prop),
-};
-static struct test_case bluetooth_setprop_tod_fail_tc = {
-	.step = bluetooth_setprop_tod_fail_steps,
-	.title = "Bluetooth Set TYPE_OF_DEVICE - Fail",
-	.step_num = get_test_case_step_num(bluetooth_setprop_tod_fail_steps),
-};
+);
 
 static int32_t setprop_remote_rssi_val = -9;
 
@@ -271,17 +217,12 @@ static bt_property_t setprop_remote_rssi_prop = {
 	.len = sizeof(setprop_remote_rssi_val),
 };
 
-static struct step bluetooth_setprop_remote_rssi_fail_steps[] = {
+TEST_CASE(bluetooth_setprop_remote_rssi_fail_tc,
+	"Bluetooth Set REMOTE_RSSI - Fail",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_FAIL(bt_set_property_action, &setprop_remote_rssi_prop),
-};
-static struct test_case bluetooth_setprop_remote_rssi_fail_tc = {
-	.step = bluetooth_setprop_remote_rssi_fail_steps,
-	.title = "Bluetooth Set REMOTE_RSSI - Fail",
-	.step_num = get_test_case_step_num(
-				bluetooth_setprop_remote_rssi_fail_steps),
-};
+);
 
 static bt_service_record_t setprop_srvc_record_val =  {
 	.uuid = { {0x00} },
@@ -295,17 +236,12 @@ static bt_property_t setprop_srvc_record_prop = {
 	.len = sizeof(setprop_srvc_record_val),
 };
 
-static struct step bluetooth_setprop_srvc_record_fail_steps[] = {
+TEST_CASE(bluetooth_setprop_srvc_record_fail_tc,
+	"Bluetooth Set SERVICE_RECORD - Fail",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_FAIL(bt_set_property_action, &setprop_srvc_record_prop),
-};
-static struct test_case bluetooth_setprop_srvc_record_fail_tc = {
-	.step = bluetooth_setprop_srvc_record_fail_steps,
-	.title = "Bluetooth Set SERVICE_RECORD - Fail",
-	.step_num = get_test_case_step_num(
-				bluetooth_setprop_srvc_record_fail_steps),
-};
+);
 
 static bt_bdaddr_t setprop_bdaddr_val = {
 	.address = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
@@ -317,17 +253,12 @@ static bt_property_t setprop_bdaddr_prop = {
 	.len = sizeof(setprop_bdaddr_val),
 };
 
-static struct step bluetooth_setprop_bdaddr_fail_steps[] = {
+TEST_CASE(bluetooth_setprop_bdaddr_fail_tc,
+	"Bluetooth Set BDADDR - Fail",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_FAIL(bt_set_property_action, &setprop_bdaddr_prop),
-};
-static struct test_case bluetooth_setprop_bdaddr_fail_tc = {
-	.step = bluetooth_setprop_bdaddr_fail_steps,
-	.title = "Bluetooth Set BDADDR - Fail",
-	.step_num = get_test_case_step_num(
-				bluetooth_setprop_bdaddr_fail_steps),
-};
+);
 
 static bt_bdaddr_t setprop_bonded_dev_val = {
 	.address = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 },
@@ -339,17 +270,12 @@ static bt_property_t setprop_bonded_dev_prop = {
 	.len = sizeof(setprop_bonded_dev_val),
 };
 
-static struct step bluetooth_setprop_bonded_dev_fail_steps[] = {
+TEST_CASE(bluetooth_setprop_bonded_dev_fail_tc,
+	"Bluetooth Set BONDED_DEVICES - Fail",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_FAIL(bt_set_property_action, &setprop_bonded_dev_prop),
-};
-static struct test_case bluetooth_setprop_bonded_dev_fail_tc = {
-	.step = bluetooth_setprop_bonded_dev_fail_steps,
-	.title = "Bluetooth Set BONDED_DEVICES - Fail",
-	.step_num = get_test_case_step_num(
-				bluetooth_setprop_bonded_dev_fail_steps),
-};
+);
 
 static bt_scan_mode_t setprop_scan_mode_conn_val = BT_SCAN_MODE_CONNECTABLE;
 
@@ -359,18 +285,13 @@ static bt_property_t setprop_scan_mode_conn_prop = {
 	.len = sizeof(setprop_scan_mode_conn_val),
 };
 
-static struct step bluetooth_setprop_scan_mode_conn_success_steps[] = {
+TEST_CASE(bluetooth_setprop_scan_mode_conn_success_tc,
+	"Bluetooth Set SCAN_MODE_CONNECTABLE - SUCCESS",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_SUCCESS(bt_set_property_action, &setprop_scan_mode_conn_prop),
 	CALLBACK_ADAPTER_PROPS(&setprop_scan_mode_conn_prop, 1),
-};
-static struct test_case bluetooth_setprop_scan_mode_conn_success_tc = {
-	.step = bluetooth_setprop_scan_mode_conn_success_steps,
-	.title = "Bluetooth Set SCAN_MODE_CONNECTABLE - SUCCESS",
-	.step_num = get_test_case_step_num(
-				bluetooth_setprop_scan_mode_conn_success_steps),
-};
+);
 
 static uint32_t test_getprop_cod_val = 0x00020c;
 
@@ -380,17 +301,13 @@ static bt_property_t getprop_cod_prop = {
 	.len = sizeof(test_getprop_cod_val),
 };
 
-static struct step bluetooth_getprop_cod_success_steps[] = {
+TEST_CASE(bluetooth_getprop_cod_success_tc,
+	"Bluetooth Get CLASS_OF_DEVICE - Success",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_SUCCESS(bt_get_property_action, &getprop_cod_prop),
 	CALLBACK_ADAPTER_PROPS(&getprop_cod_prop, 1),
-};
-static struct test_case bluetooth_getprop_cod_success_tc = {
-	.step = bluetooth_getprop_cod_success_steps,
-	.title = "Bluetooth Get CLASS_OF_DEVICE - Success",
-	.step_num = get_test_case_step_num(bluetooth_getprop_cod_success_steps),
-};
+);
 
 static bt_device_type_t test_getprop_tod_val = BT_DEVICE_DEVTYPE_DUAL;
 
@@ -400,17 +317,13 @@ static bt_property_t getprop_tod_prop = {
 	.len = sizeof(test_getprop_tod_val),
 };
 
-static struct step bluetooth_getprop_tod_success_steps[] = {
+TEST_CASE(bluetooth_getprop_tod_success_tc,
+	"Bluetooth Get TYPE_OF_DEVICE - Success",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_SUCCESS(bt_get_property_action, &getprop_tod_prop),
 	CALLBACK_ADAPTER_PROPS(&getprop_tod_prop, 1),
-};
-static struct test_case bluetooth_getprop_tod_success_tc = {
-	.step = bluetooth_getprop_tod_success_steps,
-	.title = "Bluetooth Get TYPE_OF_DEVICE - Success",
-	.step_num = get_test_case_step_num(bluetooth_getprop_tod_success_steps),
-};
+);
 
 static bt_scan_mode_t test_getprop_scan_mode_val = BT_SCAN_MODE_NONE;
 
@@ -420,18 +333,13 @@ static bt_property_t getprop_scan_mode_prop = {
 	.len = sizeof(test_getprop_scan_mode_val),
 };
 
-static struct step bluetooth_getprop_scan_mode_success_steps[] = {
+TEST_CASE(bluetooth_getprop_scan_mode_success_tc,
+	"Bluetooth Get SCAN_MODE - Success",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_SUCCESS(bt_get_property_action, &getprop_scan_mode_prop),
 	CALLBACK_ADAPTER_PROPS(&getprop_scan_mode_prop, 1),
-};
-static struct test_case bluetooth_getprop_scan_mode_success_tc = {
-	.step = bluetooth_getprop_scan_mode_success_steps,
-	.title = "Bluetooth Get SCAN_MODE - Success",
-	.step_num = get_test_case_step_num(
-				bluetooth_getprop_scan_mode_success_steps),
-};
+);
 
 static uint32_t test_getprop_disc_timeout_val = 120;
 
@@ -441,18 +349,13 @@ static bt_property_t getprop_disc_timeout_prop = {
 	.len = sizeof(test_getprop_disc_timeout_val),
 };
 
-static struct step bluetooth_getprop_disc_timeout_success_steps[] = {
+TEST_CASE(bluetooth_getprop_disc_timeout_success_tc,
+	"Bluetooth Get DISCOVERY_TIMEOUT - Success",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_SUCCESS(bt_get_property_action, &getprop_disc_timeout_prop),
 	CALLBACK_ADAPTER_PROPS(&getprop_disc_timeout_prop, 1),
-};
-static struct test_case bluetooth_getprop_disc_timeout_success_tc = {
-	.step = bluetooth_getprop_disc_timeout_success_steps,
-	.title = "Bluetooth Get DISCOVERY_TIMEOUT - Success",
-	.step_num = get_test_case_step_num(
-				bluetooth_getprop_disc_timeout_success_steps),
-};
+);
 
 static const char test_getprop_uuids_val[] = {
 	/* Multi profile UUID */
@@ -469,18 +372,13 @@ static bt_property_t getprop_uuids_prop = {
 	.len = sizeof(test_getprop_uuids_val),
 };
 
-static struct step bluetooth_getprop_uuids_success_steps[] = {
+TEST_CASE(bluetooth_getprop_uuids_success_tc,
+	"Bluetooth Get BONDED_DEVICES - Success",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_SUCCESS(bt_get_property_action, &getprop_uuids_prop),
 	CALLBACK_ADAPTER_PROPS(&getprop_uuids_prop, 1),
-};
-static struct test_case bluetooth_getprop_uuids_success_tc = {
-	.step = bluetooth_getprop_uuids_success_steps,
-	.title = "Bluetooth Get UUIDS - Success",
-	.step_num = get_test_case_step_num(
-					bluetooth_getprop_uuids_success_steps),
-};
+);
 
 static bt_property_t getprop_bonded_devs_prop = {
 	.type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
@@ -488,18 +386,13 @@ static bt_property_t getprop_bonded_devs_prop = {
 	.len = 0,
 };
 
-static struct step bluetooth_getprop_bonded_devs_success_steps[] = {
+TEST_CASE(bluetooth_getprop_bonded_devs_success_tc,
+	"Bluetooth Get BONDED_DEVICES - Success",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_SUCCESS(bt_get_property_action, &getprop_bonded_devs_prop),
 	CALLBACK_ADAPTER_PROPS(&getprop_bonded_devs_prop, 1),
-};
-static struct test_case bluetooth_getprop_bonded_devs_success_tc = {
-	.step = bluetooth_getprop_bonded_devs_success_steps,
-	.title = "Bluetooth Get BONDED_DEVICES - Success",
-	.step_num = get_test_case_step_num(
-				bluetooth_getprop_bonded_devs_success_steps),
-};
+);
 
 static bt_scan_mode_t test_setprop_scanmode_val2 = BT_SCAN_MODE_NONE;
 
@@ -509,18 +402,13 @@ static bt_property_t setprop_scan_mode2_prop = {
 	.len = sizeof(test_setprop_scanmode_val2),
 };
 
-static struct step bluetooth_setprop_scan_mode2_success_steps[] = {
+TEST_CASE(bluetooth_setprop_scan_mode2_success_tc,
+	"Bluetooth Set SCAN_MODE - Success 2",
 	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	ACTION_SUCCESS(bt_set_property_action, &setprop_scan_mode2_prop),
 	CALLBACK_ADAPTER_PROPS(&setprop_scan_mode2_prop, 1),
-};
-static struct test_case bluetooth_setprop_scan_mode2_success_tc = {
-	.step = bluetooth_setprop_scan_mode2_success_steps,
-	.title = "Bluetooth Set SCAN_MODE - Success 2",
-	.step_num = get_test_case_step_num(
-				bluetooth_setprop_scan_mode2_success_steps),
-};
+);
 
 static struct test_case *test_cases[] = {
 	&bluetooth_init,
diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index db2ed27..87a11a1 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -19,14 +19,10 @@
 
 static struct queue *list; /* List of gatt test cases */
 
-static struct step dummy_steps[] = {
+TEST_CASE(gatt_init,
+	"Gatt Init",
 	ACTION_SUCCESS(dummy_action, NULL),
-};
-static struct test_case gatt_init = {
-	.step = dummy_steps,
-	.title = "Socket Init",
-	.step_num = get_test_case_step_num(dummy_steps),
-};
+);
 
 static struct test_case *test_cases[] = {
 	&gatt_init,
diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index 49c34bd..6260825 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -19,14 +19,10 @@
 
 static struct queue *list; /* List of hidhost test cases */
 
-static struct step dummy_steps[] = {
+TEST_CASE(hidhost_init,
+	"Hidhost Init",
 	ACTION_SUCCESS(dummy_action, NULL),
-};
-static struct test_case hidhost_init = {
-	.step = dummy_steps,
-	.title = "Hidhost Init",
-	.step_num = get_test_case_step_num(dummy_steps),
-};
+);
 
 static struct test_case *test_cases[] = {
 	&hidhost_init,
diff --git a/android/tester-main.c b/android/tester-main.c
index e8cd4f2..7f52083 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -440,7 +440,7 @@ static void init_test_steps(struct test_data *data)
 	int i = 0;
 
 	for (i = 0; i < test_steps->step_num; i++)
-		queue_push_tail(data->steps, &(test_steps->step[i]));
+		queue_push_tail(data->steps, (void *) &(test_steps->step[i]));
 
 	tester_print("tester: Number of test steps=%d",
 						queue_length(data->steps));
diff --git a/android/tester-main.h b/android/tester-main.h
index d8c2986..f838831 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -50,7 +50,11 @@
 #include <hardware/bt_gatt_client.h>
 #include <hardware/bt_gatt_server.h>
 
-#define get_test_case_step_num(tc) (sizeof(tc) / sizeof(struct step))
+#define TEST_CASE(decl_name, text, ...) static struct test_case decl_name = { \
+		text, \
+		sizeof((struct step[]) {__VA_ARGS__}) / sizeof(struct step), \
+		{__VA_ARGS__}, \
+	}
 
 #define ACTION_SUCCESS(act_fun, data_set) { \
 		.action_result.status = BT_STATUS_SUCCESS, \
@@ -157,12 +161,6 @@ struct test_data {
 	pid_t bluetoothd_pid;
 };
 
-struct test_case {
-	struct step *step;
-	char *title;
-	uint16_t step_num;
-};
-
 /*
  * Struct of data to check within step action.
  */
@@ -197,6 +195,12 @@ struct step {
 	int set_data_len;
 };
 
+struct test_case {
+	char *title;
+	uint16_t step_num;
+	struct step step[];
+};
+
 /* Get, remove test cases API */
 struct queue *get_bluetooth_tests(void);
 void remove_bluetooth_tests(void);
diff --git a/android/tester-socket.c b/android/tester-socket.c
index 0afab4a..ba283fa 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -19,14 +19,10 @@
 
 static struct queue *list; /* List of socket test cases */
 
-static struct step dummy_steps[] = {
+TEST_CASE(socket_init,
+	"Socket Init",
 	ACTION_SUCCESS(dummy_action, NULL),
-};
-static struct test_case socket_init = {
-	.step = dummy_steps,
-	.title = "Socket Init",
-	.step_num = get_test_case_step_num(dummy_steps),
-};
+);
 
 static struct test_case *test_cases[] = {
 	&socket_init,
-- 
1.9.1

