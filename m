Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: patrick.ohly@intel.com
Subject: [PATCH BlueZ 5/8] unit/test-gobex-transfer: Add /gobex/test_packet_get_req_suspend_resume
Date: Fri, 14 Feb 2014 17:53:01 +0200
Message-Id: <1392393184-15266-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392393184-15266-1-git-send-email-luiz.dentz@gmail.com>
References: <1392393184-15266-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a test to call g_obex_suspend and latter g_obex_resume while
SRM is enabled.
---
 unit/test-gobex-transfer.c | 81 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 4 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index 7c9fd43..0d26111 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -106,6 +106,9 @@ static guint8 get_req_first_srm_wait[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x27
 	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0,
 	G_OBEX_HDR_SRMP, 0x01 };
 
+static guint8 get_req_srm_wait[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x05,
+	G_OBEX_HDR_SRMP, 0x01 };
+
 static guint8 get_req_last[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x03, };
 
 static guint8 get_rsp_first_app[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT, 0x00, 0x0A,
@@ -124,6 +127,8 @@ static guint8 get_rsp_first_srm_wait_next[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
 					G_OBEX_HDR_SRMP, 0x02,
 					G_OBEX_HDR_BODY, 0x00, 0x0d,
 					0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
+static guint8 get_rsp_srm_wait[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
+					0x00, 0x03 };
 static guint8 get_rsp_zero[255] = { G_OBEX_RSP_CONTINUE | FINAL_BIT, 0x00, 0xff,
 					G_OBEX_HDR_BODY, 0x00, 0xfc };
 static guint8 get_rsp_zero_wait_next[255] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
@@ -191,7 +196,13 @@ static void transfer_complete(GObex *obex, GError *err, gpointer user_data)
 
 static gboolean resume_obex(gpointer user_data)
 {
-	g_obex_resume(user_data);
+	struct test_data *d = user_data;
+
+	if (!g_main_loop_is_running(d->mainloop))
+		return FALSE;
+
+	g_obex_resume(d->obex);
+
 	return FALSE;
 }
 
@@ -232,7 +243,7 @@ static gssize provide_eagain(void *buf, gsize len, gpointer user_data)
 	}
 
 	if (d->provide_delay > 0) {
-		g_timeout_add(d->provide_delay, resume_obex, d->obex);
+		g_timeout_add(d->provide_delay, resume_obex, d);
 		d->provide_delay = 0;
 		return -EAGAIN;
 	}
@@ -260,7 +271,7 @@ static gssize provide_data(void *buf, gsize len, gpointer user_data)
 
 	if (d->provide_delay > 0) {
 		g_obex_suspend(d->obex);
-		g_timeout_add(d->provide_delay, resume_obex, d->obex);
+		g_timeout_add(d->provide_delay, resume_obex, d);
 	}
 
 	d->total += sizeof(body_data);
@@ -852,6 +863,66 @@ static void test_packet_get_req_wait(void)
 	g_assert_no_error(d.err);
 }
 
+static gboolean rcv_seq_delay(const void *buf, gsize len, gpointer user_data)
+{
+	struct test_data *d = user_data;
+
+	if (d->provide_delay > 0) {
+		g_obex_suspend(d->obex);
+		g_idle_add(resume_obex, d);
+		d->provide_delay = 0;
+	}
+
+	return TRUE;
+}
+
+static void test_packet_get_req_suspend_resume(void)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+		{ get_req_first_srm, sizeof(get_req_first_srm) },
+		{ get_req_srm_wait, sizeof(get_req_srm_wait) },
+		{ get_req_srm_wait, sizeof(get_req_srm_wait) },
+		{ get_req_last, sizeof(get_req_last) } }, {
+		{ get_rsp_first_srm, sizeof(get_rsp_first_srm) },
+		{ get_rsp_srm_wait, sizeof(get_rsp_srm_wait) },
+		{ get_rsp_srm_wait, sizeof(get_rsp_srm_wait) },
+		{ get_rsp_last, sizeof(get_rsp_last) } } };
+
+	create_endpoints(&obex, &io, SOCK_SEQPACKET);
+	d.obex = obex;
+	d.provide_delay = 1;
+
+	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
+	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+
+	d.mainloop = g_main_loop_new(NULL, FALSE);
+
+	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+
+	g_obex_get_req(obex, rcv_seq_delay, transfer_complete, &d, &d.err,
+				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
+				G_OBEX_HDR_NAME, "file.txt",
+				G_OBEX_HDR_INVALID);
+	g_assert_no_error(d.err);
+
+	g_main_loop_run(d.mainloop);
+
+	g_assert_cmpuint(d.count, ==, 4);
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
 static void test_packet_get_req_wait_next(void)
 {
 	GIOChannel *io;
@@ -1549,7 +1620,7 @@ static gboolean rcv_data_delay(const void *buf, gsize len, gpointer user_data)
 
 	if (d->provide_delay > 0) {
 		g_obex_suspend(d->obex);
-		g_timeout_add(d->provide_delay, resume_obex, d->obex);
+		g_timeout_add(d->provide_delay, resume_obex, d);
 	}
 
 	return TRUE;
@@ -2253,6 +2324,8 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_packet_get_req", test_packet_get_req);
 	g_test_add_func("/gobex/test_packet_get_req_wait",
 						test_packet_get_req_wait);
+	g_test_add_func("/gobex/test_packet_get_req_suspend_resume",
+					test_packet_get_req_suspend_resume);
 
 	g_test_add_func("/gobex/test_packet_get_req_wait_next",
 						test_packet_get_req_wait_next);
-- 
1.8.5.3

