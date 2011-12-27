Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 03/16] gobex: add unit test for GET response with random data
Date: Tue, 27 Dec 2011 11:07:04 +0200
Message-Id: <1324976837-11914-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
References: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |   80 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index ec71f9b..d784c4f 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -728,6 +728,81 @@ static void test_get_rsp(void)
 	g_assert_no_error(d.err);
 }
 
+static void handle_get_random(GObex *obex, GObexPacket *req,
+							gpointer user_data)
+{
+	struct test_data *d = user_data;
+	guint8 op = g_obex_packet_get_operation(req, NULL);
+	guint id;
+
+	if (op != G_OBEX_OP_GET) {
+		d->err = g_error_new(TEST_ERROR, TEST_ERROR_UNEXPECTED,
+					"Unexpected opcode 0x%02x", op);
+		g_main_loop_quit(d->mainloop);
+		return;
+	}
+
+	id = g_obex_get_rsp(obex, provide_random, transfer_complete, d,
+						&d->err, G_OBEX_HDR_INVALID);
+	if (id == 0)
+		g_main_loop_quit(d->mainloop);
+}
+
+static void test_get_rsp_random(int sock_type)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+				{ NULL, 0 },
+				{ NULL, 0 },
+				{ NULL, 0 },
+				{ get_rsp_last, sizeof(get_rsp_last) } }, {
+				{ get_req_last, sizeof(get_req_last) },
+				{ get_req_last, sizeof(get_req_last) },
+				{ get_req_last, sizeof(get_req_last) } } };
+
+	create_endpoints(&obex, &io, sock_type);
+
+	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
+	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+
+	d.mainloop = g_main_loop_new(NULL, FALSE);
+
+	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+
+	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get_random,
+									&d);
+
+	g_io_channel_write_chars(io, (char *) get_req_first,
+					sizeof(get_req_first), NULL, &d.err);
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
+static void test_stream_get_rsp_random(void)
+{
+	test_get_rsp_random(SOCK_STREAM);
+}
+
+static void test_packet_get_rsp_random(void)
+{
+	test_get_rsp_random(SOCK_SEQPACKET);
+}
+
 static void handle_get_app(GObex *obex, GObexPacket *req, gpointer user_data)
 {
 	struct test_data *d = user_data;
@@ -1516,6 +1591,11 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_packet_get_req_random",
 						test_packet_get_req_random);
 
+	g_test_add_func("/gobex/test_stream_get_rsp_random",
+						test_stream_get_rsp_random);
+	g_test_add_func("/gobex/test_packet_get_rsp_random",
+						test_packet_get_rsp_random);
+
 	g_test_add_func("/gobex/test_conn_get_req", test_conn_get_req);
 	g_test_add_func("/gobex/test_conn_get_rsp", test_conn_get_rsp);
 
-- 
1.7.7.4

