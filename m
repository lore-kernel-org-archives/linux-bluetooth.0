Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] gobex: Fix unit test for PUT request followed by ABORT
Date: Wed, 11 Apr 2012 15:43:06 +0300
Message-Id: <1334148186-10675-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

gobex was actually used to respond not to request so the test is
renamed to test_stream_put_rsp_abort and a new test is created using
g_obex_put_req to initiate the request and g_obex_cancel_transfer to
abort it.
---
 unit/test-gobex-transfer.c |   69 ++++++++++++++++++++++++++++++++++++++++---
 unit/util.h                |    2 +
 2 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index c712382..85ba6fa 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -240,12 +240,9 @@ static gssize provide_eagain(void *buf, gsize len, gpointer user_data)
 static gssize provide_data(void *buf, gsize len, gpointer user_data)
 {
 	struct test_data *d = user_data;
-	static int count = 0;
 
-	if (count > 0) {
-		count = 0;
+	if (d->total > 0)
 		return 0;
-	}
 
 	if (len < sizeof(body_data)) {
 		g_set_error(&d->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
@@ -261,7 +258,7 @@ static gssize provide_data(void *buf, gsize len, gpointer user_data)
 		g_timeout_add(d->provide_delay, resume_obex, d->obex);
 	}
 
-	count++;
+	d->total += sizeof(body_data);
 
 	return sizeof(body_data);
 }
@@ -455,6 +452,26 @@ static void test_stream_put_rsp(void)
 	g_assert_no_error(d.err);
 }
 
+static gboolean cancel_transfer(gpointer user_data)
+{
+	struct test_data *d = user_data;
+
+	if (d->id > 0) {
+		g_obex_cancel_transfer(d->id);
+		d->id = 0;
+		g_idle_add(cancel_transfer, user_data);
+	} else
+		g_main_loop_quit(d->mainloop);
+
+	return FALSE;
+}
+
+static gssize abort_data(void *buf, gsize len, gpointer user_data)
+{
+	g_idle_add_full(G_PRIORITY_HIGH, cancel_transfer, user_data, NULL);
+	return provide_data(buf, len, user_data);
+}
+
 static void test_stream_put_req_abort(void)
 {
 	GIOChannel *io;
@@ -462,6 +479,46 @@ static void test_stream_put_req_abort(void)
 	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
+				{ put_req_first, sizeof(put_req_first) },
+				{ abort_req, sizeof(abort_req) } }, {
+				{ put_rsp_last, sizeof(put_rsp_last) } } };
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
+	d.id = g_obex_put_req(obex, abort_data, transfer_complete, &d, &d.err,
+				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
+				G_OBEX_HDR_NAME, "file.txt",
+				G_OBEX_HDR_INVALID);
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
+static void test_stream_put_rsp_abort(void)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
 				{ put_rsp_first, sizeof(put_rsp_first) },
 				{ put_rsp_first, sizeof(put_rsp_first) },
 				{ put_rsp_first, sizeof(put_rsp_first) },
@@ -2159,6 +2216,8 @@ int main(int argc, char *argv[])
 
 	g_test_add_func("/gobex/test_stream_put_req_abort",
 						test_stream_put_req_abort);
+	g_test_add_func("/gobex/test_stream_put_rsp_abort",
+						test_stream_put_rsp_abort);
 
 	g_test_add_func("/gobex/test_stream_get_req", test_stream_get_req);
 	g_test_add_func("/gobex/test_stream_get_rsp", test_stream_get_rsp);
diff --git a/unit/util.h b/unit/util.h
index 4a7fc43..752ce61 100644
--- a/unit/util.h
+++ b/unit/util.h
@@ -38,6 +38,8 @@ struct test_data {
 	struct test_buf send[4];
 	guint provide_delay;
 	GObex *obex;
+	guint id;
+	gsize total;
 	GMainLoop *mainloop;
 };
 
-- 
1.7.7.6

