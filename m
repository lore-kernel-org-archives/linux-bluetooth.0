Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] android/tester: Add start device discovery success test case
Date: Thu, 19 Dec 2013 13:42:23 +0100
Message-Id: <1387456946-9743-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1387456946-9743-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1387456946-9743-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add test case for starting device discovery with success.

---
 android/android-tester.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 68614a2..1880cf1 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -68,7 +68,9 @@ enum hal_bluetooth_callbacks_id {
 	ADAPTER_PROP_SCAN_MODE,
 	ADAPTER_PROP_DISC_TIMEOUT,
 	ADAPTER_PROP_SERVICE_RECORD,
-	ADAPTER_PROP_BONDED_DEVICES
+	ADAPTER_PROP_BONDED_DEVICES,
+	ADAPTER_DISCOVERY_STATE_ON,
+	ADAPTER_DISCOVERY_STATE_OFF
 };
 
 struct generic_data {
@@ -527,6 +529,20 @@ static void adapter_state_changed_cb(bt_state_t state)
 	}
 }
 
+static void discovery_state_changed_cb(bt_discovery_state_t state)
+{
+	switch (state) {
+	case BT_DISCOVERY_STARTED:
+		update_hal_cb_list(ADAPTER_DISCOVERY_STATE_ON);
+		break;
+	case BT_DISCOVERY_STOPPED:
+		update_hal_cb_list(ADAPTER_DISCOVERY_STATE_OFF);
+		break;
+	default:
+		break;
+	}
+}
+
 static void adapter_properties_cb(bt_status_t status, int num_properties,
 						bt_property_t *properties)
 {
@@ -702,13 +718,19 @@ static const struct generic_data
 	.expected_property.len = sizeof(setprop_remote_service)
 };
 
+static const struct generic_data bluetooth_discovery_start_success_test = {
+	.expected_hal_callbacks = { ADAPTER_DISCOVERY_STATE_ON,
+							ADAPTER_TEST_END },
+	.expected_adapter_status = BT_STATUS_SUCCESS
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
 	.adapter_properties_cb = adapter_properties_cb,
 	.remote_device_properties_cb = NULL,
 	.device_found_cb = NULL,
-	.discovery_state_changed_cb = NULL,
+	.discovery_state_changed_cb = discovery_state_changed_cb,
 	.pin_request_cb = NULL,
 	.ssp_request_cb = NULL,
 	.bond_state_changed_cb = NULL,
@@ -1230,6 +1252,17 @@ clean:
 		close(sock_fd);
 }
 
+static void test_discovery_start_success(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t status;
+
+	init_test_conditions(data);
+
+	status = data->if_bluetooth->start_discovery();
+	check_expected_status(status);
+}
+
 static gboolean socket_chan_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1401,6 +1434,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_setprop_service_record_invalid, teardown);
 
+	test_bredrle("Bluetooth BREDR Discovery Start - Success",
+				&bluetooth_discovery_start_success_test,
+				setup_enabled_adapter,
+				test_discovery_start_success, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5

