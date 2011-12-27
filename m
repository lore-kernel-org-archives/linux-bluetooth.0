Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 04/16] gobex: add unit test for PUT request with SRM
Date: Tue, 27 Dec 2011 11:07:05 +0200
Message-Id: <1324976837-11914-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
References: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |   69 ++++++++++++++++++++++++++++++++++++++++++-
 unit/util.c                |    2 +-
 2 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index d784c4f..0e49a3a 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -52,6 +52,9 @@ static guint8 put_req_last[] = { G_OBEX_OP_PUT | FINAL_BIT, 0x00, 0x06,
 
 static guint8 put_rsp_first[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
 								0x00, 0x03 };
+static guint8 put_rsp_first_srm[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
+							0x00, 0x05,
+							G_OBEX_HDR_SRM, 0x01 };
 static guint8 put_rsp_last[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x03 };
 
 static guint8 get_req_first[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x23,
@@ -644,6 +647,63 @@ static void test_packet_put_req_random(void)
 	test_put_req_random(SOCK_SEQPACKET);
 }
 
+static void test_put_req_random_srm(int sock_type)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+			{ NULL, 0 },
+			{ NULL, 0 },
+			{ NULL, 0 },
+			{ put_req_last, sizeof(put_req_last) } }, {
+			{ put_rsp_first_srm, sizeof(put_rsp_first_srm) },
+			{ NULL, 0 },
+			{ NULL, 0 },
+			{ put_rsp_last, sizeof(put_rsp_last) } } };
+
+	create_endpoints(&obex, &io, sock_type);
+	d.obex = obex;
+
+	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
+	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+
+	d.mainloop = g_main_loop_new(NULL, FALSE);
+
+	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+
+	g_obex_put_req(obex, provide_random, transfer_complete, &d, &d.err,
+					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
+					G_OBEX_HDR_NAME, "random.bin",
+					G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
+					G_OBEX_HDR_INVALID);
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
+static void test_stream_put_req_random_srm(void)
+{
+	test_put_req_random_srm(SOCK_STREAM);
+}
+
+static void test_packet_put_req_random_srm(void)
+{
+	test_put_req_random_srm(SOCK_SEQPACKET);
+}
+
 static void test_put_req_eagain(void)
 {
 	GIOChannel *io;
@@ -1203,7 +1263,7 @@ static void test_conn_rsp(void)
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ conn_rsp, sizeof(conn_rsp) } }, {
-			{ NULL, 0 } } };
+			{ NULL, -1 } } };
 
 	create_endpoints(&obex, &io, SOCK_STREAM);
 	d.obex = obex;
@@ -1458,7 +1518,7 @@ static void test_conn_get_wrg_rsp(void)
 			{ conn_rsp, sizeof(conn_rsp) },
 			{ unavailable_rsp, sizeof(unavailable_rsp) } }, {
 			{ conn_get_req_wrg, sizeof(conn_get_req_wrg) },
-			{ NULL, 0 } } };
+			{ NULL, -1 } } };
 
 	create_endpoints(&obex, &io, SOCK_STREAM);
 	d.obex = obex;
@@ -1607,6 +1667,11 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_conn_put_req_random",
 						test_conn_put_req_random);
 
+	g_test_add_func("/gobex/test_stream_put_req_random_srm",
+					test_stream_put_req_random_srm);
+	g_test_add_func("/gobex/test_packet_put_req_random_srm",
+					test_packet_put_req_random_srm);
+
 	g_test_run();
 
 	return 0;
diff --git a/unit/util.c b/unit/util.c
index e8f2024..ad5a438 100644
--- a/unit/util.c
+++ b/unit/util.c
@@ -166,7 +166,7 @@ gboolean test_io_cb(GIOChannel *io, GIOCondition cond, gpointer user_data)
 		goto failed;
 	}
 
-	if (send_buf_len == 0)
+	if ((gssize) send_buf_len < 0)
 		goto failed;
 
 	g_io_channel_write_chars(io, send_buf, send_buf_len, &bytes_written,
-- 
1.7.7.4

