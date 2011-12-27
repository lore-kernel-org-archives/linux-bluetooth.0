Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 01/16] gobex: add unit test for PUT response with random data
Date: Tue, 27 Dec 2011 11:07:02 +0200
Message-Id: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |   89 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index f677503..bc59459 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -44,6 +44,9 @@ static guint8 put_req_first[] = { G_OBEX_OP_PUT, 0x00, 0x30,
 	G_OBEX_HDR_BODY, 0x00, 0x0d,
 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
 
+static guint8 put_req_zero[255] = { G_OBEX_OP_PUT, 0x00, 0xff,
+	G_OBEX_HDR_BODY, 0x00, 0xfc };
+
 static guint8 put_req_last[] = { G_OBEX_OP_PUT | FINAL_BIT, 0x00, 0x06,
 					G_OBEX_HDR_BODY_END, 0x00, 0x03 };
 
@@ -323,6 +326,87 @@ static void test_put_rsp(void)
 	g_assert_no_error(d.err);
 }
 
+static gboolean rcv_random(const void *buf, gsize len, gpointer user_data)
+{
+	return TRUE;
+}
+
+static void handle_put_random(GObex *obex, GObexPacket *req,
+							gpointer user_data)
+{
+	struct test_data *d = user_data;
+	guint8 op = g_obex_packet_get_operation(req, NULL);
+	guint id;
+
+	if (op != G_OBEX_OP_PUT) {
+		d->err = g_error_new(TEST_ERROR, TEST_ERROR_UNEXPECTED,
+					"Unexpected opcode 0x%02x", op);
+		g_main_loop_quit(d->mainloop);
+		return;
+	}
+
+	id = g_obex_put_rsp(obex, req, rcv_random, transfer_complete, d,
+						&d->err, G_OBEX_HDR_INVALID);
+	if (id == 0)
+		g_main_loop_quit(d->mainloop);
+}
+
+static void test_put_rsp_random(int sock_type)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+				{ put_rsp_first, sizeof(put_rsp_first) },
+				{ put_rsp_first, sizeof(put_rsp_first) },
+				{ put_rsp_first, sizeof(put_rsp_first) },
+				{ put_rsp_last, sizeof(put_rsp_last) } }, {
+				{ put_req_zero, sizeof(put_req_zero) },
+				{ put_req_zero, sizeof(put_req_zero) },
+				{ put_req_last, sizeof(put_req_last) },
+				{ NULL, -1 } } };
+
+	create_endpoints(&obex, &io, SOCK_STREAM);
+
+	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
+	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+
+	d.mainloop = g_main_loop_new(NULL, FALSE);
+
+	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+
+	g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put_random,
+									&d);
+
+	g_io_channel_write_chars(io, (char *) put_req_first,
+					sizeof(put_req_first), NULL, &d.err);
+	g_assert_no_error(d.err);
+
+	g_main_loop_run(d.mainloop);
+
+	g_assert_cmpuint(d.count, ==, RANDOM_PACKETS - 1);
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
+static void test_stream_put_rsp_random(void)
+{
+	test_put_rsp_random(SOCK_STREAM);
+}
+
+static void test_packet_put_rsp_random(void)
+{
+	test_put_rsp_random(SOCK_SEQPACKET);
+}
+
 static void test_get_req(void)
 {
 	GIOChannel *io;
@@ -1365,6 +1449,11 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_packet_put_req_random",
 						test_packet_put_req_random);
 
+	g_test_add_func("/gobex/test_stream_put_rsp_random",
+						test_stream_put_rsp_random);
+	g_test_add_func("/gobex/test_packet_put_rsp_random",
+						test_packet_put_rsp_random);
+
 	g_test_add_func("/gobex/test_conn_get_req", test_conn_get_req);
 	g_test_add_func("/gobex/test_conn_get_rsp", test_conn_get_rsp);
 
-- 
1.7.7.4

