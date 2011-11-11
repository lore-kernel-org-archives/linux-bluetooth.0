Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 05/12 v3] gobex: add unit test for CONNECT followed by PUT request
Date: Fri, 11 Nov 2011 16:28:59 +0200
Message-Id: <1321021746-5991-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321021746-5991-1-git-send-email-luiz.dentz@gmail.com>
References: <1321021746-5991-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |   76 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 75 insertions(+), 1 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index 75e9592..466e1d0 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -89,6 +89,15 @@ static guint8 conn_get_req_first_2[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x28,
 	G_OBEX_HDR_NAME, 0x00, 0x15,
 	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0 };
 
+static guint8 conn_put_req_first[] = { G_OBEX_OP_PUT, 0x00, 0x35,
+	G_OBEX_HDR_CONNECTION, 0x00, 0x00, 0x00, 0x01,
+	G_OBEX_HDR_TYPE, 0x00, 0x0b,
+	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
+	G_OBEX_HDR_NAME, 0x00, 0x15,
+	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0,
+	G_OBEX_HDR_BODY, 0x00, 0x0d,
+	0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
+
 static guint8 hdr_type[] = "foo/bar";
 static guint8 body_data[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
 
@@ -158,9 +167,12 @@ static gssize provide_eagain(void *buf, gsize len, gpointer user_data)
 static gssize provide_data(void *buf, gsize len, gpointer user_data)
 {
 	struct test_data *d = user_data;
+	static int count = 0;
 
-	if (d->count > 0)
+	if (count > 0) {
+		count = 0;
 		return 0;
+	}
 
 	if (len < sizeof(body_data)) {
 		g_set_error(&d->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
@@ -176,6 +188,8 @@ static gssize provide_data(void *buf, gsize len, gpointer user_data)
 		g_timeout_add(d->provide_delay, resume_obex, d->obex);
 	}
 
+	count++;
+
 	return sizeof(body_data);
 }
 
@@ -851,6 +865,64 @@ static void test_conn_get_rsp(void)
 	g_assert_no_error(d.err);
 }
 
+static void conn_complete_put_req(GObex *obex, GError *err, GObexPacket *rsp,
+							gpointer user_data)
+{
+	struct test_data *d = user_data;
+
+	if (err != NULL) {
+		d->err = g_error_copy(err);
+		g_main_loop_quit(d->mainloop);
+	}
+
+	g_obex_put_req(obex, provide_data, transfer_complete, d, &d->err,
+				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
+				G_OBEX_HDR_NAME, "file.txt",
+				G_OBEX_HDR_INVALID);
+}
+
+static void test_conn_put_req(void)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+			{ conn_req, sizeof(conn_req) },
+			{ conn_put_req_first, sizeof(conn_put_req_first) },
+			{ put_req_last, sizeof(put_req_last) }}, {
+			{ conn_rsp, sizeof(conn_rsp) } ,
+			{ put_rsp_first, sizeof(put_rsp_first) },
+			{ put_rsp_last, sizeof(put_rsp_last) } } };
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
+	g_obex_connect(obex, conn_complete_put_req, &d, &d.err,
+							G_OBEX_HDR_INVALID);
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
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -875,6 +947,8 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_conn_get_req", test_conn_get_req);
 	g_test_add_func("/gobex/test_conn_get_rsp", test_conn_get_rsp);
 
+	g_test_add_func("/gobex/test_conn_put_req", test_conn_put_req);
+
 	g_test_run();
 
 	return 0;
-- 
1.7.6.4

