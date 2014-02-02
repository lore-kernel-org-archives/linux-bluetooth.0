Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Subject: [PATCH 04/11] android/tester: Add create bond with SSP sucess test case
Date: Sun, 2 Feb 2014 12:16:34 +0100
Message-ID: <1391339801-587-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1391339801-587-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1391339801-587-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>

This adds create bond with SSP succes test case. Confirm is set as SSP
pairing mode.
---
 android/android-tester.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index d8f7d82..bfa23e9 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1033,6 +1033,57 @@ static void pin_request_cb(bt_bdaddr_t *remote_bd_addr,
 									cod);
 }
 
+static void bond_create_ssp_request_cb(const bt_bdaddr_t *remote_bd_addr,
+					bt_ssp_variant_t pairing_variant,
+					bool accept)
+{
+	bdaddr_t remote_addr;
+	struct test_data *data = tester_get_data();
+	struct mgmt_addr_info cp;
+	uint16_t opcode;
+
+	android2bdaddr(remote_bd_addr, &remote_addr);
+
+	if (pairing_variant == 0) {	/* HAL_SSP_VARIANT_CONFIRM */
+		if (accept)
+			opcode = MGMT_OP_USER_CONFIRM_REPLY;
+		else
+			opcode = MGMT_OP_USER_CONFIRM_NEG_REPLY;
+
+		data->cb_count--;
+
+		bacpy(&cp.bdaddr, &remote_addr);
+		cp.type = BDADDR_BREDR;
+
+		mgmt_reply(data->mgmt, opcode, data->mgmt_index, sizeof(cp),
+							&cp, NULL, NULL, NULL);
+	} else
+		tester_test_failed();
+}
+
+static void bond_create_ssp_success_request_cb(bt_bdaddr_t *remote_bd_addr,
+					bt_bdname_t *bd_name, uint32_t cod,
+					bt_ssp_variant_t pairing_variant,
+					uint32_t pass_key)
+{
+	bool accept = true;
+
+	bond_create_ssp_request_cb(remote_bd_addr, pairing_variant, accept);
+}
+
+static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
+				uint32_t cod, bt_ssp_variant_t pairing_variant,
+				uint32_t pass_key)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+
+	if (data->test_init_done &&
+				test->expected_hal_cb.ssp_request_cb)
+		test->expected_hal_cb.ssp_request_cb(remote_bd_addr, bd_name,
+					cod, pairing_variant, pass_key);
+}
+
 static bt_bdaddr_t enable_done_bdaddr_val = { {0x00} };
 static char enable_done_bdname_val[] = "BlueZ for Android";
 static bt_uuid_t enable_done_uuids_val = {
@@ -2071,6 +2122,14 @@ static const struct generic_data bt_bond_create_pin_fail_test = {
 	.expected_adapter_status = MGMT_STATUS_AUTH_FAILED,
 };
 
+static const struct generic_data bt_bond_create_ssp_success_test = {
+	.expected_hal_cb.device_found_cb = bond_device_found_cb,
+	.expected_hal_cb.bond_state_changed_cb = bond_test_state_changed_cb,
+	.expected_hal_cb.ssp_request_cb = bond_create_ssp_success_request_cb,
+	.expected_cb_count = 4,
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -2078,8 +2137,8 @@ static bt_callbacks_t bt_callbacks = {
 	.remote_device_properties_cb = remote_device_properties_cb,
 	.device_found_cb = device_found_cb,
 	.discovery_state_changed_cb = discovery_state_changed_cb,
-	.ssp_request_cb = NULL,
 	.pin_request_cb = pin_request_cb,
+	.ssp_request_cb = ssp_request_cb,
 	.bond_state_changed_cb = bond_state_changed_cb,
 	.acl_state_changed_cb = NULL,
 	.thread_evt_cb = NULL,
@@ -2854,6 +2913,18 @@ static void test_bond_create_pin_fail(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_bond_create_ssp_success(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	init_test_conditions(data);
+
+	bthost_write_ssp_mode(bthost, 0x01);
+
+	data->if_bluetooth->start_discovery();
+}
+
 /* Test Socket HAL */
 
 static void adapter_socket_state_changed_cb(bt_state_t state)
@@ -4096,6 +4167,11 @@ int main(int argc, char *argv[])
 					setup_enabled_adapter,
 					test_bond_create_pin_fail, teardown);
 
+	test_bredrle("Bluetooth Create Bond SSP - Success",
+					&bt_bond_create_ssp_success_test,
+					setup_enabled_adapter,
+					test_bond_create_ssp_success, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

