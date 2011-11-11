Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 06/12 v3] gobex: add unit test for CONNECT followed by PUT response
Date: Fri, 11 Nov 2011 16:29:00 +0200
Message-Id: <1321021746-5991-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321021746-5991-1-git-send-email-luiz.dentz@gmail.com>
References: <1321021746-5991-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |   61 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index 466e1d0..c09abf8 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -75,6 +75,10 @@ static guint8 conn_rsp_2[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x0c,
 					0x10, 0x00, 0x10, 0x00,
 					G_OBEX_HDR_CONNECTION, 0x00, 0x00,
 					0x00, 0x02 };
+static guint8 conn_rsp_3[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x0c,
+					0x10, 0x00, 0x10, 0x00,
+					G_OBEX_HDR_CONNECTION, 0x00, 0x00,
+					0x00, 0x03 };
 
 static guint8 conn_get_req_first[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x28,
 	G_OBEX_HDR_CONNECTION, 0x00, 0x00, 0x00, 0x01,
@@ -97,6 +101,14 @@ static guint8 conn_put_req_first[] = { G_OBEX_OP_PUT, 0x00, 0x35,
 	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0,
 	G_OBEX_HDR_BODY, 0x00, 0x0d,
 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
+static guint8 conn_put_req_first_3[] = { G_OBEX_OP_PUT, 0x00, 0x35,
+	G_OBEX_HDR_CONNECTION, 0x00, 0x00, 0x00, 0x03,
+	G_OBEX_HDR_TYPE, 0x00, 0x0b,
+	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
+	G_OBEX_HDR_NAME, 0x00, 0x15,
+	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0,
+	G_OBEX_HDR_BODY, 0x00, 0x0d,
+	0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
 
 static guint8 hdr_type[] = "foo/bar";
 static guint8 body_data[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
@@ -923,6 +935,54 @@ static void test_conn_put_req(void)
 	g_assert_no_error(d.err);
 }
 
+static void test_conn_put_rsp(void)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+			{ conn_rsp_3, sizeof(conn_rsp_3) },
+			{ put_rsp_first, sizeof(put_rsp_first) },
+			{ put_rsp_last, sizeof(put_rsp_last) } }, {
+			{ conn_put_req_first_3, sizeof(conn_put_req_first_3) },
+			{ put_req_last, sizeof(put_req_last) },
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
+	g_obex_add_request_function(obex, G_OBEX_OP_PUT,
+						handle_put, &d);
+
+	g_io_channel_write_chars(io, (char *) conn_req, sizeof(conn_req),
+								NULL, &d.err);
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
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -948,6 +1008,7 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_conn_get_rsp", test_conn_get_rsp);
 
 	g_test_add_func("/gobex/test_conn_put_req", test_conn_put_req);
+	g_test_add_func("/gobex/test_conn_put_rsp", test_conn_put_rsp);
 
 	g_test_run();
 
-- 
1.7.6.4

