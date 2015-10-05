Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v4 2/5] tools/l2cap-tester: add close socket test
Date: Mon,  5 Oct 2015 11:28:26 -0700
Message-Id: <1444069709-27307-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1444069709-27307-1-git-send-email-jpawlowski@google.com>
References: <1444069709-27307-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds test that checks folowing:
1. Try to connect to non-existing remote BLE device using socket.
2. Internally in kernel this adds this device to whitelist and enable scan.
3. At this moment test would try to close socket.
4. That should cause scan to be stopped.
---
 tools/l2cap-tester.c | 183 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 169 insertions(+), 14 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 2b89045..0885209 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -53,6 +53,7 @@ struct test_data {
 	uint16_t handle;
 	uint16_t scid;
 	uint16_t dcid;
+	int sk;
 };
 
 struct l2cap_data {
@@ -85,6 +86,8 @@ struct l2cap_data {
 
 	bool addr_type_avail;
 	uint8_t addr_type;
+
+	uint8_t *client_bdaddr;
 };
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -450,6 +453,12 @@ static const struct l2cap_data le_client_connect_reject_test_2 = {
 	.addr_type = BDADDR_LE_PUBLIC,
 };
 
+static uint8_t nonexisting_bdaddr[] = {0x00, 0xAA, 0x01, 0x02, 0x03, 0x00};
+static const struct l2cap_data le_client_close_socket_test_1 = {
+	.client_psm = 0x0080,
+	.client_bdaddr = nonexisting_bdaddr,
+};
+
 static const struct l2cap_data le_client_connect_nval_psm_test = {
 	.client_psm = 0x0080,
 	.expect_err = ECONNREFUSED,
@@ -1013,33 +1022,24 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm,
 	return sk;
 }
 
-static int connect_l2cap_sock(struct test_data *data, int sk, uint16_t psm,
-								uint16_t cid)
+static int connect_l2cap_impl(int sk, const uint8_t *bdaddr,
+				uint8_t bdaddr_type, uint16_t psm, uint16_t cid)
 {
-	const struct l2cap_data *l2data = data->test_data;
-	const uint8_t *client_bdaddr;
 	struct sockaddr_l2 addr;
 	int err;
 
-	client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
-	if (!client_bdaddr) {
+	if (!bdaddr) {
 		tester_warn("No client bdaddr");
 		return -ENODEV;
 	}
 
 	memset(&addr, 0, sizeof(addr));
 	addr.l2_family = AF_BLUETOOTH;
-	bacpy(&addr.l2_bdaddr, (void *) client_bdaddr);
+	bacpy(&addr.l2_bdaddr, (void *) bdaddr);
+	addr.l2_bdaddr_type = bdaddr_type;
 	addr.l2_psm = htobs(psm);
 	addr.l2_cid = htobs(cid);
 
-	if (l2data && l2data->addr_type_avail)
-		addr.l2_bdaddr_type = l2data->addr_type;
-	else if (data->hciemu_type == HCIEMU_TYPE_LE)
-		addr.l2_bdaddr_type = BDADDR_LE_PUBLIC;
-	else
-		addr.l2_bdaddr_type = BDADDR_BREDR;
-
 	err = connect(sk, (struct sockaddr *) &addr, sizeof(addr));
 	if (err < 0 && !(errno == EAGAIN || errno == EINPROGRESS)) {
 		err = -errno;
@@ -1051,6 +1051,33 @@ static int connect_l2cap_sock(struct test_data *data, int sk, uint16_t psm,
 	return 0;
 }
 
+static int connect_l2cap_sock(struct test_data *data, int sk, uint16_t psm,
+								uint16_t cid)
+{
+	const struct l2cap_data *l2data = data->test_data;
+	const uint8_t *client_bdaddr;
+	uint8_t bdaddr_type;
+
+	if (l2data->client_bdaddr != NULL)
+		client_bdaddr = l2data->client_bdaddr;
+	else
+		client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
+
+	if (!client_bdaddr) {
+		tester_warn("No client bdaddr");
+		return -ENODEV;
+	}
+
+	if (l2data && l2data->addr_type_avail)
+		bdaddr_type = l2data->addr_type;
+	else if (data->hciemu_type == HCIEMU_TYPE_LE)
+		bdaddr_type = BDADDR_LE_PUBLIC;
+	else
+		bdaddr_type = BDADDR_BREDR;
+
+	return connect_l2cap_impl(sk, client_bdaddr, bdaddr_type, psm, cid);
+}
+
 static void client_l2cap_connect_cb(uint16_t handle, uint16_t cid,
 							void *user_data)
 {
@@ -1122,6 +1149,128 @@ static void test_connect_reject(const void *test_data)
 	close(sk);
 }
 
+static void connect_socket(const uint8_t *client_bdaddr, int *sk_holder,
+							GIOFunc connect_cb)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+	GIOChannel *io;
+	int sk;
+
+	sk = create_l2cap_sock(data, 0, l2data->cid, l2data->sec_level);
+	if (sk < 0) {
+		tester_print("Error in create_l2cap_sock");
+		tester_test_failed();
+		return;
+	}
+
+	*sk_holder = sk;
+
+	if (connect_l2cap_impl(sk, client_bdaddr, BDADDR_LE_PUBLIC,
+			l2data->client_psm, l2data->cid) < 0) {
+		tester_print("Error in connect_l2cap_sock");
+		close(sk);
+		tester_test_failed();
+		return;
+	}
+
+	if (connect_cb) {
+		io = g_io_channel_unix_new(sk);
+		g_io_channel_set_close_on_unref(io, TRUE);
+
+		data->io_id = g_io_add_watch(io, G_IO_OUT, connect_cb, NULL);
+
+		g_io_channel_unref(io);
+	}
+
+	tester_print("Connect in progress, sk = %d", sk);
+}
+
+static gboolean test_close_socket_1_part_3(gpointer arg)
+{
+	struct test_data *data = tester_get_data();
+
+	tester_print("Checking whether scan was properly stopped...");
+
+	if (data->sk != -1) {
+		tester_print("Error - scan was not enabled yet");
+		tester_test_failed();
+		return FALSE;
+	}
+
+	if (hciemu_is_master_le_scan_enabled(data->hciemu)) {
+		tester_print("Delayed check whether scann is off failed");
+		tester_test_failed();
+		return FALSE;
+	}
+
+	tester_test_passed();
+	return FALSE;
+}
+
+static gboolean test_close_socket_1_part_2(gpointer args)
+{
+	struct test_data *data = tester_get_data();
+	int sk = data->sk;
+
+	tester_print("Will close socket during scan phase...");
+
+	/* We tried to conect to LE device that is not advertising. It was added
+	 * to kernel whitelist, and scan was started. We should be still
+	 * scanning.
+	 */
+	if (!hciemu_is_master_le_scan_enabled(data->hciemu)) {
+		tester_print("Error - should be still scanning");
+		tester_test_failed();
+		return FALSE;
+	}
+
+	/* Calling close() should remove device from  whitelist, and stop
+	 * the scan.
+	 */
+	if (close(sk) < 0) {
+		tester_print("Error when closing socket");
+		tester_test_failed();
+		return FALSE;
+	}
+
+	data->sk = -1;
+	/* tester_test_passed will be called when scan is stopped. */
+	return FALSE;
+}
+
+static void test_close_socket_router(uint16_t opcode, const void *param,
+					uint8_t length, void *user_data)
+{
+	/* tester_print("HCI Command 0x%04x length %u", opcode, length); */
+
+	if (opcode == BT_HCI_CMD_LE_SET_SCAN_ENABLE) {
+		const struct bt_hci_cmd_le_set_scan_enable *scan_params = param;
+
+		if (scan_params->enable == true)
+			g_idle_add(test_close_socket_1_part_2, NULL);
+		else
+			g_idle_add(test_close_socket_1_part_3, NULL);
+	}
+}
+
+static void test_close_socket(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+	const uint8_t *client_bdaddr;
+
+	hciemu_add_master_post_command_hook(data->hciemu,
+					test_close_socket_router, data);
+
+	if (l2data->client_bdaddr != NULL)
+		client_bdaddr = l2data->client_bdaddr;
+	else
+		client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
+
+	connect_socket(client_bdaddr, &data->sk, NULL);
+}
+
 static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1437,6 +1586,12 @@ int main(int argc, char *argv[])
 	test_l2cap_bredr("L2CAP LE Client - Connection Reject",
 				&le_client_connect_reject_test_2,
 				setup_powered_client, test_connect_reject);
+
+	test_l2cap_le("L2CAP LE Client - Close socket 1",
+				&le_client_close_socket_test_1,
+				setup_powered_client,
+				test_close_socket);
+
 	test_l2cap_le("L2CAP LE Client - Invalid PSM",
 					&le_client_connect_nval_psm_test,
 					setup_powered_client, test_connect);
-- 
2.5.0

