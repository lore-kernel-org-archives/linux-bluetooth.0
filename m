Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/2 v2] client: Use larger timeout first packet in transfers
Date: Thu, 20 Sep 2012 15:07:14 +0300
Message-Id: <1348142835-13146-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This align the client timeout for GET operations with g_obex_get_req_pkt
which does use 60 seconds to cover for extra interaction during the first
packet.
---
v2: Change clients to use 60 seconds timeout.

 client/transfer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/client/transfer.c b/client/transfer.c
index 76f6681..e9fabfb 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -48,6 +48,8 @@
 
 #define OBC_TRANSFER_ERROR obc_transfer_error_quark()
 
+#define FIRST_PACKET_TIMEOUT 60
+
 static guint64 counter = 0;
 
 struct transfer_callback {
@@ -662,7 +664,8 @@ static gboolean transfer_start_get(struct obc_transfer *transfer, GError **err)
 						transfer->params->data,
 						transfer->params->size);
 
-	transfer->xfer = g_obex_send_req(transfer->obex, req, -1,
+	transfer->xfer = g_obex_send_req(transfer->obex, req,
+						FIRST_PACKET_TIMEOUT,
 						get_xfer_progress_first,
 						transfer, err);
 	if (transfer->xfer == 0)
-- 
1.7.11.4

