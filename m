Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 2/7] android/tester: Add PAN Connect test case
Date: Mon, 17 Mar 2014 16:00:06 +0200
Message-Id: <1395064811-5469-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1395064811-5469-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1395064811-5469-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c | 160 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index f8266a1..f9f508f 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -133,6 +133,11 @@ struct test_data {
 	uint16_t ctrl_cid;
 	uint16_t intr_handle;
 	uint16_t intr_cid;
+
+	/* PAN */
+	uint16_t nap_handle;
+	uint16_t nap_cid;
+	uint8_t role;
 };
 
 struct bt_cb_data {
@@ -4781,6 +4786,157 @@ static void setup_pan(const void *test_data)
 		tester_setup_failed();
 }
 
+static void pan_connected_cb(btpan_connection_state_t state, bt_status_t error,
+				const bt_bdaddr_t *addr, int local, int remote)
+{
+	struct test_data *data = tester_get_data();
+	const struct pan_generic_data *test = data->test_data;
+
+	switch (state) {
+	case BTPAN_STATE_CONNECTED:
+		data->cb_count++;
+		if (data->cb_count == test->expected_cb_count)
+			tester_test_passed();
+		break;
+	case BTPAN_STATE_CONNECTING:
+		data->cb_count++;
+		break;
+	case BTPAN_STATE_DISCONNECTED:
+	case BTPAN_STATE_DISCONNECTING:
+		tester_test_failed();
+		break;
+	}
+}
+
+static void pan_connect_enabled_cb(btpan_control_state_t state,
+					bt_status_t error,
+					int local_role, const char *ifname)
+{
+	struct test_data *data = tester_get_data();
+
+	switch (state) {
+	case BTPAN_STATE_ENABLED:
+		data->cb_count++;
+		break;
+	case BTPAN_STATE_DISABLED:
+		tester_test_failed();
+		break;
+	}
+}
+
+static void pan_bond_create_pin_request_cb(bt_bdaddr_t *remote_bd_addr,
+					bt_bdname_t *bd_name, uint32_t cod)
+{
+	struct test_data *data = tester_get_data();
+	const bt_bdaddr_t *bdaddr = remote_bd_addr;
+	bt_pin_code_t pin_code = {
+			.pin = { 0x30, 0x30, 0x30, 0x30 },
+			};
+	uint8_t pin_len = 4;
+
+	data->cb_count++;
+	data->if_bluetooth->pin_reply(bdaddr, TRUE, pin_len, &pin_code);
+}
+
+static void pan_bond_device_found_cb(int num_properties,
+						bt_property_t *properties)
+{
+	struct test_data *data = tester_get_data();
+	uint8_t *bdaddr = (uint8_t *)hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t remote_addr;
+
+	bdaddr2android((const bdaddr_t *)bdaddr, &remote_addr.address);
+
+	if (data->cb_count == 0) {
+		data->cb_count++;
+		data->if_bluetooth->create_bond(&remote_addr);
+	}
+}
+
+static void pan_bond_state_bonded_changed_cb(bt_status_t status,
+			bt_bdaddr_t *remote_bd_addr, bt_bond_state_t state)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *pan_addr = hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t bdaddr;
+	bt_status_t bt_status;
+
+	switch (state) {
+	case BT_BOND_STATE_BONDING:
+		data->cb_count++;
+		break;
+	case BT_BOND_STATE_BONDED:
+		data->cb_count++;
+		if (data->cb_count == 4) {
+			bdaddr2android((const bdaddr_t *) pan_addr, &bdaddr);
+			bt_status = data->if_pan->connect(&bdaddr,
+							BTPAN_ROLE_PANU,
+							BTPAN_ROLE_PANNAP);
+			if (bt_status != BT_STATUS_SUCCESS)
+				tester_setup_failed();
+		}
+
+		break;
+	default:
+		tester_test_failed();
+		break;
+	}
+}
+
+static uint8_t pan_conn_req_pdu[] = {0x01, 0x01, 0x02, 0x11, 0x16, 0x11, 0x15};
+static uint8_t pan_conn_rsp_pdu[] = {0x01, 0x02, 0x00, 0x00};
+
+static void pan_nap_cid_hook_cb(const void *data, uint16_t len, void *user_data)
+{
+	struct test_data *t_data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
+
+	if (!memcmp((uint8_t *) data, pan_conn_req_pdu,
+						sizeof(pan_conn_req_pdu)))
+		bthost_send_cid(bthost, t_data->nap_handle, t_data->nap_cid,
+				pan_conn_rsp_pdu, sizeof(pan_conn_rsp_pdu));
+}
+
+static void pan_connect_request_cb(uint16_t handle, uint16_t cid,
+							void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	data->nap_handle = handle;
+	data->nap_cid = cid;
+
+	bthost_add_cid_hook(bthost, handle, cid, pan_nap_cid_hook_cb, NULL);
+}
+
+static const struct pan_generic_data pan_test_connect = {
+	.expected_hal_cb.device_found_cb = pan_bond_device_found_cb,
+	.expected_hal_cb.bond_state_changed_cb =
+					pan_bond_state_bonded_changed_cb,
+	.expected_hal_cb.pin_request_cb = pan_bond_create_pin_request_cb,
+	.expected_cb_count = 7,
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+	.expected_pan_hal_cb.control_state_cb = pan_connect_enabled_cb,
+	.expected_pan_hal_cb.connection_state_cb = pan_connected_cb,
+};
+
+static void test_panu_connect(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	static uint8_t pair_device_pin[] = { 0x30, 0x30, 0x30, 0x30 };
+	const void *pin = pair_device_pin;
+	uint8_t pin_len = 4;
+
+	/* Emulate NAP (PSM = 15) */
+	bthost_add_l2cap_server(bthost, 15, pan_connect_request_cb, NULL);
+
+	data->test_checks_valid = true;
+	data->cb_count = 0;
+	bthost_set_pin_code(bthost, pin, pin_len);
+	data->if_bluetooth->start_discovery();
+}
+
 #define test_bredr(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -5219,5 +5375,9 @@ int main(int argc, char *argv[])
 	test_bredr("PAN Init", NULL, setup_pan,
 						test_dummy, teardown);
 
+	test_bredr("PAN Connect Success",
+				&pan_test_connect, setup_pan,
+				test_panu_connect, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

