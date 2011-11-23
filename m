Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/4] gobex: add unit test for GET request with delay
Date: Wed, 23 Nov 2011 15:42:07 +0200
Message-Id: <1322055729-7185-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1322055729-7185-1-git-send-email-luiz.dentz@gmail.com>
References: <1322055729-7185-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index 9839c0f..30a6ad6 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -711,6 +711,49 @@ static void test_put_rsp_delay(void)
 	g_assert_no_error(d.err);
 }
 
+static void test_get_req_delay(void)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+				{ get_req_first, sizeof(get_req_first) },
+				{ get_req_last, sizeof(get_req_last) } }, {
+				{ get_rsp_first, sizeof(get_rsp_first) },
+				{ get_rsp_last, sizeof(get_rsp_last) } } };
+
+	create_endpoints(&obex, &io, SOCK_STREAM);
+	d.obex = obex;
+	d.provide_delay = 200;
+
+	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
+	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+
+	d.mainloop = g_main_loop_new(NULL, FALSE);
+
+	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+
+	g_obex_get_req(obex, rcv_data_delay, transfer_complete, &d, &d.err,
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
 static void test_get_rsp_eagain(void)
 {
 	GIOChannel *io;
@@ -1193,6 +1236,7 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_put_req_delay", test_put_req_delay);
 	g_test_add_func("/gobex/test_put_rsp_delay", test_put_rsp_delay);
 
+	g_test_add_func("/gobex/test_get_req_delay", test_get_req_delay);
 	g_test_add_func("/gobex/test_get_rsp_delay", test_get_rsp_delay);
 
 	g_test_add_func("/gobex/test_put_req_eagain", test_put_req_eagain);
-- 
1.7.7.3

