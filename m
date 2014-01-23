Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/10] android/tester: Add remove bond bad addr dev test case
Date: Thu, 23 Jan 2014 17:57:38 +0100
Message-Id: <1390496258-5480-10-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1390496258-5480-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1390496258-5480-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds remove bond fail test case. Bad addres is given as a parametr
for remove bond hal function.
---
 android/android-tester.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 86a76d1..2272416 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -953,6 +953,15 @@ static void bond_remove_success_state_changed_cb(bt_status_t status,
 	}
 }
 
+static void bond_remove_bad_addr_state_changed_cb(bt_status_t status,
+			bt_bdaddr_t *remote_bd_addr, bt_bond_state_t state)
+{
+	struct test_data *data = tester_get_data();
+
+	if (state == BT_BOND_STATE_NONE)
+		data->cb_count--;
+}
+
 static void bond_state_changed_cb(bt_status_t status,
 			bt_bdaddr_t *remote_bd_addr, bt_bond_state_t state)
 {
@@ -2181,6 +2190,13 @@ static const struct generic_data bt_bond_remove_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
+static const struct generic_data bt_bond_remove_bad_addr_test = {
+	.expected_hal_cb.bond_state_changed_cb =
+					bond_remove_bad_addr_state_changed_cb,
+	.expected_cb_count = 1,
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -3105,6 +3121,20 @@ static void test_bond_remove_success(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_bond_remove_bad_addr(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t status;
+	bt_bdaddr_t bad_addr = {
+		.address = { 0x12, 0x34, 0x56, 0x78, 0x90, 0x12 }
+	};
+
+	init_test_conditions(data);
+
+	status = data->if_bluetooth->remove_bond(&bad_addr);
+	check_expected_status(status);
+}
+
 /* Test Socket HAL */
 
 static void adapter_socket_state_changed_cb(bt_state_t state)
@@ -4277,6 +4307,11 @@ int main(int argc, char *argv[])
 					setup_enabled_adapter,
 					test_bond_remove_success, teardown);
 
+	test_bredrle("Bluetooth Remove Bond - Bad Address",
+					&bt_bond_remove_bad_addr_test,
+					setup_enabled_adapter,
+					test_bond_remove_bad_addr, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

