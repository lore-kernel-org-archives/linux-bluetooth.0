Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] android/tester: Add BDADDR set prop fail test case
Date: Mon, 30 Dec 2013 15:25:05 +0100
Message-Id: <1388413509-31265-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds BDADDR set property fail test case due to only get
possibility.
---
 android/android-tester.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index ee23fff..d7ebc02 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -798,6 +798,17 @@ static const struct generic_data
 	.set_property.len = sizeof(setprop_remote_service),
 };
 
+static bt_bdaddr_t setprop_bdaddr = {
+	.address = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
+};
+
+static const struct generic_data bluetooth_setprop_bdaddr_invalid_test = {
+	.expected_adapter_status = BT_STATUS_FAIL,
+	.set_property.type = BT_PROPERTY_BDADDR,
+	.set_property.val = &setprop_bdaddr,
+	.set_property.len = sizeof(setprop_bdaddr),
+};
+
 static const struct generic_data bluetooth_discovery_start_success_test = {
 	.expected_hal_cb.discovery_state_changed_cb =
 						discovery_start_success_cb,
@@ -1134,6 +1145,19 @@ static void test_setprop_service_record_invalid(const void *test_data)
 	check_expected_status(adapter_status);
 }
 
+static void test_setprop_bdaddr_invalid(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const bt_property_t *prop = &test->expected_property;
+	bt_status_t adapter_status;
+
+	init_test_conditions(data);
+
+	adapter_status = data->if_bluetooth->set_adapter_property(prop);
+	check_expected_status(adapter_status);
+}
+
 static void test_discovery_start_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1693,6 +1717,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_setprop_service_record_invalid, teardown);
 
+	test_bredrle("Bluetooth Set BDADDR - Invalid",
+					&bluetooth_setprop_bdaddr_invalid_test,
+					setup_enabled_adapter,
+					test_setprop_bdaddr_invalid, teardown);
+
 	test_bredrle("Bluetooth BREDR Discovery Start - Success",
 				&bluetooth_discovery_start_success_test,
 				setup_enabled_adapter,
-- 
1.8.4.2

