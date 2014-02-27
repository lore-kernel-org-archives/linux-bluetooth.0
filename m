Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/9] android/tester: Add create bond with SSP fail test case
Date: Thu, 27 Feb 2014 16:04:46 +0100
Message-Id: <1393513490-18674-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393513490-18674-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393513490-18674-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds create bond with SSP fail test case. Confirm is set as SSP
pairing mode.
---
 android/android-tester.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 2bb895c..f82025e 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1319,6 +1319,17 @@ static void bond_create_ssp_success_request_cb(bt_bdaddr_t *remote_bd_addr,
 								pass_key);
 }
 
+static void bond_create_ssp_fail_request_cb(bt_bdaddr_t *remote_bd_addr,
+					bt_bdname_t *bd_name, uint32_t cod,
+					bt_ssp_variant_t pairing_variant,
+					uint32_t pass_key)
+{
+	bool accept = false;
+
+	bond_create_ssp_request_cb(remote_bd_addr, pairing_variant, accept,
+								pass_key);
+}
+
 static gboolean ssp_request(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
@@ -2396,6 +2407,14 @@ static const struct generic_data bt_bond_create_ssp_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
+static const struct generic_data bt_bond_create_ssp_fail_test = {
+	.expected_hal_cb.device_found_cb = bond_nostatus_device_found_cb,
+	.expected_hal_cb.bond_state_changed_cb = bond_test_state_changed_cb,
+	.expected_hal_cb.ssp_request_cb = bond_create_ssp_fail_request_cb,
+	.expected_cb_count = 4,
+	.expected_adapter_status = MGMT_STATUS_AUTH_FAILED,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -3192,6 +3211,22 @@ static void test_bond_create_ssp_success(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_bond_create_ssp_fail(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	init_test_conditions(data);
+
+	mgmt_register(data->mgmt, MGMT_EV_AUTH_FAILED, data->mgmt_index,
+					bond_device_auth_fail_callback, data,
+					NULL);
+
+	bthost_write_ssp_mode(bthost, 0x01);
+
+	data->if_bluetooth->start_discovery();
+}
+
 /* Test Socket HAL */
 
 static gboolean adapter_socket_state_changed(gpointer user_data)
@@ -4545,6 +4580,11 @@ int main(int argc, char *argv[])
 					setup_enabled_adapter,
 					test_bond_create_ssp_success, teardown);
 
+	test_bredrle("Bluetooth Create Bond SSP - Negative reply",
+					&bt_bond_create_ssp_fail_test,
+					setup_enabled_adapter,
+					test_bond_create_ssp_fail, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

