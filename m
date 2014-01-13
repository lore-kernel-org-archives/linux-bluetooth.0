Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/15] android/tester: Add get remote properties success test case
Date: Mon, 13 Jan 2014 18:12:28 +0100
Message-Id: <1389633161-11357-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1389633161-11357-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1389633161-11357-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds remote properties success test case.
---
 android/android-tester.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 127 insertions(+), 1 deletion(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 0e34117..c051200 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -631,6 +631,21 @@ static void discovery_device_found_state_changed_cb(bt_discovery_state_t state)
 	}
 }
 
+static void remote_discovery_state_changed_cb(
+						bt_discovery_state_t state)
+{
+	struct test_data *data = tester_get_data();
+
+	if (state == BT_DISCOVERY_STARTED && data->cb_count == 3) {
+		data->cb_count--;
+		return;
+	}
+	if (state == BT_DISCOVERY_STOPPED && data->cb_count == 1) {
+		data->cb_count--;
+		check_cb_count();
+	}
+}
+
 static void discovery_state_changed_cb(bt_discovery_state_t state)
 {
 	struct test_data *data = tester_get_data();
@@ -700,6 +715,21 @@ static void discovery_device_found_cb(int num_properties,
 	}
 }
 
+static void remote_get_properties_device_found_cb(int num_properties,
+						bt_property_t *properties)
+{
+	struct test_data *data = tester_get_data();
+	uint8_t *bdaddr = (uint8_t *)hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t remote_addr;
+
+	bdaddr2android((const bdaddr_t *)bdaddr, &remote_addr.address);
+
+	if (data->cb_count == 2)
+		data->cb_count--;
+
+	data->if_bluetooth->get_remote_device_properties(&remote_addr);
+}
+
 static void device_found_cb(int num_properties, bt_property_t *properties)
 {
 	struct test_data *data = tester_get_data();
@@ -735,6 +765,30 @@ static void adapter_properties_cb(bt_status_t status, int num_properties,
 	}
 }
 
+static void remote_test_device_properties_cb(
+				bt_status_t status, bt_bdaddr_t *bd_addr,
+				int num_properties, bt_property_t *properties)
+{
+	int i;
+
+	for (i = 0; i < num_properties; i++)
+		check_expected_property(properties[i]);
+}
+
+static void remote_device_properties_cb(bt_status_t status,
+				bt_bdaddr_t *bd_addr, int num_properties,
+				bt_property_t *properties)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+
+	if (data->test_init_done &&
+			test->expected_hal_cb.remote_device_properties_cb) {
+		test->expected_hal_cb.remote_device_properties_cb(status,
+					bd_addr, num_properties, properties);
+	}
+}
+
 static bt_bdaddr_t enable_done_bdaddr_val = { {0x00} };
 static const char enable_done_bdname_val[] = "BlueZ for Android";
 static bt_uuid_t enable_done_uuids_val = {
@@ -1183,11 +1237,69 @@ static const struct generic_data bluetooth_discovery_device_found_test = {
 	.expected_adapter_status = BT_STATUS_NOT_EXPECTED,
 };
 
+static const char remote_get_properties_bdname_val[] = "00:AA:01:01:00:00";
+static uint32_t remote_get_properties_cod_val = 0;
+static bt_device_type_t remote_get_properties_tod_val = BT_DEVICE_DEVTYPE_BREDR;
+static int32_t remote_get_properties_rssi_val = -60;
+
+static struct priority_property remote_get_properties_props[] = {
+	{
+	.prop.type = BT_PROPERTY_BDNAME,
+	.prop.val = &remote_get_properties_bdname_val,
+	.prop.len = sizeof(remote_get_properties_bdname_val) - 1,
+	.prio = 1,
+	},
+	{
+	.prop.type = BT_PROPERTY_UUIDS,
+	.prop.val = NULL,
+	.prop.len = 0,
+	.prio = 2,
+	},
+	{
+	.prop.type = BT_PROPERTY_CLASS_OF_DEVICE,
+	.prop.val = &remote_get_properties_cod_val,
+	.prop.len = sizeof(remote_get_properties_cod_val),
+	.prio = 3,
+	},
+	{
+	.prop.type = BT_PROPERTY_TYPE_OF_DEVICE,
+	.prop.val = &remote_get_properties_tod_val,
+	.prop.len = sizeof(remote_get_properties_tod_val),
+	.prio = 4,
+	},
+	{
+	.prop.type = BT_PROPERTY_REMOTE_RSSI,
+	.prop.val = &remote_get_properties_rssi_val,
+	.prop.len = sizeof(remote_get_properties_rssi_val),
+	.prio = 5,
+	},
+	{
+	.prop.type = BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP,
+	.prop.val = NULL,
+	.prop.len = 4,
+	.prio = 6,
+	},
+};
+
+static const struct generic_data
+				bluetooth_remote_get_properties_success_test = {
+	.expected_hal_cb.discovery_state_changed_cb =
+					remote_discovery_state_changed_cb,
+	.expected_hal_cb.device_found_cb =
+					remote_get_properties_device_found_cb,
+	.expected_hal_cb.remote_device_properties_cb =
+					remote_test_device_properties_cb,
+	.expected_cb_count = 3,
+	.expected_properties_num = 6,
+	.expected_properties = remote_get_properties_props,
+	.expected_adapter_status = BT_STATUS_NOT_EXPECTED,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
 	.adapter_properties_cb = adapter_properties_cb,
-	.remote_device_properties_cb = NULL,
+	.remote_device_properties_cb = remote_device_properties_cb,
 	.device_found_cb = device_found_cb,
 	.discovery_state_changed_cb = discovery_state_changed_cb,
 	.pin_request_cb = NULL,
@@ -1696,6 +1808,15 @@ static void test_discovery_device_found(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_remote_get_properties_success(const void *test_data)
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
@@ -2297,6 +2418,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_discovery_device_found, teardown);
 
+	test_bredrle("Bluetooth RemDev Get Properties - Success",
+				&bluetooth_remote_get_properties_success_test,
+				setup_enabled_adapter,
+				test_remote_get_properties_success, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

