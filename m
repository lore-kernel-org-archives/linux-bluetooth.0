Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/10] android/tester: Add create bond with PIN success test case
Date: Thu, 23 Jan 2014 17:57:30 +0100
Message-Id: <1390496258-5480-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1390496258-5480-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1390496258-5480-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds create bond with PIN success test case.
---
 android/android-tester.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 2 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 4bd48d6..a3973af 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -908,6 +908,75 @@ static void remote_device_properties_cb(bt_status_t status,
 					bd_addr, num_properties, properties);
 }
 
+static void bond_test_state_changed_cb(bt_status_t status,
+			bt_bdaddr_t *remote_bd_addr, bt_bond_state_t state)
+{
+	struct test_data *data = tester_get_data();
+
+	switch (state) {
+	case BT_BOND_STATE_NONE:
+		data->cb_count--;
+		check_cb_count();
+		break;
+	case BT_BOND_STATE_BONDING:
+		data->cb_count--;
+		break;
+	case BT_BOND_STATE_BONDED:
+		data->cb_count--;
+		check_cb_count();
+		break;
+	default:
+		break;
+	}
+}
+
+static void bond_state_changed_cb(bt_status_t status,
+			bt_bdaddr_t *remote_bd_addr, bt_bond_state_t state)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+
+	if (data->test_init_done && test->expected_hal_cb.bond_state_changed_cb)
+			test->expected_hal_cb.bond_state_changed_cb(status,
+							remote_bd_addr, state);
+}
+
+static void bond_create_pin_success_request_cb(bt_bdaddr_t *remote_bd_addr,
+					bt_bdname_t *bd_name, uint32_t cod)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_pin_code_reply rp;
+	bdaddr_t remote_addr;
+	static uint8_t pair_device_pin[] = { 0x30, 0x30, 0x30, 0x30 };
+	const void *pin_code = pair_device_pin;
+	uint8_t pin_len = 4;
+
+	memset(&rp, 0, sizeof(rp));
+
+	data->cb_count--;
+
+	android2bdaddr(remote_bd_addr, &remote_addr);
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
+static void pin_request_cb(bt_bdaddr_t *remote_bd_addr,
+					bt_bdname_t *bd_name, uint32_t cod)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+
+	if (data->test_init_done && test->expected_hal_cb.pin_request_cb)
+		test->expected_hal_cb.pin_request_cb(remote_bd_addr, bd_name,
+									cod);
+}
+
 static bt_bdaddr_t enable_done_bdaddr_val = { {0x00} };
 static char enable_done_bdname_val[] = "BlueZ for Android";
 static bt_uuid_t enable_done_uuids_val = {
@@ -1930,6 +1999,13 @@ static const struct generic_data bt_dev_setprop_disctimeout_fail_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
 };
 
+static const struct generic_data bt_bond_create_pin_success_test = {
+	.expected_hal_cb.bond_state_changed_cb = bond_test_state_changed_cb,
+	.expected_hal_cb.pin_request_cb = bond_create_pin_success_request_cb,
+	.expected_cb_count = 4,
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -1937,9 +2013,9 @@ static bt_callbacks_t bt_callbacks = {
 	.remote_device_properties_cb = remote_device_properties_cb,
 	.device_found_cb = device_found_cb,
 	.discovery_state_changed_cb = discovery_state_changed_cb,
-	.pin_request_cb = NULL,
+	.pin_request_cb = pin_request_cb,
 	.ssp_request_cb = NULL,
-	.bond_state_changed_cb = NULL,
+	.bond_state_changed_cb = bond_state_changed_cb,
 	.acl_state_changed_cb = NULL,
 	.thread_evt_cb = NULL,
 	.dut_mode_recv_cb = NULL,
@@ -2669,6 +2745,44 @@ static void test_dev_setprop_disctimeout_fail(const void *test_data)
 
 	data->if_bluetooth->start_discovery();
 }
+
+static void bond_device_found_callback(uint16_t index, uint16_t length,
+							const void *param,
+							void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	uint8_t *bdaddr = (uint8_t *)hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t remote_addr;
+	bt_status_t status;
+
+	bdaddr2android((const bdaddr_t *)bdaddr, &remote_addr.address);
+
+	if (data->cb_count == 4) {
+		data->cb_count--;
+		status = data->if_bluetooth->create_bond(&remote_addr);
+		check_expected_status(status);
+	}
+}
+
+static void test_bond_create_pin_success(const void *test_data)
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
+					bond_device_found_callback, data, NULL);
+
+	bthost_set_pin_code(bthost, pin, pin_len);
+
+	data->if_bluetooth->start_discovery();
+}
+
 /* Test Socket HAL */
 
 static void adapter_socket_state_changed_cb(bt_state_t state)
@@ -3801,6 +3915,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_dev_setprop_disctimeout_fail, teardown);
 
+	test_bredrle("Bluetooth Create Bond PIN - Success",
+					&bt_bond_create_pin_success_test,
+					setup_enabled_adapter,
+					test_bond_create_pin_success, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

