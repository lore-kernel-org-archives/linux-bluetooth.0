Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 13/16] gobex: add unit test for CONN followed by PUT request with SRM
Date: Tue, 27 Dec 2011 11:07:14 +0200
Message-Id: <1324976837-11914-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
References: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |   74 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index 79fc872..dfac3b0 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -133,6 +133,15 @@ static guint8 conn_rsp[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x0c,
 					G_OBEX_HDR_CONNECTION, 0x00, 0x00,
 					0x00, 0x01 };
 
+static guint8 conn_req_srm[] = { G_OBEX_OP_CONNECT | FINAL_BIT, 0x00, 0x09,
+					0x10, 0x00, 0x10, 0x00,
+					G_OBEX_HDR_SRM, 0x02 };
+static guint8 conn_rsp_srm[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x0e,
+					0x10, 0x00, 0x10, 0x00,
+					G_OBEX_HDR_CONNECTION, 0x00, 0x00,
+					0x00, 0x01,
+					G_OBEX_HDR_SRM, 0x01 };
+
 static guint8 unavailable_rsp[] = { G_OBEX_RSP_SERVICE_UNAVAILABLE | FINAL_BIT,
 					0x00, 0x03 };
 
@@ -2196,6 +2205,68 @@ static void test_conn_put_req_random(void)
 	g_assert_no_error(d.err);
 }
 
+static void conn_complete_put_req_random_srm(GObex *obex, GError *err,
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
+					G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
+					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
+					G_OBEX_HDR_NAME, "random.bin",
+					G_OBEX_HDR_INVALID);
+}
+
+static void test_conn_put_req_random_srm(void)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+				{ conn_req_srm, sizeof(conn_req_srm) } ,
+				{ NULL, 0 },
+				{ NULL, 0 },
+				{ put_req_last, sizeof(put_req_last) } }, {
+				{ conn_rsp_srm, sizeof(conn_rsp_srm) } ,
+				{ NULL, 0 },
+				{ NULL, 0 },
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
+	g_obex_connect(obex, conn_complete_put_req_random_srm, &d, &d.err,
+					G_OBEX_HDR_SRM, G_OBEX_SRM_INDICATE,
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
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -2297,6 +2368,9 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_packet_get_req_random_srm_wait_next",
 				test_packet_get_req_random_srm_wait_next);
 
+	g_test_add_func("/gobex/test_conn_put_req_random_srm",
+						test_conn_put_req_random_srm);
+
 	g_test_run();
 
 	return 0;
-- 
1.7.7.4

