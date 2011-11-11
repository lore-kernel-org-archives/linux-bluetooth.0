Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 10/12 v3] gobex: fix not tracking received responses
Date: Fri, 11 Nov 2011 16:29:04 +0200
Message-Id: <1321021746-5991-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321021746-5991-1-git-send-email-luiz.dentz@gmail.com>
References: <1321021746-5991-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

obex->rx_last_op is only updated if there is no pending request which
means it only store last received request.
---
 gobex/gobex.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index b0f3716..e2d9c6c 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -860,19 +860,20 @@ static gboolean incoming_data(GIOChannel *io, GIOCondition cond,
 	if (obex->rx_data < 3 || obex->rx_data < obex->rx_pkt_len)
 		return TRUE;
 
+	obex->rx_last_op = obex->rx_buf[0] & ~FINAL_BIT;
+
 	if (obex->pending_req) {
 		struct pending_pkt *p = obex->pending_req;
 		opcode = g_obex_packet_get_operation(p->pkt, NULL);
 		header_offset = rsp_header_offset(opcode);
 	} else {
-		opcode = obex->rx_buf[0] & ~FINAL_BIT;
+		opcode = obex->rx_last_op;
 		/* Unexpected response -- fail silently */
 		if (opcode > 0x1f && opcode < 0xff) {
 			obex->rx_data = 0;
 			return TRUE;
 		}
 		header_offset = req_header_offset(opcode);
-		obex->rx_last_op = opcode;
 	}
 
 	if (header_offset < 0) {
-- 
1.7.6.4

