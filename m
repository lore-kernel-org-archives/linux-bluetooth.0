Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/9] android/tester: Coding style and syntax fix
Date: Thu, 27 Feb 2014 16:04:42 +0100
Message-Id: <1393513490-18674-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove white spaces, break lines over 80 characters, redundand braces
for single statement blocks.
---
 android/android-tester.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 79c8e47..a94c536 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1154,7 +1154,7 @@ static void remote_device_properties_cb(bt_status_t status,
 }
 
 static bt_bdaddr_t enable_done_bdaddr_val = { {0x00} };
-static char enable_done_bdname_val[] = "BlueZ for Android";
+static const char enable_done_bdname_val[] = "BlueZ for Android";
 static bt_uuid_t enable_done_uuids_val = {
 	.uu = { 0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
 					0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb},
@@ -1305,7 +1305,7 @@ static const struct generic_data bluetooth_getprop_bdaddr_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
-static char test_bdname[] = "test_bdname_setget";
+static const char test_bdname[] = "test_bdname_setget";
 
 static struct priority_property getprop_bdname_props[] = {
 	{
@@ -1563,7 +1563,8 @@ static struct priority_property setprop_scanmode_none_props[] = {
 	},
 };
 
-static const struct generic_data bluetooth_setprop_scanmode_none_success2_test = {
+static const struct generic_data
+			bluetooth_setprop_scanmode_none_success2_test = {
 	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
 	.expected_properties_num = 1,
 	.expected_properties = setprop_scanmode_none_props,
@@ -1601,7 +1602,7 @@ static const struct generic_data bluetooth_discovery_device_found_test = {
 	.expected_adapter_status = BT_STATUS_NOT_EXPECTED,
 };
 
-static char remote_get_properties_bdname_val[] = "00:AA:01:01:00:00";
+static const char remote_get_properties_bdname_val[] = "00:AA:01:01:00:00";
 static uint32_t remote_get_properties_cod_val = 0;
 static bt_device_type_t remote_get_properties_tod_val = BT_DEVICE_DEVTYPE_BREDR;
 static int32_t remote_get_properties_rssi_val = -60;
@@ -1657,7 +1658,7 @@ static const struct generic_data bt_dev_getprops_success_test = {
 	.expected_adapter_status = BT_STATUS_NOT_EXPECTED,
 };
 
-static char remote_getprop_bdname_val[] = "00:AA:01:01:00:00";
+static const char remote_getprop_bdname_val[] = "00:AA:01:01:00:00";
 
 static struct priority_property remote_getprop_bdname_props[] = {
 	{
@@ -1932,7 +1933,7 @@ static const struct generic_data bt_dev_getprop_fname_fail_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
 };
 
-static char remote_setprop_fname_val[] = "set_fname_test";
+static const char remote_setprop_fname_val[] = "set_fname_test";
 
 static struct priority_property remote_setprop_fname_props[] = {
 	{
@@ -1959,7 +1960,7 @@ static const struct generic_data bt_dev_setprop_fname_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
-static char remote_setprop_bdname_val[] = "setprop_bdname_fail";
+static const char remote_setprop_bdname_val[] = "setprop_bdname_fail";
 
 static struct priority_property remote_setprop_bdname_props[] = {
 	{
@@ -2328,7 +2329,8 @@ static void test_enable(const void *test_data)
 
 	init_test_conditions(data);
 
-	bdaddr2android((const bdaddr_t *)bdaddr, &enable_done_bdaddr_val.address);
+	bdaddr2android((const bdaddr_t *)bdaddr,
+					&enable_done_bdaddr_val.address);
 
 	adapter_status = data->if_bluetooth->enable();
 	check_expected_status(adapter_status);
@@ -2343,7 +2345,8 @@ static void test_enable_done(const void *test_data)
 
 	init_test_conditions(data);
 
-	bdaddr2android((const bdaddr_t *)bdaddr, &enable_done_bdaddr_val.address);
+	bdaddr2android((const bdaddr_t *)bdaddr,
+					&enable_done_bdaddr_val.address);
 
 	adapter_status = data->if_bluetooth->enable();
 	check_expected_status(adapter_status);
@@ -2405,7 +2408,8 @@ static void test_getprop_bdaddr_success(const void *test_data)
 
 	init_test_conditions(data);
 
-	bdaddr2android((const bdaddr_t *)bdaddr, &test_getprop_bdaddr_val.address);
+	bdaddr2android((const bdaddr_t *)bdaddr,
+					&test_getprop_bdaddr_val.address);
 
 	adapter_status = data->if_bluetooth->get_adapter_property(prop.type);
 	check_expected_status(adapter_status);
@@ -3779,7 +3783,6 @@ static void emu_powered_complete(uint16_t opcode, uint8_t status,
 	bt_status = data->if_hid->connect(&bdaddr);
 	if (bt_status != BT_STATUS_SUCCESS)
 		tester_setup_failed();
-
 }
 
 static void setup_hidhost_connect(const void *test_data)
@@ -3978,15 +3981,20 @@ int main(int argc, char *argv[])
 
 	test_bredrle("Bluetooth Init", NULL, setup_base, test_dummy, teardown);
 
-	test_bredrle("Bluetooth Enable - Success", &bluetooth_enable_success_test,
-					setup_base, test_enable, teardown);
+	test_bredrle("Bluetooth Enable - Success",
+						&bluetooth_enable_success_test,
+						setup_base, test_enable,
+						teardown);
 
 	test_bredrle("Bluetooth Enable - Success 2",
-			&bluetooth_enable_success2_test, setup_enabled_adapter,
-			test_enable_done, teardown);
-
-	test_bredrle("Bluetooth Disable - Success", &bluetooth_disable_success_test,
-			setup_enabled_adapter, test_disable, teardown);
+						&bluetooth_enable_success2_test,
+						setup_enabled_adapter,
+						test_enable_done, teardown);
+
+	test_bredrle("Bluetooth Disable - Success",
+						&bluetooth_disable_success_test,
+						setup_enabled_adapter,
+						test_disable, teardown);
 
 	test_bredrle("Bluetooth Set BDNAME - Success",
 					&bluetooth_setprop_bdname_success_test,
-- 
1.8.5.2

