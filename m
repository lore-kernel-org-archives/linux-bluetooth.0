Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/9] android/tester: Add create bond with PIN success test case
Date: Thu, 27 Feb 2014 16:04:43 +0100
Message-Id: <1393513490-18674-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393513490-18674-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393513490-18674-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds create bond with PIN success test case.
---
 android/android-tester.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 2 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index a94c536..cb08ec1 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -124,6 +124,8 @@ struct bt_cb_data {
 	bt_status_t status;
 
 	bt_bdaddr_t bdaddr;
+	bt_bdname_t bdname;
+	uint32_t cod;
 
 	int num;
 	bt_property_t *props;
@@ -1019,6 +1021,22 @@ static void remote_setprop_fail_device_found_cb(int num_properties,
 	check_expected_status(status);
 }
 
+static void bond_device_found_cb(int num_properties, bt_property_t *properties)
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
 static gboolean device_found(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1153,6 +1171,97 @@ static void remote_device_properties_cb(bt_status_t status,
 	g_idle_add(remote_device_properties, cb_data);
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
+static gboolean bond_state_changed(gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	struct bt_cb_data *cb_data = user_data;
+
+	if (data->test_init_done && test->expected_hal_cb.bond_state_changed_cb)
+			test->expected_hal_cb.bond_state_changed_cb(
+							cb_data->status,
+							&cb_data->bdaddr,
+							cb_data->state);
+
+	g_free(cb_data);
+	return FALSE;
+}
+
+static void bond_state_changed_cb(bt_status_t status,
+			bt_bdaddr_t *remote_bd_addr, bt_bond_state_t state)
+{
+	struct bt_cb_data *cb_data = g_new0(struct bt_cb_data, 1);
+
+	cb_data->status = status;
+	cb_data->bdaddr = *remote_bd_addr;
+	cb_data->state = state;
+
+	g_idle_add(bond_state_changed, cb_data);
+}
+
+static void bond_create_pin_success_request_cb(bt_bdaddr_t *remote_bd_addr,
+					bt_bdname_t *bd_name, uint32_t cod)
+{
+	struct test_data *data = tester_get_data();
+	const bt_bdaddr_t *bdaddr = remote_bd_addr;
+	bt_pin_code_t pin_code = {
+	.pin = { 0x30, 0x30, 0x30, 0x30 },
+	};
+	uint8_t pin_len = 4;
+
+	data->cb_count--;
+
+	data->if_bluetooth->pin_reply(bdaddr, TRUE, pin_len, &pin_code);
+}
+
+static gboolean pin_request(gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	struct bt_cb_data *cb_data = user_data;
+
+	if (data->test_init_done && test->expected_hal_cb.pin_request_cb)
+		test->expected_hal_cb.pin_request_cb(&cb_data->bdaddr,
+						&cb_data->bdname, cb_data->cod);
+
+	g_free(cb_data);
+	return FALSE;
+}
+
+static void pin_request_cb(bt_bdaddr_t *remote_bd_addr,
+					bt_bdname_t *bd_name, uint32_t cod)
+{
+	struct bt_cb_data *cb_data = g_new0(struct bt_cb_data, 1);
+
+	cb_data->bdaddr = *remote_bd_addr;
+	cb_data->bdname = *bd_name;
+	cb_data->cod = cod;
+
+	g_idle_add(pin_request, cb_data);
+}
+
 static bt_bdaddr_t enable_done_bdaddr_val = { {0x00} };
 static const char enable_done_bdname_val[] = "BlueZ for Android";
 static bt_uuid_t enable_done_uuids_val = {
@@ -2175,6 +2284,14 @@ static const struct generic_data bt_dev_setprop_disctimeout_fail_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
 };
 
+static const struct generic_data bt_bond_create_pin_success_test = {
+	.expected_hal_cb.device_found_cb = bond_device_found_cb,
+	.expected_hal_cb.bond_state_changed_cb = bond_test_state_changed_cb,
+	.expected_hal_cb.pin_request_cb = bond_create_pin_success_request_cb,
+	.expected_cb_count = 4,
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -2182,9 +2299,9 @@ static bt_callbacks_t bt_callbacks = {
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
@@ -2913,6 +3030,22 @@ static void test_dev_setprop_disctimeout_fail(const void *test_data)
 
 	data->if_bluetooth->start_discovery();
 }
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
+	bthost_set_pin_code(bthost, pin, pin_len);
+
+	data->if_bluetooth->start_discovery();
+}
+
 /* Test Socket HAL */
 
 static gboolean adapter_socket_state_changed(gpointer user_data)
@@ -4251,6 +4384,11 @@ int main(int argc, char *argv[])
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

