Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/12] android/tester: Add set device BDNAME prop fail test case
Date: Wed, 15 Jan 2014 13:16:58 +0100
Message-Id: <1389788228-32195-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1389788228-32195-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1389788228-32195-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds set device BDNAME property fail test case.
---
 android/android-tester.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 27f436f..60371e4 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -793,6 +793,27 @@ static void remote_setprop_device_found_cb(int num_properties,
 	check_expected_status(status);
 }
 
+static void remote_setprop_fail_device_found_cb(int num_properties,
+						bt_property_t *properties)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	bt_status_t status;
+	uint8_t *bdaddr = (uint8_t *)hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t remote_addr;
+
+	const bt_property_t prop = test->expected_properties[0].prop;
+
+	bdaddr2android((const bdaddr_t *)bdaddr, &remote_addr.address);
+
+	if (data->cb_count == 2)
+		data->cb_count--;
+
+	status = data->if_bluetooth->set_remote_device_property(&remote_addr,
+									&prop);
+	check_expected_status(status);
+}
+
 static void device_found_cb(int num_properties, bt_property_t *properties)
 {
 	struct test_data *data = tester_get_data();
@@ -1681,6 +1702,25 @@ static const struct generic_data bt_dev_setprop_fname_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
+static const char remote_setprop_bdname_val[] = "setprop_bdname_fail";
+
+static struct priority_property remote_setprop_bdname_props[] = {
+	{
+	.prop.type = BT_PROPERTY_BDNAME,
+	.prop.val = &remote_setprop_bdname_val,
+	.prop.len = sizeof(remote_setprop_bdname_val) - 1,
+	},
+};
+
+static const struct generic_data bt_dev_setprop_bdname_fail_test = {
+	.expected_hal_cb.discovery_state_changed_cb =
+					remote_discovery_state_changed_cb,
+	.expected_hal_cb.device_found_cb = remote_setprop_fail_device_found_cb,
+	.expected_cb_count = 3,
+	.expected_properties = remote_setprop_bdname_props,
+	.expected_adapter_status = BT_STATUS_FAIL,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -2329,6 +2369,15 @@ static void test_dev_setprop_fname_success(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_dev_setprop_bdname_fail(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	init_test_conditions(data);
+
+	data->if_bluetooth->start_discovery();
+}
+
 /* Test Socket HAL */
 
 static void adapter_socket_state_changed_cb(bt_state_t state)
@@ -3006,6 +3055,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_dev_setprop_fname_success, teardown);
 
+	test_bredrle("Bluetooth Device Set BDNAME - Fail",
+					&bt_dev_setprop_bdname_fail_test,
+					setup_enabled_adapter,
+					test_dev_setprop_bdname_fail, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

