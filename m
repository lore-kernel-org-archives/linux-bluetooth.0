Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v3 5/8] tools/l2cap-tester: Two socket connect test
Date: Wed,  2 Sep 2015 10:51:12 -0700
Message-Id: <1441216275-2954-5-git-send-email-jpawlowski@google.com>
In-Reply-To: <1441216275-2954-1-git-send-email-jpawlowski@google.com>
References: <1441216275-2954-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test tries to open two sockets to same address, to make sure
both would succeed.
---
 tools/l2cap-tester.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 1b7ee94..5e56934 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -54,6 +54,7 @@ struct test_data {
 	uint16_t scid;
 	uint16_t dcid;
 	int sk;
+	int sk2;
 };
 
 struct l2cap_data {
@@ -465,6 +466,12 @@ static const struct l2cap_data le_client_close_socket_test_2 = {
 	.server_not_advertising = true,
 };
 
+static const struct l2cap_data le_client_two_sockets_same_client = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.server_not_advertising = true,
+};
+
 static const struct l2cap_data le_client_connect_nval_psm_test = {
 	.client_psm = 0x0080,
 	.expect_err = ECONNREFUSED,
@@ -1360,6 +1367,97 @@ static void test_close_socket(const void *test_data)
 	connect_socket(client_bdaddr, &data->sk, NULL);
 }
 
+static uint8_t test_two_sockets_connect_cb_cnt;
+static gboolean test_two_sockets_connect_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+	int err, sk_err, sk;
+	socklen_t len = sizeof(sk_err);
+
+	data->io_id = 0;
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
+		err = -errno;
+	else
+		err = -sk_err;
+
+	if (err < 0) {
+		tester_warn("Connect failed: %s (%d)", strerror(-err), -err);
+		tester_test_failed();
+		return FALSE;
+	}
+
+	tester_print("Successfully connected");
+	test_two_sockets_connect_cb_cnt++;
+
+	if (test_two_sockets_connect_cb_cnt == 2) {
+		close(data->sk);
+		close(data->sk2);
+		tester_test_passed();
+	}
+
+	return FALSE;
+}
+
+static gboolean enable_advertising(gpointer args)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	bthost_set_adv_enable(bthost, 0x01);
+}
+
+void test_connect_two_sockets_part_2(void)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+	const uint8_t *client_bdaddr;
+
+	client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
+	connect_socket(client_bdaddr, &data->sk2, test_two_sockets_connect_cb);
+
+	g_idle_add(enable_advertising, NULL);
+}
+
+static void test_connect_two_sockets_router(uint16_t opcode, const void *param,
+					uint8_t length, void *user_data)
+{
+	const struct bt_hci_cmd_le_set_scan_enable *scan_params = param;
+
+	tester_print("HCI Command 0x%04x length %u", opcode, length);
+	if (opcode == BT_HCI_CMD_LE_SET_SCAN_ENABLE &&
+						scan_params->enable == true) {
+		test_connect_two_sockets_part_2();
+	}
+}
+
+static void test_connect_two_sockets(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+	const uint8_t *client_bdaddr;
+
+	test_two_sockets_connect_cb_cnt = 0;
+
+	hciemu_add_master_post_command_hook(data->hciemu,
+				test_connect_two_sockets_router, data);
+
+	if (l2data->server_psm) {
+		struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+		if (!l2data->data_len)
+			bthost_add_l2cap_server(bthost, l2data->server_psm,
+						NULL, NULL);
+	}
+
+	client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
+	connect_socket(client_bdaddr, &data->sk, test_two_sockets_connect_cb);
+}
+
 static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1686,6 +1784,11 @@ int main(int argc, char *argv[])
 				setup_powered_client,
 				test_close_socket);
 
+	test_l2cap_le("L2CAP LE Client - Open two sockets",
+				&le_client_two_sockets_same_client,
+				setup_powered_client,
+				test_connect_two_sockets);
+
 	test_l2cap_le("L2CAP LE Client - Invalid PSM",
 					&le_client_connect_nval_psm_test,
 					setup_powered_client, test_connect);
-- 
2.1.4

