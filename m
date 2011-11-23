Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 4/4] gobex: add unit test for GET response with APPARAM
Date: Wed, 23 Nov 2011 15:42:09 +0200
Message-Id: <1322055729-7185-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1322055729-7185-1-git-send-email-luiz.dentz@gmail.com>
References: <1322055729-7185-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |   68 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index a03ece2..f769fc6 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -597,6 +597,73 @@ static void test_get_rsp(void)
 	g_assert_no_error(d.err);
 }
 
+static void handle_get_app(GObex *obex, GObexPacket *req, gpointer user_data)
+{
+	struct test_data *d = user_data;
+	guint8 op = g_obex_packet_get_operation(req, NULL);
+	GObexPacket *rsp;
+
+	if (op != G_OBEX_OP_GET) {
+		d->err = g_error_new(TEST_ERROR, TEST_ERROR_UNEXPECTED,
+					"Unexpected opcode 0x%02x", op);
+		g_main_loop_quit(d->mainloop);
+		return;
+	}
+
+	g_obex_add_request_function(d->obex, G_OBEX_OP_GET, handle_get, d);
+
+	rsp = g_obex_packet_new(G_OBEX_RSP_CONTINUE, TRUE,
+				G_OBEX_HDR_APPARAM, hdr_app, sizeof(hdr_app),
+				G_OBEX_HDR_INVALID);
+
+	if (g_obex_send(d->obex, rsp, NULL) == FALSE)
+		g_main_loop_quit(d->mainloop);
+}
+
+static void test_get_rsp_app(void)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+			{ get_rsp_first_app, sizeof(get_rsp_first_app) },
+			{ get_rsp_first, sizeof(get_rsp_first) },
+			{ get_rsp_last, sizeof(get_rsp_last) } }, {
+			{ get_req_first, sizeof(get_req_first) },
+			{ get_req_last, sizeof(get_req_last) },
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
+	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get_app, &d);
+
+	g_io_channel_write_chars(io, (char *) get_req_first_app,
+					sizeof(get_req_first_app), NULL, &d.err);
+	g_assert_no_error(d.err);
+
+	g_main_loop_run(d.mainloop);
+
+	g_assert_cmpuint(d.count, ==, 2);
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
 static void test_put_req_delay(void)
 {
 	GIOChannel *io;
@@ -1290,6 +1357,7 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_get_rsp", test_get_rsp);
 
 	g_test_add_func("/gobex/test_get_req_app", test_get_req_app);
+	g_test_add_func("/gobex/test_get_rsp_app", test_get_rsp_app);
 
 	g_test_add_func("/gobex/test_put_req_delay", test_put_req_delay);
 	g_test_add_func("/gobex/test_put_rsp_delay", test_put_rsp_delay);
-- 
1.7.7.3

