Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/12] android/tester: Add set device FRIENDLY_NAME prop success test case
Date: Wed, 15 Jan 2014 13:16:57 +0100
Message-Id: <1389788228-32195-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds set device FRIENDLY NAME property success test case.
---
 android/android-tester.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 030111b..27f436f 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -653,6 +653,20 @@ static void remote_discovery_state_changed_cb(bt_discovery_state_t state)
 	}
 }
 
+static void remote_setprop_disc_state_changed_cb(bt_discovery_state_t state)
+{
+	struct test_data *data = tester_get_data();
+
+	if (state == BT_DISCOVERY_STARTED && data->cb_count == 4) {
+		data->cb_count--;
+		return;
+	}
+	if (state == BT_DISCOVERY_STOPPED) {
+		data->cb_count--;
+		check_cb_count();
+	}
+}
+
 static void discovery_state_changed_cb(bt_discovery_state_t state)
 {
 	struct test_data *data = tester_get_data();
@@ -758,6 +772,27 @@ static void remote_get_property_device_found_cb(int num_properties,
 	check_expected_status(status);
 }
 
+static void remote_setprop_device_found_cb(int num_properties,
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
+	if (data->cb_count == 3)
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
@@ -803,6 +838,29 @@ static void remote_test_device_properties_cb(bt_status_t status,
 		check_expected_property(properties[i]);
 }
 
+static void remote_setprop_device_properties_cb(bt_status_t status,
+				bt_bdaddr_t *bd_addr, int num_properties,
+				bt_property_t *properties)
+{
+	int i;
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	uint8_t *bdaddr = (uint8_t *)hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t remote_addr;
+	const bt_property_t prop = test->expected_properties[1].prop;
+
+	for (i = 0; i < num_properties; i++)
+		check_expected_property(properties[i]);
+
+	if (g_slist_length(data->expected_properties_list) == 1) {
+		bdaddr2android((const bdaddr_t *)bdaddr, &remote_addr.address);
+		data->cb_count--;
+		check_cb_count();
+		data->if_bluetooth->get_remote_device_property(&remote_addr,
+								prop.type);
+	}
+}
+
 static void remote_device_properties_cb(bt_status_t status,
 				bt_bdaddr_t *bd_addr, int num_properties,
 				bt_property_t *properties)
@@ -1596,6 +1654,33 @@ static const struct generic_data bt_dev_getprop_fname_fail_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
 };
 
+static const char remote_setprop_fname_val[] = "set_fname_test";
+
+static struct priority_property remote_setprop_fname_props[] = {
+	{
+	.prop.type = BT_PROPERTY_REMOTE_FRIENDLY_NAME,
+	.prop.val = &remote_setprop_fname_val,
+	.prop.len = sizeof(remote_setprop_fname_val) - 1,
+	},
+	{
+	.prop.type = BT_PROPERTY_REMOTE_FRIENDLY_NAME,
+	.prop.val = &remote_setprop_fname_val,
+	.prop.len = sizeof(remote_setprop_fname_val) - 1,
+	},
+};
+
+static const struct generic_data bt_dev_setprop_fname_success_test = {
+	.expected_hal_cb.discovery_state_changed_cb =
+					remote_setprop_disc_state_changed_cb,
+	.expected_hal_cb.device_found_cb = remote_setprop_device_found_cb,
+	.expected_hal_cb.remote_device_properties_cb =
+					remote_setprop_device_properties_cb,
+	.expected_cb_count = 4,
+	.expected_properties_num = 2,
+	.expected_properties = remote_setprop_fname_props,
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -2235,6 +2320,15 @@ static void test_dev_getprop_fname_fail(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_dev_setprop_fname_success(const void *test_data)
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
@@ -2907,6 +3001,11 @@ int main(int argc, char *argv[])
 					setup_enabled_adapter,
 					test_dev_getprop_fname_fail, teardown);
 
+	test_bredrle("Bluetooth Device Set FRIENDLY_NAME - Success",
+				&bt_dev_setprop_fname_success_test,
+				setup_enabled_adapter,
+				test_dev_setprop_fname_success, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

