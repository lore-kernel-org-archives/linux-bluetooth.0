Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v4 5/5] tools/l2cap-tester connect two sockets disconnect one test
Date: Mon,  5 Oct 2015 11:28:29 -0700
Message-Id: <1444069709-27307-5-git-send-email-jpawlowski@google.com>
In-Reply-To: <1444069709-27307-1-git-send-email-jpawlowski@google.com>
References: <1444069709-27307-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test open two sockets to same client, then close first one and make
sure second one connect successfully.
---
 tools/l2cap-tester.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index a483977..12360aa 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -90,6 +90,7 @@ struct l2cap_data {
 
 	uint8_t *client_bdaddr;
 	bool server_not_advertising;
+	bool close_one_socket;
 };
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -472,6 +473,13 @@ static const struct l2cap_data le_client_two_sockets_same_client = {
 	.server_not_advertising = true,
 };
 
+static const struct l2cap_data le_client_two_sockets_close_one = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.server_not_advertising = true,
+	.close_one_socket = true,
+};
+
 static const struct l2cap_data le_client_connect_nval_psm_test = {
 	.client_psm = 0x0080,
 	.expect_err = ECONNREFUSED,
@@ -1377,6 +1385,7 @@ static gboolean test_two_sockets_connect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
 	int err, sk_err, sk;
 	socklen_t len = sizeof(sk_err);
 
@@ -1404,6 +1413,11 @@ static gboolean test_two_sockets_connect_cb(GIOChannel *io, GIOCondition cond,
 		tester_test_passed();
 	}
 
+	if (l2data->close_one_socket && test_two_sockets_connect_cb_cnt == 1) {
+		close(data->sk2);
+		tester_test_passed();
+	}
+
 	return FALSE;
 }
 
@@ -1419,14 +1433,21 @@ static gboolean enable_advertising(gpointer args)
 static void test_connect_two_sockets_part_2(void)
 {
 	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
 	const uint8_t *client_bdaddr;
 
 	client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
 	connect_socket(client_bdaddr, &data->sk2, test_two_sockets_connect_cb);
 
+	if (l2data->close_one_socket) {
+		tester_print("Closing first socket! %d", data->sk);
+		close(data->sk);
+	}
+
 	g_idle_add(enable_advertising, NULL);
 }
 
+static uint8_t test_scan_enable_counter;
 static void test_connect_two_sockets_router(uint16_t opcode, const void *param,
 					uint8_t length, void *user_data)
 {
@@ -1435,7 +1456,11 @@ static void test_connect_two_sockets_router(uint16_t opcode, const void *param,
 	tester_print("HCI Command 0x%04x length %u", opcode, length);
 	if (opcode == BT_HCI_CMD_LE_SET_SCAN_ENABLE &&
 						scan_params->enable == true) {
-		test_connect_two_sockets_part_2();
+		test_scan_enable_counter++;
+		if (test_scan_enable_counter == 1)
+			test_connect_two_sockets_part_2();
+		else if (test_scan_enable_counter == 2)
+			g_idle_add(enable_advertising, NULL);
 	}
 }
 
@@ -1446,6 +1471,7 @@ static void test_connect_two_sockets(const void *test_data)
 	const uint8_t *client_bdaddr;
 
 	test_two_sockets_connect_cb_cnt = 0;
+	test_scan_enable_counter = 0;
 
 	hciemu_add_master_post_command_hook(data->hciemu,
 				test_connect_two_sockets_router, data);
@@ -1459,7 +1485,11 @@ static void test_connect_two_sockets(const void *test_data)
 	}
 
 	client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
-	connect_socket(client_bdaddr, &data->sk, test_two_sockets_connect_cb);
+	if (l2data->close_one_socket)
+		connect_socket(client_bdaddr, &data->sk, NULL);
+	else
+		connect_socket(client_bdaddr, &data->sk,
+						test_two_sockets_connect_cb);
 }
 
 static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
@@ -1793,6 +1823,11 @@ int main(int argc, char *argv[])
 				setup_powered_client,
 				test_connect_two_sockets);
 
+	test_l2cap_le("L2CAP LE Client - Open two sockets close one",
+				&le_client_two_sockets_close_one,
+				setup_powered_client,
+				test_connect_two_sockets);
+
 	test_l2cap_le("L2CAP LE Client - Invalid PSM",
 					&le_client_connect_nval_psm_test,
 					setup_powered_client, test_connect);
-- 
2.5.0

