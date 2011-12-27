Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 06/16] gobex: add unit test for PUT response with SRM
Date: Tue, 27 Dec 2011 11:07:07 +0200
Message-Id: <1324976837-11914-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
References: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |   93 ++++++++++++++++++++++++++++++++++++++++++++
 unit/util.c                |    7 +++
 2 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index dce5db5..032fee4 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -44,6 +44,15 @@ static guint8 put_req_first[] = { G_OBEX_OP_PUT, 0x00, 0x30,
 	G_OBEX_HDR_BODY, 0x00, 0x0d,
 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
 
+static guint8 put_req_first_srm[] = { G_OBEX_OP_PUT, 0x00, 0x32,
+	G_OBEX_HDR_TYPE, 0x00, 0x0b,
+	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
+	G_OBEX_HDR_NAME, 0x00, 0x15,
+	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0,
+	G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
+	G_OBEX_HDR_BODY, 0x00, 0x0d,
+	0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
+
 static guint8 put_req_zero[255] = { G_OBEX_OP_PUT, 0x00, 0xff,
 	G_OBEX_HDR_BODY, 0x00, 0xfc };
 
@@ -419,6 +428,85 @@ static void test_packet_put_rsp_random(void)
 	test_put_rsp_random(SOCK_SEQPACKET);
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
+static void test_put_rsp_random_srm(int sock_type)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+			{ put_rsp_first_srm, sizeof(put_rsp_first_srm) },
+			{ NULL, -1 },
+			{ NULL, -1 },
+			{ put_rsp_last, sizeof(put_rsp_last) } }, {
+			{ put_req_zero, sizeof(put_req_zero) },
+			{ put_req_zero, sizeof(put_req_zero) },
+			{ put_req_last, sizeof(put_req_last) },
+			{ NULL, 0 } } };
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
+	g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put_random_srm,
+									&d);
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
+static void test_stream_put_rsp_random_srm(void)
+{
+	test_put_rsp_random_srm(SOCK_STREAM);
+}
+
+static void test_packet_put_rsp_random_srm(void)
+{
+	test_put_rsp_random_srm(SOCK_SEQPACKET);
+}
+
 static void test_get_req(void)
 {
 	GIOChannel *io;
@@ -1757,6 +1845,11 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_packet_put_req_random_srm",
 					test_packet_put_req_random_srm);
 
+	g_test_add_func("/gobex/test_stream_put_rsp_random_srm",
+					test_stream_put_rsp_random_srm);
+	g_test_add_func("/gobex/test_packet_put_rsp_random_srm",
+					test_packet_put_rsp_random_srm);
+
 	g_test_add_func("/gobex/test_stream_get_rsp_random_srm",
 					test_stream_get_rsp_random_srm);
 	g_test_add_func("/gobex/test_packet_get_rsp_random_srm",
diff --git a/unit/util.c b/unit/util.c
index ad5a438..a591ab1 100644
--- a/unit/util.c
+++ b/unit/util.c
@@ -142,6 +142,9 @@ gboolean test_io_cb(GIOChannel *io, GIOCondition cond, gpointer user_data)
 
 	d->count++;
 
+	if (!(cond & G_IO_IN))
+		goto send;
+
 	status = g_io_channel_read_chars(io, buf, sizeof(buf), &rbytes, NULL);
 	if (status != G_IO_STATUS_NORMAL) {
 		g_print("io_cb count %u\n", d->count);
@@ -166,6 +169,7 @@ gboolean test_io_cb(GIOChannel *io, GIOCondition cond, gpointer user_data)
 		goto failed;
 	}
 
+send:
 	if ((gssize) send_buf_len < 0)
 		goto failed;
 
@@ -178,6 +182,9 @@ gboolean test_io_cb(GIOChannel *io, GIOCondition cond, gpointer user_data)
 		goto failed;
 	}
 
+	if (d->recv[d->count].len < 0 || (gssize) expect_len < 0)
+		return test_io_cb(io, G_IO_OUT, user_data);
+
 	return TRUE;
 
 failed:
-- 
1.7.7.4

