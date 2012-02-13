Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] client: Fix sending GET while SRM is active
Date: Mon, 13 Feb 2012 12:15:42 +0200
Message-Id: <1329128142-26867-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If SRM is active remote will be generating responses automatically
---
 client/transfer.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 8677b07..157811d 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -383,10 +383,13 @@ static void get_buf_xfer_progress(GObex *obex, GError *err, GObexPacket *rsp,
 		return;
 	}
 
-	req = g_obex_packet_new(G_OBEX_OP_GET, TRUE, G_OBEX_HDR_INVALID);
+	if (!g_obex_srm_active(obex)) {
+		req = g_obex_packet_new(G_OBEX_OP_GET, TRUE, G_OBEX_HDR_INVALID);
 
-	transfer->xfer = g_obex_send_req(obex, req, -1, get_buf_xfer_progress,
+		transfer->xfer = g_obex_send_req(obex, req, -1,
+							get_buf_xfer_progress,
 							transfer, &err);
+	}
 
 	if (callback)
 		callback->func(transfer, transfer->transferred, err,
-- 
1.7.7.6

