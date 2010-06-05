Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 06/14] Bluetooth: Check packet FCS earlier
Date: Sat,  5 Jun 2010 04:50:10 -0300
Message-Id: <1275724218-29453-7-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275724218-29453-6-git-send-email-gustavo@padovan.org>
References: <1275724218-29453-1-git-send-email-gustavo@padovan.org>
 <1275724218-29453-2-git-send-email-gustavo@padovan.org>
 <1275724218-29453-3-git-send-email-gustavo@padovan.org>
 <1275724218-29453-4-git-send-email-gustavo@padovan.org>
 <1275724218-29453-5-git-send-email-gustavo@padovan.org>
 <1275724218-29453-6-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

This way, if FCS is enabled and the packet is corrupted, we just drop it
without read it len, which could be corrupted.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index a567614..97584d8 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -4114,25 +4114,25 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		skb_pull(skb, 2);
 		len = skb->len;
 
+		/*
+		 * We can just drop the corrupted I-frame here.
+		 * Receiver will miss it and start proper recovery
+		 * procedures and ask retransmission.
+		 */
+		if (l2cap_check_fcs(pi, skb))
+			goto drop;
+
 		if (__is_sar_start(control))
 			len -= 2;
 
 		if (pi->fcs == L2CAP_FCS_CRC16)
 			len -= 2;
 
-		/*
-		 * We can just drop the corrupted I-frame here.
-		 * Receiver will miss it and start proper recovery
-		 * procedures and ask retransmission.
-		 */
 		if (len > pi->mps) {
 			l2cap_send_disconn_req(pi->conn, sk);
 			goto drop;
 		}
 
-		if (l2cap_check_fcs(pi, skb))
-			goto drop;
-
 		req_seq = __get_reqseq(control);
 		req_seq_offset = (req_seq - pi->expected_ack_seq) % 64;
 		if (req_seq_offset < 0)
@@ -4172,6 +4172,9 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		skb_pull(skb, 2);
 		len = skb->len;
 
+		if (l2cap_check_fcs(pi, skb))
+			goto drop;
+
 		if (__is_sar_start(control))
 			len -= 2;
 
@@ -4181,9 +4184,6 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (len > pi->mps || len < 4 || __is_sframe(control))
 			goto drop;
 
-		if (l2cap_check_fcs(pi, skb))
-			goto drop;
-
 		tx_seq = __get_txseq(control);
 
 		if (pi->expected_tx_seq == tx_seq)
-- 
1.7.1
