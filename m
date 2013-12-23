Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] android/tester: Move BT discovery test cases before Socket Hal
Date: Mon, 23 Dec 2013 12:50:25 +0100
Message-Id: <1387799429-6674-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1387799429-6674-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1387799429-6674-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This moves and organize test case data. BT discovery test cases to right
place in code.
---
 android/android-tester.c | 160 +++++++++++++++++++++++------------------------
 1 file changed, 80 insertions(+), 80 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 701ffd2..0fe341b 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -930,7 +930,6 @@ static void setup(struct test_data *data)
 		tester_setup_failed();
 		return;
 	}
-
 }
 
 static void setup_base(const void *test_data)
@@ -1158,6 +1157,78 @@ static void test_setprop_service_record_invalid(const void *test_data)
 	check_expected_status(adapter_status);
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
+static bool pre_inq_compl_hook(const void *dummy, uint16_t len, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	/* Make sure Inquiry Command Complete is not called */
+
+	hciemu_del_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT, BT_HCI_CMD_INQUIRY);
+
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
+static void test_discovery_device_found(const void *test_data)
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
@@ -1479,77 +1550,6 @@ clean:
 		close(sock_fd);
 }
 
-static void test_discovery_start_success(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	bt_status_t status;
-
-	init_test_conditions(data);
-
-	status = data->if_bluetooth->start_discovery();
-	check_expected_status(status);
-}
-
-static void test_discovery_stop_done(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	bt_status_t status;
-
-	init_test_conditions(data);
-
-	status = data->if_bluetooth->cancel_discovery();
-	check_expected_status(status);
-}
-
-static bool pre_inq_compl_hook(const void *dummy, uint16_t len, void *user_data)
-{
-	struct test_data *data = tester_get_data();
-
-	/* Make sure Inquiry Command Complete is not called */
-
-	hciemu_del_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT, BT_HCI_CMD_INQUIRY);
-
-	return false;
-}
-
-static void test_discovery_stop_success(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	bt_status_t status;
-
-	data->userflag = DEVICE_DISCOVERY_CANCEL_ON_START;
-
-	init_test_conditions(data);
-
-	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT, BT_HCI_CMD_INQUIRY,
-					pre_inq_compl_hook, data);
-
-	status = data->if_bluetooth->start_discovery();
-	check_expected_status(status);
-}
-
-static void test_discovery_start_done(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-
-	data->userflag = DEVICE_DISCOVERY_START_ON_START;
-
-	init_test_conditions(data);
-
-	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT, BT_HCI_CMD_INQUIRY,
-					pre_inq_compl_hook, data);
-
-	data->if_bluetooth->start_discovery();
-}
-
-static void test_discovery_device_found(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-
-	init_test_conditions(data);
-
-	data->if_bluetooth->start_discovery();
-}
 
 static gboolean socket_chan_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
@@ -1722,26 +1722,26 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_setprop_service_record_invalid, teardown);
 
-	test_bredrle("Bluetooth BREDR Discovery Start - Done",
-				&bluetooth_discovery_start_done_test,
-				setup_enabled_adapter,
-				test_discovery_start_done, teardown);
-
 	test_bredrle("Bluetooth BREDR Discovery Start - Success",
 				&bluetooth_discovery_start_success_test,
 				setup_enabled_adapter,
 				test_discovery_start_success, teardown);
 
-	test_bredrle("Bluetooth BREDR Discovery Stop - Done",
-				&bluetooth_discovery_stop_done_test,
+	test_bredrle("Bluetooth BREDR Discovery Start - Done",
+				&bluetooth_discovery_start_done_test,
 				setup_enabled_adapter,
-				test_discovery_stop_done, teardown);
+				test_discovery_start_done, teardown);
 
 	test_bredrle("Bluetooth BREDR Discovery Stop - Success",
 				&bluetooth_discovery_stop_success_test,
 				setup_enabled_adapter,
 				test_discovery_stop_success, teardown);
 
+	test_bredrle("Bluetooth BREDR Discovery Stop - Done",
+				&bluetooth_discovery_stop_done_test,
+				setup_enabled_adapter,
+				test_discovery_stop_done, teardown);
+
 	test_bredrle("Bluetooth BREDR Discovery Device Found",
 				&bluetooth_discovery_device_found_test,
 				setup_enabled_adapter,
-- 
1.8.4.2

