Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 19/19] android/android-tester: Remove test cases replaced by tester-ng
Date: Thu,  3 Jul 2014 18:00:22 +0200
Message-Id: <1404403222-26911-20-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Enable, Enable done, Disable, set bdname, discovery timeout, scan mode
test cases are no longer needed in android-tester because of
android-tester-ng test rewrite.
---
 android/android-tester.c | 248 -----------------------------------------------
 1 file changed, 248 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index bf39517..8b67db9 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -706,27 +706,6 @@ static void setup_powered_emulated_remote(void)
 		bthost_write_scan_enable(bthost, 0x03);
 }
 
-static void enable_success_cb(bt_state_t state)
-{
-	struct test_data *data = tester_get_data();
-
-	if (state == BT_STATE_ON) {
-		setup_powered_emulated_remote();
-		data->cb_count--;
-		check_cb_count();
-	}
-}
-
-static void disable_success_cb(bt_state_t state)
-{
-	struct test_data *data = tester_get_data();
-
-	if (state == BT_STATE_OFF) {
-		data->cb_count--;
-		check_cb_count();
-	}
-}
-
 static gboolean adapter_state_changed(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1406,110 +1385,6 @@ static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
 	g_idle_add(ssp_request, cb_data);
 }
 
-static bt_bdaddr_t enable_done_bdaddr_val = { {0x00} };
-static const char enable_done_bdname_val[] = "BlueZ for Android";
-static const char enable_done_uuids_val[] = {
-	/* Multi profile UUID */
-	0x00, 0x00, 0x11, 0x3b, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
-					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB,
-	/* Device identification profile UUID */
-	0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
-					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB,
-};
-static bt_device_type_t enable_done_tod_val = BT_DEVICE_DEVTYPE_DUAL;
-static bt_scan_mode_t enable_done_scanmode_val = BT_SCAN_MODE_NONE;
-static uint32_t enable_done_disctimeout_val = 120;
-
-static struct priority_property enable_done_props[] = {
-	{
-	.prop.type = BT_PROPERTY_BDADDR,
-	.prop.len = sizeof(enable_done_bdaddr_val),
-	.prop.val = &enable_done_bdaddr_val,
-	.prio = 1,
-	},
-	{
-	.prop.type = BT_PROPERTY_BDNAME,
-	.prop.len = sizeof(enable_done_bdname_val) - 1,
-	.prop.val = &enable_done_bdname_val,
-	.prio = 2,
-	},
-	{
-	.prop.type = BT_PROPERTY_UUIDS,
-	.prop.len = sizeof(enable_done_uuids_val),
-	.prop.val = &enable_done_uuids_val,
-	.prio = 2,
-	},
-	{
-	.prop.type = BT_PROPERTY_CLASS_OF_DEVICE,
-	.prop.len = sizeof(uint32_t),
-	.prop.val = NULL,
-	.prio = 2,
-	},
-	{
-	.prop.type = BT_PROPERTY_TYPE_OF_DEVICE,
-	.prop.len = sizeof(enable_done_tod_val),
-	.prop.val = &enable_done_tod_val,
-	.prio = 2,
-	},
-	{
-	.prop.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
-	.prop.len = sizeof(enable_done_scanmode_val),
-	.prop.val = &enable_done_scanmode_val,
-	.prio = 2,
-	},
-	{
-	.prop.type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
-	.prop.len = 0,
-	.prop.val = NULL,
-	.prio = 2,
-	},
-	{
-	.prop.type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
-	.prop.len = sizeof(enable_done_disctimeout_val),
-	.prop.val = &enable_done_disctimeout_val,
-	.prio = 2,
-	},
-};
-
-static const struct generic_data bluetooth_enable_success_test = {
-	.expected_hal_cb.adapter_state_changed_cb = enable_success_cb,
-	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
-	.expected_cb_count = 1,
-	.expected_properties_num = 8,
-	.expected_properties = enable_done_props,
-	.expected_adapter_status = BT_STATUS_SUCCESS,
-};
-
-static const struct generic_data bluetooth_enable_success2_test = {
-	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
-	.expected_adapter_status = BT_STATUS_SUCCESS,
-	.expected_properties_num = 8,
-	.expected_properties = enable_done_props,
-};
-
-static const struct generic_data bluetooth_disable_success_test = {
-	.expected_hal_cb.adapter_state_changed_cb = disable_success_cb,
-	.expected_cb_count = 1,
-	.expected_adapter_status = BT_STATUS_SUCCESS,
-};
-
-static char test_set_bdname[] = "test_bdname_set";
-
-static struct priority_property setprop_bdname_props[] = {
-	{
-	.prop.type = BT_PROPERTY_BDNAME,
-	.prop.val = test_set_bdname,
-	.prop.len = sizeof(test_set_bdname) - 1,
-	.prio = 0,
-	},
-};
-
-static const struct generic_data bluetooth_setprop_bdname_success_test = {
-	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
-	.expected_properties_num = 1,
-	.expected_properties = setprop_bdname_props,
-};
-
 static bt_scan_mode_t test_setprop_scanmode_val =
 					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE;
 
@@ -1521,13 +1396,6 @@ static struct priority_property setprop_scanmode_props[] = {
 	},
 };
 
-static const struct generic_data bluetooth_setprop_scanmode_success_test = {
-	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
-	.expected_properties_num = 1,
-	.expected_properties = setprop_scanmode_props,
-	.expected_adapter_status = BT_STATUS_SUCCESS,
-};
-
 static uint32_t test_setprop_disctimeout_val = 120;
 
 static struct priority_property setprop_disctimeout_props[] = {
@@ -1538,13 +1406,6 @@ static struct priority_property setprop_disctimeout_props[] = {
 	},
 };
 
-static const struct generic_data bluetooth_setprop_disctimeout_success_test = {
-	.expected_hal_cb.adapter_properties_cb = check_count_properties_cb,
-	.expected_properties_num = 1,
-	.expected_properties = setprop_disctimeout_props,
-	.expected_adapter_status = BT_STATUS_SUCCESS,
-};
-
 static bt_bdaddr_t test_getprop_bdaddr_val = { {0x00} };
 
 static struct priority_property getprop_bdaddr_props[] = {
@@ -2639,85 +2500,6 @@ static void test_dummy(const void *test_data)
 	tester_test_passed();
 }
 
-static void test_enable(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	bt_status_t adapter_status;
-
-	uint8_t *bdaddr = (uint8_t *)hciemu_get_master_bdaddr(data->hciemu);
-
-	init_test_conditions(data);
-
-	bdaddr2android((const bdaddr_t *)bdaddr,
-					&enable_done_bdaddr_val.address);
-
-	adapter_status = data->if_bluetooth->enable();
-	check_expected_status(adapter_status);
-}
-
-static void test_enable_done(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	bt_status_t adapter_status;
-
-	uint8_t *bdaddr = (uint8_t *)hciemu_get_master_bdaddr(data->hciemu);
-
-	init_test_conditions(data);
-
-	bdaddr2android((const bdaddr_t *)bdaddr,
-					&enable_done_bdaddr_val.address);
-
-	adapter_status = data->if_bluetooth->enable();
-	check_expected_status(adapter_status);
-}
-
-static void test_disable(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	bt_status_t adapter_status;
-
-	init_test_conditions(data);
-
-	adapter_status = data->if_bluetooth->disable();
-	check_expected_status(adapter_status);
-}
-
-static void test_setprop_bdname_success(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	const bt_property_t *prop = &(setprop_bdname_props[0].prop);
-	bt_status_t adapter_status;
-
-	init_test_conditions(data);
-
-	adapter_status = data->if_bluetooth->set_adapter_property(prop);
-	check_expected_status(adapter_status);
-}
-
-static void test_setprop_scanmode_succes(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	const bt_property_t *prop = &(setprop_scanmode_props[0].prop);
-	bt_status_t adapter_status;
-
-	init_test_conditions(data);
-
-	adapter_status = data->if_bluetooth->set_adapter_property(prop);
-	check_expected_status(adapter_status);
-}
-
-static void test_setprop_disctimeout_succes(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	const bt_property_t *prop = &(setprop_disctimeout_props[0].prop);
-	bt_status_t adapter_status;
-
-	init_test_conditions(data);
-
-	adapter_status = data->if_bluetooth->set_adapter_property(prop);
-	check_expected_status(adapter_status);
-}
-
 static void test_getprop_bdaddr_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -4431,36 +4213,6 @@ int main(int argc, char *argv[])
 
 	test_bredrle("Bluetooth Init", NULL, setup_base, test_dummy, teardown);
 
-	test_bredrle("Bluetooth Enable - Success",
-						&bluetooth_enable_success_test,
-						setup_base, test_enable,
-						teardown);
-
-	test_bredrle("Bluetooth Enable - Success 2",
-						&bluetooth_enable_success2_test,
-						setup_enabled_adapter,
-						test_enable_done, teardown);
-
-	test_bredrle("Bluetooth Disable - Success",
-						&bluetooth_disable_success_test,
-						setup_enabled_adapter,
-						test_disable, teardown);
-
-	test_bredrle("Bluetooth Set BDNAME - Success",
-					&bluetooth_setprop_bdname_success_test,
-					setup_enabled_adapter,
-					test_setprop_bdname_success, teardown);
-
-	test_bredrle("Bluetooth Set SCAN_MODE - Success",
-				&bluetooth_setprop_scanmode_success_test,
-				setup_enabled_adapter,
-				test_setprop_scanmode_succes, teardown);
-
-	test_bredrle("Bluetooth Set DISCOVERY_TIMEOUT - Success",
-				&bluetooth_setprop_disctimeout_success_test,
-				setup_enabled_adapter,
-				test_setprop_disctimeout_succes, teardown);
-
 	test_bredrle("Bluetooth Get BDADDR - Success",
 					&bluetooth_getprop_bdaddr_success_test,
 					setup_enabled_adapter,
-- 
1.9.3

