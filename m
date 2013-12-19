Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] android/tester: Add start device discovery done test case
Date: Thu, 19 Dec 2013 13:42:26 +0100
Message-Id: <1387456946-9743-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1387456946-9743-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1387456946-9743-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This tests device discovery start being reported as done because of
ongoing discovery.

---
 android/android-tester.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 737aeb3..aa0c155 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -98,6 +98,7 @@ struct socket_data {
 
 /* User flags for Device Discovery */
 #define DEVICE_DISCOVERY_CANCEL_ON_START	0x01
+#define DEVICE_DISCOVERY_START_ON_START		0x02
 
 struct test_data {
 	struct mgmt *mgmt;
@@ -543,6 +544,11 @@ static void post_discovery_started_cb(bt_discovery_state_t state)
 		status = data->if_bluetooth->cancel_discovery();
 		check_expected_status(status);
 	}
+
+	if (data->userflag & DEVICE_DISCOVERY_START_ON_START) {
+		status = data->if_bluetooth->start_discovery();
+		check_expected_status(status);
+	}
 }
 
 static void discovery_state_changed_cb(bt_discovery_state_t state)
@@ -741,6 +747,12 @@ static const struct generic_data bluetooth_discovery_start_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS
 };
 
+static const struct generic_data bluetooth_discovery_start_done_test = {
+	.expected_hal_callbacks = { ADAPTER_DISCOVERY_STATE_ON,
+							ADAPTER_TEST_END },
+	.expected_adapter_status = BT_STATUS_DONE
+};
+
 static const struct generic_data bluetooth_discovery_stop_done_test = {
 	.expected_hal_callbacks = { ADAPTER_TEST_END },
 	.expected_adapter_status = BT_STATUS_DONE
@@ -1324,6 +1336,20 @@ static void test_discovery_stop_success(const void *test_data)
 	check_expected_status(status);
 }
 
+static void test_discovery_start_done(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	data->userflag = DEVICE_DISCOVERY_START_ON_START;
+
+	init_test_conditions(data);
+
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT, BT_HCI_CMD_INQUIRY,
+					pre_inq_compl_hook, data);
+
+	data->if_bluetooth->start_discovery();
+}
+
 static gboolean socket_chan_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1495,6 +1521,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_setprop_service_record_invalid, teardown);
 
+	test_bredrle("Bluetooth BREDR Discovery Start - Done",
+				&bluetooth_discovery_start_done_test,
+				setup_enabled_adapter,
+				test_discovery_start_done, teardown);
+
 	test_bredrle("Bluetooth BREDR Discovery Start - Success",
 				&bluetooth_discovery_start_success_test,
 				setup_enabled_adapter,
-- 
1.8.5

