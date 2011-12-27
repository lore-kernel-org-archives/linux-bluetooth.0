Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 08/16] gobex: add unit test for PUT request with SRM and SRMP wait
Date: Tue, 27 Dec 2011 11:07:09 +0200
Message-Id: <1324976837-11914-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
References: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |   66 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index 0475ac9..bf15359 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -64,6 +64,10 @@ static guint8 put_rsp_first[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
 static guint8 put_rsp_first_srm[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
 							0x00, 0x05,
 							G_OBEX_HDR_SRM, 0x01 };
+static guint8 put_rsp_first_srm_wait[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
+							0x00, 0x07,
+							G_OBEX_HDR_SRM, 0x01,
+							G_OBEX_HDR_SRMP, 0x01 };
 static guint8 put_rsp_last[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x03 };
 
 static guint8 get_req_first[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x23,
@@ -802,6 +806,63 @@ static void test_packet_put_req_random(void)
 	test_put_req_random(SOCK_SEQPACKET);
 }
 
+static void test_put_req_random_srm_wait(int sock_type)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+		{ NULL, 0 },
+		{ NULL, 0 },
+		{ NULL, 0 },
+		{ put_req_last, sizeof(put_req_last) } }, {
+		{ put_rsp_first_srm_wait, sizeof(put_rsp_first_srm_wait) },
+		{ put_rsp_first, sizeof(put_rsp_first) },
+		{ NULL, 0 },
+		{ put_rsp_last, sizeof(put_rsp_last) } } };
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
+static void test_stream_put_req_random_srm_wait(void)
+{
+	test_put_req_random_srm_wait(SOCK_STREAM);
+}
+
+static void test_packet_put_req_random_srm_wait(void)
+{
+	test_put_req_random_srm_wait(SOCK_SEQPACKET);
+}
+
 static void test_put_req_random_srm(int sock_type)
 {
 	GIOChannel *io;
@@ -1905,6 +1966,11 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_packet_put_req_random_srm",
 					test_packet_put_req_random_srm);
 
+	g_test_add_func("/gobex/test_stream_put_req_random_srm_wait",
+					test_stream_put_req_random_srm_wait);
+	g_test_add_func("/gobex/test_packet_put_req_random_srm_wait",
+					test_packet_put_req_random_srm_wait);
+
 	g_test_add_func("/gobex/test_stream_put_rsp_random_srm",
 					test_stream_put_rsp_random_srm);
 	g_test_add_func("/gobex/test_packet_put_rsp_random_srm",
-- 
1.7.7.4

