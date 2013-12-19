Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] android/tester: Add stop device discovery done test case
Date: Thu, 19 Dec 2013 13:42:24 +0100
Message-Id: <1387456946-9743-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1387456946-9743-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1387456946-9743-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add test case for stopping device discovery when it wasn't started.

---
 android/android-tester.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 1880cf1..0dae111 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -724,6 +724,11 @@ static const struct generic_data bluetooth_discovery_start_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS
 };
 
+static const struct generic_data bluetooth_discovery_stop_done_test = {
+	.expected_hal_callbacks = { ADAPTER_TEST_END },
+	.expected_adapter_status = BT_STATUS_DONE
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -1263,6 +1268,17 @@ static void test_discovery_start_success(const void *test_data)
 	check_expected_status(status);
 }
 
+static void test_discovery_stop_done(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t status;
+
+	init_test_conditions(data);
+
+	status = data->if_bluetooth->cancel_discovery();
+	check_expected_status(status);
+}
+
 static gboolean socket_chan_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1439,6 +1455,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_discovery_start_success, teardown);
 
+	test_bredrle("Bluetooth BREDR Discovery Stop - Done",
+				&bluetooth_discovery_stop_done_test,
+				setup_enabled_adapter,
+				test_discovery_stop_done, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5

