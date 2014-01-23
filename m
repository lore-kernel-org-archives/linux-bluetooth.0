Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/10] android/tester: Add cancel bond success test case
Date: Thu, 23 Jan 2014 17:57:36 +0100
Message-Id: <1390496258-5480-8-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1390496258-5480-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1390496258-5480-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds cancel bond success test case. SSP as pairing mode.
---
 android/android-tester.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 3268904..ee5f225 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1050,6 +1050,24 @@ static void bond_create_ssp_fail_request_cb(bt_bdaddr_t *remote_bd_addr,
 	bond_create_ssp_request_cb(remote_bd_addr, pairing_variant, accept);
 }
 
+static void bond_cancel_success_ssp_request_cb(bt_bdaddr_t *remote_bd_addr,
+					bt_bdname_t *bd_name, uint32_t cod,
+					bt_ssp_variant_t pairing_variant,
+					uint32_t pass_key)
+{
+	struct test_data *data = tester_get_data();
+	uint8_t *bdaddr = (uint8_t *)hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t remote_addr;
+	bt_status_t status;
+
+	bdaddr2android((const bdaddr_t *)bdaddr, &remote_addr.address);
+
+	data->cb_count--;
+
+	status = data->if_bluetooth->cancel_bond(&remote_addr);
+	check_expected_status(status);
+}
+
 static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
 				uint32_t cod, bt_ssp_variant_t pairing_variant,
 				uint32_t pass_key)
@@ -2125,6 +2143,13 @@ static const struct generic_data bt_bond_create_bad_addr_success_test = {
 	.expected_adapter_status = MGMT_STATUS_CONNECT_FAILED,
 };
 
+static const struct generic_data bt_bond_cancel_success_test = {
+	.expected_hal_cb.bond_state_changed_cb = bond_test_state_changed_cb,
+	.expected_hal_cb.ssp_request_cb = bond_cancel_success_ssp_request_cb,
+	.expected_cb_count = 4,
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -3019,6 +3044,21 @@ static void test_bond_create_bad_addr_success(const void *test_data)
 	data->if_bluetooth->create_bond(&bad_addr);
 }
 
+static void test_bond_cancel_success(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	init_test_conditions(data);
+
+	mgmt_register(data->mgmt, MGMT_EV_DEVICE_FOUND, data->mgmt_index,
+			bond_device_nostatus_found_callback, data, NULL);
+
+	bthost_write_ssp_mode(bthost, 0x01);
+
+	data->if_bluetooth->start_discovery();
+}
+
 /* Test Socket HAL */
 
 static void adapter_socket_state_changed_cb(bt_state_t state)
@@ -4181,6 +4221,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_bond_create_bad_addr_success, teardown);
 
+	test_bredrle("Bluetooth Cancel Bonding - Success",
+					&bt_bond_cancel_success_test,
+					setup_enabled_adapter,
+					test_bond_cancel_success, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

