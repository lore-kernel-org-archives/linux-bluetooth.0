Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] unit/test-gobex: Add test for g_obex_disconnect
Date: Fri, 21 Mar 2014 13:58:23 +0200
Message-Id: <1395403104-10344-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395403104-10344-1-git-send-email-luiz.dentz@gmail.com>
References: <1395403104-10344-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/unit/test-gobex.c b/unit/test-gobex.c
index ded83dd..2834c77 100644
--- a/unit/test-gobex.c
+++ b/unit/test-gobex.c
@@ -45,6 +45,10 @@ static uint8_t pkt_connect_req[] = { G_OBEX_OP_CONNECT | FINAL_BIT,
 static uint8_t pkt_connect_rsp[] = { 0x20 | FINAL_BIT, 0x00, 0x07,
 					0x10, 0x00, 0x10, 0x00 };
 
+static uint8_t pkt_disconnect_req[] = { G_OBEX_OP_DISCONNECT | FINAL_BIT,
+					0x00, 0x03 };
+static uint8_t pkt_disconnect_rsp[] = { 0x20 | FINAL_BIT, 0x00, 0x03 };
+
 static uint8_t pkt_setpath_req[] = { G_OBEX_OP_SETPATH | FINAL_BIT, 0x00, 0x10,
 					0x02, 0x00,
 					G_OBEX_HDR_NAME, 0x00, 0x0b,
@@ -883,6 +887,42 @@ static void test_connect(void)
 	g_assert_no_error(d.err);
 }
 
+static void test_obex_disconnect(void)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+			{ pkt_disconnect_req, sizeof(pkt_disconnect_req) } }, {
+			{ pkt_disconnect_rsp, sizeof(pkt_disconnect_rsp) } } };
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
+	g_obex_disconnect(obex, req_complete, &d, &d.err);
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
 static void test_setpath(void)
 {
 	GIOChannel *io;
@@ -1188,6 +1228,7 @@ int main(int argc, char *argv[])
 					test_cancel_req_delay_pkt);
 
 	g_test_add_func("/gobex/test_connect", test_connect);
+	g_test_add_func("/gobex/test_obex_disconnect", test_obex_disconnect);
 
 	g_test_add_func("/gobex/test_setpath", test_setpath);
 	g_test_add_func("/gobex/test_setpath_up", test_setpath_up);
-- 
1.8.5.3

