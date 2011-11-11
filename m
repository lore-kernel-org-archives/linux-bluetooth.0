Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 07/12 v3] gobex: add unit test for CONNECT followed by GET wrong response
Date: Fri, 11 Nov 2011 16:29:01 +0200
Message-Id: <1321021746-5991-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321021746-5991-1-git-send-email-luiz.dentz@gmail.com>
References: <1321021746-5991-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |   52 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index c09abf8..b4c62c1 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -79,6 +79,13 @@ static guint8 conn_rsp_3[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x0c,
 					0x10, 0x00, 0x10, 0x00,
 					G_OBEX_HDR_CONNECTION, 0x00, 0x00,
 					0x00, 0x03 };
+static guint8 conn_rsp_4[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x0c,
+					0x10, 0x00, 0x10, 0x00,
+					G_OBEX_HDR_CONNECTION, 0x00, 0x00,
+					0x00, 0x04 };
+
+static guint8 unavailable_rsp[] = { G_OBEX_RSP_SERVICE_UNAVAILABLE | FINAL_BIT,
+					0x00, 0x03 };
 
 static guint8 conn_get_req_first[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x28,
 	G_OBEX_HDR_CONNECTION, 0x00, 0x00, 0x00, 0x01,
@@ -983,6 +990,49 @@ static void test_conn_put_rsp(void)
 	g_assert_no_error(d.err);
 }
 
+static void test_conn_get_wrg_rsp(void)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+			{ conn_rsp_4, sizeof(conn_rsp_4) },
+			{ unavailable_rsp, sizeof(unavailable_rsp) } }, {
+			{ conn_get_req_first, sizeof(conn_get_req_first) },
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
@@ -1010,6 +1060,8 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_conn_put_req", test_conn_put_req);
 	g_test_add_func("/gobex/test_conn_put_rsp", test_conn_put_rsp);
 
+	g_test_add_func("/gobex/test_conn_get_wrg_rsp", test_conn_get_wrg_rsp);
+
 	g_test_run();
 
 	return 0;
-- 
1.7.6.4

