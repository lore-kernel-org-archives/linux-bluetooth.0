Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] tools/rfcomm-tester: Add RFCOMM server read test case
Date: Wed, 12 Feb 2014 12:41:41 +0100
Message-Id: <1392205301-4204-7-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1392205301-4204-1-git-send-email-marcin.kraglak@tieto.com>
References: <1392205301-4204-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will test reading data passed to RFCOMM socket on server side.
---
 tools/rfcomm-tester.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index b46f95a..1af64f1 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -338,6 +338,14 @@ const struct rfcomm_server_data listen_send_success = {
 	.send_data = data
 };
 
+const struct rfcomm_server_data listen_read_success = {
+	.server_channel = 0x0c,
+	.client_channel = 0x0c,
+	.expected_status = true,
+	.data_len = sizeof(data),
+	.read_data = data
+};
+
 const struct rfcomm_server_data listen_nval = {
 	.server_channel = 0x0c,
 	.client_channel = 0x0e,
@@ -544,6 +552,29 @@ static void test_connect(const void *test_data)
 	tester_print("Connect in progress %d", sk);
 }
 
+static gboolean server_received_data(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct rfcomm_server_data *server_data = data->test_data;
+	char buf[1024];
+	int sk;
+
+	sk = g_io_channel_unix_get_fd(io);
+	if (read(sk, buf, server_data->data_len) != server_data->data_len) {
+		tester_warn("Unable to read %u bytes", server_data->data_len);
+		tester_test_failed();
+		return false;
+	}
+
+	if (memcmp(buf, server_data->read_data, server_data->data_len))
+		tester_test_failed();
+	else
+		tester_test_passed();
+
+	return false;
+}
+
 static gboolean rfcomm_listen_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -568,6 +599,17 @@ static gboolean rfcomm_listen_cb(GIOChannel *io, GIOCondition cond,
 			tester_test_failed();
 		close(new_sk);
 		return false;
+	} else if (server_data->read_data) {
+		GIOChannel *new_io;
+
+		new_io = g_io_channel_unix_new(new_sk);
+		g_io_channel_set_close_on_unref(new_io, TRUE);
+
+		data->io_id = g_io_add_watch(new_io, G_IO_IN,
+						server_received_data, NULL);
+
+		g_io_channel_unref(new_io);
+		return false;
 	}
 
 	close(new_sk);
@@ -583,8 +625,18 @@ static void connection_cb(uint16_t handle, uint16_t cid, void *user_data,
 	struct test_data *data = tester_get_data();
 	const struct rfcomm_server_data *server_data = data->test_data;
 
-	if (server_data->data_len)
+	if (server_data->read_data) {
+		data->conn_handle = handle;
+		data->cid = cid;
+		bthost_send_uih(hciemu_client_get_host(data->hciemu),
+						data->conn_handle, data->cid,
+						server_data->client_channel,
+						server_data->read_data,
+						server_data->data_len);
 		return;
+	} else if (server_data->data_len) {
+		return;
+	}
 
 	if (server_data->expected_status == status)
 		tester_test_passed();
@@ -681,7 +733,9 @@ int main(int argc, char *argv[])
 	test_rfcomm("Basic RFCOMM Socket Server - Write Success",
 				&listen_send_success, setup_powered_server,
 				test_server);
-
+	test_rfcomm("Basic RFCOMM Socket Server - Read Success",
+				&listen_read_success, setup_powered_server,
+				test_server);
 	test_rfcomm("Basic RFCOMM Socket Server - Conn Refused", &listen_nval,
 					setup_powered_server, test_server);
 
-- 
1.8.3.1

