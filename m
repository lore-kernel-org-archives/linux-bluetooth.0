Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/9 v3] gobex: add unit test for CONNECT request
Date: Fri, 11 Nov 2011 12:31:07 +0200
Message-Id: <1321007475-2236-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |   57 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index a246418..25c5383 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -65,6 +65,13 @@ static guint8 get_rsp_first[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT, 0x00, 0x10,
 static guint8 get_rsp_last[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x06,
 					G_OBEX_HDR_BODY_END, 0x00, 0x03 };
 
+static guint8 conn_req[] = { G_OBEX_OP_CONNECT | FINAL_BIT, 0x00, 0x07,
+					0x10, 0x00, 0x10, 0x00 };
+static guint8 conn_rsp[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x0c,
+					0x10, 0x00, 0x10, 0x00,
+					G_OBEX_HDR_CONNECTION, 0x00, 0x00,
+					0x00, 0x01 };
+
 static guint8 hdr_type[] = "foo/bar";
 static guint8 body_data[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
 
@@ -614,10 +621,60 @@ static void test_get_rsp_eagain(void)
 	g_assert_no_error(d.err);
 }
 
+static void conn_complete(GObex *obex, GError *err, GObexPacket *rsp,
+							gpointer user_data)
+{
+	struct test_data *d = user_data;
+
+	if (err != NULL)
+		d->err = g_error_copy(err);
+
+	g_main_loop_quit(d->mainloop);
+}
+
+static void test_conn_req(void)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+				{ conn_req, sizeof(conn_req) } }, {
+				{ conn_rsp, sizeof(conn_rsp) } } };
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
+	g_obex_connect(obex, conn_complete, &d, &d.err, G_OBEX_HDR_INVALID);
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
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
 
+	g_test_add_func("/gobex/test_conn_req", test_conn_req);
+
 	g_test_add_func("/gobex/test_put_req", test_put_req);
 	g_test_add_func("/gobex/test_put_rsp", test_put_rsp);
 
-- 
1.7.6.4

