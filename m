Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] unit/test-gobex: Add test for OBEX authentication
Date: Fri, 28 Mar 2014 15:38:38 +0200
Message-Id: <1396013919-15122-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1396013919-15122-1-git-send-email-luiz.dentz@gmail.com>
References: <1396013919-15122-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/unit/test-gobex.c b/unit/test-gobex.c
index 2834c77..74208f6 100644
--- a/unit/test-gobex.c
+++ b/unit/test-gobex.c
@@ -49,6 +49,21 @@ static uint8_t pkt_disconnect_req[] = { G_OBEX_OP_DISCONNECT | FINAL_BIT,
 					0x00, 0x03 };
 static uint8_t pkt_disconnect_rsp[] = { 0x20 | FINAL_BIT, 0x00, 0x03 };
 
+static uint8_t pkt_unauth_rsp[] = { 0x41 | FINAL_BIT, 0x00, 0x1c,
+					0x10, 0x00, 0x10, 0x00, 0x4d, 0x00,
+					0x15, 0x00, 0x10, 0x00, 0x00, 0x00,
+					0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+					0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+					0x00 };
+static uint8_t pkt_auth_req[] = { G_OBEX_OP_CONNECT | FINAL_BIT, 0x00, 0x1c,
+					0x10, 0x00, 0x10, 0x00, 0x4e, 0x00,
+					0x15, 0x00, 0x10, 0x5a, 0xd4, 0x93,
+					0x93, 0xba, 0x4a, 0xf8, 0xac, 0xce,
+					0x7f, 0x5b, 0x1a, 0x05, 0x38, 0x74,
+					0x24 };
+static uint8_t pkt_auth_rsp[] = { 0x20 | FINAL_BIT, 0x00, 0x07,
+					0x10, 0x00, 0x10, 0x00 };
+
 static uint8_t pkt_setpath_req[] = { G_OBEX_OP_SETPATH | FINAL_BIT, 0x00, 0x10,
 					0x02, 0x00,
 					G_OBEX_HDR_NAME, 0x00, 0x0b,
@@ -923,6 +938,45 @@ static void test_obex_disconnect(void)
 	g_assert_no_error(d.err);
 }
 
+static void test_auth(void)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+				{ pkt_connect_req, sizeof(pkt_connect_req) },
+				{ pkt_auth_req, sizeof(pkt_auth_req) } }, {
+				{ pkt_unauth_rsp, sizeof(pkt_unauth_rsp) },
+				{ pkt_auth_rsp, sizeof(pkt_auth_rsp) } },
+				};
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
+	g_obex_connect(obex, req_complete, &d, &d.err, G_OBEX_HDR_INVALID);
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
 static void test_setpath(void)
 {
 	GIOChannel *io;
@@ -1229,6 +1283,7 @@ int main(int argc, char *argv[])
 
 	g_test_add_func("/gobex/test_connect", test_connect);
 	g_test_add_func("/gobex/test_obex_disconnect", test_obex_disconnect);
+	g_test_add_func("/gobex/test_auth", test_auth);
 
 	g_test_add_func("/gobex/test_setpath", test_setpath);
 	g_test_add_func("/gobex/test_setpath_up", test_setpath_up);
-- 
1.8.5.3

