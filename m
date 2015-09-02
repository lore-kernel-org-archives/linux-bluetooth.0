Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v3 8/8] tools/l2cap-tester: Connect to two devices test.
Date: Wed,  2 Sep 2015 10:51:15 -0700
Message-Id: <1441216275-2954-8-git-send-email-jpawlowski@google.com>
In-Reply-To: <1441216275-2954-1-git-send-email-jpawlowski@google.com>
References: <1441216275-2954-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test tries to connect to two devices at same device, and makes sure
that both connections are successfull.
---
 tools/l2cap-tester.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 125 insertions(+), 4 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 46913d2..4f96494 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -57,6 +57,13 @@ struct test_data {
 	int sk2;
 };
 
+/* values of second_socket_dest */
+enum {
+	CLIENT_1,
+	CLIENT_2,
+	UNKNOWN_HOST
+};
+
 struct l2cap_data {
 	uint16_t client_psm;
 	uint16_t server_psm;
@@ -91,6 +98,7 @@ struct l2cap_data {
 	uint8_t *client_bdaddr;
 	bool server_not_advertising;
 	bool close_one_socket;
+	uint8_t second_socket_dest;
 };
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -471,6 +479,14 @@ static const struct l2cap_data le_client_two_sockets_same_client = {
 	.client_psm = 0x0080,
 	.server_psm = 0x0080,
 	.server_not_advertising = true,
+	.second_socket_dest = CLIENT_1,
+};
+
+static const struct l2cap_data le_client_two_sockets_2 = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.server_not_advertising = true,
+	.second_socket_dest = CLIENT_2,
 };
 
 static const struct l2cap_data le_client_two_sockets_close_one = {
@@ -478,6 +494,7 @@ static const struct l2cap_data le_client_two_sockets_close_one = {
 	.server_psm = 0x0080,
 	.server_not_advertising = true,
 	.close_one_socket = true,
+	.second_socket_dest = CLIENT_1,
 };
 
 static const struct l2cap_data le_client_connect_nval_psm_test = {
@@ -542,6 +559,39 @@ static void client_cmd_complete(uint16_t opcode, uint8_t status,
 		tester_setup_complete();
 }
 
+static void client_2_cmd_complete(uint16_t opcode, uint8_t status,
+					const void *param, uint8_t len,
+					void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *test = data->test_data;
+	struct bthost *bthost;
+
+	bthost = hciemu_client_2_get_host(data->hciemu);
+
+	switch (opcode) {
+	case BT_HCI_CMD_WRITE_SCAN_ENABLE:
+	case BT_HCI_CMD_LE_SET_ADV_ENABLE:
+		tester_print("Client 2 set connectable status 0x%02x", status);
+		if (!status && test && test->enable_ssp) {
+			bthost_write_ssp_mode(bthost, 0x01);
+			return;
+		}
+		break;
+	case BT_HCI_CMD_WRITE_SIMPLE_PAIRING_MODE:
+		tester_print("Client enable SSP status 0x%02x", status);
+		break;
+	default:
+		return;
+	}
+
+
+	if (status)
+		tester_setup_failed();
+	else
+		tester_setup_complete();
+}
+
 static void server_cmd_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -565,7 +615,7 @@ static void setup_powered_client_callback(uint8_t status, uint16_t length,
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
-	struct bthost *bthost;
+	struct bthost *bthost, *bthost_2;
 
 	if (status != MGMT_STATUS_SUCCESS) {
 		tester_setup_failed();
@@ -577,6 +627,9 @@ static void setup_powered_client_callback(uint8_t status, uint16_t length,
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_set_cmd_complete_cb(bthost, client_cmd_complete, user_data);
 
+	bthost_2 = hciemu_client_2_get_host(data->hciemu);
+	bthost_set_cmd_complete_cb(bthost_2, client_2_cmd_complete, user_data);
+
 	if (data->hciemu_type == HCIEMU_TYPE_LE) {
 		if (!l2data || !l2data->server_not_advertising)
 			bthost_set_adv_enable(bthost, 0x01);
@@ -702,6 +755,50 @@ static void send_rsp_new_conn(uint16_t handle, void *user_data)
 						bthost_send_rsp, NULL);
 }
 
+static void bthost_send_rsp_2(const void *buf, uint16_t len, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+	struct bthost *bthost;
+
+	if (l2data->expect_cmd_len && len != l2data->expect_cmd_len) {
+		tester_test_failed();
+		return;
+	}
+
+	if (l2data->expect_cmd && memcmp(buf, l2data->expect_cmd,
+						l2data->expect_cmd_len)) {
+		tester_test_failed();
+		return;
+	}
+
+	if (!l2data->send_cmd)
+		return;
+
+	bthost = hciemu_client_2_get_host(data->hciemu);
+	bthost_send_cid(bthost, data->handle, data->dcid,
+				l2data->send_cmd, l2data->send_cmd_len);
+}
+
+static void send_rsp_new_conn_2(uint16_t handle, void *user_data)
+{
+	struct test_data *data = user_data;
+	struct bthost *bthost;
+
+	tester_print("New connection with handle 0x%04x", handle);
+
+	data->handle = handle;
+
+	if (data->hciemu_type == HCIEMU_TYPE_LE)
+		data->dcid = 0x0005;
+	else
+		data->dcid = 0x0001;
+
+	bthost = hciemu_client_2_get_host(data->hciemu);
+	bthost_add_cid_hook(bthost, data->handle, data->dcid,
+						bthost_send_rsp_2, NULL);
+}
+
 static void setup_powered_common(void)
 {
 	struct test_data *data = tester_get_data();
@@ -750,8 +847,13 @@ static void setup_powered_client(const void *test_data)
 	tester_print("Powering on controller");
 
 	if (test && (test->expect_cmd || test->send_cmd)) {
-		struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+		struct bthost *bthost, *bthost_2;
+
+		bthost = hciemu_client_get_host(data->hciemu);
+		bthost_2 = hciemu_client_2_get_host(data->hciemu);
+
 		bthost_set_connect_cb(bthost, send_rsp_new_conn, data);
+		bthost_set_connect_cb(bthost_2, send_rsp_new_conn_2, data);
 	}
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
@@ -1388,6 +1490,8 @@ static gboolean test_two_sockets_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	sk = g_io_channel_unix_get_fd(io);
 
+	tester_print("test_two_sockets_connect_cb *******************\n");
+
 	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
 		err = -errno;
 	else
@@ -1420,8 +1524,10 @@ static gboolean enable_advertising(gpointer args)
 {
 	struct test_data *data = tester_get_data();
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	struct bthost *bthost_2 = hciemu_client_2_get_host(data->hciemu);
 
 	bthost_set_adv_enable(bthost, 0x01);
+	bthost_set_adv_enable(bthost_2, 0x01);
 }
 
 void test_connect_two_sockets_part_2(void)
@@ -1431,6 +1537,11 @@ void test_connect_two_sockets_part_2(void)
 	const uint8_t *client_bdaddr;
 
 	client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
+	if (l2data->second_socket_dest == CLIENT_1)
+		client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
+	else if (l2data->second_socket_dest == CLIENT_2)
+		client_bdaddr = hciemu_get_client_2_bdaddr(data->hciemu);
+
 	connect_socket(client_bdaddr, &data->sk2, test_two_sockets_connect_cb);
 
 	if (l2data->close_one_socket) {
@@ -1438,7 +1549,8 @@ void test_connect_two_sockets_part_2(void)
 		close(data->sk);
 	}
 
-	g_idle_add(enable_advertising, NULL);
+	if (l2data->second_socket_dest == CLIENT_1)
+		g_idle_add(enable_advertising, NULL);
 }
 
 static uint8_t test_scan_enable_counter;
@@ -1472,10 +1584,14 @@ static void test_connect_two_sockets(const void *test_data)
 
 	if (l2data->server_psm) {
 		struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+		struct bthost *bthost_2 = hciemu_client_get_host(data->hciemu);
 
-		if (!l2data->data_len)
+		if (!l2data->data_len) {
 			bthost_add_l2cap_server(bthost, l2data->server_psm,
 						NULL, NULL);
+			bthost_add_l2cap_server(bthost_2, l2data->server_psm,
+						NULL, NULL);
+		}
 	}
 
 	client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
@@ -1817,6 +1933,11 @@ int main(int argc, char *argv[])
 				setup_powered_client,
 				test_connect_two_sockets);
 
+	test_l2cap_le("L2CAP LE Client - Open two sockets 2",
+				&le_client_two_sockets_2,
+				setup_powered_client,
+				test_connect_two_sockets);
+
 	test_l2cap_le("L2CAP LE Client - Open two sockets close one",
 				&le_client_two_sockets_close_one,
 				setup_powered_client,
-- 
2.1.4

