Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] tools/l2cap_tester: Add read client test case
Date: Thu, 19 Dec 2013 10:30:03 +0100
Message-Id: <1387445406-20324-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1387445406-20324-1-git-send-email-marcin.kraglak@tieto.com>
References: <1387445406-20324-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test case send data from remote device to client.
It verifies if data is passed corerctly through l2cap socket.
---
 tools/l2cap-tester.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 9161953..1d00c93 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -50,12 +50,18 @@ struct test_data {
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	unsigned int io_id;
+	uint16_t handle;
+	uint16_t scid;
+	uint16_t dcid;
 };
 
 struct l2cap_client_data {
 	uint16_t client_psm;
 	uint16_t server_psm;
 	int expect_err;
+	uint16_t data_len;
+	const void *read_data;
+	const void *write_data;
 };
 
 struct l2cap_server_data {
@@ -247,6 +253,15 @@ static const struct l2cap_client_data client_connect_success_test = {
 	.server_psm = 0x1001,
 };
 
+static uint8_t l2_data[] = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
+
+static const struct  l2cap_client_data client_connect_read_success_test = {
+	.client_psm = 0x1001,
+	.server_psm = 0x1001,
+	.read_data = l2_data,
+	.data_len = sizeof(l2_data),
+};
+
 static const struct l2cap_client_data client_connect_nval_psm_test = {
 	.client_psm = 0x1001,
 	.expect_err = ECONNREFUSED,
@@ -455,6 +470,25 @@ static void test_basic(const void *test_data)
 	tester_test_passed();
 }
 
+static gboolean client_received_data(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_client_data *l2data = data->test_data;
+	char buf[1024];
+	int sk;
+
+	sk = g_io_channel_unix_get_fd(io);
+	read(sk, buf, l2data->data_len);
+
+	if (memcmp(buf, l2data->read_data, l2data->data_len))
+		tester_test_failed();
+	else
+		tester_test_passed();
+
+	return FALSE;
+}
+
 static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -477,6 +511,18 @@ static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 	else
 		tester_print("Successfully connected");
 
+	if (l2data->read_data) {
+		struct bthost *bthost;
+
+		bthost = hciemu_client_get_host(data->hciemu);
+		g_io_add_watch(io, G_IO_IN, client_received_data, NULL);
+
+		bthost_send_cid(bthost, data->handle, data->dcid,
+					l2data->read_data, l2data->data_len);
+
+		return FALSE;
+	}
+
 	if (-err != l2data->expect_err)
 		tester_test_failed();
 	else
@@ -559,6 +605,15 @@ static int connect_l2cap_sock(struct test_data *data, int sk, uint16_t psm)
 	return 0;
 }
 
+static void client_l2cap_connect_cb(uint16_t handle, uint16_t cid,
+							void *user_data)
+{
+	struct test_data *data = user_data;
+
+	data->dcid = cid;
+	data->handle = handle;
+}
+
 static void test_connect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -568,7 +623,14 @@ static void test_connect(const void *test_data)
 
 	if (l2data->server_psm) {
 		struct bthost *bthost = hciemu_client_get_host(data->hciemu);
-		bthost_set_server_psm(bthost, l2data->server_psm, NULL, NULL);
+		bthost_l2cap_connect_cb cb;
+
+		if (l2data->data_len)
+			cb = client_l2cap_connect_cb;
+		else
+			cb = NULL;
+
+		bthost_set_server_psm(bthost, l2data->server_psm, cb, data);
 	}
 
 	sk = create_l2cap_sock(data, 0);
@@ -744,6 +806,11 @@ int main(int argc, char *argv[])
 	test_l2cap_bredr("L2CAP BR/EDR Client - Success",
 					&client_connect_success_test,
 					setup_powered_client, test_connect);
+
+	test_l2cap_bredr("L2CAP BR/EDR Client - Read Success",
+					&client_connect_read_success_test,
+					setup_powered_client, test_connect);
+
 	test_l2cap_bredr("L2CAP BR/EDR Client - Invalid PSM",
 					&client_connect_nval_psm_test,
 					setup_powered_client, test_connect);
-- 
1.8.3.1

