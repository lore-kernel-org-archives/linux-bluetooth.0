Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/tester: Add remote device found success test case
Date: Fri, 20 Dec 2013 13:57:46 +0100
Message-Id: <1387544266-3159-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add checking for remote device being found.

---
 android/android-tester.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 2 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 3fbcb2f..9a5824c 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -70,7 +70,8 @@ enum hal_bluetooth_callbacks_id {
 	ADAPTER_PROP_SERVICE_RECORD,
 	ADAPTER_PROP_BONDED_DEVICES,
 	ADAPTER_DISCOVERY_STATE_ON,
-	ADAPTER_DISCOVERY_STATE_OFF
+	ADAPTER_DISCOVERY_STATE_OFF,
+	REMOTE_DEVICE_FOUND
 };
 
 struct generic_data {
@@ -141,6 +142,32 @@ static void test_update_state(void)
 	tester_test_passed();
 }
 
+static void test_device_property(bt_property_t *property,
+			bt_property_type_t type, const void *value, int len)
+{
+	if (value == NULL) {
+		tester_warn("NULL property passed");
+		tester_test_failed();
+	}
+
+	if (property->type != type) {
+		tester_warn("Wrong remote property type %d, expected %d",
+							type, property->type);
+		tester_test_failed();
+	}
+
+	if (property->len != len) {
+		tester_warn("Wrong remote property len %d, expected %d",
+							len, property->len);
+		tester_test_failed();
+	}
+
+	if (memcmp(property->val, value, len)) {
+		tester_warn("Wrong remote property value");
+		tester_test_failed();
+	}
+}
+
 static void test_mgmt_settings_set(struct test_data *data)
 {
 	data->mgmt_settings_set = true;
@@ -567,6 +594,55 @@ static void discovery_state_changed_cb(bt_discovery_state_t state)
 	}
 }
 
+static void device_found_cb(int num_properties, bt_property_t *properties)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *remote_bdaddr =
+					hciemu_get_client_bdaddr(data->hciemu);
+	const uint32_t emu_remote_type = BT_DEVICE_DEVTYPE_BREDR;
+	const int32_t emu_remote_rssi = -60;
+	bt_bdaddr_t emu_remote_bdaddr;
+	int i;
+
+	update_hal_cb_list(REMOTE_DEVICE_FOUND);
+
+	if (num_properties < 1)
+		tester_test_failed();
+
+	bdaddr2android((const bdaddr_t *) remote_bdaddr, &emu_remote_bdaddr);
+
+	for (i = 0; i < num_properties; i++) {
+		int prop_len;
+		const void *prop_data;
+
+		switch (properties[i].type) {
+		case BT_PROPERTY_BDADDR:
+			prop_len = sizeof(emu_remote_bdaddr);
+			prop_data = &emu_remote_bdaddr;
+
+			break;
+		case BT_PROPERTY_TYPE_OF_DEVICE:
+			prop_len = sizeof(emu_remote_type);
+			prop_data = &emu_remote_type;
+
+			break;
+		case BT_PROPERTY_REMOTE_RSSI:
+			prop_len = sizeof(emu_remote_rssi);
+			prop_data = &emu_remote_rssi;
+
+			break;
+		default:
+			prop_len = 0;
+			prop_data = NULL;
+
+			break;
+		}
+
+		test_device_property(&properties[i], properties[i].type,
+							prop_data, prop_len);
+	}
+}
+
 static void adapter_properties_cb(bt_status_t status, int num_properties,
 						bt_property_t *properties)
 {
@@ -765,12 +841,20 @@ static const struct generic_data bluetooth_discovery_stop_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS
 };
 
+static const struct generic_data bluetooth_discovery_device_found_test = {
+	.expected_hal_callbacks = { ADAPTER_DISCOVERY_STATE_ON,
+						REMOTE_DEVICE_FOUND,
+						ADAPTER_DISCOVERY_STATE_OFF,
+						ADAPTER_TEST_END },
+	.expected_adapter_status = BT_STATUS_NOT_EXPECTED
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
 	.adapter_properties_cb = adapter_properties_cb,
 	.remote_device_properties_cb = NULL,
-	.device_found_cb = NULL,
+	.device_found_cb = device_found_cb,
 	.discovery_state_changed_cb = discovery_state_changed_cb,
 	.pin_request_cb = NULL,
 	.ssp_request_cb = NULL,
@@ -1409,6 +1493,15 @@ static void test_discovery_start_done(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_discovery_device_found(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	init_test_conditions(data);
+
+	data->if_bluetooth->start_discovery();
+}
+
 static gboolean socket_chan_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1600,6 +1693,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_discovery_stop_success, teardown);
 
+	test_bredrle("Bluetooth BREDR Discovery Device Found",
+				&bluetooth_discovery_device_found_test,
+				setup_enabled_adapter,
+				test_discovery_device_found, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5

