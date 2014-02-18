Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 5/6] tools/rfcomm-tester: Add RFCOMM client read test case
Date: Tue, 18 Feb 2014 08:50:54 +0100
Message-Id: <1392709855-32600-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1392709855-32600-1-git-send-email-marcin.kraglak@tieto.com>
References: <1392709855-32600-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will test reading data passed to RFCOMM socket on client side.
---
 tools/rfcomm-tester.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 765de88..4066553 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -51,6 +51,7 @@ struct test_data {
 	enum hciemu_type hciemu_type;
 	const void *test_data;
 	unsigned int io_id;
+	uint16_t conn_handle;
 };
 
 struct rfcomm_client_data {
@@ -309,6 +310,13 @@ const struct rfcomm_client_data connect_send_success = {
 	.send_data = data
 };
 
+const struct rfcomm_client_data connect_read_success = {
+	.server_channel = 0x0c,
+	.client_channel = 0x0c,
+	.data_len = sizeof(data),
+	.read_data = data
+};
+
 const struct rfcomm_client_data connect_nval = {
 	.server_channel = 0x0c,
 	.client_channel = 0x0e,
@@ -389,6 +397,31 @@ static int connect_rfcomm_sock(int sk, const bdaddr_t *bdaddr, uint8_t channel)
 	return 0;
 }
 
+static gboolean client_received_data(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct rfcomm_client_data *client_data = data->test_data;
+	int sk;
+	ssize_t ret;
+	char buf[248];
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	ret = read(sk, buf, client_data->data_len);
+	if (client_data->data_len != ret) {
+		tester_test_failed();
+		return false;
+	}
+
+	if (memcmp(client_data->read_data, buf, client_data->data_len))
+		tester_test_failed();
+	else
+		tester_test_passed();
+
+	return false;
+}
+
 static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
 		gpointer user_data)
 {
@@ -420,6 +453,14 @@ static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
 			tester_test_failed();
 
 		return false;
+	} else if (client_data->read_data) {
+		g_io_add_watch(io, G_IO_IN, client_received_data, NULL);
+		bthost_send_rfcomm_data(hciemu_client_get_host(data->hciemu),
+						data->conn_handle,
+						client_data->client_channel,
+						client_data->read_data,
+						client_data->data_len);
+		return false;
 	}
 
 	if (err < 0)
@@ -479,6 +520,8 @@ static void rfcomm_connect_cb(uint16_t handle, uint16_t cid,
 		bthost_add_rfcomm_channel_hook(bthost, handle,
 						client_data->client_channel,
 						client_hook_func, NULL);
+	else if (client_data->read_data)
+		data->conn_handle = handle;
 }
 
 static void test_connect(const void *test_data)
@@ -645,6 +688,9 @@ int main(int argc, char *argv[])
 	test_rfcomm("Basic RFCOMM Socket Client - Write Success",
 				&connect_send_success, setup_powered_client,
 				test_connect);
+	test_rfcomm("Basic RFCOMM Socket Client - Read Success",
+				&connect_read_success, setup_powered_client,
+				test_connect);
 	test_rfcomm("Basic RFCOMM Socket Client - Conn Refused",
 			&connect_nval, setup_powered_client, test_connect);
 	test_rfcomm("Basic RFCOMM Socket Server - Success", &listen_success,
-- 
1.8.3.1

