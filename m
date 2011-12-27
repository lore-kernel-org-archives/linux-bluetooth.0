Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 11/16] gobex: add unit test for GET request with SRM and SRMP wait
Date: Tue, 27 Dec 2011 11:07:12 +0200
Message-Id: <1324976837-11914-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
References: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |   70 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index 0e5d309..3fb2c8f 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -91,6 +91,14 @@ static guint8 get_req_first_srm[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x25,
 	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0,
 	G_OBEX_HDR_SRM, 0x01 };
 
+static guint8 get_req_first_srm_wait[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x27,
+	G_OBEX_HDR_TYPE, 0x00, 0x0b,
+	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
+	G_OBEX_HDR_NAME, 0x00, 0x15,
+	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0,
+	G_OBEX_HDR_SRM, 0x01,
+	G_OBEX_HDR_SRMP, 0x01 };
+
 static guint8 get_req_last[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x03, };
 
 static guint8 get_rsp_first_app[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT, 0x00, 0x0A,
@@ -747,6 +755,63 @@ static void test_packet_get_req_random_srm(void)
 	test_get_req_random_srm(SOCK_SEQPACKET);
 }
 
+static void test_get_req_random_srm_wait(int sock_type)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+		{ get_req_first_srm_wait, sizeof(get_req_first_srm_wait) },
+		{ get_req_last, sizeof(get_req_last) },
+		{ NULL, -1 },
+		{ get_req_last, sizeof(get_req_last) } }, {
+		{ get_rsp_first_srm, sizeof(get_rsp_first_srm) },
+		{ get_rsp_zero, sizeof(get_rsp_zero) },
+		{ get_rsp_zero, sizeof(get_rsp_zero) },
+		{ get_rsp_last, sizeof(get_rsp_last) } } };
+
+	create_endpoints(&obex, &io, sock_type);
+
+	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
+	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+
+	d.mainloop = g_main_loop_new(NULL, FALSE);
+
+	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+
+	g_obex_get_req(obex, rcv_random, transfer_complete, &d, &d.err,
+				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
+				G_OBEX_HDR_NAME, "file.txt",
+				G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
+				G_OBEX_HDR_SRMP, G_OBEX_SRMP_WAIT,
+				G_OBEX_HDR_INVALID);
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
+static void test_stream_get_req_random_srm_wait(void)
+{
+	test_get_req_random_srm_wait(SOCK_STREAM);
+}
+
+static void test_packet_get_req_random_srm_wait(void)
+{
+	test_get_req_random_srm_wait(SOCK_SEQPACKET);
+}
+
 static void test_get_req_app(void)
 {
 	GIOChannel *io;
@@ -2155,6 +2220,11 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_packet_get_req_random_srm",
 					test_packet_get_req_random_srm);
 
+	g_test_add_func("/gobex/test_stream_get_req_random_srm_wait",
+					test_stream_get_req_random_srm_wait);
+	g_test_add_func("/gobex/test_packet_get_req_random_srm_wait",
+					test_packet_get_req_random_srm_wait);
+
 	g_test_run();
 
 	return 0;
-- 
1.7.7.4

