Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/6] gobex: Add random put request test
Date: Fri, 26 Aug 2011 12:49:33 +0300
Message-Id: <1314352176-12244-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1314352176-12244-1-git-send-email-luiz.dentz@gmail.com>
References: <1314352176-12244-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |  102 ++++++++++++++++++++++++++++++++++++++------
 unit/util.h                |    4 +-
 2 files changed, 90 insertions(+), 16 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index aeea846..a246418 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -22,16 +22,19 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/socket.h>
+#include <sys/stat.h>
 #include <errno.h>
 #include <unistd.h>
 #include <string.h>
 #include <stdint.h>
+#include <fcntl.h>
 
 #include <gobex/gobex.h>
 
 #include "util.h"
 
 #define FINAL_BIT 0x80
+#define RANDOM_PACKETS 4
 
 static guint8 put_req_first[] = { G_OBEX_OP_PUT, 0x00, 0x30,
 	G_OBEX_HDR_TYPE, 0x00, 0x0b,
@@ -81,6 +84,28 @@ static gboolean resume_obex(gpointer user_data)
 	return FALSE;
 }
 
+static gssize provide_random(void *buf, gsize len, gpointer user_data)
+{
+	struct test_data *d = user_data;
+	int fd;
+	gssize ret;
+
+	if (d->count == RANDOM_PACKETS - 1)
+		return 0;
+
+	fd = open("/dev/urandom", O_RDONLY | O_NOCTTY, 0);
+	if (fd < 0) {
+		g_set_error(&d->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
+				"open(/dev/urandom): %s", strerror(errno));
+		g_main_loop_quit(d->mainloop);
+		return -1;
+	}
+
+	ret = read(fd, buf, len);
+	close(fd);
+	return ret;
+}
+
 static gssize provide_eagain(void *buf, gsize len, gpointer user_data)
 {
 	struct test_data *d = user_data;
@@ -328,19 +353,25 @@ static void handle_get(GObex *obex, GObexPacket *req, gpointer user_data)
 		g_main_loop_quit(d->mainloop);
 }
 
-static void test_get_rsp(void)
+static void test_put_req_random(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
 	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
-				{ get_rsp_first, sizeof(get_rsp_first) },
-				{ get_rsp_last, sizeof(get_rsp_last) } }, {
-				{ get_req_last, sizeof(get_req_last) },
-				{ NULL, 0 } } };
+				{ NULL, 0 },
+				{ NULL, 0 },
+				{ NULL, 0 },
+				{ put_req_last, sizeof(put_req_last) } }, {
+				{ put_rsp_first, sizeof(put_rsp_first) },
+				{ put_rsp_first, sizeof(put_rsp_first) },
+				{ put_rsp_first, sizeof(put_rsp_first) },
+				{ put_rsp_last, sizeof(put_rsp_last) } } };
 
 	create_endpoints(&obex, &io, SOCK_STREAM);
+	d.obex = obex;
+	d.provide_delay = 200;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
@@ -349,15 +380,15 @@ static void test_get_rsp(void)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get, &d);
-
-	g_io_channel_write_chars(io, (char *) get_req_first,
-					sizeof(get_req_first), NULL, &d.err);
+	g_obex_put_req(obex, provide_random, transfer_complete, &d, &d.err,
+					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
+					G_OBEX_HDR_NAME, "random.bin",
+					G_OBEX_HDR_INVALID);
 	g_assert_no_error(d.err);
 
 	g_main_loop_run(d.mainloop);
 
-	g_assert_cmpuint(d.count, ==, 1);
+	g_assert_cmpuint(d.count, ==, RANDOM_PACKETS);
 
 	g_main_loop_unref(d.mainloop);
 
@@ -369,7 +400,7 @@ static void test_get_rsp(void)
 	g_assert_no_error(d.err);
 }
 
-static void test_put_req_delay(void)
+static void test_put_req_eagain(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -392,7 +423,7 @@ static void test_put_req_delay(void)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_put_req(obex, provide_data, transfer_complete, &d, &d.err,
+	g_obex_put_req(obex, provide_eagain, transfer_complete, &d, &d.err,
 					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 					G_OBEX_HDR_NAME, "file.txt",
 					G_OBEX_HDR_INVALID);
@@ -412,7 +443,48 @@ static void test_put_req_delay(void)
 	g_assert_no_error(d.err);
 }
 
-static void test_put_req_eagain(void)
+static void test_get_rsp(void)
+{
+	GIOChannel *io;
+	GIOCondition cond;
+	guint io_id, timer_id;
+	GObex *obex;
+	struct test_data d = { 0, NULL, {
+				{ get_rsp_first, sizeof(get_rsp_first) },
+				{ get_rsp_last, sizeof(get_rsp_last) } }, {
+				{ get_req_last, sizeof(get_req_last) },
+				{ NULL, 0 } } };
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
+	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get, &d);
+
+	g_io_channel_write_chars(io, (char *) get_req_first,
+					sizeof(get_req_first), NULL, &d.err);
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
+static void test_put_req_delay(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -435,7 +507,7 @@ static void test_put_req_eagain(void)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_put_req(obex, provide_eagain, transfer_complete, &d, &d.err,
+	g_obex_put_req(obex, provide_data, transfer_complete, &d, &d.err,
 					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 					G_OBEX_HDR_NAME, "file.txt",
 					G_OBEX_HDR_INVALID);
@@ -558,6 +630,8 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_put_req_eagain", test_put_req_eagain);
 	g_test_add_func("/gobex/test_put_req_eagain", test_get_rsp_eagain);
 
+	g_test_add_func("/gobex/test_put_req_random", test_put_req_random);
+
 	g_test_run();
 
 	return 0;
diff --git a/unit/util.h b/unit/util.h
index 1878051..4a7fc43 100644
--- a/unit/util.h
+++ b/unit/util.h
@@ -34,8 +34,8 @@ struct test_buf {
 struct test_data {
 	guint count;
 	GError *err;
-	struct test_buf recv[3];
-	struct test_buf send[3];
+	struct test_buf recv[4];
+	struct test_buf send[4];
 	guint provide_delay;
 	GObex *obex;
 	GMainLoop *mainloop;
-- 
1.7.6

