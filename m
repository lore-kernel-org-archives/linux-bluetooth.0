Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/6] android/tester: Whitespace and semicolon style correction
Date: Mon, 23 Dec 2013 15:15:52 +0100
Message-Id: <1387808154-21661-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1387808154-21661-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1387808154-21661-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds semicolon to the last element in test case condition
structure. Additional whitespace was removed from function.
---
 android/android-tester.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 57f3fc9..fc53465 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -701,18 +701,18 @@ fail:
 static const struct generic_data bluetooth_enable_success_test = {
 	.expected_hal_callbacks = { ADAPTER_PROPS, ADAPTER_STATE_CHANGED_ON,
 							ADAPTER_TEST_END },
-	.expected_adapter_status = BT_STATUS_SUCCESS
+	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
 static const struct generic_data bluetooth_enable_done_test = {
 	.expected_hal_callbacks = { ADAPTER_PROPS, ADAPTER_TEST_END },
-	.expected_adapter_status = BT_STATUS_DONE
+	.expected_adapter_status = BT_STATUS_DONE,
 };
 
 static const struct generic_data bluetooth_disable_success_test = {
 	.expected_hal_callbacks = { ADAPTER_STATE_CHANGED_OFF,
 							ADAPTER_TEST_END },
-	.expected_adapter_status = BT_STATUS_SUCCESS
+	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
 static const struct generic_data bluetooth_setprop_bdname_success_test = {
@@ -720,7 +720,7 @@ static const struct generic_data bluetooth_setprop_bdname_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 	.expected_property.type = BT_PROPERTY_BDNAME,
 	.expected_property.val = "test_bdname",
-	.expected_property.len = 11
+	.expected_property.len = 11,
 };
 
 static bt_scan_mode_t test_setprop_scanmode_val =
@@ -733,7 +733,7 @@ static const struct generic_data bluetooth_setprop_scanmode_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 	.expected_property.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
 	.expected_property.val = &test_setprop_scanmode_val,
-	.expected_property.len = sizeof(bt_scan_mode_t)
+	.expected_property.len = sizeof(bt_scan_mode_t),
 };
 
 static uint32_t test_setprop_disctimeout_val = 120;
@@ -743,7 +743,7 @@ static const struct generic_data bluetooth_setprop_disctimeout_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 	.expected_property.type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
 	.expected_property.val = &test_setprop_disctimeout_val,
-	.expected_property.len = sizeof(test_setprop_disctimeout_val)
+	.expected_property.len = sizeof(test_setprop_disctimeout_val),
 };
 
 static const struct generic_data bluetooth_getprop_bdaddr_success_test = {
@@ -751,7 +751,7 @@ static const struct generic_data bluetooth_getprop_bdaddr_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 	.expected_property.type = BT_PROPERTY_BDADDR,
 	.expected_property.val = NULL,
-	.expected_property.len = sizeof(bt_bdaddr_t)
+	.expected_property.len = sizeof(bt_bdaddr_t),
 };
 
 static char test_bdname[] = "test_bdname_setget";
@@ -774,7 +774,7 @@ static const struct generic_data bluetooth_setprop_uuid_invalid_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
 	.expected_property.type = BT_PROPERTY_UUIDS,
 	.expected_property.val = &setprop_uuids,
-	.expected_property.len = sizeof(setprop_uuids)
+	.expected_property.len = sizeof(setprop_uuids),
 };
 
 static uint32_t setprop_class_of_device = 0;
@@ -784,7 +784,7 @@ static const struct generic_data bluetooth_setprop_cod_invalid_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
 	.expected_property.type = BT_PROPERTY_CLASS_OF_DEVICE,
 	.expected_property.val = &setprop_class_of_device,
-	.expected_property.len = sizeof(setprop_class_of_device)
+	.expected_property.len = sizeof(setprop_class_of_device),
 };
 
 static bt_device_type_t setprop_type_of_device = BT_DEVICE_DEVTYPE_BREDR;
@@ -794,7 +794,7 @@ static const struct generic_data bluetooth_setprop_tod_invalid_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
 	.expected_property.type = BT_PROPERTY_TYPE_OF_DEVICE,
 	.expected_property.val = &setprop_type_of_device,
-	.expected_property.len = sizeof(setprop_type_of_device)
+	.expected_property.len = sizeof(setprop_type_of_device),
 };
 
 static int32_t setprop_remote_rssi = 0;
@@ -804,13 +804,13 @@ static const struct generic_data bluetooth_setprop_remote_rssi_invalid_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
 	.expected_property.type = BT_PROPERTY_REMOTE_RSSI,
 	.expected_property.val = &setprop_remote_rssi,
-	.expected_property.len = sizeof(setprop_remote_rssi)
+	.expected_property.len = sizeof(setprop_remote_rssi),
 };
 
 static bt_service_record_t setprop_remote_service = {
 	.uuid = { {0x00} },
 	.channel = 12,
-	.name = "bt_name"
+	.name = "bt_name",
 };
 
 static const struct generic_data
@@ -819,30 +819,30 @@ static const struct generic_data
 	.expected_adapter_status = BT_STATUS_FAIL,
 	.expected_property.type = BT_PROPERTY_SERVICE_RECORD,
 	.expected_property.val = &setprop_remote_service,
-	.expected_property.len = sizeof(setprop_remote_service)
+	.expected_property.len = sizeof(setprop_remote_service),
 };
 
 static const struct generic_data bluetooth_discovery_start_success_test = {
 	.expected_hal_callbacks = { ADAPTER_DISCOVERY_STATE_ON,
 							ADAPTER_TEST_END },
-	.expected_adapter_status = BT_STATUS_SUCCESS
+	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
 static const struct generic_data bluetooth_discovery_start_done_test = {
 	.expected_hal_callbacks = { ADAPTER_DISCOVERY_STATE_ON,
 							ADAPTER_TEST_END },
-	.expected_adapter_status = BT_STATUS_DONE
+	.expected_adapter_status = BT_STATUS_DONE,
 };
 
 static const struct generic_data bluetooth_discovery_stop_done_test = {
 	.expected_hal_callbacks = { ADAPTER_TEST_END },
-	.expected_adapter_status = BT_STATUS_DONE
+	.expected_adapter_status = BT_STATUS_DONE,
 };
 
 static const struct generic_data bluetooth_discovery_stop_success_test = {
 	.expected_hal_callbacks = { ADAPTER_DISCOVERY_STATE_ON,
 				ADAPTER_DISCOVERY_STATE_OFF, ADAPTER_TEST_END },
-	.expected_adapter_status = BT_STATUS_SUCCESS
+	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
 static const struct generic_data bluetooth_discovery_device_found_test = {
@@ -850,7 +850,7 @@ static const struct generic_data bluetooth_discovery_device_found_test = {
 						REMOTE_DEVICE_FOUND,
 						ADAPTER_DISCOVERY_STATE_OFF,
 						ADAPTER_TEST_END },
-	.expected_adapter_status = BT_STATUS_NOT_EXPECTED
+	.expected_adapter_status = BT_STATUS_NOT_EXPECTED,
 };
 
 static bt_callbacks_t bt_callbacks = {
@@ -1486,7 +1486,6 @@ static void test_listen_close(const void *test_data)
 clean:
 	if (sock_fd >= 0)
 		close(sock_fd);
-
 }
 
 static void test_listen_listen(const void *test_data)
@@ -1554,7 +1553,6 @@ clean:
 		close(sock_fd);
 }
 
-
 static gboolean socket_chan_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
-- 
1.8.4.2

