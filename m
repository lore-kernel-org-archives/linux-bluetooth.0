Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 14/16] gobex: simplify naming of tests when transfering sequence of packets
Date: Tue, 27 Dec 2011 11:07:15 +0200
Message-Id: <1324976837-11914-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
References: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Before random was used but the number of packets were not really random
so now seq is used instead.
---
 unit/test-gobex-transfer.c |  364 +++++++++++++++++++++----------------------
 1 files changed, 178 insertions(+), 186 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index dfac3b0..eb6a55e 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -188,7 +188,7 @@ static gboolean resume_obex(gpointer user_data)
 	return FALSE;
 }
 
-static gssize provide_random(void *buf, gsize len, gpointer user_data)
+static gssize provide_seq(void *buf, gsize len, gpointer user_data)
 {
 	struct test_data *d = user_data;
 	int fd;
@@ -382,12 +382,12 @@ static void test_put_rsp(void)
 	g_assert_no_error(d.err);
 }
 
-static gboolean rcv_random(const void *buf, gsize len, gpointer user_data)
+static gboolean rcv_seq(const void *buf, gsize len, gpointer user_data)
 {
 	return TRUE;
 }
 
-static void handle_put_random(GObex *obex, GObexPacket *req,
+static void handle_put_seq(GObex *obex, GObexPacket *req,
 							gpointer user_data)
 {
 	struct test_data *d = user_data;
@@ -401,35 +401,13 @@ static void handle_put_random(GObex *obex, GObexPacket *req,
 		return;
 	}
 
-	id = g_obex_put_rsp(obex, req, rcv_random, transfer_complete, d,
+	id = g_obex_put_rsp(obex, req, rcv_seq, transfer_complete, d,
 						&d->err, G_OBEX_HDR_INVALID);
 	if (id == 0)
 		g_main_loop_quit(d->mainloop);
 }
 
-static void handle_put_random_srm(GObex *obex, GObexPacket *req,
-							gpointer user_data)
-{
-	struct test_data *d = user_data;
-	guint8 op = g_obex_packet_get_operation(req, NULL);
-	guint id;
-
-	if (op != G_OBEX_OP_PUT) {
-		d->err = g_error_new(TEST_ERROR, TEST_ERROR_UNEXPECTED,
-					"Unexpected opcode 0x%02x", op);
-		g_main_loop_quit(d->mainloop);
-		return;
-	}
-
-	id = g_obex_put_rsp(obex, req, rcv_random, transfer_complete, d,
-					&d->err,
-					G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
-					G_OBEX_HDR_INVALID);
-	if (id == 0)
-		g_main_loop_quit(d->mainloop);
-}
-
-static void test_put_rsp_random(int sock_type)
+static void test_put_rsp_seq(int sock_type)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -454,7 +432,7 @@ static void test_put_rsp_random(int sock_type)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put_random,
+	g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put_seq,
 									&d);
 
 	g_io_channel_write_chars(io, (char *) put_req_first,
@@ -475,17 +453,17 @@ static void test_put_rsp_random(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_put_rsp_random(void)
+static void test_stream_put_rsp(void)
 {
-	test_put_rsp_random(SOCK_STREAM);
+	test_put_rsp_seq(SOCK_STREAM);
 }
 
-static void test_packet_put_rsp_random(void)
+static void test_packet_put_rsp(void)
 {
-	test_put_rsp_random(SOCK_SEQPACKET);
+	test_put_rsp_seq(SOCK_SEQPACKET);
 }
 
-static void handle_put_random_wait(GObex *obex, GObexPacket *req,
+static void handle_put_seq_wait(GObex *obex, GObexPacket *req,
 							gpointer user_data)
 {
 	struct test_data *d = user_data;
@@ -499,7 +477,7 @@ static void handle_put_random_wait(GObex *obex, GObexPacket *req,
 		return;
 	}
 
-	id = g_obex_put_rsp(obex, req, rcv_random, transfer_complete, d,
+	id = g_obex_put_rsp(obex, req, rcv_seq, transfer_complete, d,
 					&d->err,
 					G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
 					G_OBEX_HDR_SRMP, G_OBEX_SRMP_WAIT,
@@ -508,7 +486,7 @@ static void handle_put_random_wait(GObex *obex, GObexPacket *req,
 		g_main_loop_quit(d->mainloop);
 }
 
-static void test_put_rsp_random_srm_wait(int sock_type)
+static void test_put_rsp_seq_srm_wait(int sock_type)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -534,7 +512,7 @@ static void test_put_rsp_random_srm_wait(int sock_type)
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_add_request_function(obex, G_OBEX_OP_PUT,
-						handle_put_random_wait, &d);
+						handle_put_seq_wait, &d);
 
 	g_io_channel_write_chars(io, (char *) put_req_first_srm,
 					sizeof(put_req_first_srm), NULL,
@@ -555,17 +533,39 @@ static void test_put_rsp_random_srm_wait(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_put_rsp_random_srm_wait(void)
+static void test_stream_put_rsp_srm_wait(void)
 {
-	test_put_rsp_random_srm_wait(SOCK_STREAM);
+	test_put_rsp_seq_srm_wait(SOCK_STREAM);
 }
 
-static void test_packet_put_rsp_random_srm_wait(void)
+static void test_packet_put_rsp_srm_wait(void)
 {
-	test_put_rsp_random_srm_wait(SOCK_SEQPACKET);
+	test_put_rsp_seq_srm_wait(SOCK_SEQPACKET);
+}
+
+static void handle_put_seq_srm(GObex *obex, GObexPacket *req,
+							gpointer user_data)
+{
+	struct test_data *d = user_data;
+	guint8 op = g_obex_packet_get_operation(req, NULL);
+	guint id;
+
+	if (op != G_OBEX_OP_PUT) {
+		d->err = g_error_new(TEST_ERROR, TEST_ERROR_UNEXPECTED,
+					"Unexpected opcode 0x%02x", op);
+		g_main_loop_quit(d->mainloop);
+		return;
+	}
+
+	id = g_obex_put_rsp(obex, req, rcv_seq, transfer_complete, d,
+					&d->err,
+					G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
+					G_OBEX_HDR_INVALID);
+	if (id == 0)
+		g_main_loop_quit(d->mainloop);
 }
 
-static void test_put_rsp_random_srm(int sock_type)
+static void test_put_rsp_seq_srm(int sock_type)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -590,7 +590,7 @@ static void test_put_rsp_random_srm(int sock_type)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put_random_srm,
+	g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put_seq_srm,
 									&d);
 
 	g_io_channel_write_chars(io, (char *) put_req_first_srm,
@@ -612,14 +612,14 @@ static void test_put_rsp_random_srm(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_put_rsp_random_srm(void)
+static void test_stream_put_rsp_srm(void)
 {
-	test_put_rsp_random_srm(SOCK_STREAM);
+	test_put_rsp_seq_srm(SOCK_STREAM);
 }
 
-static void test_packet_put_rsp_random_srm(void)
+static void test_packet_put_rsp_srm(void)
 {
-	test_put_rsp_random_srm(SOCK_SEQPACKET);
+	test_put_rsp_seq_srm(SOCK_SEQPACKET);
 }
 
 static void test_get_req(void)
@@ -663,7 +663,7 @@ static void test_get_req(void)
 	g_assert_no_error(d.err);
 }
 
-static void test_get_req_random(int sock_type)
+static void test_get_req_seq(int sock_type)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -688,7 +688,7 @@ static void test_get_req_random(int sock_type)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_get_req(obex, rcv_random, transfer_complete, &d, &d.err,
+	g_obex_get_req(obex, rcv_seq, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 				G_OBEX_HDR_NAME, "file.txt",
 				G_OBEX_HDR_INVALID);
@@ -708,17 +708,17 @@ static void test_get_req_random(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_get_req_random(void)
+static void test_stream_get_req(void)
 {
-	test_get_req_random(SOCK_STREAM);
+	test_get_req_seq(SOCK_STREAM);
 }
 
-static void test_packet_get_req_random(void)
+static void test_packet_get_req(void)
 {
-	test_get_req_random(SOCK_SEQPACKET);
+	test_get_req_seq(SOCK_SEQPACKET);
 }
 
-static void test_get_req_random_srm(int sock_type)
+static void test_get_req_seq_srm(int sock_type)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -743,7 +743,7 @@ static void test_get_req_random_srm(int sock_type)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_get_req(obex, rcv_random, transfer_complete, &d, &d.err,
+	g_obex_get_req(obex, rcv_seq, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 				G_OBEX_HDR_NAME, "file.txt",
 				G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
@@ -764,17 +764,17 @@ static void test_get_req_random_srm(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_get_req_random_srm(void)
+static void test_stream_get_req_srm(void)
 {
-	test_get_req_random_srm(SOCK_STREAM);
+	test_get_req_seq_srm(SOCK_STREAM);
 }
 
-static void test_packet_get_req_random_srm(void)
+static void test_packet_get_req_srm(void)
 {
-	test_get_req_random_srm(SOCK_SEQPACKET);
+	test_get_req_seq_srm(SOCK_SEQPACKET);
 }
 
-static void test_get_req_random_srm_wait(int sock_type)
+static void test_get_req_seq_srm_wait(int sock_type)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -799,7 +799,7 @@ static void test_get_req_random_srm_wait(int sock_type)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_get_req(obex, rcv_random, transfer_complete, &d, &d.err,
+	g_obex_get_req(obex, rcv_seq, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 				G_OBEX_HDR_NAME, "file.txt",
 				G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
@@ -821,17 +821,17 @@ static void test_get_req_random_srm_wait(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_get_req_random_srm_wait(void)
+static void test_stream_get_req_srm_wait(void)
 {
-	test_get_req_random_srm_wait(SOCK_STREAM);
+	test_get_req_seq_srm_wait(SOCK_STREAM);
 }
 
-static void test_packet_get_req_random_srm_wait(void)
+static void test_packet_get_req_srm_wait(void)
 {
-	test_get_req_random_srm_wait(SOCK_SEQPACKET);
+	test_get_req_seq_srm_wait(SOCK_SEQPACKET);
 }
 
-static void test_get_req_random_srm_wait_next(int sock_type)
+static void test_get_req_seq_srm_wait_next(int sock_type)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -857,7 +857,7 @@ static void test_get_req_random_srm_wait_next(int sock_type)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_get_req(obex, rcv_random, transfer_complete, &d, &d.err,
+	g_obex_get_req(obex, rcv_seq, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 				G_OBEX_HDR_NAME, "file.txt",
 				G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
@@ -878,14 +878,14 @@ static void test_get_req_random_srm_wait_next(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_get_req_random_srm_wait_next(void)
+static void test_stream_get_req_srm_wait_next(void)
 {
-	test_get_req_random_srm_wait_next(SOCK_STREAM);
+	test_get_req_seq_srm_wait_next(SOCK_STREAM);
 }
 
-static void test_packet_get_req_random_srm_wait_next(void)
+static void test_packet_get_req_srm_wait_next(void)
 {
-	test_get_req_random_srm_wait_next(SOCK_SEQPACKET);
+	test_get_req_seq_srm_wait_next(SOCK_SEQPACKET);
 }
 
 static void test_get_req_app(void)
@@ -971,7 +971,7 @@ static void handle_get(GObex *obex, GObexPacket *req, gpointer user_data)
 		g_main_loop_quit(d->mainloop);
 }
 
-static void test_put_req_random(int sock_type)
+static void test_put_req_seq(int sock_type)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -997,7 +997,7 @@ static void test_put_req_random(int sock_type)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_put_req(obex, provide_random, transfer_complete, &d, &d.err,
+	g_obex_put_req(obex, provide_seq, transfer_complete, &d, &d.err,
 					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 					G_OBEX_HDR_NAME, "random.bin",
 					G_OBEX_HDR_INVALID);
@@ -1017,17 +1017,17 @@ static void test_put_req_random(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_put_req_random(void)
+static void test_stream_put_req(void)
 {
-	test_put_req_random(SOCK_STREAM);
+	test_put_req_seq(SOCK_STREAM);
 }
 
-static void test_packet_put_req_random(void)
+static void test_packet_put_req(void)
 {
-	test_put_req_random(SOCK_SEQPACKET);
+	test_put_req_seq(SOCK_SEQPACKET);
 }
 
-static void test_put_req_random_srm_wait(int sock_type)
+static void test_put_req_seq_srm_wait(int sock_type)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -1053,7 +1053,7 @@ static void test_put_req_random_srm_wait(int sock_type)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_put_req(obex, provide_random, transfer_complete, &d, &d.err,
+	g_obex_put_req(obex, provide_seq, transfer_complete, &d, &d.err,
 					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 					G_OBEX_HDR_NAME, "random.bin",
 					G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
@@ -1074,17 +1074,17 @@ static void test_put_req_random_srm_wait(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_put_req_random_srm_wait(void)
+static void test_stream_put_req_srm_wait(void)
 {
-	test_put_req_random_srm_wait(SOCK_STREAM);
+	test_put_req_seq_srm_wait(SOCK_STREAM);
 }
 
-static void test_packet_put_req_random_srm_wait(void)
+static void test_packet_put_req_srm_wait(void)
 {
-	test_put_req_random_srm_wait(SOCK_SEQPACKET);
+	test_put_req_seq_srm_wait(SOCK_SEQPACKET);
 }
 
-static void test_put_req_random_srm(int sock_type)
+static void test_put_req_seq_srm(int sock_type)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -1110,7 +1110,7 @@ static void test_put_req_random_srm(int sock_type)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_put_req(obex, provide_random, transfer_complete, &d, &d.err,
+	g_obex_put_req(obex, provide_seq, transfer_complete, &d, &d.err,
 					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 					G_OBEX_HDR_NAME, "random.bin",
 					G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
@@ -1131,14 +1131,14 @@ static void test_put_req_random_srm(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_put_req_random_srm(void)
+static void test_stream_put_req_srm(void)
 {
-	test_put_req_random_srm(SOCK_STREAM);
+	test_put_req_seq_srm(SOCK_STREAM);
 }
 
-static void test_packet_put_req_random_srm(void)
+static void test_packet_put_req_srm(void)
 {
-	test_put_req_random_srm(SOCK_SEQPACKET);
+	test_put_req_seq_srm(SOCK_SEQPACKET);
 }
 
 static void test_put_req_eagain(void)
@@ -1225,7 +1225,7 @@ static void test_get_rsp(void)
 	g_assert_no_error(d.err);
 }
 
-static void handle_get_random(GObex *obex, GObexPacket *req,
+static void handle_get_seq(GObex *obex, GObexPacket *req,
 							gpointer user_data)
 {
 	struct test_data *d = user_data;
@@ -1239,13 +1239,13 @@ static void handle_get_random(GObex *obex, GObexPacket *req,
 		return;
 	}
 
-	id = g_obex_get_rsp(obex, provide_random, transfer_complete, d,
+	id = g_obex_get_rsp(obex, provide_seq, transfer_complete, d,
 						&d->err, G_OBEX_HDR_INVALID);
 	if (id == 0)
 		g_main_loop_quit(d->mainloop);
 }
 
-static void test_get_rsp_random(int sock_type)
+static void test_get_rsp_seq(int sock_type)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -1269,7 +1269,7 @@ static void test_get_rsp_random(int sock_type)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get_random,
+	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get_seq,
 									&d);
 
 	g_io_channel_write_chars(io, (char *) get_req_first,
@@ -1290,17 +1290,17 @@ static void test_get_rsp_random(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_get_rsp_random(void)
+static void test_stream_get_rsp(void)
 {
-	test_get_rsp_random(SOCK_STREAM);
+	test_get_rsp_seq(SOCK_STREAM);
 }
 
-static void test_packet_get_rsp_random(void)
+static void test_packet_get_rsp(void)
 {
-	test_get_rsp_random(SOCK_SEQPACKET);
+	test_get_rsp_seq(SOCK_SEQPACKET);
 }
 
-static void handle_get_random_srm(GObex *obex, GObexPacket *req,
+static void handle_get_seq_srm(GObex *obex, GObexPacket *req,
 							gpointer user_data)
 {
 	struct test_data *d = user_data;
@@ -1314,7 +1314,7 @@ static void handle_get_random_srm(GObex *obex, GObexPacket *req,
 		return;
 	}
 
-	id = g_obex_get_rsp(obex, provide_random, transfer_complete, d,
+	id = g_obex_get_rsp(obex, provide_seq, transfer_complete, d,
 					&d->err,
 					G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
 					G_OBEX_HDR_INVALID);
@@ -1322,7 +1322,7 @@ static void handle_get_random_srm(GObex *obex, GObexPacket *req,
 		g_main_loop_quit(d->mainloop);
 }
 
-static void test_get_rsp_random_srm(int sock_type)
+static void test_get_rsp_seq_srm(int sock_type)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -1346,7 +1346,7 @@ static void test_get_rsp_random_srm(int sock_type)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get_random_srm,
+	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get_seq_srm,
 									&d);
 
 	g_io_channel_write_chars(io, (char *) get_req_first_srm,
@@ -1368,17 +1368,17 @@ static void test_get_rsp_random_srm(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_get_rsp_random_srm(void)
+static void test_stream_get_rsp_srm(void)
 {
-	test_get_rsp_random_srm(SOCK_STREAM);
+	test_get_rsp_seq_srm(SOCK_STREAM);
 }
 
-static void test_packet_get_rsp_random_srm(void)
+static void test_packet_get_rsp_srm(void)
 {
-	test_get_rsp_random_srm(SOCK_SEQPACKET);
+	test_get_rsp_seq_srm(SOCK_SEQPACKET);
 }
 
-static void handle_get_random_srm_wait(GObex *obex, GObexPacket *req,
+static void handle_get_seq_srm_wait(GObex *obex, GObexPacket *req,
 							gpointer user_data)
 {
 	struct test_data *d = user_data;
@@ -1392,7 +1392,7 @@ static void handle_get_random_srm_wait(GObex *obex, GObexPacket *req,
 		return;
 	}
 
-	id = g_obex_get_rsp(obex, provide_random, transfer_complete, d,
+	id = g_obex_get_rsp(obex, provide_seq, transfer_complete, d,
 					&d->err,
 					G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
 					G_OBEX_HDR_SRMP, G_OBEX_SRMP_WAIT,
@@ -1401,7 +1401,7 @@ static void handle_get_random_srm_wait(GObex *obex, GObexPacket *req,
 		g_main_loop_quit(d->mainloop);
 }
 
-static void test_get_rsp_random_srm_wait(int sock_type)
+static void test_get_rsp_seq_srm_wait(int sock_type)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -1426,7 +1426,7 @@ static void test_get_rsp_random_srm_wait(int sock_type)
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_add_request_function(obex, G_OBEX_OP_GET,
-					handle_get_random_srm_wait, &d);
+					handle_get_seq_srm_wait, &d);
 
 	g_io_channel_write_chars(io, (char *) get_req_first_srm,
 					sizeof(get_req_first_srm), NULL,
@@ -1447,14 +1447,14 @@ static void test_get_rsp_random_srm_wait(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_get_rsp_random_srm_wait(void)
+static void test_stream_get_rsp_srm_wait(void)
 {
-	test_get_rsp_random_srm_wait(SOCK_STREAM);
+	test_get_rsp_seq_srm_wait(SOCK_STREAM);
 }
 
-static void test_packet_get_rsp_random_srm_wait(void)
+static void test_packet_get_rsp_srm_wait(void)
 {
-	test_get_rsp_random_srm_wait(SOCK_SEQPACKET);
+	test_get_rsp_seq_srm_wait(SOCK_SEQPACKET);
 }
 
 static void handle_get_app(GObex *obex, GObexPacket *req, gpointer user_data)
@@ -2145,7 +2145,7 @@ static void test_conn_get_wrg_rsp(void)
 	g_assert_no_error(d.err);
 }
 
-static void conn_complete_put_req_random(GObex *obex, GError *err,
+static void conn_complete_put_req_seq(GObex *obex, GError *err,
 					GObexPacket *rsp, gpointer user_data)
 {
 	struct test_data *d = user_data;
@@ -2155,13 +2155,13 @@ static void conn_complete_put_req_random(GObex *obex, GError *err,
 		g_main_loop_quit(d->mainloop);
 	}
 
-	g_obex_put_req(obex, provide_random, transfer_complete, d, &d->err,
+	g_obex_put_req(obex, provide_seq, transfer_complete, d, &d->err,
 					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 					G_OBEX_HDR_NAME, "random.bin",
 					G_OBEX_HDR_INVALID);
 }
 
-static void test_conn_put_req_random(void)
+static void test_conn_put_req_seq(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -2187,7 +2187,7 @@ static void test_conn_put_req_random(void)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_connect(obex, conn_complete_put_req_random, &d, &d.err,
+	g_obex_connect(obex, conn_complete_put_req_seq, &d, &d.err,
 							G_OBEX_HDR_INVALID);
 	g_assert_no_error(d.err);
 
@@ -2205,7 +2205,7 @@ static void test_conn_put_req_random(void)
 	g_assert_no_error(d.err);
 }
 
-static void conn_complete_put_req_random_srm(GObex *obex, GError *err,
+static void conn_complete_put_req_seq_srm(GObex *obex, GError *err,
 					GObexPacket *rsp, gpointer user_data)
 {
 	struct test_data *d = user_data;
@@ -2215,14 +2215,14 @@ static void conn_complete_put_req_random_srm(GObex *obex, GError *err,
 		g_main_loop_quit(d->mainloop);
 	}
 
-	g_obex_put_req(obex, provide_random, transfer_complete, d, &d->err,
+	g_obex_put_req(obex, provide_seq, transfer_complete, d, &d->err,
 					G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
 					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 					G_OBEX_HDR_NAME, "random.bin",
 					G_OBEX_HDR_INVALID);
 }
 
-static void test_conn_put_req_random_srm(void)
+static void test_conn_put_req_seq_srm(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -2248,7 +2248,7 @@ static void test_conn_put_req_random_srm(void)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_connect(obex, conn_complete_put_req_random_srm, &d, &d.err,
+	g_obex_connect(obex, conn_complete_put_req_seq_srm, &d, &d.err,
 					G_OBEX_HDR_SRM, G_OBEX_SRM_INDICATE,
 					G_OBEX_HDR_INVALID);
 	g_assert_no_error(d.err);
@@ -2292,25 +2292,17 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_put_req_eagain", test_put_req_eagain);
 	g_test_add_func("/gobex/test_get_req_eagain", test_get_rsp_eagain);
 
-	g_test_add_func("/gobex/test_stream_put_req_random",
-						test_stream_put_req_random);
-	g_test_add_func("/gobex/test_packet_put_req_random",
-						test_packet_put_req_random);
+	g_test_add_func("/gobex/test_stream_put_req", test_stream_put_req);
+	g_test_add_func("/gobex/test_packet_put_req", test_packet_put_req);
 
-	g_test_add_func("/gobex/test_stream_put_rsp_random",
-						test_stream_put_rsp_random);
-	g_test_add_func("/gobex/test_packet_put_rsp_random",
-						test_packet_put_rsp_random);
+	g_test_add_func("/gobex/test_stream_put_rsp", test_stream_put_rsp);
+	g_test_add_func("/gobex/test_packet_put_rsp", test_packet_put_rsp);
 
-	g_test_add_func("/gobex/test_stream_get_req_random",
-						test_stream_get_req_random);
-	g_test_add_func("/gobex/test_packet_get_req_random",
-						test_packet_get_req_random);
+	g_test_add_func("/gobex/test_stream_get_req", test_stream_get_req);
+	g_test_add_func("/gobex/test_packet_get_req", test_packet_get_req);
 
-	g_test_add_func("/gobex/test_stream_get_rsp_random",
-						test_stream_get_rsp_random);
-	g_test_add_func("/gobex/test_packet_get_rsp_random",
-						test_packet_get_rsp_random);
+	g_test_add_func("/gobex/test_stream_get_rsp", test_stream_get_rsp);
+	g_test_add_func("/gobex/test_packet_get_rsp", test_packet_get_rsp);
 
 	g_test_add_func("/gobex/test_conn_get_req", test_conn_get_req);
 	g_test_add_func("/gobex/test_conn_get_rsp", test_conn_get_rsp);
@@ -2320,56 +2312,56 @@ int main(int argc, char *argv[])
 
 	g_test_add_func("/gobex/test_conn_get_wrg_rsp", test_conn_get_wrg_rsp);
 
-	g_test_add_func("/gobex/test_conn_put_req_random",
-						test_conn_put_req_random);
-
-	g_test_add_func("/gobex/test_stream_put_req_random_srm",
-					test_stream_put_req_random_srm);
-	g_test_add_func("/gobex/test_packet_put_req_random_srm",
-					test_packet_put_req_random_srm);
-
-	g_test_add_func("/gobex/test_stream_put_req_random_srm_wait",
-					test_stream_put_req_random_srm_wait);
-	g_test_add_func("/gobex/test_packet_put_req_random_srm_wait",
-					test_packet_put_req_random_srm_wait);
-
-	g_test_add_func("/gobex/test_stream_put_rsp_random_srm",
-					test_stream_put_rsp_random_srm);
-	g_test_add_func("/gobex/test_packet_put_rsp_random_srm",
-					test_packet_put_rsp_random_srm);
-
-	g_test_add_func("/gobex/test_stream_put_rsp_random_srm_wait",
-					test_stream_put_rsp_random_srm_wait);
-	g_test_add_func("/gobex/test_packet_put_rsp_random_srm_wait",
-					test_packet_put_rsp_random_srm_wait);
-
-	g_test_add_func("/gobex/test_stream_get_rsp_random_srm",
-					test_stream_get_rsp_random_srm);
-	g_test_add_func("/gobex/test_packet_get_rsp_random_srm",
-					test_packet_get_rsp_random_srm);
-
-	g_test_add_func("/gobex/test_stream_get_rsp_random_srm_wait",
-					test_stream_get_rsp_random_srm_wait);
-	g_test_add_func("/gobex/test_packet_get_rsp_random_srm_wait",
-					test_packet_get_rsp_random_srm_wait);
-
-	g_test_add_func("/gobex/test_stream_get_req_random_srm",
-					test_stream_get_req_random_srm);
-	g_test_add_func("/gobex/test_packet_get_req_random_srm",
-					test_packet_get_req_random_srm);
-
-	g_test_add_func("/gobex/test_stream_get_req_random_srm_wait",
-					test_stream_get_req_random_srm_wait);
-	g_test_add_func("/gobex/test_packet_get_req_random_srm_wait",
-					test_packet_get_req_random_srm_wait);
-
-	g_test_add_func("/gobex/test_stream_get_req_random_srm_wait_next",
-				test_stream_get_req_random_srm_wait_next);
-	g_test_add_func("/gobex/test_packet_get_req_random_srm_wait_next",
-				test_packet_get_req_random_srm_wait_next);
-
-	g_test_add_func("/gobex/test_conn_put_req_random_srm",
-						test_conn_put_req_random_srm);
+	g_test_add_func("/gobex/test_conn_put_req_seq",
+						test_conn_put_req_seq);
+
+	g_test_add_func("/gobex/test_stream_put_req_srm",
+						test_stream_put_req_srm);
+	g_test_add_func("/gobex/test_packet_put_req_srm",
+						test_packet_put_req_srm);
+
+	g_test_add_func("/gobex/test_stream_put_req_srm_wait",
+						test_stream_put_req_srm_wait);
+	g_test_add_func("/gobex/test_packet_put_req_srm_wait",
+						test_packet_put_req_srm_wait);
+
+	g_test_add_func("/gobex/test_stream_put_rsp_srm",
+						test_stream_put_rsp_srm);
+	g_test_add_func("/gobex/test_packet_put_rsp_srm",
+						test_packet_put_rsp_srm);
+
+	g_test_add_func("/gobex/test_stream_put_rsp_srm_wait",
+						test_stream_put_rsp_srm_wait);
+	g_test_add_func("/gobex/test_packet_put_rsp_srm_wait",
+						test_packet_put_rsp_srm_wait);
+
+	g_test_add_func("/gobex/test_stream_get_rsp_srm",
+						test_stream_get_rsp_srm);
+	g_test_add_func("/gobex/test_packet_get_rsp_srm",
+						test_packet_get_rsp_srm);
+
+	g_test_add_func("/gobex/test_stream_get_rsp_srm_wait",
+						test_stream_get_rsp_srm_wait);
+	g_test_add_func("/gobex/test_packet_get_rsp_srm_wait",
+						test_packet_get_rsp_srm_wait);
+
+	g_test_add_func("/gobex/test_stream_get_req_srm",
+						test_stream_get_req_srm);
+	g_test_add_func("/gobex/test_packet_get_req_srm",
+						test_packet_get_req_srm);
+
+	g_test_add_func("/gobex/test_stream_get_req_srm_wait",
+						test_stream_get_req_srm_wait);
+	g_test_add_func("/gobex/test_packet_get_req_srm_wait",
+						test_packet_get_req_srm_wait);
+
+	g_test_add_func("/gobex/test_stream_get_req_srm_wait_next",
+					test_stream_get_req_srm_wait_next);
+	g_test_add_func("/gobex/test_packet_get_req_srm_wait_next",
+					test_packet_get_req_srm_wait_next);
+
+	g_test_add_func("/gobex/test_conn_put_req_seq_srm",
+						test_conn_put_req_seq_srm);
 
 	g_test_run();
 
-- 
1.7.7.4

