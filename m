Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] android/tester: Add device discovery cancel success test case
Date: Thu, 19 Dec 2013 13:42:25 +0100
Message-Id: <1387456946-9743-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1387456946-9743-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1387456946-9743-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Test for successfull discovery canceling after it was started.

---
 android/android-tester.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 0dae111..737aeb3 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -96,6 +96,9 @@ struct socket_data {
 
 #define BT_STATUS_NOT_EXPECTED	-1
 
+/* User flags for Device Discovery */
+#define DEVICE_DISCOVERY_CANCEL_ON_START	0x01
+
 struct test_data {
 	struct mgmt *mgmt;
 	uint16_t mgmt_index;
@@ -115,6 +118,8 @@ struct test_data {
 
 	bt_property_t test_property;
 	GSList *expected_callbacks;
+
+	uint32_t userflag;
 };
 
 static char exec_dir[PATH_MAX + 1];
@@ -529,11 +534,23 @@ static void adapter_state_changed_cb(bt_state_t state)
 	}
 }
 
+static void post_discovery_started_cb(bt_discovery_state_t state)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t status;
+
+	if (data->userflag & DEVICE_DISCOVERY_CANCEL_ON_START) {
+		status = data->if_bluetooth->cancel_discovery();
+		check_expected_status(status);
+	}
+}
+
 static void discovery_state_changed_cb(bt_discovery_state_t state)
 {
 	switch (state) {
 	case BT_DISCOVERY_STARTED:
 		update_hal_cb_list(ADAPTER_DISCOVERY_STATE_ON);
+		post_discovery_started_cb(state);
 		break;
 	case BT_DISCOVERY_STOPPED:
 		update_hal_cb_list(ADAPTER_DISCOVERY_STATE_OFF);
@@ -729,6 +746,12 @@ static const struct generic_data bluetooth_discovery_stop_done_test = {
 	.expected_adapter_status = BT_STATUS_DONE
 };
 
+static const struct generic_data bluetooth_discovery_stop_success_test = {
+	.expected_hal_callbacks = { ADAPTER_DISCOVERY_STATE_ON,
+				ADAPTER_DISCOVERY_STATE_OFF, ADAPTER_TEST_END },
+	.expected_adapter_status = BT_STATUS_SUCCESS
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -1279,6 +1302,28 @@ static void test_discovery_stop_done(const void *test_data)
 	check_expected_status(status);
 }
 
+static bool pre_inq_compl_hook(const void *data, uint16_t len, void *user_data)
+{
+	/* Make sure Inquiry Command Complete is not called */
+	return false;
+}
+
+static void test_discovery_stop_success(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t status;
+
+	data->userflag = DEVICE_DISCOVERY_CANCEL_ON_START;
+
+	init_test_conditions(data);
+
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT, BT_HCI_CMD_INQUIRY,
+					pre_inq_compl_hook, data);
+
+	status = data->if_bluetooth->start_discovery();
+	check_expected_status(status);
+}
+
 static gboolean socket_chan_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1460,6 +1505,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_discovery_stop_done, teardown);
 
+	test_bredrle("Bluetooth BREDR Discovery Stop - Success",
+				&bluetooth_discovery_stop_success_test,
+				setup_enabled_adapter,
+				test_discovery_stop_success, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5

