Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/15] android/tester: Add get remote BDNAME property success test case
Date: Mon, 13 Jan 2014 18:12:29 +0100
Message-Id: <1389633161-11357-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1389633161-11357-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1389633161-11357-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds remote BDNAME property success test case.
---
 android/android-tester.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index c051200..674d3f6 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -730,6 +730,25 @@ static void remote_get_properties_device_found_cb(int num_properties,
 	data->if_bluetooth->get_remote_device_properties(&remote_addr);
 }
 
+static void remote_get_property_device_found_cb(int num_properties, bt_property_t *properties)
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
+	status = data->if_bluetooth->get_remote_device_property(&remote_addr, prop.type);
+	check_expected_status(status);
+}
+
 static void device_found_cb(int num_properties, bt_property_t *properties)
 {
 	struct test_data *data = tester_get_data();
@@ -1295,6 +1314,29 @@ static const struct generic_data
 	.expected_adapter_status = BT_STATUS_NOT_EXPECTED,
 };
 
+static char remote_getprop_bdname_val[] = "00:AA:01:01:00:00";
+
+static struct priority_property remote_getprop_bdname_props[] = {
+	{
+	.prop.type = BT_PROPERTY_BDNAME,
+	.prop.val = &remote_getprop_bdname_val,
+	.prop.len = sizeof(remote_getprop_bdname_val) - 1,
+	},
+};
+
+static const struct generic_data
+				bluetooth_remote_getprop_bdname_success_test = {
+	.expected_hal_cb.discovery_state_changed_cb =
+					remote_discovery_state_changed_cb,
+	.expected_hal_cb.device_found_cb = remote_get_property_device_found_cb,
+	.expected_hal_cb.remote_device_properties_cb =
+					remote_test_device_properties_cb,
+	.expected_cb_count = 3,
+	.expected_properties_num = 1,
+	.expected_properties = remote_getprop_bdname_props,
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -1817,6 +1859,15 @@ static void test_remote_get_properties_success(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_remote_getprop_bdname__success(const void *test_data)
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
@@ -2423,6 +2474,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_remote_get_properties_success, teardown);
 
+	test_bredrle("Bluetooth RemDev Get BDNAME- Success",
+				&bluetooth_remote_getprop_bdname_success_test,
+				setup_enabled_adapter,
+				test_remote_getprop_bdname__success, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

