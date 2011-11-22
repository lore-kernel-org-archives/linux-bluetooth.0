Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/2] gobex: add unit test for async PUT response
Date: Tue, 22 Nov 2011 17:09:47 +0200
Message-Id: <1321974587-25047-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321974587-25047-1-git-send-email-luiz.dentz@gmail.com>
References: <1321974587-25047-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |   74 ++++++++++++++++++++++++++++++++++++++++++++
 unit/util.h                |    1 +
 2 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index 30a6ad6..9d23dcd 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -330,6 +330,79 @@ static void test_put_rsp(void)
 	g_assert_no_error(d.err);
 }
 
+static gboolean put_rsp_async(gpointer user_data)
+{
+	struct test_data *d = user_data;
+	guint id;
+
+	id = g_obex_put_rsp(d->obex, d->pkt, rcv_data, transfer_complete, d,
+						&d->err, G_OBEX_HDR_INVALID);
+	if (id == 0)
+		g_main_loop_quit(d->mainloop);
+
+	g_obex_packet_unref(d->pkt);
+
+	return FALSE;
+}
+
+static void handle_put_async(GObex *obex, GObexPacket *req, gpointer user_data)
+{
+	struct test_data *d = user_data;
+	guint8 op = g_obex_packet_get_operation(req, NULL);
+
+	if (op != G_OBEX_OP_PUT) {
+		d->err = g_error_new(TEST_ERROR, TEST_ERROR_UNEXPECTED,
+					"Unexpected opcode 0x%02x", op);
+		g_main_loop_quit(d->mainloop);
+		return;
+	}
+
+	d->pkt = g_obex_packet_ref(req);
+	g_idle_add(put_rsp_async, d);
+}
+
+static void test_put_rsp_async(void)
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
+
+	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
+	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+
+	d.mainloop = g_main_loop_new(NULL, FALSE);
+
+	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+
+	g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put_async, &d);
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
 static void test_get_req(void)
 {
 	GIOChannel *io;
@@ -1229,6 +1302,7 @@ int main(int argc, char *argv[])
 
 	g_test_add_func("/gobex/test_put_req", test_put_req);
 	g_test_add_func("/gobex/test_put_rsp", test_put_rsp);
+	g_test_add_func("/gobex/test_put_rsp_async", test_put_rsp_async);
 
 	g_test_add_func("/gobex/test_get_req", test_get_req);
 	g_test_add_func("/gobex/test_get_rsp", test_get_rsp);
diff --git a/unit/util.h b/unit/util.h
index 4a7fc43..2a2972c 100644
--- a/unit/util.h
+++ b/unit/util.h
@@ -38,6 +38,7 @@ struct test_data {
 	struct test_buf send[4];
 	guint provide_delay;
 	GObex *obex;
+	GObexPacket *pkt;
 	GMainLoop *mainloop;
 };
 
-- 
1.7.7.3

