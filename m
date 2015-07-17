Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v2 6/6] tools/l2cap-tester: add close socket test
Date: Fri, 17 Jul 2015 22:51:40 +0200
Message-Id: <1437166300-14633-6-git-send-email-jpawlowski@google.com>
In-Reply-To: <1437166300-14633-1-git-send-email-jpawlowski@google.com>
References: <1437166300-14633-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds test that checks folowing:
1. Try to connect to existing remote BLE device using socket.
2. Internally in kernel this adds this device to whitelist and start scan.
3. At this moment remote device advertises just once.
4. This causes kernel to stop scan, and send connect request.
5. Call close() on socket, this should cause le_conn_canel request
   to controller.
---
 tools/l2cap-tester.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 3 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index beaec8a..d46fb90 100644
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
@@ -543,6 +549,7 @@ static void setup_powered_client_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
 	struct bthost *bthost;
 
 	if (status != MGMT_STATUS_SUCCESS) {
@@ -554,10 +561,15 @@ static void setup_powered_client_callback(uint8_t status, uint16_t length,
 
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
@@ -1231,6 +1243,90 @@ static void test_close_socket_1(const void *test_data)
 	tester_print("Connect in progress");
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
+static gboolean test_close_socket_2_part_2(gpointer arg)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	/* Make sure CMD_LE_CREATE_CONN will not immediately result in
+	 * BT_HCI_EVT_CONN_COMPLETE.
+	 */
+	hciemu_set_client_le_noresp_conn_request(data->hciemu, true);
+
+	/* Advertise once. After that, kernel should stop scanning, and trigger
+	 * BT_HCI_CMD_LE_CREATE_CONN_CANCEL.
+	 */
+	bthost_set_adv_enable(bthost, 0x01);
+	bthost_set_adv_enable(bthost, 0x00);
+}
+
+static void test_close_socket_2_router(uint16_t opcode, const void *param,
+					uint8_t length, void *user_data)
+{
+	/* tester_print("HCI Command 0x%04x length %u", opcode, length); */
+
+	if (opcode == BT_HCI_CMD_LE_SET_SCAN_ENABLE) {
+		const struct bt_hci_cmd_le_set_scan_enable *scan_params = param;
+
+		if (scan_params->enable == true)
+			g_idle_add(test_close_socket_2_part_2, NULL);
+		else
+			g_idle_add(test_close_socket_2_part_3, NULL);
+	} else if (opcode == BT_HCI_CMD_LE_CREATE_CONN_CANCEL)
+		tester_test_passed();
+}
+
+static void test_close_socket_2(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+	int sk;
+
+	hciemu_add_master_post_command_hook(data->hciemu,
+				test_close_socket_2_router, data);
+
+	sk = create_l2cap_sock(data, 0, l2data->cid, l2data->sec_level);
+	if (sk < 0) {
+		tester_test_failed();
+		return;
+	}
+
+	data->sk = sk;
+	if (connect_l2cap_sock(data, sk, l2data->client_psm,
+							l2data->cid) < 0) {
+		close(sk);
+		tester_test_failed();
+		return;
+	}
+
+	tester_print("Connect in progress");
+}
+
 static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1552,6 +1648,11 @@ int main(int argc, char *argv[])
 				setup_powered_client,
 				test_close_socket_1);
 
+	test_l2cap_le("L2CAP LE Client - Close socket 2",
+				&le_client_close_socket_test_2,
+				setup_powered_client,
+				test_close_socket_2);
+
 	test_l2cap_le("L2CAP LE Client - Invalid PSM",
 					&le_client_connect_nval_psm_test,
 					setup_powered_client, test_connect);
-- 
2.1.4

