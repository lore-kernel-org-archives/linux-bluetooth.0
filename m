Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] gobex/transfer: Keep request id for GET when SRM is active
Date: Thu, 20 Mar 2014 19:20:27 +0200
Message-Id: <1395336027-30438-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395336027-30438-1-git-send-email-luiz.dentz@gmail.com>
References: <1395336027-30438-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case a GET operation is in progress with SRM the same request id is
valid for the whole transfer otherwise it is not possible to cancel the
transfer after the first response.
---
 gobex/gobex-transfer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index 09f56ba..8498177 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -195,9 +195,11 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 	struct transfer *transfer = user_data;
 	GObexPacket *req;
 	gboolean rspcode, final;
+	guint id;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
 
+	id = transfer->req_id;
 	transfer->req_id = 0;
 
 	if (err != NULL) {
@@ -230,8 +232,11 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 	} else if (!g_obex_srm_active(transfer->obex)) {
 		req = g_obex_packet_new(transfer->opcode, TRUE,
 							G_OBEX_HDR_INVALID);
-	} else
+	} else {
+		/* Keep id since request still outstanting */
+		transfer->req_id = id;
 		return;
+	}
 
 	transfer->req_id = g_obex_send_req(obex, req, -1, transfer_response,
 							transfer, &err);
-- 
1.8.5.3

