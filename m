Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/4] gobex: add unit test for PUT response with delay
Date: Wed, 23 Nov 2011 15:42:06 +0200
Message-Id: <1322055729-7185-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |   86 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index 306a6f0..9839c0f 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -627,6 +627,90 @@ static void test_get_rsp_delay(void)
 	g_assert_no_error(d.err);
 }
 
+static gboolean rcv_data_delay(const void *buf, gsize len, gpointer user_data)
+{
+	struct test_data *d = user_data;
+
+	if (len != sizeof(body_data))
+		d->err = g_error_new(TEST_ERROR, TEST_ERROR_UNEXPECTED,
+					"Unexpected byte count %zu", len);
+
+	if (memcmp(buf, body_data, sizeof(body_data)) != 0) {
+		dump_bufs(body_data, sizeof(body_data), buf, len);
+		d->err = g_error_new(TEST_ERROR, TEST_ERROR_UNEXPECTED,
+					"Unexpected byte count %zu", len);
+	}
+
+	if (d->provide_delay > 0) {
+		g_obex_suspend(d->obex);
+		g_timeout_add(d->provide_delay, resume_obex, d->obex);
+	}
+
+	return TRUE;
+}
+
+static void handle_put_delay(GObex *obex, GObexPacket *req, gpointer user_data)
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
+	id = g_obex_put_rsp(obex, req, rcv_data_delay, transfer_complete, d,
+						&d->err, G_OBEX_HDR_INVALID);
+	if (id == 0)
+		g_main_loop_quit(d->mainloop);
+}
+
+static void test_put_rsp_delay(void)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+				{ put_rsp_first, sizeof(put_rsp_first) },
+				{ put_rsp_last, sizeof(put_rsp_last) } }, {
+				{ put_req_last, sizeof(put_req_last) },
+				{ NULL, 0 } } };
+
+	create_endpoints(&obex, &io, SOCK_STREAM);
+	d.obex = obex;
+	d.provide_delay = 200;
+
+	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
+	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+
+	d.mainloop = g_main_loop_new(NULL, FALSE);
+
+	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+
+	g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put_delay, &d);
+
+	g_io_channel_write_chars(io, (char *) put_req_first,
+					sizeof(put_req_first), NULL, &d.err);
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
 static void test_get_rsp_eagain(void)
 {
 	GIOChannel *io;
@@ -1107,6 +1191,8 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_get_rsp", test_get_rsp);
 
 	g_test_add_func("/gobex/test_put_req_delay", test_put_req_delay);
+	g_test_add_func("/gobex/test_put_rsp_delay", test_put_rsp_delay);
+
 	g_test_add_func("/gobex/test_get_rsp_delay", test_get_rsp_delay);
 
 	g_test_add_func("/gobex/test_put_req_eagain", test_put_req_eagain);
-- 
1.7.7.3

