Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/3] gobex: introduce g_obex_get_rsp_pkt
Date: Wed, 11 Jan 2012 15:22:02 +0200
Message-Id: <1326288123-31807-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1326288123-31807-1-git-send-email-luiz.dentz@gmail.com>
References: <1326288123-31807-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

g_obex_get_rsp_pkt takes a response packet which sometimes is more
convenient for adding headers.
---
 gobex/gobex-transfer.c |   35 +++++++++++++++++++++++------------
 gobex/gobex.h          |    4 ++++
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index 614d2d1..a779e4f 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -543,16 +543,12 @@ static gssize get_get_data(void *buf, gsize len, gpointer user_data)
 	return ret;
 }
 
-static void transfer_get_req_first(struct transfer *transfer,
-					guint8 first_hdr_id, va_list args)
+static void transfer_get_req_first(struct transfer *transfer, GObexPacket *rsp)
 {
 	GError *err = NULL;
-	GObexPacket *rsp;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
 
-	rsp = g_obex_packet_new_valist(G_OBEX_RSP_CONTINUE, TRUE,
-							first_hdr_id, args);
 	g_obex_packet_add_body(rsp, get_get_data, transfer);
 
 	if (!g_obex_send(transfer->obex, rsp, &err)) {
@@ -578,12 +574,11 @@ static void transfer_get_req(GObex *obex, GObexPacket *req, gpointer user_data)
 	}
 }
 
-guint g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
-			GObexFunc complete_func, gpointer user_data,
-			GError **err, guint8 first_hdr_id, ...)
+guint g_obex_get_rsp_pkt(GObex *obex, GObexPacket *rsp,
+			GObexDataProducer data_func, GObexFunc complete_func,
+			gpointer user_data, GError **err)
 {
 	struct transfer *transfer;
-	va_list args;
 	guint id;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p", obex);
@@ -591,9 +586,7 @@ guint g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
 	transfer = transfer_new(obex, G_OBEX_OP_GET, complete_func, user_data);
 	transfer->data_producer = data_func;
 
-	va_start(args, first_hdr_id);
-	transfer_get_req_first(transfer, first_hdr_id, args);
-	va_end(args);
+	transfer_get_req_first(transfer, rsp);
 
 	if (!g_slist_find(transfers, transfer))
 		return 0;
@@ -611,6 +604,24 @@ guint g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
 	return transfer->id;
 }
 
+guint g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
+			GObexFunc complete_func, gpointer user_data,
+			GError **err, guint8 first_hdr_id, ...)
+{
+	GObexPacket *rsp;
+	va_list args;
+
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p", obex);
+
+	va_start(args, first_hdr_id);
+	rsp = g_obex_packet_new_valist(G_OBEX_RSP_CONTINUE, TRUE,
+							first_hdr_id, args);
+	va_end(args);
+
+	return g_obex_get_rsp_pkt(obex, rsp, data_func, complete_func,
+							user_data, err);
+}
+
 gboolean g_obex_cancel_transfer(guint id)
 {
 	struct transfer *transfer = NULL;
diff --git a/gobex/gobex.h b/gobex/gobex.h
index f3a7f94..1c47c68 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -118,6 +118,10 @@ guint g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
 			GObexFunc complete_func, gpointer user_data,
 			GError **err, guint8 first_hdr_id, ...);
 
+guint g_obex_get_rsp_pkt(GObex *obex, GObexPacket *rsp,
+			GObexDataProducer data_func, GObexFunc complete_func,
+			gpointer user_data, GError **err);
+
 gboolean g_obex_cancel_transfer(guint id);
 
 const char *g_obex_strerror(guint8 err_code);
-- 
1.7.7.5

