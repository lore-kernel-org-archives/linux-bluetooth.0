Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/4] gobex: add unit test for GET request with APPARAM
Date: Wed, 23 Nov 2011 15:42:08 +0200
Message-Id: <1322055729-7185-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1322055729-7185-1-git-send-email-luiz.dentz@gmail.com>
References: <1322055729-7185-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |   58 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index 30a6ad6..a03ece2 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -57,8 +57,19 @@ static guint8 get_req_first[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x23,
 	G_OBEX_HDR_NAME, 0x00, 0x15,
 	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0 };
 
+static guint8 get_req_first_app[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x2a,
+	G_OBEX_HDR_TYPE, 0x00, 0x0b,
+	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
+	G_OBEX_HDR_NAME, 0x00, 0x15,
+	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0,
+	G_OBEX_HDR_APPARAM, 0x00, 0x07,
+	0, 1, 2, 3  };
+
 static guint8 get_req_last[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x03, };
 
+static guint8 get_rsp_first_app[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT, 0x00, 0x0A,
+					G_OBEX_HDR_APPARAM, 0x00, 0x07,
+					0, 1, 2, 3 };
 static guint8 get_rsp_first[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT, 0x00, 0x10,
 					G_OBEX_HDR_BODY, 0x00, 0x0d,
 					0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
@@ -118,6 +129,7 @@ static guint8 conn_put_req_first_3[] = { G_OBEX_OP_PUT, 0x00, 0x35,
 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
 
 static guint8 hdr_type[] = "foo/bar";
+static guint8 hdr_app[] = { 0, 1, 2, 3 };
 static guint8 body_data[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
 
 static void transfer_complete(GObex *obex, GError *err, gpointer user_data)
@@ -371,6 +383,50 @@ static void test_get_req(void)
 	g_assert_no_error(d.err);
 }
 
+static void test_get_req_app(void)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+			{ get_req_first_app, sizeof(get_req_first_app) },
+			{ get_req_last, sizeof(get_req_last) },
+			{ get_req_last, sizeof(get_req_last) } }, {
+			{ get_rsp_first_app, sizeof(get_rsp_first_app) },
+			{ get_rsp_first, sizeof(get_rsp_first) },
+			{ get_rsp_last, sizeof(get_rsp_last) } } };
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
+	g_obex_get_req(obex, rcv_data, transfer_complete, &d, &d.err,
+				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
+				G_OBEX_HDR_NAME, "file.txt",
+				G_OBEX_HDR_APPARAM, hdr_app, sizeof(hdr_app),
+				G_OBEX_HDR_INVALID);
+	g_assert_no_error(d.err);
+
+	g_main_loop_run(d.mainloop);
+
+	g_assert_cmpuint(d.count, ==, 3);
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
 static void handle_get_eagain(GObex *obex, GObexPacket *req,
 						gpointer user_data)
 {
@@ -1233,6 +1289,8 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_get_req", test_get_req);
 	g_test_add_func("/gobex/test_get_rsp", test_get_rsp);
 
+	g_test_add_func("/gobex/test_get_req_app", test_get_req_app);
+
 	g_test_add_func("/gobex/test_put_req_delay", test_put_req_delay);
 	g_test_add_func("/gobex/test_put_rsp_delay", test_put_rsp_delay);
 
-- 
1.7.7.3

