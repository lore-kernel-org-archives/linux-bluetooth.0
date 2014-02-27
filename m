Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/9] android/tester: Add create bond with PIN fail test case
Date: Thu, 27 Feb 2014 16:04:44 +0100
Message-Id: <1393513490-18674-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393513490-18674-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393513490-18674-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds create bond with PIN fail test case.
---
 android/android-tester.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index cb08ec1..4db5722 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1037,6 +1037,21 @@ static void bond_device_found_cb(int num_properties, bt_property_t *properties)
 	}
 }
 
+static void bond_nostatus_device_found_cb(int num_properties,
+						bt_property_t *properties)
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
 static gboolean device_found(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1236,6 +1251,21 @@ static void bond_create_pin_success_request_cb(bt_bdaddr_t *remote_bd_addr,
 	data->if_bluetooth->pin_reply(bdaddr, TRUE, pin_len, &pin_code);
 }
 
+static void bond_create_pin_fail_request_cb(bt_bdaddr_t *remote_bd_addr,
+					bt_bdname_t *bd_name, uint32_t cod)
+{
+	struct test_data *data = tester_get_data();
+	const bt_bdaddr_t *bdaddr = remote_bd_addr;
+	bt_pin_code_t pin_code = {
+	.pin = { 0x31, 0x31, 0x31, 0x31 },
+	};
+	uint8_t pin_len = 4;
+
+	data->cb_count--;
+
+	data->if_bluetooth->pin_reply(bdaddr, TRUE, pin_len, &pin_code);
+}
+
 static gboolean pin_request(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
@@ -2292,6 +2322,14 @@ static const struct generic_data bt_bond_create_pin_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
+static const struct generic_data bt_bond_create_pin_fail_test = {
+	.expected_hal_cb.device_found_cb = bond_nostatus_device_found_cb,
+	.expected_hal_cb.bond_state_changed_cb = bond_test_state_changed_cb,
+	.expected_hal_cb.pin_request_cb = bond_create_pin_fail_request_cb,
+	.expected_cb_count = 4,
+	.expected_adapter_status = MGMT_STATUS_AUTH_FAILED,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -3030,6 +3068,16 @@ static void test_dev_setprop_disctimeout_fail(const void *test_data)
 
 	data->if_bluetooth->start_discovery();
 }
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
@@ -3046,6 +3094,26 @@ static void test_bond_create_pin_success(const void *test_data)
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
 
 static gboolean adapter_socket_state_changed(gpointer user_data)
@@ -4389,6 +4457,11 @@ int main(int argc, char *argv[])
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

