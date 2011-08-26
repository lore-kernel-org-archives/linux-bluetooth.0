Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/6] gobex: fix setting final bit on PUT requests
Date: Fri, 26 Aug 2011 12:49:32 +0300
Message-Id: <1314352176-12244-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1314352176-12244-1-git-send-email-luiz.dentz@gmail.com>
References: <1314352176-12244-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Final bit should not be set when creating new request packets for PUT
since it may be not be the end of the body.
---
 gobex/gobex-transfer.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index fad641b..386ba9a 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -170,9 +170,11 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 		return;
 	}
 
-	req = g_obex_packet_new(transfer->opcode, TRUE, G_OBEX_HDR_INVALID);
+	final = transfer->opcode == G_OBEX_OP_PUT ? FALSE : TRUE;
 
-	if (transfer->opcode == G_OBEX_OP_PUT)
+	req = g_obex_packet_new(transfer->opcode, final, G_OBEX_HDR_INVALID);
+
+	if (!final)
 		g_obex_packet_add_body(req, put_get_data, transfer);
 
 	transfer->req_id = g_obex_send_req(obex, req, -1, transfer_response,
-- 
1.7.6

