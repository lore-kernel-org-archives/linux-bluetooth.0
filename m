Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/9 v3] gobex: add unit test for CONNECT response
Date: Fri, 11 Nov 2011 12:31:08 +0200
Message-Id: <1321007475-2236-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321007475-2236-1-git-send-email-luiz.dentz@gmail.com>
References: <1321007475-2236-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |   60 ++++++++++++++++++++++++++++++++++++++++++++
 unit/util.c                |    3 ++
 2 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index 25c5383..c711876 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -669,11 +669,71 @@ static void test_conn_req(void)
 	g_assert_no_error(d.err);
 }
 
+static void handle_conn_rsp(GObex *obex, GObexPacket *req,
+						gpointer user_data)
+{
+	struct test_data *d = user_data;
+	guint8 op = g_obex_packet_get_operation(req, NULL);
+	GObexPacket *rsp;
+
+	if (op != G_OBEX_OP_CONNECT) {
+		d->err = g_error_new(TEST_ERROR, TEST_ERROR_UNEXPECTED,
+					"Unexpected opcode 0x%02x", op);
+		g_main_loop_quit(d->mainloop);
+		return;
+	}
+
+	rsp = g_obex_packet_new(G_OBEX_RSP_SUCCESS, TRUE, G_OBEX_HDR_INVALID);
+	g_obex_send(obex, rsp, &d->err);
+}
+
+static void test_conn_rsp(void)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+			{ conn_rsp, sizeof(conn_rsp) } }, {
+			{ NULL, 0 } } };
+
+	create_endpoints(&obex, &io, SOCK_STREAM);
+	d.obex = obex;
+
+	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
+	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+
+	d.mainloop = g_main_loop_new(NULL, FALSE);
+
+	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+
+	g_obex_add_request_function(obex, G_OBEX_OP_CONNECT,
+						handle_conn_rsp, &d);
+
+	g_io_channel_write_chars(io, (char *) conn_req, sizeof(conn_req),
+								NULL, &d.err);
+	g_assert_no_error(d.err);
+
+	g_main_loop_run(d.mainloop);
+
+	g_assert_cmpuint(d.count, ==, 1);
+
+	g_main_loop_unref(d.mainloop);
+
+	g_source_remove(timer_id);
+	g_io_channel_unref(io);
+	g_source_remove(io_id);
+	g_obex_unref(obex);
+
+	g_assert_no_error(d.err);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
 
 	g_test_add_func("/gobex/test_conn_req", test_conn_req);
+	g_test_add_func("/gobex/test_conn_rsp", test_conn_rsp);
 
 	g_test_add_func("/gobex/test_put_req", test_put_req);
 	g_test_add_func("/gobex/test_put_rsp", test_put_rsp);
diff --git a/unit/util.c b/unit/util.c
index 630a70e..5788654 100644
--- a/unit/util.c
+++ b/unit/util.c
@@ -166,6 +166,9 @@ gboolean test_io_cb(GIOChannel *io, GIOCondition cond, gpointer user_data)
 		goto failed;
 	}
 
+	if (send_buf_len == 0)
+		goto failed;
+
 	g_io_channel_write_chars(io, send_buf, send_buf_len, &bytes_written,
 									NULL);
 	if (bytes_written != send_buf_len) {
-- 
1.7.6.4

