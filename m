Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Subject: [PATCH 07/11] android/tester: Add create bond with bad addr fail test case
Date: Sun, 2 Feb 2014 12:16:37 +0100
Message-ID: <1391339801-587-8-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1391339801-587-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1391339801-587-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>

This adds create bond with bad addr fail test case.
---
 android/android-tester.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index c8c2a75..3497f4a 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -2155,6 +2155,10 @@ static const struct generic_data bt_bond_create_no_disc_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
+static const struct generic_data bt_bond_create_bad_addr_success_test = {
+	.expected_adapter_status = MGMT_STATUS_CONNECT_FAILED,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -2985,6 +2989,22 @@ static void test_bond_create_no_disc_success(const void *test_data)
 	check_expected_status(status);
 }
 
+static void test_bond_create_bad_addr_success(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_bdaddr_t bad_addr = {
+		.address = { 0x12, 0x34, 0x56, 0x78, 0x90, 0x12 }
+	};
+
+	init_test_conditions(data);
+
+	mgmt_register(data->mgmt, MGMT_EV_CONNECT_FAILED, data->mgmt_index,
+					bond_device_auth_fail_callback, data,
+					NULL);
+
+	data->if_bluetooth->create_bond(&bad_addr);
+}
+
 /* Test Socket HAL */
 
 static void adapter_socket_state_changed_cb(bt_state_t state)
@@ -4242,6 +4262,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_bond_create_no_disc_success, teardown);
 
+	test_bredrle("Bluetooth Create Bond - Bad Address",
+				&bt_bond_create_bad_addr_success_test,
+				setup_enabled_adapter,
+				test_bond_create_bad_addr_success, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

