Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH] gobex: Add "cd ../dir" handling in setpath
Date: Thu, 17 Nov 2011 14:45:30 +0100
Message-Id: <1321537530-22509-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gobex/gobex.c     |   14 ++++++++++----
 unit/test-gobex.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 7840304..b374b06 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -1088,6 +1088,7 @@ guint g_obex_setpath(GObex *obex, const char *path, GObexResponseFunc func,
 {
 	GObexPacket *req;
 	struct setpath_data data;
+	const char *folder;
 
 	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
 
@@ -1095,12 +1096,17 @@ guint g_obex_setpath(GObex *obex, const char *path, GObexResponseFunc func,
 
 	memset(&data, 0, sizeof(data));
 
-	if (strcmp(path, "..") == 0)
+	if (path != NULL && strncmp("..", path, 2) == 0) {
 		data.flags = 0x03;
-	else {
-		GObexHeader *hdr;
+		folder = (path[2] == '/') ? &path[3] : NULL;
+	} else {
 		data.flags = 0x02;
-		hdr = g_obex_header_new_unicode(G_OBEX_HDR_NAME, path);
+		folder = path;
+	}
+
+	if (folder != NULL) {
+		GObexHeader *hdr;
+		hdr = g_obex_header_new_unicode(G_OBEX_HDR_NAME, folder);
 		g_obex_packet_add_header(req, hdr);
 	}
 
diff --git a/unit/test-gobex.c b/unit/test-gobex.c
index 62443db..cce5b98 100644
--- a/unit/test-gobex.c
+++ b/unit/test-gobex.c
@@ -46,6 +46,10 @@ static uint8_t pkt_setpath_req[] = { G_OBEX_OP_SETPATH | FINAL_BIT, 0x00, 0x10,
 					0, 'd', 0, 'i', 0, 'r', 0, 0 };
 static uint8_t pkt_setpath_up_req[] = { G_OBEX_OP_SETPATH | FINAL_BIT,
 					0x00, 0x05, 0x03, 0x00 };
+static uint8_t pkt_setpath_up_down_req[] = { G_OBEX_OP_SETPATH | FINAL_BIT,
+					0x00, 0x10, 0x03, 0x00,
+					G_OBEX_HDR_NAME, 0x00, 0x0b,
+					0, 'd', 0, 'i', 0, 'r', 0, 0 };
 static uint8_t pkt_success_rsp[] = { 0x20 | FINAL_BIT, 0x00, 0x03 };
 
 static uint8_t pkt_mkdir_req[] = { G_OBEX_OP_SETPATH | FINAL_BIT, 0x00, 0x10,
@@ -943,6 +947,43 @@ static void test_setpath_up(void)
 	g_assert_no_error(d.err);
 }
 
+static void test_setpath_up_down(void)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+			{ pkt_setpath_up_down_req,
+					sizeof(pkt_setpath_up_down_req) } }, {
+			{ pkt_success_rsp, sizeof(pkt_success_rsp) } } };
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
+	g_obex_setpath(obex, "../dir", req_complete, &d, &d.err);
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
 static void test_mkdir(void)
 {
 	GIOChannel *io;
@@ -1142,6 +1183,7 @@ int main(int argc, char *argv[])
 
 	g_test_add_func("/gobex/test_setpath", test_setpath);
 	g_test_add_func("/gobex/test_setpath_up", test_setpath_up);
+	g_test_add_func("/gobex/test_setpath_up_down", test_setpath_up_down);
 
 	g_test_add_func("/gobex/test_mkdir", test_mkdir);
 
-- 
1.7.4.1

