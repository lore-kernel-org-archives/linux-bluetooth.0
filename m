Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [RFC obexd 3/4] gobex: add response function parameter to API
Date: Wed, 21 Dec 2011 02:41:02 +0100
Message-Id: <1324431663-3800-4-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1324431663-3800-1-git-send-email-adamek.kuba@gmail.com>
References: <1324431663-3800-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All *_req/*_req_pkt functions now have an additional parameter.
This parameter is the function to be used to handle response packets.
If this parameter is NULL, the default packet reponse function
is used.

Previously, the default response function passed itself as the
callback function to g_obex_send_req (to handle the next packet).
Now this is changed so that the response function supplied
at transfer creation is passed.
---
 client/transfer.c          |    6 +++---
 gobex/gobex-transfer.c     |   36 +++++++++++++++++++++++++++++-------
 gobex/gobex.h              |    8 ++++++--
 unit/test-gobex-transfer.c |   20 ++++++++++----------
 4 files changed, 48 insertions(+), 22 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index c481378..bdefaec 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -548,7 +548,7 @@ int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
 		transfer->xfer = g_obex_send_req(obex, req, -1, rsp_cb,
 							transfer, &err);
 	else
-		transfer->xfer = g_obex_get_req_pkt(obex, req, data_cb,
+		transfer->xfer = g_obex_get_req_pkt(obex, req, NULL, data_cb,
 							complete_cb, transfer,
 							&err);
 
@@ -600,8 +600,8 @@ done:
 						transfer->params->data,
 						transfer->params->size);
 
-	transfer->xfer = g_obex_put_req_pkt(obex, req, data_cb, xfer_complete,
-							transfer, &err);
+	transfer->xfer = g_obex_put_req_pkt(obex, req, NULL, data_cb,
+						xfer_complete, transfer, &err);
 	if (transfer->xfer == 0)
 		return -ENOTCONN;
 
diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index 2595128..51f0189 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -47,6 +47,7 @@ struct _GObexTransfer {
 
 	GObexDataProducer data_producer;
 	GObexDataConsumer data_consumer;
+	GObexResponseFunc response_func;
 	GObexFunc complete_func;
 
 	gpointer user_data;
@@ -214,7 +215,7 @@ void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 							G_OBEX_HDR_INVALID);
 	}
 
-	transfer->req_id = g_obex_send_req(obex, req, -1, transfer_response,
+	transfer->req_id = g_obex_send_req(obex, req, -1, transfer->response_func,
 							transfer, &err);
 failed:
 	if (err != NULL) {
@@ -246,6 +247,7 @@ static GObexTransfer *transfer_new(GObex *obex, guint8 opcode,
 }
 
 guint g_obex_put_req_pkt(GObex *obex, GObexPacket *req,
+			GObexResponseFunc response_func,
 			GObexDataProducer data_func, GObexFunc complete_func,
 			gpointer user_data, GError **err)
 {
@@ -256,13 +258,17 @@ guint g_obex_put_req_pkt(GObex *obex, GObexPacket *req,
 	if (g_obex_packet_get_operation(req, NULL) != G_OBEX_OP_PUT)
 		return 0;
 
+	if (response_func == NULL)
+		response_func = transfer_response;
+
 	transfer = transfer_new(obex, G_OBEX_OP_PUT, complete_func, user_data);
 	transfer->data_producer = data_func;
+	transfer->response_func = response_func;
 
 	g_obex_packet_add_body(req, put_get_data, transfer);
 
 	transfer->req_id = g_obex_send_req(obex, req, FIRST_PACKET_TIMEOUT,
-					transfer_response, transfer, err);
+					response_func, transfer, err);
 	if (transfer->req_id == 0) {
 		transfer_free(transfer);
 		return 0;
@@ -273,7 +279,8 @@ guint g_obex_put_req_pkt(GObex *obex, GObexPacket *req,
 	return transfer->id;
 }
 
-guint g_obex_put_req(GObex *obex, GObexDataProducer data_func,
+guint g_obex_put_req(GObex *obex, GObexResponseFunc response_func,
+			GObexDataProducer data_func,
 			GObexFunc complete_func, gpointer user_data,
 			GError **err, guint8 first_hdr_id, ...)
 {
@@ -283,8 +290,12 @@ guint g_obex_put_req(GObex *obex, GObexDataProducer data_func,
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p", obex);
 
+	if (response_func == NULL)
+		response_func = transfer_response;
+
 	transfer = transfer_new(obex, G_OBEX_OP_PUT, complete_func, user_data);
 	transfer->data_producer = data_func;
+	transfer->response_func = response_func;
 
 	va_start(args, first_hdr_id);
 	req = g_obex_packet_new_valist(G_OBEX_OP_PUT, FALSE,
@@ -294,7 +305,7 @@ guint g_obex_put_req(GObex *obex, GObexDataProducer data_func,
 	g_obex_packet_add_body(req, put_get_data, transfer);
 
 	transfer->req_id = g_obex_send_req(obex, req, FIRST_PACKET_TIMEOUT,
-					transfer_response, transfer, err);
+					response_func, transfer, err);
 	if (transfer->req_id == 0) {
 		transfer_free(transfer);
 		return 0;
@@ -429,6 +440,7 @@ guint g_obex_put_rsp(GObex *obex, GObexPacket *req,
 }
 
 guint g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
+			GObexResponseFunc response_func,
 			GObexDataConsumer data_func, GObexFunc complete_func,
 			gpointer user_data, GError **err)
 {
@@ -439,10 +451,15 @@ guint g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
 	if (g_obex_packet_get_operation(req, NULL) != G_OBEX_OP_GET)
 		return 0;
 
+	if (response_func == NULL)
+		response_func = transfer_response;
+
 	transfer = transfer_new(obex, G_OBEX_OP_GET, complete_func, user_data);
 	transfer->data_consumer = data_func;
+	transfer->response_func = response_func;
+
 	transfer->req_id = g_obex_send_req(obex, req, FIRST_PACKET_TIMEOUT,
-					transfer_response, transfer, err);
+					response_func, transfer, err);
 	if (transfer->req_id == 0) {
 		transfer_free(transfer);
 		return 0;
@@ -453,7 +470,8 @@ guint g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
 	return transfer->id;
 }
 
-guint g_obex_get_req(GObex *obex, GObexDataConsumer data_func,
+guint g_obex_get_req(GObex *obex, GObexResponseFunc response_func,
+			GObexDataConsumer data_func,
 			GObexFunc complete_func, gpointer user_data,
 			GError **err, guint8 first_hdr_id, ...)
 {
@@ -463,8 +481,12 @@ guint g_obex_get_req(GObex *obex, GObexDataConsumer data_func,
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p", obex);
 
+	if (response_func == NULL)
+		response_func = transfer_response;
+
 	transfer = transfer_new(obex, G_OBEX_OP_GET, complete_func, user_data);
 	transfer->data_consumer = data_func;
+	transfer->response_func = response_func;
 
 	va_start(args, first_hdr_id);
 	req = g_obex_packet_new_valist(G_OBEX_OP_GET, TRUE,
@@ -472,7 +494,7 @@ guint g_obex_get_req(GObex *obex, GObexDataConsumer data_func,
 	va_end(args);
 
 	transfer->req_id = g_obex_send_req(obex, req, FIRST_PACKET_TIMEOUT,
-					transfer_response, transfer, err);
+					response_func, transfer, err);
 	if (transfer->req_id == 0) {
 		transfer_free(transfer);
 		return 0;
diff --git a/gobex/gobex.h b/gobex/gobex.h
index b07e8df..6141e51 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -93,19 +93,23 @@ guint g_obex_move(GObex *obex, const char *name, const char *dest,
 
 /* Transfer related high-level functions */
 
-guint g_obex_put_req(GObex *obex, GObexDataProducer data_func,
+guint g_obex_put_req(GObex *obex, GObexResponseFunc response_func,
+			GObexDataProducer data_func,
 			GObexFunc complete_func, gpointer user_data,
 			GError **err, guint8 first_hdr_id, ...);
 
 guint g_obex_put_req_pkt(GObex *obex, GObexPacket *req,
+			GObexResponseFunc response_func,
 			GObexDataProducer data_func, GObexFunc complete_func,
 			gpointer user_data, GError **err);
 
-guint g_obex_get_req(GObex *obex, GObexDataConsumer data_func,
+guint g_obex_get_req(GObex *obex, GObexResponseFunc response_func,
+			GObexDataConsumer data_func,
 			GObexFunc complete_func, gpointer user_data,
 			GError **err, guint8 first_hdr_id, ...);
 
 guint g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
+			GObexResponseFunc response_func,
 			GObexDataConsumer data_func, GObexFunc complete_func,
 			gpointer user_data, GError **err);
 
diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index f677503..3600dc9 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -226,7 +226,7 @@ static void test_put_req(void)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_put_req(obex, provide_data, transfer_complete, &d, &d.err,
+	g_obex_put_req(obex, NULL, provide_data, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 				G_OBEX_HDR_NAME, "file.txt",
 				G_OBEX_HDR_INVALID);
@@ -344,7 +344,7 @@ static void test_get_req(void)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_get_req(obex, rcv_data, transfer_complete, &d, &d.err,
+	g_obex_get_req(obex, NULL, rcv_data, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 				G_OBEX_HDR_NAME, "file.txt",
 				G_OBEX_HDR_INVALID);
@@ -387,7 +387,7 @@ static void test_get_req_app(void)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_get_req(obex, rcv_data, transfer_complete, &d, &d.err,
+	g_obex_get_req(obex, NULL, rcv_data, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 				G_OBEX_HDR_NAME, "file.txt",
 				G_OBEX_HDR_APPARAM, hdr_app, sizeof(hdr_app),
@@ -473,7 +473,7 @@ static void test_put_req_random(int sock_type)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_put_req(obex, provide_random, transfer_complete, &d, &d.err,
+	g_obex_put_req(obex, NULL, provide_random, transfer_complete, &d, &d.err,
 					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 					G_OBEX_HDR_NAME, "random.bin",
 					G_OBEX_HDR_INVALID);
@@ -526,7 +526,7 @@ static void test_put_req_eagain(void)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_put_req(obex, provide_eagain, transfer_complete, &d, &d.err,
+	g_obex_put_req(obex, NULL, provide_eagain, transfer_complete, &d, &d.err,
 					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 					G_OBEX_HDR_NAME, "file.txt",
 					G_OBEX_HDR_INVALID);
@@ -677,7 +677,7 @@ static void test_put_req_delay(void)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_put_req(obex, provide_data, transfer_complete, &d, &d.err,
+	g_obex_put_req(obex, NULL, provide_data, transfer_complete, &d, &d.err,
 					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 					G_OBEX_HDR_NAME, "file.txt",
 					G_OBEX_HDR_INVALID);
@@ -847,7 +847,7 @@ static void test_get_req_delay(void)
 
 	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
-	g_obex_get_req(obex, rcv_data_delay, transfer_complete, &d, &d.err,
+	g_obex_get_req(obex, NULL, rcv_data_delay, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 				G_OBEX_HDR_NAME, "file.txt",
 				G_OBEX_HDR_INVALID);
@@ -1030,7 +1030,7 @@ static void conn_complete_get_req(GObex *obex, GError *err, GObexPacket *rsp,
 		g_main_loop_quit(d->mainloop);
 	}
 
-	g_obex_get_req(obex, rcv_data, transfer_complete, d, &d->err,
+	g_obex_get_req(obex, NULL, rcv_data, transfer_complete, d, &d->err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 				G_OBEX_HDR_NAME, "file.txt",
 				G_OBEX_HDR_INVALID);
@@ -1136,7 +1136,7 @@ static void conn_complete_put_req(GObex *obex, GError *err, GObexPacket *rsp,
 		g_main_loop_quit(d->mainloop);
 	}
 
-	g_obex_put_req(obex, provide_data, transfer_complete, d, &d->err,
+	g_obex_put_req(obex, NULL, provide_data, transfer_complete, d, &d->err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 				G_OBEX_HDR_NAME, "file.txt",
 				G_OBEX_HDR_INVALID);
@@ -1285,7 +1285,7 @@ static void conn_complete_put_req_random(GObex *obex, GError *err,
 		g_main_loop_quit(d->mainloop);
 	}
 
-	g_obex_put_req(obex, provide_random, transfer_complete, d, &d->err,
+	g_obex_put_req(obex, NULL, provide_random, transfer_complete, d, &d->err,
 					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
 					G_OBEX_HDR_NAME, "random.bin",
 					G_OBEX_HDR_INVALID);
-- 
1.7.4.1

