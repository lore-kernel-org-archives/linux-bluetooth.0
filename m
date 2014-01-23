Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/10] android/tester: Add create bond with SSP fail test case
Date: Thu, 23 Jan 2014 17:57:33 +0100
Message-Id: <1390496258-5480-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1390496258-5480-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1390496258-5480-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds create bond with SSP fail test case. Confirm is set as SSP
pairing mode.
---
 android/android-tester.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 1ee1196..0d37fb3 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1040,6 +1040,16 @@ static void bond_create_ssp_success_request_cb(bt_bdaddr_t *remote_bd_addr,
 	bond_create_ssp_request_cb(remote_bd_addr, pairing_variant, accept);
 }
 
+static void bond_create_ssp_fail_request_cb(bt_bdaddr_t *remote_bd_addr,
+					bt_bdname_t *bd_name, uint32_t cod,
+					bt_ssp_variant_t pairing_variant,
+					uint32_t pass_key)
+{
+	bool accept = false;
+
+	bond_create_ssp_request_cb(remote_bd_addr, pairing_variant, accept);
+}
+
 static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
 				uint32_t cod, bt_ssp_variant_t pairing_variant,
 				uint32_t pass_key)
@@ -2097,6 +2107,13 @@ static const struct generic_data bt_bond_create_ssp_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
+static const struct generic_data bt_bond_create_ssp_fail_test = {
+	.expected_hal_cb.bond_state_changed_cb = bond_test_state_changed_cb,
+	.expected_hal_cb.ssp_request_cb = bond_create_ssp_fail_request_cb,
+	.expected_cb_count = 4,
+	.expected_adapter_status = MGMT_STATUS_AUTH_FAILED,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -2937,6 +2954,25 @@ static void test_bond_create_ssp_success(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_bond_create_ssp_fail(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	init_test_conditions(data);
+
+	mgmt_register(data->mgmt, MGMT_EV_DEVICE_FOUND, data->mgmt_index,
+					bond_device_nostatus_found_callback,
+					data, NULL);
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
 
 static void adapter_socket_state_changed_cb(bt_state_t state)
@@ -4084,6 +4120,11 @@ int main(int argc, char *argv[])
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

