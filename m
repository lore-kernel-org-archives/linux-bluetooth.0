Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [RFC obexd 1/4] gobex: make transfer structure public and opaque
Date: Wed, 21 Dec 2011 02:41:00 +0100
Message-Id: <1324431663-3800-2-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1324431663-3800-1-git-send-email-adamek.kuba@gmail.com>
References: <1324431663-3800-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This renames the structure responsible for storing transfer
information in gobex to _GObexTransfer and typedefs the name
GObexTransfer to it in the main gobex header.
This will let applications using gobex to implement their own
packet response functions.
---
 gobex/gobex-transfer.c |   52 ++++++++++++++++++++++++------------------------
 gobex/gobex.h          |    1 +
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index 692d713..57eb37b 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -33,7 +33,7 @@
 
 static GSList *transfers = NULL;
 
-struct transfer {
+struct _GObexTransfer {
 	guint id;
 	guint8 opcode;
 
@@ -52,7 +52,7 @@ struct transfer {
 	gpointer user_data;
 };
 
-static void transfer_free(struct transfer *transfer)
+static void transfer_free(GObexTransfer *transfer)
 {
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
 
@@ -77,12 +77,12 @@ static void transfer_free(struct transfer *transfer)
 	g_free(transfer);
 }
 
-static struct transfer *find_transfer(guint id)
+static GObexTransfer *find_transfer(guint id)
 {
 	GSList *l;
 
 	for (l = transfers; l != NULL; l = g_slist_next(l)) {
-		struct transfer *t = l->data;
+		GObexTransfer *t = l->data;
 		if (t->id == id)
 			return t;
 	}
@@ -90,7 +90,7 @@ static struct transfer *find_transfer(guint id)
 	return NULL;
 }
 
-static void transfer_complete(struct transfer *transfer, GError *err)
+static void transfer_complete(GObexTransfer *transfer, GError *err)
 {
 	guint id = transfer->id;
 
@@ -107,7 +107,7 @@ static void transfer_complete(struct transfer *transfer, GError *err)
 static void transfer_abort_response(GObex *obex, GError *err, GObexPacket *rsp,
 							gpointer user_data)
 {
-	struct transfer *transfer = user_data;
+	GObexTransfer *transfer = user_data;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
 
@@ -124,7 +124,7 @@ static void transfer_abort_response(GObex *obex, GError *err, GObexPacket *rsp,
 
 static gssize put_get_data(void *buf, gsize len, gpointer user_data)
 {
-	struct transfer *transfer = user_data;
+	GObexTransfer *transfer = user_data;
 	GObexPacket *req;
 	GError *err = NULL;
 	gssize ret;
@@ -148,7 +148,7 @@ static gssize put_get_data(void *buf, gsize len, gpointer user_data)
 	return ret;
 }
 
-static gboolean handle_get_body(struct transfer *transfer, GObexPacket *rsp,
+static gboolean handle_get_body(GObexTransfer *transfer, GObexPacket *rsp,
 								GError **err)
 {
 	GObexHeader *body = g_obex_packet_get_body(rsp);
@@ -174,7 +174,7 @@ static gboolean handle_get_body(struct transfer *transfer, GObexPacket *rsp,
 static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 							gpointer user_data)
 {
-	struct transfer *transfer = user_data;
+	GObexTransfer *transfer = user_data;
 	GObexPacket *req;
 	gboolean rspcode, final;
 
@@ -224,15 +224,15 @@ failed:
 	}
 }
 
-static struct transfer *transfer_new(GObex *obex, guint8 opcode,
+static GObexTransfer *transfer_new(GObex *obex, guint8 opcode,
 				GObexFunc complete_func, gpointer user_data)
 {
 	static guint next_id = 1;
-	struct transfer *transfer;
+	GObexTransfer *transfer;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p opcode %u", obex, opcode);
 
-	transfer = g_new0(struct transfer, 1);
+	transfer = g_new0(GObexTransfer, 1);
 
 	transfer->id = next_id++;
 	transfer->opcode = opcode;
@@ -249,7 +249,7 @@ guint g_obex_put_req_pkt(GObex *obex, GObexPacket *req,
 			GObexDataProducer data_func, GObexFunc complete_func,
 			gpointer user_data, GError **err)
 {
-	struct transfer *transfer;
+	GObexTransfer *transfer;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p", obex);
 
@@ -277,7 +277,7 @@ guint g_obex_put_req(GObex *obex, GObexDataProducer data_func,
 			GObexFunc complete_func, gpointer user_data,
 			GError **err, guint8 first_hdr_id, ...)
 {
-	struct transfer *transfer;
+	GObexTransfer *transfer;
 	GObexPacket *req;
 	va_list args;
 
@@ -307,7 +307,7 @@ guint g_obex_put_req(GObex *obex, GObexDataProducer data_func,
 
 static void transfer_abort_req(GObex *obex, GObexPacket *req, gpointer user_data)
 {
-	struct transfer *transfer = user_data;
+	GObexTransfer *transfer = user_data;
 	GObexPacket *rsp;
 	GError *err;
 
@@ -322,7 +322,7 @@ static void transfer_abort_req(GObex *obex, GObexPacket *req, gpointer user_data
 	g_error_free(err);
 }
 
-static guint8 put_get_bytes(struct transfer *transfer, GObexPacket *req)
+static guint8 put_get_bytes(GObexTransfer *transfer, GObexPacket *req)
 {
 	GObexHeader *body;
 	gboolean final;
@@ -352,7 +352,7 @@ static guint8 put_get_bytes(struct transfer *transfer, GObexPacket *req)
 	return rsp;
 }
 
-static void transfer_put_req_first(struct transfer *transfer, GObexPacket *req,
+static void transfer_put_req_first(GObexTransfer *transfer, GObexPacket *req,
 					guint8 first_hdr_id, va_list args)
 {
 	GError *err = NULL;
@@ -375,7 +375,7 @@ static void transfer_put_req_first(struct transfer *transfer, GObexPacket *req,
 
 static void transfer_put_req(GObex *obex, GObexPacket *req, gpointer user_data)
 {
-	struct transfer *transfer = user_data;
+	GObexTransfer *transfer = user_data;
 	GError *err = NULL;
 	GObexPacket *rsp;
 	guint8 rspcode;
@@ -399,7 +399,7 @@ guint g_obex_put_rsp(GObex *obex, GObexPacket *req,
 			gpointer user_data, GError **err,
 			guint8 first_hdr_id, ...)
 {
-	struct transfer *transfer;
+	GObexTransfer *transfer;
 	va_list args;
 	guint id;
 
@@ -432,7 +432,7 @@ guint g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
 			GObexDataConsumer data_func, GObexFunc complete_func,
 			gpointer user_data, GError **err)
 {
-	struct transfer *transfer;
+	GObexTransfer *transfer;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p", obex);
 
@@ -457,7 +457,7 @@ guint g_obex_get_req(GObex *obex, GObexDataConsumer data_func,
 			GObexFunc complete_func, gpointer user_data,
 			GError **err, guint8 first_hdr_id, ...)
 {
-	struct transfer *transfer;
+	GObexTransfer *transfer;
 	GObexPacket *req;
 	va_list args;
 
@@ -485,7 +485,7 @@ guint g_obex_get_req(GObex *obex, GObexDataConsumer data_func,
 
 static gssize get_get_data(void *buf, gsize len, gpointer user_data)
 {
-	struct transfer *transfer = user_data;
+	GObexTransfer *transfer = user_data;
 	GObexPacket *req;
 	GError *err = NULL;
 	gssize ret;
@@ -517,7 +517,7 @@ static gssize get_get_data(void *buf, gsize len, gpointer user_data)
 	return ret;
 }
 
-static void transfer_get_req_first(struct transfer *transfer,
+static void transfer_get_req_first(GObexTransfer *transfer,
 					guint8 first_hdr_id, va_list args)
 {
 	GError *err = NULL;
@@ -537,7 +537,7 @@ static void transfer_get_req_first(struct transfer *transfer,
 
 static void transfer_get_req(GObex *obex, GObexPacket *req, gpointer user_data)
 {
-	struct transfer *transfer = user_data;
+	GObexTransfer *transfer = user_data;
 	GError *err = NULL;
 	GObexPacket *rsp;
 
@@ -556,7 +556,7 @@ guint g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
 			GObexFunc complete_func, gpointer user_data,
 			GError **err, guint8 first_hdr_id, ...)
 {
-	struct transfer *transfer;
+	GObexTransfer *transfer;
 	va_list args;
 	guint id;
 
@@ -587,7 +587,7 @@ guint g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
 
 gboolean g_obex_cancel_transfer(guint id)
 {
-	struct transfer *transfer = NULL;
+	GObexTransfer *transfer = NULL;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", id);
 
diff --git a/gobex/gobex.h b/gobex/gobex.h
index 81981ea..3403444 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -34,6 +34,7 @@ typedef enum {
 } GObexTransportType;
 
 typedef struct _GObex GObex;
+typedef struct _GObexTransfer GObexTransfer;
 
 typedef void (*GObexFunc) (GObex *obex, GError *err, gpointer user_data);
 typedef void (*GObexRequestFunc) (GObex *obex, GObexPacket *req,
-- 
1.7.4.1

