Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH obexd] gobex: call g_obex_unref() before io channel unref
Date: Thu, 08 Mar 2012 12:18:43 +0530
Message-id: <1331189323-6773-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In g_obex_unref, tx_queue will be flushed which results in SIGPIPE
in g_io_channel_write_chars() since socket is already closed in
io channel unref.
---
 unit/test-gobex-transfer.c |  105 +++++++++++++++++++++++++++++---------------
 1 files changed, 70 insertions(+), 35 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index c712382..2195090 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -297,12 +297,13 @@ static void test_put_req(void)
 
 	g_assert_cmpuint(d.count, ==, 2);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -374,12 +375,13 @@ static void test_put_rsp(void)
 
 	g_assert_cmpuint(d.count, ==, 1);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -445,12 +447,13 @@ static void test_stream_put_rsp(void)
 
 	g_assert_cmpuint(d.count, ==, RANDOM_PACKETS - 1);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -490,12 +493,13 @@ static void test_stream_put_req_abort(void)
 
 	g_assert_cmpuint(d.count, ==, RANDOM_PACKETS - 2);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_error(d.err, G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED);
 }
@@ -559,12 +563,13 @@ static void test_packet_put_rsp_wait(void)
 
 	g_assert_cmpuint(d.count, ==, RANDOM_PACKETS);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -605,12 +610,13 @@ static void test_packet_put_rsp(void)
 
 	g_assert_cmpuint(d.count, ==, RANDOM_PACKETS);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -646,12 +652,13 @@ static void test_get_req(void)
 
 	g_assert_cmpuint(d.count, ==, 2);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -691,12 +698,13 @@ static void test_stream_get_req(void)
 
 	g_assert_cmpuint(d.count, ==, RANDOM_PACKETS);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -736,12 +744,13 @@ static void test_packet_get_req(void)
 
 	g_assert_cmpuint(d.count, ==, RANDOM_PACKETS);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -782,12 +791,13 @@ static void test_packet_get_req_wait(void)
 
 	g_assert_cmpuint(d.count, ==, RANDOM_PACKETS);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -828,12 +838,13 @@ static void test_packet_get_req_wait_next(void)
 
 	g_assert_cmpuint(d.count, ==, RANDOM_PACKETS);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -872,12 +883,13 @@ static void test_get_req_app(void)
 
 	g_assert_cmpuint(d.count, ==, 3);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -957,12 +969,13 @@ static void test_stream_put_req(void)
 
 	g_assert_cmpuint(d.count, ==, RANDOM_PACKETS);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1003,12 +1016,13 @@ static void test_packet_put_req_wait(void)
 
 	g_assert_cmpuint(d.count, ==, RANDOM_PACKETS);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1049,12 +1063,13 @@ static void test_packet_put_req(void)
 
 	g_assert_cmpuint(d.count, ==, RANDOM_PACKETS);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1088,6 +1103,8 @@ static void test_put_req_eagain(void)
 					G_OBEX_HDR_INVALID);
 	g_assert_no_error(d.err);
 
+	g_obex_unref(obex);
+
 	g_main_loop_run(d.mainloop);
 
 	g_assert_cmpuint(d.count, ==, 2);
@@ -1097,7 +1114,6 @@ static void test_put_req_eagain(void)
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1133,12 +1149,13 @@ static void test_get_rsp(void)
 
 	g_assert_cmpuint(d.count, ==, 1);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1197,12 +1214,13 @@ static void test_stream_get_rsp(void)
 
 	g_assert_cmpuint(d.count, ==, RANDOM_PACKETS - 1);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1242,12 +1260,13 @@ static void test_packet_get_rsp(void)
 
 	g_assert_cmpuint(d.count, ==, RANDOM_PACKETS - 1);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1310,12 +1329,13 @@ static void test_packet_get_rsp_wait(void)
 
 	g_assert_cmpuint(d.count, ==, RANDOM_PACKETS - 1);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1377,12 +1397,13 @@ static void test_get_rsp_app(void)
 
 	g_assert_cmpuint(d.count, ==, 2);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1420,12 +1441,13 @@ static void test_put_req_delay(void)
 
 	g_assert_cmpuint(d.count, ==, 2);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1463,12 +1485,13 @@ static void test_get_rsp_delay(void)
 
 	g_assert_cmpuint(d.count, ==, 1);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1547,12 +1570,13 @@ static void test_put_rsp_delay(void)
 
 	g_assert_cmpuint(d.count, ==, 1);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1590,12 +1614,13 @@ static void test_get_req_delay(void)
 
 	g_assert_cmpuint(d.count, ==, 2);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1634,12 +1659,13 @@ static void test_get_rsp_eagain(void)
 
 	g_assert_cmpuint(d.count, ==, 1);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1682,12 +1708,13 @@ static void test_conn_req(void)
 
 	g_assert_cmpuint(d.count, ==, 1);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1743,12 +1770,13 @@ static void test_conn_rsp(void)
 
 	g_assert_cmpuint(d.count, ==, 1);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1801,12 +1829,13 @@ static void test_conn_get_req(void)
 
 	g_assert_cmpuint(d.count, ==, 3);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1849,12 +1878,13 @@ static void test_conn_get_rsp(void)
 
 	g_assert_cmpuint(d.count, ==, 2);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1907,12 +1937,13 @@ static void test_conn_put_req(void)
 
 	g_assert_cmpuint(d.count, ==, 3);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1955,12 +1986,13 @@ static void test_conn_put_rsp(void)
 
 	g_assert_cmpuint(d.count, ==, 2);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -1998,12 +2030,13 @@ static void test_conn_get_wrg_rsp(void)
 
 	g_assert_cmpuint(d.count, ==, 2);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -2058,12 +2091,13 @@ static void test_conn_put_req_seq(void)
 
 	g_assert_cmpuint(d.count, ==, RANDOM_PACKETS);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
@@ -2119,12 +2153,13 @@ static void test_conn_put_req_seq_srm(void)
 
 	g_assert_cmpuint(d.count, ==, RANDOM_PACKETS);
 
+	g_obex_unref(obex);
+
 	g_main_loop_unref(d.mainloop);
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
-	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
 }
-- 
1.7.1

