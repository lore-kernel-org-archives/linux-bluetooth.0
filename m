Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [RFC 1/7] Bluetooth: Calculate L2CAP FCS on fragmented skbuffs.
Date: Tue, 10 Aug 2010 12:14:58 -0700
Message-Id: <1281467704-5378-2-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

When L2CAP PDUs are longer than the HCI MTU, they are stored in
fragmented skbuffs.  This adds a function to calculate the FCS
on any skbuff (fragmented or not), and replaces direct calls
to crc16 with calls to the new apply_fcs() function.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap.c |   57 ++++++++++++++++++++++++++++++++----------------
 1 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 8d362d7..5e78c18 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -351,6 +351,33 @@ static inline u8 l2cap_get_ident(struct l2cap_conn *conn)
 	return id;
 }
 
+static void apply_fcs(struct sk_buff *skb)
+{
+	size_t len;
+	u16 partial_crc;
+	struct sk_buff *iter;
+	struct sk_buff *final_frag = skb;
+
+	if (skb_has_frags(skb))
+		len = skb_headlen(skb);
+	else
+		len = skb->len - L2CAP_FCS_SIZE;
+
+	partial_crc = crc16(0, (u8 *) skb->data, len);
+
+	skb_walk_frags(skb, iter) {
+		len = iter->len;
+		if (!iter->next)
+			len -= L2CAP_FCS_SIZE;
+
+		partial_crc = crc16(partial_crc, iter->data, len);
+		final_frag = iter;
+	}
+
+	put_unaligned_le16(partial_crc,
+		final_frag->data + final_frag->len - L2CAP_FCS_SIZE);
+}
+
 static inline void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *data)
 {
 	struct sk_buff *skb = l2cap_build_cmd(conn, code, ident, len, data);
@@ -401,10 +428,8 @@ static inline void l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
 	lh->cid = cpu_to_le16(pi->dcid);
 	put_unaligned_le16(control, skb_put(skb, 2));
 
-	if (pi->fcs == L2CAP_FCS_CRC16) {
-		u16 fcs = crc16(0, (u8 *)lh, count - 2);
-		put_unaligned_le16(fcs, skb_put(skb, 2));
-	}
+	if (pi->fcs == L2CAP_FCS_CRC16)
+		apply_fcs(skb);
 
 	hci_send_acl(pi->conn->hcon, skb, 0);
 }
@@ -1458,7 +1483,7 @@ static void l2cap_streaming_send(struct sock *sk)
 {
 	struct sk_buff *skb, *tx_skb;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	u16 control, fcs;
+	u16 control;
 
 	while ((skb = sk->sk_send_head)) {
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
@@ -1467,10 +1492,8 @@ static void l2cap_streaming_send(struct sock *sk)
 		control |= pi->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT;
 		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
-		if (pi->fcs == L2CAP_FCS_CRC16) {
-			fcs = crc16(0, (u8 *)tx_skb->data, tx_skb->len - 2);
-			put_unaligned_le16(fcs, tx_skb->data + tx_skb->len - 2);
-		}
+		if (pi->fcs == L2CAP_FCS_CRC16)
+			apply_fcs(tx_skb);
 
 		l2cap_do_send(sk, tx_skb);
 
@@ -1490,7 +1513,7 @@ static void l2cap_retransmit_one_frame(struct sock *sk, u8 tx_seq)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct sk_buff *skb, *tx_skb;
-	u16 control, fcs;
+	u16 control;
 
 	skb = skb_peek(TX_QUEUE(sk));
 	if (!skb)
@@ -1525,10 +1548,8 @@ static void l2cap_retransmit_one_frame(struct sock *sk, u8 tx_seq)
 
 	put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
-	if (pi->fcs == L2CAP_FCS_CRC16) {
-		fcs = crc16(0, (u8 *)tx_skb->data, tx_skb->len - 2);
-		put_unaligned_le16(fcs, tx_skb->data + tx_skb->len - 2);
-	}
+	if (pi->fcs == L2CAP_FCS_CRC16)
+		apply_fcs(tx_skb);
 
 	l2cap_do_send(sk, tx_skb);
 }
@@ -1537,7 +1558,7 @@ static int l2cap_ertm_send(struct sock *sk)
 {
 	struct sk_buff *skb, *tx_skb;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	u16 control, fcs;
+	u16 control;
 	int nsent = 0;
 
 	if (sk->sk_state != BT_CONNECTED)
@@ -1567,10 +1588,8 @@ static int l2cap_ertm_send(struct sock *sk)
 		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
 
-		if (pi->fcs == L2CAP_FCS_CRC16) {
-			fcs = crc16(0, (u8 *)skb->data, tx_skb->len - 2);
-			put_unaligned_le16(fcs, skb->data + tx_skb->len - 2);
-		}
+		if (pi->fcs == L2CAP_FCS_CRC16)
+			apply_fcs(tx_skb);
 
 		l2cap_do_send(sk, tx_skb);
 
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
