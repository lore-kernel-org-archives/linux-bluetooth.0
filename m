Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] tools/rfcomm-tester: Add RFCOMM client read test case
Date: Wed, 12 Feb 2014 12:41:40 +0100
Message-Id: <1392205301-4204-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1392205301-4204-1-git-send-email-marcin.kraglak@tieto.com>
References: <1392205301-4204-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will test reading data passed to RFCOMM socket on client side.
---
 tools/rfcomm-tester.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 1c2563d..b46f95a 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -51,6 +51,8 @@ struct test_data {
 	enum hciemu_type hciemu_type;
 	const void *test_data;
 	unsigned int io_id;
+	uint16_t conn_handle;
+	uint16_t cid;
 };
 
 struct rfcomm_client_data {
@@ -309,6 +311,13 @@ const struct rfcomm_client_data connect_send_success = {
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
@@ -389,6 +398,30 @@ static int connect_rfcomm_sock(int sk, const bdaddr_t *bdaddr, uint8_t channel)
 	return 0;
 }
 
+static gboolean client_received_data(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct rfcomm_client_data *client_data = data->test_data;
+	int sk;
+	char buf[248];
+
+	sk = g_io_channel_unix_get_fd(io);
+
+
+	if (client_data->data_len != read(sk, buf, client_data->data_len)) {
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
@@ -417,6 +450,15 @@ static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
 							client_data->data_len))
 			tester_test_failed();
 		return false;
+	} else if (client_data->read_data) {
+		g_io_add_watch(io, G_IO_IN, client_received_data,
+									NULL);
+		bthost_send_uih(hciemu_client_get_host(data->hciemu),
+						data->conn_handle, data->cid,
+						client_data->client_channel,
+						client_data->read_data,
+						client_data->data_len);
+		return false;
 	}
 
 	if (err < 0)
@@ -457,10 +499,14 @@ static void rfcomm_connect_cb(uint16_t handle, uint16_t cid,
 	struct test_data *data = tester_get_data();
 	const struct rfcomm_client_data *client_data = data->test_data;
 
-	if (client_data->send_data)
+	if (client_data->send_data) {
 		bthost_add_channel_hook(hciemu_client_get_host(data->hciemu),
 					handle,	client_data->client_channel,
 					client_hook_func, NULL);
+	} else if (client_data->read_data) {
+		data->conn_handle = handle;
+		data->cid = cid;
+	}
 }
 
 static void test_connect(const void *test_data)
@@ -625,6 +671,9 @@ int main(int argc, char *argv[])
 	test_rfcomm("Basic RFCOMM Socket Client - Write Success",
 			&connect_send_success, setup_powered_client,
 			test_connect);
+	test_rfcomm("Basic RFCOMM Socket Client - Read Success",
+			&connect_read_success, setup_powered_client,
+			test_connect);
 	test_rfcomm("Basic RFCOMM Socket Client - Conn Refused",
 			&connect_nval, setup_powered_client, test_connect);
 	test_rfcomm("Basic RFCOMM Socket Server - Success", &listen_success,
-- 
1.8.3.1

