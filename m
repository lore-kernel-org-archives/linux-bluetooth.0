Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [l2cap 5/6] Bluetooth: Check packet FCS earlier
Date: Wed, 12 May 2010 00:05:57 -0300
Message-Id: <1273633558-10576-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1273633558-10576-4-git-send-email-padovan@profusion.mobi>
References: <1273513181-28258-2-git-send-email-gustavo@padovan.org>
 <1273633558-10576-1-git-send-email-padovan@profusion.mobi>
 <1273633558-10576-2-git-send-email-padovan@profusion.mobi>
 <1273633558-10576-3-git-send-email-padovan@profusion.mobi>
 <1273633558-10576-4-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

This way, if FCS is enabled and the packet is corrupted, we just drop it
without read it len, which could be corrupted.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 6b5226d..dbd43d1 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -4115,25 +4115,25 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
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
@@ -4173,6 +4173,9 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		skb_pull(skb, 2);
 		len = skb->len;
 
+		if (l2cap_check_fcs(pi, skb))
+			goto drop;
+
 		if (__is_sar_start(control))
 			len -= 2;
 
@@ -4182,9 +4185,6 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (len > pi->mps || len < 4 || __is_sframe(control))
 			goto drop;
 
-		if (l2cap_check_fcs(pi, skb))
-			goto drop;
-
 		tx_seq = __get_txseq(control);
 
 		if (pi->expected_tx_seq == tx_seq)
-- 
1.6.4.4
