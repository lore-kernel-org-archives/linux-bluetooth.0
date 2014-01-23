Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/10] android/tester: Add create bond with PIN fail test case
Date: Thu, 23 Jan 2014 17:57:31 +0100
Message-Id: <1390496258-5480-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1390496258-5480-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1390496258-5480-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds create bond with PIN fail test case.
---
 android/android-tester.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index a3973af..defab30 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -966,6 +966,31 @@ static void bond_create_pin_success_request_cb(bt_bdaddr_t *remote_bd_addr,
 					sizeof(rp), &rp, NULL, NULL, NULL);
 }
 
+static void bond_create_pin_fail_request_cb(bt_bdaddr_t *remote_bd_addr,
+					bt_bdname_t *bd_name, uint32_t cod)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_pin_code_reply rp;
+	bdaddr_t remote_addr;
+	static uint8_t bad_device_pin[] = { 0x31, 0x31, 0x31, 0x31 };
+	const void *pin_code = bad_device_pin;
+	uint8_t pin_len = 4;
+
+	memset(&rp, 0, sizeof(rp));
+
+	android2bdaddr(remote_bd_addr, &remote_addr);
+
+	data->cb_count--;
+
+	bacpy(&rp.addr.bdaddr, &remote_addr);
+	rp.addr.type = BDADDR_BREDR;
+	rp.pin_len = pin_len;
+	memcpy(rp.pin_code, pin_code, rp.pin_len);
+
+	mgmt_reply(data->mgmt, MGMT_OP_PIN_CODE_REPLY, data->mgmt_index,
+					sizeof(rp), &rp, NULL, NULL, NULL);
+}
+
 static void pin_request_cb(bt_bdaddr_t *remote_bd_addr,
 					bt_bdname_t *bd_name, uint32_t cod)
 {
@@ -2006,6 +2031,13 @@ static const struct generic_data bt_bond_create_pin_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
+static const struct generic_data bt_bond_create_pin_fail_test = {
+	.expected_hal_cb.bond_state_changed_cb = bond_test_state_changed_cb,
+	.expected_hal_cb.pin_request_cb = bond_create_pin_fail_request_cb,
+	.expected_cb_count = 4,
+	.expected_adapter_status = MGMT_STATUS_AUTH_FAILED,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -2764,6 +2796,31 @@ static void bond_device_found_callback(uint16_t index, uint16_t length,
 	}
 }
 
+static void bond_device_nostatus_found_callback(uint16_t index, uint16_t length,
+							const void *param,
+							void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	uint8_t *bdaddr = (uint8_t *)hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t remote_addr;
+
+	bdaddr2android((const bdaddr_t *)bdaddr, &remote_addr.address);
+
+	if (data->cb_count == 4) {
+		data->cb_count--;
+		data->if_bluetooth->create_bond(&remote_addr);
+	}
+}
+
+static void bond_device_auth_fail_callback(uint16_t index, uint16_t length,
+							const void *param,
+							void *user_data)
+{
+	const struct mgmt_ev_auth_failed *ev = param;
+
+	check_expected_status(ev->status);
+}
+
 static void test_bond_create_pin_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -2783,6 +2840,29 @@ static void test_bond_create_pin_success(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_bond_create_pin_fail(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	static uint8_t pair_device_pin[] = { 0x30, 0x30, 0x30, 0x30 };
+	const void *pin = pair_device_pin;
+	uint8_t pin_len = 4;
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
+	bthost_set_pin_code(bthost, pin, pin_len);
+
+	data->if_bluetooth->start_discovery();
+}
+
 /* Test Socket HAL */
 
 static void adapter_socket_state_changed_cb(bt_state_t state)
@@ -3920,6 +4000,11 @@ int main(int argc, char *argv[])
 					setup_enabled_adapter,
 					test_bond_create_pin_success, teardown);
 
+	test_bredrle("Bluetooth Create Bond PIN - Bad PIN",
+					&bt_bond_create_pin_fail_test,
+					setup_enabled_adapter,
+					test_bond_create_pin_fail, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

