Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 1/2] client: Fix memory leak connected to params
Date: Mon, 21 Nov 2011 09:32:32 +0100
Message-Id: <1321864353-3159-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

obc_transfer_params (created in obc_session_get) are reused to store
params received in the response. But actual parameter data were not
freed before g_memdup in get_buf_xfer_progress.
---
 client/transfer.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index b6994d1..334d8d4 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -533,11 +533,16 @@ int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
 		g_obex_packet_add_bytes(req, G_OBEX_HDR_TYPE, transfer->type,
 						strlen(transfer->type) + 1);
 
-	if (transfer->params != NULL)
+	if (transfer->params != NULL) {
 		g_obex_packet_add_bytes(req, G_OBEX_HDR_APPARAM,
 						transfer->params->data,
 						transfer->params->size);
 
+		g_free(transfer->params->data);
+		transfer->params->size = 0;
+		transfer->params->data = NULL;
+	}
+
 	if (rsp_cb)
 		transfer->xfer = g_obex_send_req(obex, req, -1, rsp_cb,
 							transfer, &err);
-- 
1.7.4.1

