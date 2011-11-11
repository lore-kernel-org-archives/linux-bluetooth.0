Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 08/12 v3] gobex: add unit test for CONNECT followed by PUT request with random data
Date: Fri, 11 Nov 2011 16:29:02 +0200
Message-Id: <1321021746-5991-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321021746-5991-1-git-send-email-luiz.dentz@gmail.com>
References: <1321021746-5991-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Note that in order to work the buffer had to be increased to OBEX maximum
MTU otherwise test_io_cb would be sending responses for each fragment it
has read which may not constitute a full packet.
---
 unit/test-gobex-transfer.c |   63 ++++++++++++++++++++++++++++++++++++++++++++
 unit/util.c                |    2 +-
 2 files changed, 64 insertions(+), 1 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index b4c62c1..306a6f0 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -1033,6 +1033,66 @@ static void test_conn_get_wrg_rsp(void)
 	g_assert_no_error(d.err);
 }
 
+static void conn_complete_put_req_random(GObex *obex, GError *err,
+					GObexPacket *rsp, gpointer user_data)
+{
+	struct test_data *d = user_data;
+
+	if (err != NULL) {
+		d->err = g_error_copy(err);
+		g_main_loop_quit(d->mainloop);
+	}
+
+	g_obex_put_req(obex, provide_random, transfer_complete, d, &d->err,
+					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
+					G_OBEX_HDR_NAME, "random.bin",
+					G_OBEX_HDR_INVALID);
+}
+
+static void test_conn_put_req_random(void)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+				{ conn_req, sizeof(conn_req) } ,
+				{ NULL, 0 },
+				{ NULL, 0 },
+				{ put_req_last, sizeof(put_req_last) } }, {
+				{ conn_rsp, sizeof(conn_rsp) } ,
+				{ put_rsp_first, sizeof(put_rsp_first) },
+				{ put_rsp_first, sizeof(put_rsp_first) },
+				{ put_rsp_last, sizeof(put_rsp_last) } } };
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
+	g_obex_connect(obex, conn_complete_put_req_random, &d, &d.err,
+							G_OBEX_HDR_INVALID);
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
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -1062,6 +1122,9 @@ int main(int argc, char *argv[])
 
 	g_test_add_func("/gobex/test_conn_get_wrg_rsp", test_conn_get_wrg_rsp);
 
+	g_test_add_func("/gobex/test_conn_put_req_random",
+						test_conn_put_req_random);
+
 	g_test_run();
 
 	return 0;
diff --git a/unit/util.c b/unit/util.c
index 5788654..e8f2024 100644
--- a/unit/util.c
+++ b/unit/util.c
@@ -132,7 +132,7 @@ gboolean test_io_cb(GIOChannel *io, GIOCondition cond, gpointer user_data)
 	struct test_data *d = user_data;
 	GIOStatus status;
 	gsize bytes_written, rbytes, send_buf_len, expect_len;
-	char buf[255];
+	char buf[65535];
 	const char *send_buf, *expect;
 
 	expect = d->recv[d->count].data;
-- 
1.7.6.4

