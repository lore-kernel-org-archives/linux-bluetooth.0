Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 11/11] android/tester: Remove old bluetooth core test cases
Date: Mon, 21 Jul 2014 09:40:29 +0200
Message-Id: <1405928429-11491-12-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405928429-11491-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405928429-11491-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This removes few last bluetooth cases from the old tester.
All cases were ported to new testing framework.
---
 android/android-tester.c | 282 -----------------------------------------------
 1 file changed, 282 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 2b72bd8..ae86b87 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -263,36 +263,6 @@ static void test_update_state(void)
 	}
 }
 
-static void test_mgmt_settings_set(struct test_data *data)
-{
-	data->conditions_left--;
-
-	test_update_state();
-}
-
-static void command_generic_new_settings(uint16_t index, uint16_t length,
-					const void *param, void *user_data)
-{
-	struct test_data *data = tester_get_data();
-	const struct generic_data *test_data = data->test_data;
-	uint32_t settings;
-
-	if (length != 4) {
-		tester_warn("Invalid parameter size for new settings event");
-		tester_test_failed();
-		return;
-	}
-
-	settings = get_le32(param);
-
-	if ((settings & test_data->expect_settings_set) !=
-					test_data->expect_settings_set)
-		return;
-
-	test_mgmt_settings_set(data);
-	mgmt_unregister(data->mgmt, data->mgmt_settings_id);
-}
-
 static void check_cb_count(void)
 {
 	struct test_data *data = tester_get_data();
@@ -306,64 +276,6 @@ static void check_cb_count(void)
 	}
 }
 
-static void expected_cb_count_init(struct test_data *data)
-{
-	const struct generic_data *test_data = data->test_data;
-
-	data->cb_count = test_data->expected_cb_count;
-
-	check_cb_count();
-}
-
-static void mgmt_cb_init(struct test_data *data)
-{
-	const struct generic_data *test_data = data->test_data;
-
-	if (!test_data->expect_settings_set)
-		test_mgmt_settings_set(data);
-	else
-		data->mgmt_settings_id = mgmt_register(data->mgmt,
-				MGMT_EV_NEW_SETTINGS, data->mgmt_index,
-				command_generic_new_settings, NULL, NULL);
-}
-
-static void expected_status_init(struct test_data *data)
-{
-	const struct generic_data *test_data = data->test_data;
-
-	if (test_data->expected_adapter_status == BT_STATUS_NOT_EXPECTED)
-		data->conditions_left--;
-}
-
-static void test_property_init(struct test_data *data)
-{
-	const struct generic_data *test_data = data->test_data;
-	GSList *l = data->expected_properties_list;
-	int i;
-
-	if (!test_data->expected_properties_num) {
-		data->conditions_left--;
-		return;
-	}
-
-	for (i = 0; i < test_data->expected_properties_num; i++)
-		l = g_slist_prepend(l, &(test_data->expected_properties[i]));
-
-	data->expected_properties_list = l;
-}
-
-static void init_test_conditions(struct test_data *data)
-{
-	data->test_checks_valid = true;
-
-	data->conditions_left = 4;
-
-	expected_cb_count_init(data);
-	mgmt_cb_init(data);
-	expected_status_init(data);
-	test_property_init(data);
-}
-
 static void check_expected_status(uint8_t status)
 {
 	struct test_data *data = tester_get_data();
@@ -2110,28 +2022,6 @@ static bool setup(struct test_data *data)
 	return true;
 }
 
-static void setup_enabled_adapter(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	bt_status_t status;
-
-	if (!setup(data)) {
-		tester_setup_failed();
-		return;
-	}
-
-	status = data->if_bluetooth->init(&bt_callbacks);
-	if (status != BT_STATUS_SUCCESS) {
-		data->if_bluetooth = NULL;
-		tester_setup_failed();
-		return;
-	}
-
-	status = data->if_bluetooth->enable();
-	if (status != BT_STATUS_SUCCESS)
-		tester_setup_failed();
-}
-
 static void teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -2163,138 +2053,6 @@ static void test_dummy(const void *test_data)
 	tester_test_passed();
 }
 
-static void bond_device_auth_fail_callback(uint16_t index, uint16_t length,
-							const void *param,
-							void *user_data)
-{
-	const struct mgmt_ev_auth_failed *ev = param;
-
-	check_expected_status(ev->status);
-}
-
-static void test_bond_create_pin_success(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
-
-	static uint8_t pair_device_pin[] = { 0x30, 0x30, 0x30, 0x30 };
-	const void *pin = pair_device_pin;
-	uint8_t pin_len = 4;
-
-	init_test_conditions(data);
-
-	bthost_set_pin_code(bthost, pin, pin_len);
-
-	data->if_bluetooth->start_discovery();
-}
-
-static void test_bond_create_pin_fail(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
-
-	static uint8_t pair_device_pin[] = { 0x30, 0x30, 0x30, 0x30 };
-	const void *pin = pair_device_pin;
-	uint8_t pin_len = 4;
-
-	init_test_conditions(data);
-
-	mgmt_register(data->mgmt, MGMT_EV_AUTH_FAILED, data->mgmt_index,
-					bond_device_auth_fail_callback, data,
-					NULL);
-
-	bthost_set_pin_code(bthost, pin, pin_len);
-
-	data->if_bluetooth->start_discovery();
-}
-
-static void test_bond_create_ssp_success(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
-
-	init_test_conditions(data);
-
-	bthost_write_ssp_mode(bthost, 0x01);
-
-	data->if_bluetooth->start_discovery();
-}
-
-static void test_bond_create_ssp_fail(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
-
-	init_test_conditions(data);
-
-	mgmt_register(data->mgmt, MGMT_EV_AUTH_FAILED, data->mgmt_index,
-					bond_device_auth_fail_callback, data,
-					NULL);
-
-	bthost_write_ssp_mode(bthost, 0x01);
-
-	data->if_bluetooth->start_discovery();
-}
-
-static void test_bond_create_no_disc_success(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
-
-	uint8_t *bdaddr = (uint8_t *)hciemu_get_client_bdaddr(data->hciemu);
-	bt_bdaddr_t remote_addr;
-	bt_status_t status;
-
-	init_test_conditions(data);
-
-	bdaddr2android((const bdaddr_t *)bdaddr, &remote_addr.address);
-
-	bthost_write_ssp_mode(bthost, 0x01);
-
-	status = data->if_bluetooth->create_bond(&remote_addr);
-	check_expected_status(status);
-}
-
-static void test_bond_create_bad_addr_success(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	bt_bdaddr_t bad_addr = {
-		.address = { 0x12, 0x34, 0x56, 0x78, 0x90, 0x12 }
-	};
-
-	init_test_conditions(data);
-
-	mgmt_register(data->mgmt, MGMT_EV_CONNECT_FAILED, data->mgmt_index,
-					bond_device_auth_fail_callback, data,
-					NULL);
-
-	data->if_bluetooth->create_bond(&bad_addr);
-}
-
-static void test_bond_cancel_success(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
-
-	init_test_conditions(data);
-
-	bthost_write_ssp_mode(bthost, 0x01);
-
-	data->if_bluetooth->start_discovery();
-}
-
-static void test_bond_remove_success(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
-
-	init_test_conditions(data);
-
-	bthost_write_ssp_mode(bthost, 0x01);
-
-	data->if_bluetooth->start_discovery();
-}
-
 /* Test Socket HAL */
 
 static gboolean adapter_socket_state_changed(gpointer user_data)
@@ -3376,46 +3134,6 @@ int main(int argc, char *argv[])
 
 	tester_init(&argc, &argv);
 
-	test_bredr("Bluetooth Create Bond PIN - Success",
-					&bt_bond_create_pin_success_test,
-					setup_enabled_adapter,
-					test_bond_create_pin_success, teardown);
-
-	test_bredr("Bluetooth Create Bond PIN - Bad PIN",
-					&bt_bond_create_pin_fail_test,
-					setup_enabled_adapter,
-					test_bond_create_pin_fail, teardown);
-
-	test_bredr("Bluetooth Create Bond SSP - Success",
-					&bt_bond_create_ssp_success_test,
-					setup_enabled_adapter,
-					test_bond_create_ssp_success, teardown);
-
-	test_bredr("Bluetooth Create Bond SSP - Negative reply",
-					&bt_bond_create_ssp_fail_test,
-					setup_enabled_adapter,
-					test_bond_create_ssp_fail, teardown);
-
-	test_bredrle("Bluetooth Create Bond - No Discovery",
-				&bt_bond_create_no_disc_success_test,
-				setup_enabled_adapter,
-				test_bond_create_no_disc_success, teardown);
-
-	test_bredrle("Bluetooth Create Bond - Bad Address",
-				&bt_bond_create_bad_addr_success_test,
-				setup_enabled_adapter,
-				test_bond_create_bad_addr_success, teardown);
-
-	test_bredr("Bluetooth Cancel Bonding - Success",
-					&bt_bond_cancel_success_test,
-					setup_enabled_adapter,
-					test_bond_cancel_success, teardown);
-
-	test_bredr("Bluetooth Remove Bond - Success",
-					&bt_bond_remove_success_test,
-					setup_enabled_adapter,
-					test_bond_remove_success, teardown);
-
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.9.1

