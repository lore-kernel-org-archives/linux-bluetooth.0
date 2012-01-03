Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 4/4] gobex: fix unit test when using SOCK_SEQPACKET
Date: Tue,  3 Jan 2012 15:52:24 +0200
Message-Id: <1325598744-18855-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1325598744-18855-1-git-send-email-luiz.dentz@gmail.com>
References: <1325598744-18855-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Now that SRM is automatically configured when the transport type is
SOCK_SEQPACKET all tests that uses this transport are already testing
SRM so there is no need to keep adding the headers manually.

In addition to that remove the tests for SRM using SOCK_STREAM since
those are currently not supported without including the headers.
---
 unit/test-gobex-transfer.c |  313 +++++++-------------------------------------
 1 files changed, 48 insertions(+), 265 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index eb6a55e..d4cf181 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -85,18 +85,18 @@ static guint8 get_req_first_app[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x2a,
 	0, 1, 2, 3  };
 
 static guint8 get_req_first_srm[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x25,
+	G_OBEX_HDR_SRM, 0x01,
 	G_OBEX_HDR_TYPE, 0x00, 0x0b,
 	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
 	G_OBEX_HDR_NAME, 0x00, 0x15,
-	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0,
-	G_OBEX_HDR_SRM, 0x01 };
+	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0 };
 
 static guint8 get_req_first_srm_wait[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x27,
+	G_OBEX_HDR_SRM, 0x01,
 	G_OBEX_HDR_TYPE, 0x00, 0x0b,
 	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
 	G_OBEX_HDR_NAME, 0x00, 0x15,
 	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0,
-	G_OBEX_HDR_SRM, 0x01,
 	G_OBEX_HDR_SRMP, 0x01 };
 
 static guint8 get_req_last[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x03, };
@@ -407,7 +407,7 @@ static void handle_put_seq(GObex *obex, GObexPacket *req,
 		g_main_loop_quit(d->mainloop);
 }
 
-static void test_put_rsp_seq(int sock_type)
+static void test_stream_put_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -453,16 +453,6 @@ static void test_put_rsp_seq(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_put_rsp(void)
-{
-	test_put_rsp_seq(SOCK_STREAM);
-}
-
-static void test_packet_put_rsp(void)
-{
-	test_put_rsp_seq(SOCK_SEQPACKET);
-}
-
 static void handle_put_seq_wait(GObex *obex, GObexPacket *req,
 							gpointer user_data)
 {
@@ -479,14 +469,13 @@ static void handle_put_seq_wait(GObex *obex, GObexPacket *req,
 
 	id = g_obex_put_rsp(obex, req, rcv_seq, transfer_complete, d,
 					&d->err,
-					G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
 					G_OBEX_HDR_SRMP, G_OBEX_SRMP_WAIT,
 					G_OBEX_HDR_INVALID);
 	if (id == 0)
 		g_main_loop_quit(d->mainloop);
 }
 
-static void test_put_rsp_seq_srm_wait(int sock_type)
+static void test_packet_put_rsp_wait(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -502,7 +491,7 @@ static void test_put_rsp_seq_srm_wait(int sock_type)
 		{ put_req_last, sizeof(put_req_last) },
 		{ NULL, 0 } } };
 
-	create_endpoints(&obex, &io, sock_type);
+	create_endpoints(&obex, &io, SOCK_SEQPACKET);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
@@ -533,39 +522,7 @@ static void test_put_rsp_seq_srm_wait(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_put_rsp_srm_wait(void)
-{
-	test_put_rsp_seq_srm_wait(SOCK_STREAM);
-}
-
-static void test_packet_put_rsp_srm_wait(void)
-{
-	test_put_rsp_seq_srm_wait(SOCK_SEQPACKET);
-}
-
-static void handle_put_seq_srm(GObex *obex, GObexPacket *req,
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
-	id = g_obex_put_rsp(obex, req, rcv_seq, transfer_complete, d,
-					&d->err,
-					G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
-					G_OBEX_HDR_INVALID);
-	if (id == 0)
-		g_main_loop_quit(d->mainloop);
-}
-
-static void test_put_rsp_seq_srm(int sock_type)
+static void test_packet_put_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -581,7 +538,7 @@ static void test_put_rsp_seq_srm(int sock_type)
 			{ put_req_last, sizeof(put_req_last) },
 			{ NULL, 0 } } };
 
-	create_endpoints(&obex, &io, sock_type);
+	create_endpoints(&obex, &io, SOCK_SEQPACKET);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
@@ -590,8 +547,7 @@ static void test_put_rsp_seq_srm(int sock_type)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put_seq_srm,
-									&d);
+	g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put_seq, &d);
 
 	g_io_channel_write_chars(io, (char *) put_req_first_srm,
 					sizeof(put_req_first_srm), NULL,
@@ -612,16 +568,6 @@ static void test_put_rsp_seq_srm(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_put_rsp_srm(void)
-{
-	test_put_rsp_seq_srm(SOCK_STREAM);
-}
-
-static void test_packet_put_rsp_srm(void)
-{
-	test_put_rsp_seq_srm(SOCK_SEQPACKET);
-}
-
 static void test_get_req(void)
 {
 	GIOChannel *io;
@@ -663,7 +609,7 @@ static void test_get_req(void)
 	g_assert_no_error(d.err);
 }
 
-static void test_get_req_seq(int sock_type)
+static void test_stream_get_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -679,7 +625,7 @@ static void test_get_req_seq(int sock_type)
 				{ get_rsp_zero, sizeof(get_rsp_zero) },
 				{ get_rsp_last, sizeof(get_rsp_last) } } };
 
-	create_endpoints(&obex, &io, sock_type);
+	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
@@ -708,18 +654,8 @@ static void test_get_req_seq(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_get_req(void)
-{
-	test_get_req_seq(SOCK_STREAM);
-}
-
 static void test_packet_get_req(void)
 {
-	test_get_req_seq(SOCK_SEQPACKET);
-}
-
-static void test_get_req_seq_srm(int sock_type)
-{
 	GIOChannel *io;
 	GIOCondition cond;
 	guint io_id, timer_id;
@@ -734,7 +670,7 @@ static void test_get_req_seq_srm(int sock_type)
 			{ get_rsp_zero, sizeof(get_rsp_zero) },
 			{ get_rsp_last, sizeof(get_rsp_last) } } };
 
-	create_endpoints(&obex, &io, sock_type);
+	create_endpoints(&obex, &io, SOCK_SEQPACKET);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
@@ -746,7 +682,6 @@ static void test_get_req_seq_srm(int sock_type)
 	g_obex_get_req(obex, rcv_seq, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 				G_OBEX_HDR_NAME, "file.txt",
-				G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
 				G_OBEX_HDR_INVALID);
 	g_assert_no_error(d.err);
 
@@ -764,17 +699,7 @@ static void test_get_req_seq_srm(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_get_req_srm(void)
-{
-	test_get_req_seq_srm(SOCK_STREAM);
-}
-
-static void test_packet_get_req_srm(void)
-{
-	test_get_req_seq_srm(SOCK_SEQPACKET);
-}
-
-static void test_get_req_seq_srm_wait(int sock_type)
+static void test_packet_get_req_wait(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -790,7 +715,7 @@ static void test_get_req_seq_srm_wait(int sock_type)
 		{ get_rsp_zero, sizeof(get_rsp_zero) },
 		{ get_rsp_last, sizeof(get_rsp_last) } } };
 
-	create_endpoints(&obex, &io, sock_type);
+	create_endpoints(&obex, &io, SOCK_SEQPACKET);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
@@ -802,7 +727,6 @@ static void test_get_req_seq_srm_wait(int sock_type)
 	g_obex_get_req(obex, rcv_seq, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 				G_OBEX_HDR_NAME, "file.txt",
-				G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
 				G_OBEX_HDR_SRMP, G_OBEX_SRMP_WAIT,
 				G_OBEX_HDR_INVALID);
 	g_assert_no_error(d.err);
@@ -821,17 +745,7 @@ static void test_get_req_seq_srm_wait(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_get_req_srm_wait(void)
-{
-	test_get_req_seq_srm_wait(SOCK_STREAM);
-}
-
-static void test_packet_get_req_srm_wait(void)
-{
-	test_get_req_seq_srm_wait(SOCK_SEQPACKET);
-}
-
-static void test_get_req_seq_srm_wait_next(int sock_type)
+static void test_packet_get_req_wait_next(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -848,7 +762,7 @@ static void test_get_req_seq_srm_wait_next(int sock_type)
 		{ get_rsp_zero_wait_next, sizeof(get_rsp_zero_wait_next) },
 		{ get_rsp_last, sizeof(get_rsp_last) } } };
 
-	create_endpoints(&obex, &io, sock_type);
+	create_endpoints(&obex, &io, SOCK_SEQPACKET);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
@@ -860,7 +774,6 @@ static void test_get_req_seq_srm_wait_next(int sock_type)
 	g_obex_get_req(obex, rcv_seq, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 				G_OBEX_HDR_NAME, "file.txt",
-				G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
 				G_OBEX_HDR_INVALID);
 	g_assert_no_error(d.err);
 
@@ -878,16 +791,6 @@ static void test_get_req_seq_srm_wait_next(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_get_req_srm_wait_next(void)
-{
-	test_get_req_seq_srm_wait_next(SOCK_STREAM);
-}
-
-static void test_packet_get_req_srm_wait_next(void)
-{
-	test_get_req_seq_srm_wait_next(SOCK_SEQPACKET);
-}
-
 static void test_get_req_app(void)
 {
 	GIOChannel *io;
@@ -971,7 +874,7 @@ static void handle_get(GObex *obex, GObexPacket *req, gpointer user_data)
 		g_main_loop_quit(d->mainloop);
 }
 
-static void test_put_req_seq(int sock_type)
+static void test_stream_put_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -987,7 +890,7 @@ static void test_put_req_seq(int sock_type)
 				{ put_rsp_first, sizeof(put_rsp_first) },
 				{ put_rsp_last, sizeof(put_rsp_last) } } };
 
-	create_endpoints(&obex, &io, sock_type);
+	create_endpoints(&obex, &io, SOCK_STREAM);
 	d.obex = obex;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
@@ -1017,17 +920,7 @@ static void test_put_req_seq(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_put_req(void)
-{
-	test_put_req_seq(SOCK_STREAM);
-}
-
-static void test_packet_put_req(void)
-{
-	test_put_req_seq(SOCK_SEQPACKET);
-}
-
-static void test_put_req_seq_srm_wait(int sock_type)
+static void test_packet_put_req_wait(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -1043,7 +936,7 @@ static void test_put_req_seq_srm_wait(int sock_type)
 		{ NULL, 0 },
 		{ put_rsp_last, sizeof(put_rsp_last) } } };
 
-	create_endpoints(&obex, &io, sock_type);
+	create_endpoints(&obex, &io, SOCK_SEQPACKET);
 	d.obex = obex;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
@@ -1056,7 +949,6 @@ static void test_put_req_seq_srm_wait(int sock_type)
 	g_obex_put_req(obex, provide_seq, transfer_complete, &d, &d.err,
 					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 					G_OBEX_HDR_NAME, "random.bin",
-					G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
 					G_OBEX_HDR_INVALID);
 	g_assert_no_error(d.err);
 
@@ -1074,17 +966,7 @@ static void test_put_req_seq_srm_wait(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_put_req_srm_wait(void)
-{
-	test_put_req_seq_srm_wait(SOCK_STREAM);
-}
-
-static void test_packet_put_req_srm_wait(void)
-{
-	test_put_req_seq_srm_wait(SOCK_SEQPACKET);
-}
-
-static void test_put_req_seq_srm(int sock_type)
+static void test_packet_put_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -1100,7 +982,7 @@ static void test_put_req_seq_srm(int sock_type)
 			{ NULL, 0 },
 			{ put_rsp_last, sizeof(put_rsp_last) } } };
 
-	create_endpoints(&obex, &io, sock_type);
+	create_endpoints(&obex, &io, SOCK_SEQPACKET);
 	d.obex = obex;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
@@ -1113,7 +995,6 @@ static void test_put_req_seq_srm(int sock_type)
 	g_obex_put_req(obex, provide_seq, transfer_complete, &d, &d.err,
 					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 					G_OBEX_HDR_NAME, "random.bin",
-					G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
 					G_OBEX_HDR_INVALID);
 	g_assert_no_error(d.err);
 
@@ -1131,16 +1012,6 @@ static void test_put_req_seq_srm(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_put_req_srm(void)
-{
-	test_put_req_seq_srm(SOCK_STREAM);
-}
-
-static void test_packet_put_req_srm(void)
-{
-	test_put_req_seq_srm(SOCK_SEQPACKET);
-}
-
 static void test_put_req_eagain(void)
 {
 	GIOChannel *io;
@@ -1245,7 +1116,7 @@ static void handle_get_seq(GObex *obex, GObexPacket *req,
 		g_main_loop_quit(d->mainloop);
 }
 
-static void test_get_rsp_seq(int sock_type)
+static void test_stream_get_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -1260,7 +1131,7 @@ static void test_get_rsp_seq(int sock_type)
 				{ get_req_last, sizeof(get_req_last) },
 				{ get_req_last, sizeof(get_req_last) } } };
 
-	create_endpoints(&obex, &io, sock_type);
+	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
@@ -1269,8 +1140,7 @@ static void test_get_rsp_seq(int sock_type)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get_seq,
-									&d);
+	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get_seq, &d);
 
 	g_io_channel_write_chars(io, (char *) get_req_first,
 					sizeof(get_req_first), NULL, &d.err);
@@ -1290,40 +1160,8 @@ static void test_get_rsp_seq(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_get_rsp(void)
-{
-	test_get_rsp_seq(SOCK_STREAM);
-}
-
 static void test_packet_get_rsp(void)
 {
-	test_get_rsp_seq(SOCK_SEQPACKET);
-}
-
-static void handle_get_seq_srm(GObex *obex, GObexPacket *req,
-							gpointer user_data)
-{
-	struct test_data *d = user_data;
-	guint8 op = g_obex_packet_get_operation(req, NULL);
-	guint id;
-
-	if (op != G_OBEX_OP_GET) {
-		d->err = g_error_new(TEST_ERROR, TEST_ERROR_UNEXPECTED,
-					"Unexpected opcode 0x%02x", op);
-		g_main_loop_quit(d->mainloop);
-		return;
-	}
-
-	id = g_obex_get_rsp(obex, provide_seq, transfer_complete, d,
-					&d->err,
-					G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
-					G_OBEX_HDR_INVALID);
-	if (id == 0)
-		g_main_loop_quit(d->mainloop);
-}
-
-static void test_get_rsp_seq_srm(int sock_type)
-{
 	GIOChannel *io;
 	GIOCondition cond;
 	guint io_id, timer_id;
@@ -1337,7 +1175,7 @@ static void test_get_rsp_seq_srm(int sock_type)
 				{ NULL, 0 },
 				{ get_req_last, sizeof(get_req_last) } } };
 
-	create_endpoints(&obex, &io, sock_type);
+	create_endpoints(&obex, &io, SOCK_SEQPACKET);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
@@ -1346,8 +1184,7 @@ static void test_get_rsp_seq_srm(int sock_type)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get_seq_srm,
-									&d);
+	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get_seq, &d);
 
 	g_io_channel_write_chars(io, (char *) get_req_first_srm,
 					sizeof(get_req_first_srm), NULL,
@@ -1368,16 +1205,6 @@ static void test_get_rsp_seq_srm(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_get_rsp_srm(void)
-{
-	test_get_rsp_seq_srm(SOCK_STREAM);
-}
-
-static void test_packet_get_rsp_srm(void)
-{
-	test_get_rsp_seq_srm(SOCK_SEQPACKET);
-}
-
 static void handle_get_seq_srm_wait(GObex *obex, GObexPacket *req,
 							gpointer user_data)
 {
@@ -1394,14 +1221,13 @@ static void handle_get_seq_srm_wait(GObex *obex, GObexPacket *req,
 
 	id = g_obex_get_rsp(obex, provide_seq, transfer_complete, d,
 					&d->err,
-					G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
 					G_OBEX_HDR_SRMP, G_OBEX_SRMP_WAIT,
 					G_OBEX_HDR_INVALID);
 	if (id == 0)
 		g_main_loop_quit(d->mainloop);
 }
 
-static void test_get_rsp_seq_srm_wait(int sock_type)
+static void test_packet_get_rsp_wait(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
@@ -1416,7 +1242,7 @@ static void test_get_rsp_seq_srm_wait(int sock_type)
 				{ NULL, 0 },
 				{ get_req_last, sizeof(get_req_last) } } };
 
-	create_endpoints(&obex, &io, sock_type);
+	create_endpoints(&obex, &io, SOCK_SEQPACKET);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
@@ -1447,16 +1273,6 @@ static void test_get_rsp_seq_srm_wait(int sock_type)
 	g_assert_no_error(d.err);
 }
 
-static void test_stream_get_rsp_srm_wait(void)
-{
-	test_get_rsp_seq_srm_wait(SOCK_STREAM);
-}
-
-static void test_packet_get_rsp_srm_wait(void)
-{
-	test_get_rsp_seq_srm_wait(SOCK_SEQPACKET);
-}
-
 static void handle_get_app(GObex *obex, GObexPacket *req, gpointer user_data)
 {
 	struct test_data *d = user_data;
@@ -2216,7 +2032,6 @@ static void conn_complete_put_req_seq_srm(GObex *obex, GError *err,
 	}
 
 	g_obex_put_req(obex, provide_seq, transfer_complete, d, &d->err,
-					G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE,
 					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 					G_OBEX_HDR_NAME, "random.bin",
 					G_OBEX_HDR_INVALID);
@@ -2238,7 +2053,7 @@ static void test_conn_put_req_seq_srm(void)
 				{ NULL, 0 },
 				{ put_rsp_last, sizeof(put_rsp_last) } } };
 
-	create_endpoints(&obex, &io, SOCK_STREAM);
+	create_endpoints(&obex, &io, SOCK_SEQPACKET);
 	d.obex = obex;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
@@ -2293,16 +2108,10 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_get_req_eagain", test_get_rsp_eagain);
 
 	g_test_add_func("/gobex/test_stream_put_req", test_stream_put_req);
-	g_test_add_func("/gobex/test_packet_put_req", test_packet_put_req);
-
 	g_test_add_func("/gobex/test_stream_put_rsp", test_stream_put_rsp);
-	g_test_add_func("/gobex/test_packet_put_rsp", test_packet_put_rsp);
 
 	g_test_add_func("/gobex/test_stream_get_req", test_stream_get_req);
-	g_test_add_func("/gobex/test_packet_get_req", test_packet_get_req);
-
 	g_test_add_func("/gobex/test_stream_get_rsp", test_stream_get_rsp);
-	g_test_add_func("/gobex/test_packet_get_rsp", test_packet_get_rsp);
 
 	g_test_add_func("/gobex/test_conn_get_req", test_conn_get_req);
 	g_test_add_func("/gobex/test_conn_get_rsp", test_conn_get_rsp);
@@ -2315,50 +2124,24 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_conn_put_req_seq",
 						test_conn_put_req_seq);
 
-	g_test_add_func("/gobex/test_stream_put_req_srm",
-						test_stream_put_req_srm);
-	g_test_add_func("/gobex/test_packet_put_req_srm",
-						test_packet_put_req_srm);
-
-	g_test_add_func("/gobex/test_stream_put_req_srm_wait",
-						test_stream_put_req_srm_wait);
-	g_test_add_func("/gobex/test_packet_put_req_srm_wait",
-						test_packet_put_req_srm_wait);
-
-	g_test_add_func("/gobex/test_stream_put_rsp_srm",
-						test_stream_put_rsp_srm);
-	g_test_add_func("/gobex/test_packet_put_rsp_srm",
-						test_packet_put_rsp_srm);
-
-	g_test_add_func("/gobex/test_stream_put_rsp_srm_wait",
-						test_stream_put_rsp_srm_wait);
-	g_test_add_func("/gobex/test_packet_put_rsp_srm_wait",
-						test_packet_put_rsp_srm_wait);
-
-	g_test_add_func("/gobex/test_stream_get_rsp_srm",
-						test_stream_get_rsp_srm);
-	g_test_add_func("/gobex/test_packet_get_rsp_srm",
-						test_packet_get_rsp_srm);
-
-	g_test_add_func("/gobex/test_stream_get_rsp_srm_wait",
-						test_stream_get_rsp_srm_wait);
-	g_test_add_func("/gobex/test_packet_get_rsp_srm_wait",
-						test_packet_get_rsp_srm_wait);
-
-	g_test_add_func("/gobex/test_stream_get_req_srm",
-						test_stream_get_req_srm);
-	g_test_add_func("/gobex/test_packet_get_req_srm",
-						test_packet_get_req_srm);
-
-	g_test_add_func("/gobex/test_stream_get_req_srm_wait",
-						test_stream_get_req_srm_wait);
-	g_test_add_func("/gobex/test_packet_get_req_srm_wait",
-						test_packet_get_req_srm_wait);
-
-	g_test_add_func("/gobex/test_stream_get_req_srm_wait_next",
-					test_stream_get_req_srm_wait_next);
-	g_test_add_func("/gobex/test_packet_get_req_srm_wait_next",
-					test_packet_get_req_srm_wait_next);
+	g_test_add_func("/gobex/test_packet_put_req", test_packet_put_req);
+	g_test_add_func("/gobex/test_packet_put_req_wait",
+						test_packet_put_req_wait);
+
+	g_test_add_func("/gobex/test_packet_put_rsp", test_packet_put_rsp);
+	g_test_add_func("/gobex/test_packet_put_rsp_wait",
+						test_packet_put_rsp_wait);
+
+	g_test_add_func("/gobex/test_packet_get_rsp", test_packet_get_rsp);
+	g_test_add_func("/gobex/test_packet_get_rsp_wait",
+						test_packet_get_rsp_wait);
+
+	g_test_add_func("/gobex/test_packet_get_req", test_packet_get_req);
+	g_test_add_func("/gobex/test_packet_get_req_wait",
+						test_packet_get_req_wait);
+
+	g_test_add_func("/gobex/test_packet_get_req_wait_next",
+						test_packet_get_req_wait_next);
 
 	g_test_add_func("/gobex/test_conn_put_req_seq_srm",
 						test_conn_put_req_seq_srm);
-- 
1.7.7.4

