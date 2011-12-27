Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 09/16] gobex: add unit test for PUT response with SRM and SRMP wait
Date: Tue, 27 Dec 2011 11:07:10 +0200
Message-Id: <1324976837-11914-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
References: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |   87 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 86 insertions(+), 1 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index bf15359..9eb6604 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -380,6 +380,28 @@ static void handle_put_random(GObex *obex, GObexPacket *req,
 		g_main_loop_quit(d->mainloop);
 }
 
+static void handle_put_random_srm(GObex *obex, GObexPacket *req,
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
+					&d->err,
+					G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
+					G_OBEX_HDR_INVALID);
+	if (id == 0)
+		g_main_loop_quit(d->mainloop);
+}
+
 static void test_put_rsp_random(int sock_type)
 {
 	GIOChannel *io;
@@ -436,7 +458,7 @@ static void test_packet_put_rsp_random(void)
 	test_put_rsp_random(SOCK_SEQPACKET);
 }
 
-static void handle_put_random_srm(GObex *obex, GObexPacket *req,
+static void handle_put_random_wait(GObex *obex, GObexPacket *req,
 							gpointer user_data)
 {
 	struct test_data *d = user_data;
@@ -453,11 +475,69 @@ static void handle_put_random_srm(GObex *obex, GObexPacket *req,
 	id = g_obex_put_rsp(obex, req, rcv_random, transfer_complete, d,
 					&d->err,
 					G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
+					G_OBEX_HDR_SRMP, G_OBEX_SRMP_WAIT,
 					G_OBEX_HDR_INVALID);
 	if (id == 0)
 		g_main_loop_quit(d->mainloop);
 }
 
+static void test_put_rsp_random_srm_wait(int sock_type)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+		{ put_rsp_first_srm_wait, sizeof(put_rsp_first_srm_wait) },
+		{ put_rsp_first, sizeof(put_rsp_first) },
+		{ NULL, -1 },
+		{ put_rsp_last, sizeof(put_rsp_last) } }, {
+		{ put_req_zero, sizeof(put_req_zero) },
+		{ put_req_zero, sizeof(put_req_zero) },
+		{ put_req_last, sizeof(put_req_last) },
+		{ NULL, 0 } } };
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
+	g_obex_add_request_function(obex, G_OBEX_OP_PUT,
+						handle_put_random_wait, &d);
+
+	g_io_channel_write_chars(io, (char *) put_req_first_srm,
+					sizeof(put_req_first_srm), NULL,
+					&d.err);
+	g_assert_no_error(d.err);
+
+	g_main_loop_run(d.mainloop);
+
+	g_assert_cmpuint(d.count, ==, RANDOM_PACKETS);
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
+static void test_stream_put_rsp_random_srm_wait(void)
+{
+	test_put_rsp_random_srm_wait(SOCK_STREAM);
+}
+
+static void test_packet_put_rsp_random_srm_wait(void)
+{
+	test_put_rsp_random_srm_wait(SOCK_SEQPACKET);
+}
+
 static void test_put_rsp_random_srm(int sock_type)
 {
 	GIOChannel *io;
@@ -1976,6 +2056,11 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_packet_put_rsp_random_srm",
 					test_packet_put_rsp_random_srm);
 
+	g_test_add_func("/gobex/test_stream_put_rsp_random_srm_wait",
+					test_stream_put_rsp_random_srm_wait);
+	g_test_add_func("/gobex/test_packet_put_rsp_random_srm_wait",
+					test_packet_put_rsp_random_srm_wait);
+
 	g_test_add_func("/gobex/test_stream_get_rsp_random_srm",
 					test_stream_get_rsp_random_srm);
 	g_test_add_func("/gobex/test_packet_get_rsp_random_srm",
-- 
1.7.7.4

