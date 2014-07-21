Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 01/11] android/tester-ng: Allow test framework user to choose emu type
Date: Mon, 21 Jul 2014 09:40:19 +0200
Message-Id: <1405928429-11491-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405928429-11491-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405928429-11491-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to set emulated adapter type for each test case in place
where tests are defined. Previously this was hardcoded in the framework.
---
 android/tester-bluetooth.c | 108 ++++++++++++++++++++++-----------------------
 android/tester-gatt.c      |   2 +-
 android/tester-hidhost.c   |   2 +-
 android/tester-main.c      |  25 +++--------
 android/tester-main.h      |  11 ++++-
 android/tester-socket.c    |   2 +-
 6 files changed, 73 insertions(+), 77 deletions(-)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index a5096af..d80fe68 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -381,150 +381,150 @@ static struct bt_action_data prop_test_ble_remote_timestamp_req = {
 };
 
 static struct test_case test_cases[] = {
-	TEST_CASE("Bluetooth Init",
+	TEST_CASE_BREDRLE("Bluetooth Init",
 		ACTION_SUCCESS(dummy_action, NULL),
 	),
-	TEST_CASE("Bluetooth Enable - Success",
+	TEST_CASE_BREDRLE("Bluetooth Enable - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_ADAPTER_PROPS(prop_emu_default_set, 8),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 	),
-	TEST_CASE("Bluetooth Enable - Success 2",
+	TEST_CASE_BREDRLE("Bluetooth Enable - Success 2",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_ADAPTER_PROPS(prop_emu_default_set, 8),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 	),
-	TEST_CASE("Bluetooth Disable - Success",
+	TEST_CASE_BREDRLE("Bluetooth Disable - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
-	TEST_CASE("Bluetooth Set BDNAME - Success",
+	TEST_CASE_BREDRLE("Bluetooth Set BDNAME - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bt_set_property_action, &prop_test_bdname),
 		CALLBACK_ADAPTER_PROPS(&prop_test_bdname, 1),
 	),
-	TEST_CASE("Bluetooth Set SCAN_MODE - Success",
+	TEST_CASE_BREDRLE("Bluetooth Set SCAN_MODE - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bt_set_property_action,
 					&prop_test_scanmode_conn_discov),
 		CALLBACK_ADAPTER_PROPS(&prop_test_scanmode_conn_discov, 1),
 	),
-	TEST_CASE("Bluetooth Set DISCOVERY_TIMEOUT - Success",
+	TEST_CASE_BREDRLE("Bluetooth Set DISCOVERY_TIMEOUT - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bt_set_property_action, &prop_test_disctimeout),
 		CALLBACK_ADAPTER_PROPS(&prop_test_disctimeout, 1),
 	),
-	TEST_CASE("Bluetooth Get BDADDR - Success",
+	TEST_CASE_BREDRLE("Bluetooth Get BDADDR - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bt_get_property_action, &prop_emu_bdaddr),
 		CALLBACK_ADAPTER_PROPS(&prop_emu_bdaddr, 1),
 	),
-	TEST_CASE("Bluetooth Get BDNAME - Success",
+	TEST_CASE_BREDRLE("Bluetooth Get BDNAME - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bt_get_property_action, &prop_emu_bdname),
 		CALLBACK_ADAPTER_PROPS(&prop_emu_bdname, 1),
 	),
-	TEST_CASE("Bluetooth Set UUID - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Set UUID - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_FAIL(bt_set_property_action, &prop_test_uuid),
 	),
-	TEST_CASE("Bluetooth Set CLASS_OF_DEVICE - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Set CLASS_OF_DEVICE - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_FAIL(bt_set_property_action, &prop_test_cod),
 	),
-	TEST_CASE("Bluetooth Set TYPE_OF_DEVICE - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Set TYPE_OF_DEVICE - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_FAIL(bt_set_property_action, &prop_test_tod),
 	),
-	TEST_CASE("Bluetooth Set REMOTE_RSSI - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Set REMOTE_RSSI - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_FAIL(bt_set_property_action, &prop_test_remote_rssi),
 	),
-	TEST_CASE("Bluetooth Set SERVICE_RECORD - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Set SERVICE_RECORD - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_FAIL(bt_set_property_action, &prop_test_srvc_record),
 	),
-	TEST_CASE("Bluetooth Set BDADDR - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Set BDADDR - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_FAIL(bt_set_property_action, &prop_test_bdaddr),
 	),
-	TEST_CASE("Bluetooth Set SCAN_MODE_CONNECTABLE - SUCCESS",
+	TEST_CASE_BREDRLE("Bluetooth Set SCAN_MODE_CONNECTABLE - SUCCESS",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bt_set_property_action,
 						&prop_test_scan_mode_conn),
 		CALLBACK_ADAPTER_PROPS(&prop_test_scan_mode_conn, 1),
 	),
-	TEST_CASE("Bluetooth Set BONDED_DEVICES - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Set BONDED_DEVICES - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_FAIL(bt_set_property_action, &prop_test_bonded_dev_addr),
 	),
-	TEST_CASE("Bluetooth Get CLASS_OF_DEVICE - Success",
+	TEST_CASE_BREDRLE("Bluetooth Get CLASS_OF_DEVICE - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bt_get_property_action, &prop_emu_cod),
 		CALLBACK_ADAPTER_PROPS(&prop_emu_cod, 1),
 	),
-	TEST_CASE("Bluetooth Get TYPE_OF_DEVICE - Success",
+	TEST_CASE_BREDRLE("Bluetooth Get TYPE_OF_DEVICE - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bt_get_property_action, &prop_emu_tod),
 		CALLBACK_ADAPTER_PROPS(&prop_emu_tod, 1),
 	),
-	TEST_CASE("Bluetooth Get SCAN_MODE - Success",
+	TEST_CASE_BREDRLE("Bluetooth Get SCAN_MODE - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bt_get_property_action, &prop_emu_scan_mode),
 		CALLBACK_ADAPTER_PROPS(&prop_emu_scan_mode, 1),
 	),
-	TEST_CASE("Bluetooth Get DISCOVERY_TIMEOUT - Success",
+	TEST_CASE_BREDRLE("Bluetooth Get DISCOVERY_TIMEOUT - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bt_get_property_action, &prop_emu_disc_timeout),
 		CALLBACK_ADAPTER_PROPS(&prop_emu_disc_timeout, 1),
 	),
-	TEST_CASE("Bluetooth Get UUIDS - Success",
+	TEST_CASE_BREDRLE("Bluetooth Get UUIDS - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bt_get_property_action, &prop_emu_uuids),
 		CALLBACK_ADAPTER_PROPS(&prop_emu_uuids, 1),
 	),
-	TEST_CASE("Bluetooth Get BONDED_DEVICES - Success",
+	TEST_CASE_BREDRLE("Bluetooth Get BONDED_DEVICES - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bt_get_property_action, &prop_emu_bonded_devs),
 		CALLBACK_ADAPTER_PROPS(&prop_emu_bonded_devs, 1),
 	),
-	TEST_CASE("Bluetooth Set SCAN_MODE - Success 2",
+	TEST_CASE_BREDRLE("Bluetooth Set SCAN_MODE - Success 2",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bt_set_property_action,
 						&prop_test_scan_mode_none),
 		CALLBACK_ADAPTER_PROPS(&prop_test_scan_mode_none, 1),
 	),
-	TEST_CASE("Bluetooth BR/EDR Discovery Start - Success",
+	TEST_CASE_BREDRLE("Bluetooth BR/EDR Discovery Start - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bt_start_discovery_action, NULL),
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STARTED),
 	),
-	TEST_CASE("Bluetooth BR/EDR Discovery Start - Done",
+	TEST_CASE_BREDRLE("Bluetooth BR/EDR Discovery Start - Done",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bt_start_discovery_action, NULL),
@@ -532,7 +532,7 @@ static struct test_case test_cases[] = {
 							BT_DISCOVERY_STARTED),
 		ACTION_SUCCESS(bt_start_discovery_action, NULL),
 	),
-	TEST_CASE("Bluetooth BR/EDR Discovery Stop - Success",
+	TEST_CASE_BREDRLE("Bluetooth BR/EDR Discovery Stop - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bt_start_discovery_action, NULL),
@@ -542,7 +542,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 	),
-	TEST_CASE("Bluetooth BR/EDR Discovery Stop - Done",
+	TEST_CASE_BREDRLE("Bluetooth BR/EDR Discovery Stop - Done",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(bt_start_discovery_action, NULL),
@@ -553,7 +553,7 @@ static struct test_case test_cases[] = {
 							BT_DISCOVERY_STOPPED),
 		ACTION_SUCCESS(bt_start_discovery_action, NULL),
 	),
-	TEST_CASE("Bluetooth BR/EDR Discovery Device Found",
+	TEST_CASE_BREDRLE("Bluetooth BR/EDR Discovery Device Found",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -565,7 +565,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STOPPED),
 	),
-	TEST_CASE("Bluetooth Device Get Props - Success",
+	TEST_CASE_BREDRLE("Bluetooth Device Get Props - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -579,7 +579,7 @@ static struct test_case test_cases[] = {
 							&emu_remote_bdaddr_val),
 		CALLBACK_DEVICE_PROPS(prop_emu_ble_remotes_query_set, 6),
 	),
-	TEST_CASE("Bluetooth Device Get BDNAME - Success",
+	TEST_CASE_BREDRLE("Bluetooth Device Get BDNAME - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -593,7 +593,7 @@ static struct test_case test_cases[] = {
 					&prop_emu_ble_remote_bdname_req),
 		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_bdname_prop, 1),
 	),
-	TEST_CASE("Bluetooth Device Get UUIDS - Success",
+	TEST_CASE_BREDRLE("Bluetooth Device Get UUIDS - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -607,7 +607,7 @@ static struct test_case test_cases[] = {
 						&prop_emu_ble_remote_uuids_req),
 		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_uuids_prop, 1),
 	),
-	TEST_CASE("Bluetooth Device Get COD - Success",
+	TEST_CASE_BREDRLE("Bluetooth Device Get COD - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -621,7 +621,7 @@ static struct test_case test_cases[] = {
 						&prop_emu_ble_remote_cod_req),
 		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_cod_prop, 1),
 	),
-	TEST_CASE("Bluetooth Device Get TOD - Success",
+	TEST_CASE_BREDRLE("Bluetooth Device Get TOD - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -635,7 +635,7 @@ static struct test_case test_cases[] = {
 						&prop_emu_ble_remote_tod_req),
 		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_tod_prop, 1),
 	),
-	TEST_CASE("Bluetooth Device Get RSSI - Success",
+	TEST_CASE_BREDRLE("Bluetooth Device Get RSSI - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -649,7 +649,7 @@ static struct test_case test_cases[] = {
 						&prop_emu_ble_remote_rssi_req),
 		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_rssi_prop, 1),
 	),
-	TEST_CASE("Bluetooth Device Get TIMESTAMP - Success",
+	TEST_CASE_BREDRLE("Bluetooth Device Get TIMESTAMP - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -663,7 +663,7 @@ static struct test_case test_cases[] = {
 					&prop_emu_ble_remote_timestamp_req),
 		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_timestamp_prop, 1),
 	),
-	TEST_CASE("Bluetooth Device Get BDADDR - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Device Get BDADDR - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -676,7 +676,7 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(bt_get_device_prop_action,
 					&prop_emu_ble_remote_bdaddr_req),
 	),
-	TEST_CASE("Bluetooth Device Get SCAN_MODE - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Device Get SCAN_MODE - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -689,7 +689,7 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(bt_get_device_prop_action,
 					&prop_emu_ble_remote_scan_mode_req),
 	),
-	TEST_CASE("Bluetooth Device Get BONDED_DEVICES - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Device Get BONDED_DEVICES - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -702,7 +702,7 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(bt_get_device_prop_action,
 					&prop_emu_ble_remote_bondeddev_req),
 	),
-	TEST_CASE("Bluetooth Device Get DISCOVERY_TIMEOUT - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Device Get DISCOVERY_TIMEOUT - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -715,7 +715,7 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(bt_get_device_prop_action,
 					&prop_emu_ble_remote_disctimeout_req),
 	),
-	TEST_CASE("Bluetooth Device Get VERSION_INFO - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Device Get VERSION_INFO - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -728,7 +728,7 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(bt_get_device_prop_action,
 					&prop_emu_ble_remote_verinfo_req),
 	),
-	TEST_CASE("Bluetooth Device Get FRIENDLY_NAME - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Device Get FRIENDLY_NAME - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -741,7 +741,7 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(bt_get_device_prop_action,
 						&prop_emu_ble_remote_fname_req),
 	),
-	TEST_CASE("Bluetooth Device Set FRIENDLY_NAME - Success",
+	TEST_CASE_BREDRLE("Bluetooth Device Set FRIENDLY_NAME - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -757,7 +757,7 @@ static struct test_case test_cases[] = {
 						&prop_emu_ble_remote_fname_req),
 		CALLBACK_DEVICE_PROPS(&prop_emu_ble_remote_fname_prop, 1),
 	),
-	TEST_CASE("Bluetooth Device Set BDNAME - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Device Set BDNAME - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -770,7 +770,7 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(bt_set_device_prop_action,
 					&prop_test_ble_remote_bdname_req),
 	),
-	TEST_CASE("Bluetooth Device Set UUIDS - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Device Set UUIDS - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -783,7 +783,7 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(bt_set_device_prop_action,
 					&prop_test_ble_remote_uuids_req),
 	),
-	TEST_CASE("Bluetooth Device Set COD - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Device Set COD - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -796,7 +796,7 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(bt_set_device_prop_action,
 						&prop_test_ble_remote_cod_req),
 	),
-	TEST_CASE("Bluetooth Device Set TOD - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Device Set TOD - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -809,7 +809,7 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(bt_set_device_prop_action,
 						&prop_test_ble_remote_tod_req),
 	),
-	TEST_CASE("Bluetooth Device Set RSSI - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Device Set RSSI - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -822,7 +822,7 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(bt_set_device_prop_action,
 						&prop_test_ble_remote_rssi_req),
 	),
-	TEST_CASE("Bluetooth Device Set TIMESTAMP - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Device Set TIMESTAMP - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -835,7 +835,7 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(bt_set_device_prop_action,
 					&prop_test_ble_remote_timestamp_req),
 	),
-	TEST_CASE("Bluetooth Device Set BDADDR - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Device Set BDADDR - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -848,7 +848,7 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(bt_set_device_prop_action,
 					&prop_test_ble_remote_bdaddr_req),
 	),
-	TEST_CASE("Bluetooth Device Set SERVICE_RECORD - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Device Set SERVICE_RECORD - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -861,7 +861,7 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(bt_set_device_prop_action,
 					&prop_test_ble_remote_srvc_record_req),
 	),
-	TEST_CASE("Bluetooth Device Set SCAN_MODE - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Device Set SCAN_MODE - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -874,7 +874,7 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(bt_set_device_prop_action,
 					&prop_test_ble_remote_scanmode_req),
 	),
-	TEST_CASE("Bluetooth Device Set BONDED_DEVICES - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Device Set BONDED_DEVICES - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -887,7 +887,7 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(bt_set_device_prop_action,
 						&prop_test_ble_bonded_dev_req),
 	),
-	TEST_CASE("Bluetooth Device Set DISCOVERY_TIMEOUT - Fail",
+	TEST_CASE_BREDRLE("Bluetooth Device Set DISCOVERY_TIMEOUT - Fail",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index a55fbe0..b85cfc8 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -20,7 +20,7 @@
 static struct queue *list; /* List of gatt test cases */
 
 static struct test_case test_cases[] = {
-	TEST_CASE("Gatt Init",
+	TEST_CASE_BREDRLE("Gatt Init",
 		ACTION_SUCCESS(dummy_action, NULL),
 	),
 };
diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index b00a4e9..a32b0df 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -20,7 +20,7 @@
 static struct queue *list; /* List of hidhost test cases */
 
 static struct test_case test_cases[] = {
-	TEST_CASE("Hidhost Init",
+	TEST_CASE_BREDRLE("Hidhost Init",
 		ACTION_SUCCESS(dummy_action, NULL),
 	),
 };
diff --git a/android/tester-main.c b/android/tester-main.c
index 4c7a5e7..c850082 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1116,26 +1116,13 @@ static void generic_test_function(const void *test_data)
 	first_step->action();
 }
 
-#define test_bredr(data, test_setup, test, test_teardown) \
+#define test(data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
 		user = g_malloc0(sizeof(struct test_data)); \
 		if (!user) \
 			break; \
-		user->hciemu_type = HCIEMU_TYPE_BREDR; \
-		user->test_data = data; \
-		tester_add_full(data->title, data, test_pre_setup, \
-					test_setup, test, test_teardown, \
-					test_post_teardown, 3, user, g_free); \
-	} while (0)
-
-#define test_bredrle(data, test_setup, test, test_teardown) \
-	do { \
-		struct test_data *user; \
-		user = g_malloc0(sizeof(struct test_data)); \
-		if (!user) \
-			break; \
-		user->hciemu_type = HCIEMU_TYPE_BREDRLE; \
+		user->hciemu_type = data->emu_type; \
 		user->test_data = data; \
 		tester_add_full(data->title, data, test_pre_setup, \
 					test_setup, test, test_teardown, \
@@ -1152,28 +1139,28 @@ static void add_bluetooth_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
 
-	test_bredrle(tc, setup, generic_test_function, teardown);
+	test(tc, setup, generic_test_function, teardown);
 }
 
 static void add_socket_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
 
-	test_bredrle(tc, setup_socket, generic_test_function, teardown);
+	test(tc, setup_socket, generic_test_function, teardown);
 }
 
 static void add_hidhost_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
 
-	test_bredrle(tc, setup_hidhost, generic_test_function, teardown);
+	test(tc, setup_hidhost, generic_test_function, teardown);
 }
 
 static void add_gatt_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
 
-	test_bredrle(tc, setup_gatt, generic_test_function, teardown);
+	test(tc, setup_gatt, generic_test_function, teardown);
 }
 
 int main(int argc, char *argv[])
diff --git a/android/tester-main.h b/android/tester-main.h
index 2f6252d..e8eedf4 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -50,7 +50,15 @@
 #include <hardware/bt_gatt_client.h>
 #include <hardware/bt_gatt_server.h>
 
-#define TEST_CASE(text, ...) { \
+#define TEST_CASE_BREDR(text, ...) { \
+		HCIEMU_TYPE_BREDR, \
+		text, \
+		sizeof((struct step[]) {__VA_ARGS__}) / sizeof(struct step), \
+		(struct step[]) {__VA_ARGS__}, \
+	}
+
+#define TEST_CASE_BREDRLE(text, ...) { \
+		HCIEMU_TYPE_BREDRLE, \
 		text, \
 		sizeof((struct step[]) {__VA_ARGS__}) / sizeof(struct step), \
 		(struct step[]) {__VA_ARGS__}, \
@@ -212,6 +220,7 @@ struct step {
 };
 
 struct test_case {
+	uint8_t emu_type;
 	char *title;
 	uint16_t step_num;
 	const struct step const *step;
diff --git a/android/tester-socket.c b/android/tester-socket.c
index 254b539..fd0f035 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -20,7 +20,7 @@
 static struct queue *list; /* List of socket test cases */
 
 static struct test_case test_cases[] = {
-	TEST_CASE("Socket Init",
+	TEST_CASE_BREDRLE("Socket Init",
 		ACTION_SUCCESS(dummy_action, NULL),
 	),
 };
-- 
1.9.1

