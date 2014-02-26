Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 12/17] android/tester: Add discovery cancel test
Date: Wed, 26 Feb 2014 02:57:23 +0100
Message-ID: <1393379848-4031-13-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test a scenario:
1. Start discovery (99 remote devices)
2. Cancel discovery after 11 inquiry results

Test pass if cancel inquiry command hits btdev before all 50 remote
devices is found
---
 android/android-tester.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 6d5638e..c6484bf 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -56,6 +56,8 @@ struct generic_data {
 	bt_callbacks_t expected_hal_cb;
 	struct priority_property *expected_properties;
 	uint8_t expected_properties_num;
+	uint8_t set_num_of_remote;
+	int expected_device_found_num;
 };
 
 struct socket_data {
@@ -408,6 +410,13 @@ static void index_removed_callback(uint16_t index, uint16_t length,
 	tester_post_teardown_complete();
 }
 
+static void enable_and_set_discoverable(gpointer data, gpointer user_data)
+{
+	struct bthost *bthost = ((struct remote_dev *)data)->bthost;
+	bthost_start(bthost);
+	bthost_write_scan_enable(bthost, 0x03);
+}
+
 static void read_index_list_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -643,6 +652,26 @@ static void discovery_stop_success_cb(bt_discovery_state_t state)
 	}
 }
 
+static void discovery_cancel_state_changed_cb(bt_discovery_state_t state)
+{
+	struct test_data *data = tester_get_data();
+
+	if (state == BT_DISCOVERY_STARTED) {
+		data->cb_count--;
+		return;
+	}
+
+	if (state == BT_DISCOVERY_STOPPED)
+		data->cb_count--;
+
+	if (data->cb_count) {
+		tester_test_failed();
+		return;
+	}
+
+	tester_test_passed();
+}
+
 static void discovery_device_found_state_changed_cb(bt_discovery_state_t state)
 {
 	struct test_data *data = tester_get_data();
@@ -695,6 +724,28 @@ static void discovery_state_changed_cb(bt_discovery_state_t state)
 	}
 }
 
+static void device_found_cancel_cb(int num_properties,
+						bt_property_t *properties)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	static int num_resp;
+	int triger_cancel = 11;
+
+	if (num_resp > test->expected_device_found_num)
+		return;
+
+	/* Increase cb_count if we reach bad amount of found devices*/
+	if (num_resp++ == test->expected_device_found_num)
+		data->cb_count++;
+
+	/* It is time to issue cancel discovery */
+	if (num_resp == triger_cancel) {
+		data->cb_count--;
+		data->if_bluetooth->cancel_discovery();
+	}
+}
+
 static void discovery_device_found_cb(int num_properties,
 						bt_property_t *properties)
 {
@@ -1362,6 +1413,16 @@ static const struct generic_data bluetooth_discovery_device_found_test = {
 	.expected_adapter_status = BT_STATUS_NOT_EXPECTED,
 };
 
+static const struct generic_data bluetooth_discovery_cancel_test = {
+	.expected_hal_cb.discovery_state_changed_cb =
+					discovery_cancel_state_changed_cb,
+	.expected_hal_cb.device_found_cb = device_found_cancel_cb,
+	.set_num_of_remote = 98,
+	.expected_device_found_num = 50,
+	.expected_cb_count = 4,
+	.expected_adapter_status = BT_STATUS_NOT_EXPECTED,
+};
+
 static char remote_get_properties_bdname_val[] = "00:AA:01:01:00:00";
 static uint32_t remote_get_properties_cod_val = 0;
 static bt_device_type_t remote_get_properties_tod_val = BT_DEVICE_DEVTYPE_BREDR;
@@ -2052,6 +2113,25 @@ static void setup_enabled_adapter(const void *test_data)
 		tester_setup_failed();
 }
 
+static void setup_enable_adapter_add_remote(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = test_data;
+	GList *l;
+	int i;
+
+	/* Setup some more remote devices if needed */
+	i = hciemu_add_remote_devs(data->hciemu, test->set_num_of_remote);
+	if (i != test->set_num_of_remote)
+		tester_setup_failed();
+
+	tester_print("Created %d remote devices", i);
+	l = hciemu_get_remote_devs(data->hciemu);
+	g_list_foreach(l, enable_and_set_discoverable, NULL);
+
+	setup_enabled_adapter(test_data);
+}
+
 static void teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -2406,6 +2486,18 @@ static bool pre_inq_compl_hook(const void *dummy, uint16_t len, void *user_data)
 	return false;
 }
 
+static bool post_inq_cancel_hook(const void *dummy, uint16_t len,
+							void *user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	hciemu_del_hook(data->hciemu, HCIEMU_HOOK_POST_CMD,
+						BT_HCI_CMD_INQUIRY_CANCEL);
+
+	data->cb_count--;
+	return true;
+}
+
 static void test_discovery_stop_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -2430,6 +2522,20 @@ static void test_discovery_start_done(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_discovery_device_cancel(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	init_test_conditions(data);
+
+	/* Need this hook to check if inquiry cancel reached btdev */
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_CMD,
+						BT_HCI_CMD_INQUIRY_CANCEL,
+						post_inq_cancel_hook, data);
+
+	data->if_bluetooth->start_discovery();
+}
+
 static void test_discovery_device_found(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -3764,6 +3870,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_discovery_device_found, teardown);
 
+	test_bredrle("Bluetooth BR/EDR Discovery Cancel",
+				&bluetooth_discovery_cancel_test,
+				setup_enable_adapter_add_remote,
+				test_discovery_device_cancel, teardown);
+
 	test_bredrle("Bluetooth Device Get Props - Success",
 					&bt_dev_getprops_success_test,
 					setup_enabled_adapter,
-- 
1.8.4

