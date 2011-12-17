Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/3] gobex: reduce duplicated code in g_obex_put_req
Date: Sat, 17 Dec 2011 12:17:47 +0200
Message-Id: <1324117067-12459-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1324117067-12459-1-git-send-email-luiz.dentz@gmail.com>
References: <1324117067-12459-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

g_obex_put_req is quite similar to g_obex_put_req_pkt so now it just
call it to avoid duplicating this code.
---
 gobex/gobex-transfer.c |   18 ++----------------
 1 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index 692d713..0a7a29f 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -277,32 +277,18 @@ guint g_obex_put_req(GObex *obex, GObexDataProducer data_func,
 			GObexFunc complete_func, gpointer user_data,
 			GError **err, guint8 first_hdr_id, ...)
 {
-	struct transfer *transfer;
 	GObexPacket *req;
 	va_list args;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p", obex);
 
-	transfer = transfer_new(obex, G_OBEX_OP_PUT, complete_func, user_data);
-	transfer->data_producer = data_func;
-
 	va_start(args, first_hdr_id);
 	req = g_obex_packet_new_valist(G_OBEX_OP_PUT, FALSE,
 							first_hdr_id, args);
 	va_end(args);
 
-	g_obex_packet_add_body(req, put_get_data, transfer);
-
-	transfer->req_id = g_obex_send_req(obex, req, FIRST_PACKET_TIMEOUT,
-					transfer_response, transfer, err);
-	if (transfer->req_id == 0) {
-		transfer_free(transfer);
-		return 0;
-	}
-
-	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
-
-	return transfer->id;
+	return g_obex_put_req_pkt(obex, req, data_func, complete_func,
+							user_data, err);
 }
 
 static void transfer_abort_req(GObex *obex, GObexPacket *req, gpointer user_data)
-- 
1.7.7.4

