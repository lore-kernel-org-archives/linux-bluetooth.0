Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/10] android/tester: Coding style and syntax fix
Date: Thu, 23 Jan 2014 17:57:29 +0100
Message-Id: <1390496258-5480-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove white spaces, break lines over 80 characters, redundand braces
for single statement blocks.
---
 android/android-tester.c | 51 ++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 9a17612..4bd48d6 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -690,9 +690,8 @@ static void discovery_state_changed_cb(bt_discovery_state_t state)
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
 
-	if (test && test->expected_hal_cb.discovery_state_changed_cb) {
+	if (test && test->expected_hal_cb.discovery_state_changed_cb)
 		test->expected_hal_cb.discovery_state_changed_cb(state);
-	}
 }
 
 static void discovery_device_found_cb(int num_properties,
@@ -837,10 +836,9 @@ static void device_found_cb(int num_properties, bt_property_t *properties)
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
 
-	if (data->test_init_done && test->expected_hal_cb.device_found_cb) {
+	if (data->test_init_done && test->expected_hal_cb.device_found_cb)
 		test->expected_hal_cb.device_found_cb(num_properties,
 								properties);
-	}
 }
 
 static void check_count_properties_cb(bt_status_t status, int num_properties,
@@ -852,7 +850,6 @@ static void check_count_properties_cb(bt_status_t status, int num_properties,
 		check_expected_property(properties[i]);
 }
 
-
 static void adapter_properties_cb(bt_status_t status, int num_properties,
 						bt_property_t *properties)
 {
@@ -860,11 +857,9 @@ static void adapter_properties_cb(bt_status_t status, int num_properties,
 	const struct generic_data *test = data->test_data;
 
 	if (data->test_init_done &&
-				test->expected_hal_cb.adapter_properties_cb) {
-		test->expected_hal_cb.adapter_properties_cb(
-							status, num_properties,
-							properties);
-	}
+				test->expected_hal_cb.adapter_properties_cb)
+		test->expected_hal_cb.adapter_properties_cb(status,
+						num_properties, properties);
 }
 
 static void remote_test_device_properties_cb(bt_status_t status,
@@ -908,10 +903,9 @@ static void remote_device_properties_cb(bt_status_t status,
 	const struct generic_data *test = data->test_data;
 
 	if (data->test_init_done &&
-			test->expected_hal_cb.remote_device_properties_cb) {
+			test->expected_hal_cb.remote_device_properties_cb)
 		test->expected_hal_cb.remote_device_properties_cb(status,
 					bd_addr, num_properties, properties);
-	}
 }
 
 static bt_bdaddr_t enable_done_bdaddr_val = { {0x00} };
@@ -1324,7 +1318,8 @@ static struct priority_property setprop_scanmode_none_props[] = {
 	},
 };
 
-static const struct generic_data bluetooth_setprop_scanmode_none_success2_test = {
+static const struct generic_data
+			bluetooth_setprop_scanmode_none_success2_test = {
 	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
 	.expected_properties_num = 1,
 	.expected_properties = setprop_scanmode_none_props,
@@ -1951,7 +1946,6 @@ static bt_callbacks_t bt_callbacks = {
 	.le_test_mode_cb = NULL
 };
 
-
 static void setup(struct test_data *data)
 {
 	const hw_module_t *module;
@@ -2093,7 +2087,8 @@ static void test_enable(const void *test_data)
 
 	init_test_conditions(data);
 
-	bdaddr2android((const bdaddr_t *)bdaddr, &enable_done_bdaddr_val.address);
+	bdaddr2android((const bdaddr_t *)bdaddr,
+					&enable_done_bdaddr_val.address);
 
 	adapter_status = data->if_bluetooth->enable();
 	check_expected_status(adapter_status);
@@ -2108,7 +2103,8 @@ static void test_enable_done(const void *test_data)
 
 	init_test_conditions(data);
 
-	bdaddr2android((const bdaddr_t *)bdaddr, &enable_done_bdaddr_val.address);
+	bdaddr2android((const bdaddr_t *)bdaddr,
+					&enable_done_bdaddr_val.address);
 
 	adapter_status = data->if_bluetooth->enable();
 	check_expected_status(adapter_status);
@@ -2170,7 +2166,8 @@ static void test_getprop_bdaddr_success(const void *test_data)
 
 	init_test_conditions(data);
 
-	bdaddr2android((const bdaddr_t *)bdaddr, &test_getprop_bdaddr_val.address);
+	bdaddr2android((const bdaddr_t *)bdaddr,
+					&test_getprop_bdaddr_val.address);
 
 	adapter_status = data->if_bluetooth->get_adapter_property(prop.type);
 	check_expected_status(adapter_status);
@@ -3374,7 +3371,6 @@ static void emu_powered_complete(uint16_t opcode, uint8_t status,
 	bt_status = data->if_hid->connect(&bdaddr);
 	if (bt_status != BT_STATUS_SUCCESS)
 		tester_setup_failed();
-
 }
 
 static void setup_hidhost_connect(const void *test_data)
@@ -3535,15 +3531,20 @@ int main(int argc, char *argv[])
 
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

