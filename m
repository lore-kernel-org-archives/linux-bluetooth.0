Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 11/12 v3] gobex: fix sending Connection ID header in all requests
Date: Fri, 11 Nov 2011 16:29:05 +0200
Message-Id: <1321021746-5991-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321021746-5991-1-git-send-email-luiz.dentz@gmail.com>
References: <1321021746-5991-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

According to both OBEX and GOEP specs Connection ID should only be
included in the first packet of a request.
---
 client/transfer.c |    1 -
 gobex/gobex.c     |    3 +++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index b6994d1..7db20f6 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -377,7 +377,6 @@ static void get_buf_xfer_progress(GObex *obex, GError *err, GObexPacket *rsp,
 
 	transfer->xfer = g_obex_send_req(obex, req, -1, get_buf_xfer_progress,
 							transfer, &err);
-
 	if (callback)
 		callback->func(transfer, transfer->transferred, err,
 							callback->data);
diff --git a/gobex/gobex.c b/gobex/gobex.c
index e2d9c6c..8a23485 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -410,6 +410,9 @@ guint g_obex_send_req(GObex *obex, GObexPacket *req, gint timeout,
 	if (obex->conn_id == CONNID_INVALID)
 		goto create_pending;
 
+	if (obex->rx_last_op == G_OBEX_RSP_CONTINUE)
+		goto create_pending;
+
 	connid = g_obex_packet_get_header(req, G_OBEX_HDR_CONNECTION);
 	if (connid != NULL)
 		goto create_pending;
-- 
1.7.6.4

