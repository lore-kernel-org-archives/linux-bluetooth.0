Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 4/4] gobex: add unit test for packet PUT request with random data
Date: Mon,  5 Dec 2011 14:35:19 +0200
Message-Id: <1323088519-18235-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1323088519-18235-1-git-send-email-luiz.dentz@gmail.com>
References: <1323088519-18235-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index 5bdd71b..f677503 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -447,7 +447,7 @@ static void handle_get(GObex *obex, GObexPacket *req, gpointer user_data)
 		g_main_loop_quit(d->mainloop);
 }
 
-static void test_put_req_random(void)
+static void test_put_req_random(int sock_type)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -463,7 +463,7 @@ static void test_put_req_random(void)
 				{ put_rsp_first, sizeof(put_rsp_first) },
 				{ put_rsp_last, sizeof(put_rsp_last) } } };
 
-	create_endpoints(&obex, &io, SOCK_STREAM);
+	create_endpoints(&obex, &io, sock_type);
 	d.obex = obex;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
@@ -493,6 +493,16 @@ static void test_put_req_random(void)
 	g_assert_no_error(d.err);
 }
 
+static void test_stream_put_req_random(void)
+{
+	test_put_req_random(SOCK_STREAM);
+}
+
+static void test_packet_put_req_random(void)
+{
+	test_put_req_random(SOCK_SEQPACKET);
+}
+
 static void test_put_req_eagain(void)
 {
 	GIOChannel *io;
@@ -1350,7 +1360,10 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_put_req_eagain", test_put_req_eagain);
 	g_test_add_func("/gobex/test_get_req_eagain", test_get_rsp_eagain);
 
-	g_test_add_func("/gobex/test_put_req_random", test_put_req_random);
+	g_test_add_func("/gobex/test_stream_put_req_random",
+						test_stream_put_req_random);
+	g_test_add_func("/gobex/test_packet_put_req_random",
+						test_packet_put_req_random);
 
 	g_test_add_func("/gobex/test_conn_get_req", test_conn_get_req);
 	g_test_add_func("/gobex/test_conn_get_rsp", test_conn_get_rsp);
-- 
1.7.7.3

