Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [RFC obexd 4/4] gobex: add functions to public transfer API
Date: Wed, 21 Dec 2011 02:41:03 +0100
Message-Id: <1324431663-3800-5-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1324431663-3800-1-git-send-email-adamek.kuba@gmail.com>
References: <1324431663-3800-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Two additional functions are added to the public gobex
transfer API and renamed to prevent name collisions. These are:
- g_obex_transfer_get_data - to allow custom packet response
handlers to access user data from the opaque GObexTransfer,
- g_obex_transfer_complete - to allow them to end the transfer
without calling the default packet response function.

Additionally, the default packet response function
is renamed to g_obex_transfer_response.
---
 gobex/gobex-transfer.c |   44 ++++++++++++++++++++++++--------------------
 gobex/gobex.h          |    6 +++++-
 2 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index 51f0189..95cc47b 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -53,6 +53,10 @@ struct _GObexTransfer {
 	gpointer user_data;
 };
 
+gpointer g_obex_transfer_get_data(GObexTransfer *transfer) {
+	return transfer->user_data;
+}
+
 static void transfer_free(GObexTransfer *transfer)
 {
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
@@ -91,7 +95,7 @@ static GObexTransfer *find_transfer(guint id)
 	return NULL;
 }
 
-static void transfer_complete(GObexTransfer *transfer, GError *err)
+void g_obex_transfer_complete(GObexTransfer *transfer, GError *err)
 {
 	guint id = transfer->id;
 
@@ -118,7 +122,7 @@ static void transfer_abort_response(GObex *obex, GError *err, GObexPacket *rsp,
 	err = g_error_new(G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED,
 						"Operation was aborted");
 	g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", err->message);
-	transfer_complete(transfer, err);
+	g_obex_transfer_complete(transfer, err);
 	g_error_free(err);
 }
 
@@ -142,7 +146,7 @@ static gssize put_get_data(void *buf, gsize len, gpointer user_data)
 						transfer_abort_response,
 						transfer, &err);
 	if (err != NULL) {
-		transfer_complete(transfer, err);
+		g_obex_transfer_complete(transfer, err);
 		g_error_free(err);
 	}
 
@@ -172,7 +176,7 @@ static gboolean handle_get_body(GObexTransfer *transfer, GObexPacket *rsp,
 	return ret;
 }
 
-void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
+void g_obex_transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 							gpointer user_data)
 {
 	GObexTransfer *transfer = user_data;
@@ -184,7 +188,7 @@ void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 	transfer->req_id = 0;
 
 	if (err != NULL) {
-		transfer_complete(transfer, err);
+		g_obex_transfer_complete(transfer, err);
 		return;
 	}
 
@@ -202,7 +206,7 @@ void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 	}
 
 	if (rspcode == G_OBEX_RSP_SUCCESS) {
-		transfer_complete(transfer, NULL);
+		g_obex_transfer_complete(transfer, NULL);
 		return;
 	}
 
@@ -220,7 +224,7 @@ void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 failed:
 	if (err != NULL) {
 		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", err->message);
-		transfer_complete(transfer, err);
+		g_obex_transfer_complete(transfer, err);
 		g_error_free(err);
 	}
 }
@@ -259,7 +263,7 @@ guint g_obex_put_req_pkt(GObex *obex, GObexPacket *req,
 		return 0;
 
 	if (response_func == NULL)
-		response_func = transfer_response;
+		response_func = g_obex_transfer_response;
 
 	transfer = transfer_new(obex, G_OBEX_OP_PUT, complete_func, user_data);
 	transfer->data_producer = data_func;
@@ -291,7 +295,7 @@ guint g_obex_put_req(GObex *obex, GObexResponseFunc response_func,
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p", obex);
 
 	if (response_func == NULL)
-		response_func = transfer_response;
+		response_func = g_obex_transfer_response;
 
 	transfer = transfer_new(obex, G_OBEX_OP_PUT, complete_func, user_data);
 	transfer->data_producer = data_func;
@@ -329,7 +333,7 @@ static void transfer_abort_req(GObex *obex, GObexPacket *req, gpointer user_data
 	rsp = g_obex_packet_new(G_OBEX_RSP_SUCCESS, TRUE, G_OBEX_HDR_INVALID);
 	g_obex_send(obex, rsp, NULL);
 
-	transfer_complete(transfer, err);
+	g_obex_transfer_complete(transfer, err);
 	g_error_free(err);
 }
 
@@ -376,12 +380,12 @@ static void transfer_put_req_first(GObexTransfer *transfer, GObexPacket *req,
 
 	rsp = g_obex_packet_new_valist(rspcode, TRUE, first_hdr_id, args);
 	if (!g_obex_send(transfer->obex, rsp, &err)) {
-		transfer_complete(transfer, err);
+		g_obex_transfer_complete(transfer, err);
 		g_error_free(err);
 	}
 
 	if (rspcode != G_OBEX_RSP_CONTINUE)
-		transfer_complete(transfer, NULL);
+		g_obex_transfer_complete(transfer, NULL);
 }
 
 static void transfer_put_req(GObex *obex, GObexPacket *req, gpointer user_data)
@@ -397,12 +401,12 @@ static void transfer_put_req(GObex *obex, GObexPacket *req, gpointer user_data)
 
 	rsp = g_obex_packet_new(rspcode, TRUE, G_OBEX_HDR_INVALID);
 	if (!g_obex_send(obex, rsp, &err)) {
-		transfer_complete(transfer, err);
+		g_obex_transfer_complete(transfer, err);
 		g_error_free(err);
 	}
 
 	if (rspcode != G_OBEX_RSP_CONTINUE)
-		transfer_complete(transfer, NULL);
+		g_obex_transfer_complete(transfer, NULL);
 }
 
 guint g_obex_put_rsp(GObex *obex, GObexPacket *req,
@@ -452,7 +456,7 @@ guint g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
 		return 0;
 
 	if (response_func == NULL)
-		response_func = transfer_response;
+		response_func = g_obex_transfer_response;
 
 	transfer = transfer_new(obex, G_OBEX_OP_GET, complete_func, user_data);
 	transfer->data_consumer = data_func;
@@ -482,7 +486,7 @@ guint g_obex_get_req(GObex *obex, GObexResponseFunc response_func,
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p", obex);
 
 	if (response_func == NULL)
-		response_func = transfer_response;
+		response_func = g_obex_transfer_response;
 
 	transfer = transfer_new(obex, G_OBEX_OP_GET, complete_func, user_data);
 	transfer->data_consumer = data_func;
@@ -522,7 +526,7 @@ static gssize get_get_data(void *buf, gsize len, gpointer user_data)
 		return ret;
 
 	if (ret == 0) {
-		transfer_complete(transfer, NULL);
+		g_obex_transfer_complete(transfer, NULL);
 		return ret;
 	}
 
@@ -533,7 +537,7 @@ static gssize get_get_data(void *buf, gsize len, gpointer user_data)
 	err = g_error_new(G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED,
 				"Data producer function failed");
 	g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", err->message);
-	transfer_complete(transfer, err);
+	g_obex_transfer_complete(transfer, err);
 	g_error_free(err);
 
 	return ret;
@@ -552,7 +556,7 @@ static void transfer_get_req_first(GObexTransfer *transfer,
 	g_obex_packet_add_body(rsp, get_get_data, transfer);
 
 	if (!g_obex_send(transfer->obex, rsp, &err)) {
-		transfer_complete(transfer, err);
+		g_obex_transfer_complete(transfer, err);
 		g_error_free(err);
 	}
 }
@@ -569,7 +573,7 @@ static void transfer_get_req(GObex *obex, GObexPacket *req, gpointer user_data)
 	g_obex_packet_add_body(rsp, get_get_data, transfer);
 
 	if (!g_obex_send(obex, rsp, &err)) {
-		transfer_complete(transfer, err);
+		g_obex_transfer_complete(transfer, err);
 		g_error_free(err);
 	}
 }
diff --git a/gobex/gobex.h b/gobex/gobex.h
index 6141e51..96b0c08 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -124,9 +124,13 @@ guint g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
 
 gboolean g_obex_cancel_transfer(guint id);
 
-void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
+void g_obex_transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 							gpointer user_data);
 
+void g_obex_transfer_complete(GObexTransfer *transfer, GError *err);
+
+gpointer g_obex_transfer_get_data(GObexTransfer *transfer);
+
 const char *g_obex_strerror(guint8 err_code);
 
 #endif /* __GOBEX_H */
-- 
1.7.4.1

