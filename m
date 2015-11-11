Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH BlueZ v5 3/5] tools/l2cap-tester: Disconnect during connect attempt test
Date: Tue, 10 Nov 2015 22:36:28 -0800
Message-Id: <1447223790-3263-3-git-send-email-jpawlowski@google.com>
In-Reply-To: <1447223790-3263-1-git-send-email-jpawlowski@google.com>
References: <1447223790-3263-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds test that checks folowing:
1. Try to connect to existing BLE device that is not advertising.
2. Internally in kernel this adds this device to whitelist and enable scan.
3. Make the device advertise once. That would stop the scan, and trigger
   connect attempt to device.
4. Close socket. This should stop the connect attempt, by sending
   BT_HCI_CMD_LE_CREATE_CONN_CANCEL.
---
 tools/l2cap-tester.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 105 insertions(+), 6 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 2936feb..4bea30f 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -88,6 +88,7 @@ struct l2cap_data {
 	uint8_t addr_type;
 
 	uint8_t *client_bdaddr;
+	bool server_not_advertising;
 };
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -459,6 +460,11 @@ static const struct l2cap_data le_client_close_socket_test_1 = {
 	.client_bdaddr = nonexisting_bdaddr,
 };
 
+static const struct l2cap_data le_client_close_socket_test_2 = {
+	.client_psm = 0x0080,
+	.server_not_advertising = true,
+};
+
 static const struct l2cap_data le_client_connect_nval_psm_test = {
 	.client_psm = 0x0080,
 	.expect_err = ECONNREFUSED,
@@ -576,6 +582,7 @@ static void setup_powered_client_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
 	struct bthost *bthost;
 
 	if (status != MGMT_STATUS_SUCCESS) {
@@ -587,10 +594,15 @@ static void setup_powered_client_callback(uint8_t status, uint16_t length,
 
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_set_cmd_complete_cb(bthost, client_cmd_complete, user_data);
-	if (data->hciemu_type == HCIEMU_TYPE_LE)
-		bthost_set_adv_enable(bthost, 0x01);
-	else
+
+	if (data->hciemu_type == HCIEMU_TYPE_LE) {
+		if (!l2data || !l2data->server_not_advertising)
+			bthost_set_adv_enable(bthost, 0x01);
+		else
+			tester_setup_complete();
+	} else {
 		bthost_write_scan_enable(bthost, 0x03);
+	}
 }
 
 static void setup_powered_server_callback(uint8_t status, uint16_t length,
@@ -1272,18 +1284,100 @@ static gboolean test_close_socket_1_part_2(gpointer args)
 	return FALSE;
 }
 
+static gboolean test_close_socket_2_part_3(gpointer arg)
+{
+	struct test_data *data = tester_get_data();
+	int sk = data->sk;
+	int err;
+
+	/* Scan should be already over, we're trying to create connection */
+	if (hciemu_is_master_le_scan_enabled(data->hciemu)) {
+		tester_print("Error - should no longer scan");
+		tester_test_failed();
+		return FALSE;
+	}
+
+	/* Calling close() should eventually cause CMD_LE_CREATE_CONN_CANCEL */
+	err = close(sk);
+	if (err < 0) {
+		tester_print("Error when closing socket");
+		tester_test_failed();
+		return FALSE;
+	}
+
+	/* CMD_LE_CREATE_CONN_CANCEL will trigger test pass. */
+	return FALSE;
+}
+
+static bool test_close_socket_cc_hook(const void *data, uint16_t len,
+							void *user_data)
+{
+	return false;
+}
+
+static gboolean test_close_socket_2_part_2(gpointer arg)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	/* Make sure CMD_LE_CREATE_CONN will not immediately result in
+	 * BT_HCI_EVT_CONN_COMPLETE.
+	 */
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT,
+		BT_HCI_CMD_LE_CREATE_CONN, test_close_socket_cc_hook, NULL);
+
+	/* Advertise once. After that, kernel should stop scanning, and trigger
+	 * BT_HCI_CMD_LE_CREATE_CONN_CANCEL.
+	 */
+	bthost_set_adv_enable(bthost, 0x01);
+	bthost_set_adv_enable(bthost, 0x00);
+	return FALSE;
+}
+
+static void test_close_socket_scan_enabled(void)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+
+	if (l2data == &le_client_close_socket_test_1)
+		g_idle_add(test_close_socket_1_part_2, NULL);
+	else if (l2data == &le_client_close_socket_test_2)
+		g_idle_add(test_close_socket_2_part_2, NULL);
+}
+
+static void test_close_socket_scan_disabled(void)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+
+	if (l2data == &le_client_close_socket_test_1)
+		g_idle_add(test_close_socket_1_part_3, NULL);
+	else if (l2data == &le_client_close_socket_test_2)
+		g_idle_add(test_close_socket_2_part_3, NULL);
+}
+
+static void test_close_socket_conn_cancel(void)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+
+	if (l2data == &le_client_close_socket_test_2)
+		tester_test_passed();
+}
+
 static void test_close_socket_router(uint16_t opcode, const void *param,
 					uint8_t length, void *user_data)
 {
 	/* tester_print("HCI Command 0x%04x length %u", opcode, length); */
-
 	if (opcode == BT_HCI_CMD_LE_SET_SCAN_ENABLE) {
 		const struct bt_hci_cmd_le_set_scan_enable *scan_params = param;
 
 		if (scan_params->enable == true)
-			g_idle_add(test_close_socket_1_part_2, NULL);
+			test_close_socket_scan_enabled();
 		else
-			g_idle_add(test_close_socket_1_part_3, NULL);
+			test_close_socket_scan_disabled();
+	} else if (opcode == BT_HCI_CMD_LE_CREATE_CONN_CANCEL) {
+		test_close_socket_conn_cancel();
 	}
 }
 
@@ -1625,6 +1719,11 @@ int main(int argc, char *argv[])
 				setup_powered_client,
 				test_close_socket);
 
+	test_l2cap_le("L2CAP LE Client - Close socket 2",
+				&le_client_close_socket_test_2,
+				setup_powered_client,
+				test_close_socket);
+
 	test_l2cap_le("L2CAP LE Client - Invalid PSM",
 					&le_client_connect_nval_psm_test,
 					setup_powered_client, test_connect);
-- 
2.5.0

