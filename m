Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 8/8] Bluetooth: Group code for sending an I-frame.
Date: Mon, 17 Aug 2009 23:53:50 -0300
Message-Id: <1250564030-13684-8-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1250564030-13684-7-git-send-email-gustavo@las.ic.unicamp.br>
References: <1250564030-13684-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1250564030-13684-2-git-send-email-gustavo@las.ic.unicamp.br>
 <1250564030-13684-3-git-send-email-gustavo@las.ic.unicamp.br>
 <1250564030-13684-4-git-send-email-gustavo@las.ic.unicamp.br>
 <1250564030-13684-5-git-send-email-gustavo@las.ic.unicamp.br>
 <1250564030-13684-6-git-send-email-gustavo@las.ic.unicamp.br>
 <1250564030-13684-7-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove duplicated code for ERTM and Streming mode.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |   74 ++++++++++++++++--------------------------------
 1 files changed, 25 insertions(+), 49 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 60c612c..3c63ba7 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1241,37 +1241,38 @@ static void l2cap_drop_acked_frames(struct sock *sk)
 static inline int l2cap_do_send(struct sock *sk, struct sk_buff *skb)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sk_buff *tx_skb;
+	u16 control, fcs;
 	int err;
 
 	BT_DBG("sk %p, skb %p len %d", sk, skb, skb->len);
 
-	err = hci_send_acl(pi->conn->hcon, skb, 0);
+	tx_skb = skb_clone(skb, GFP_ATOMIC);
+
+	control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
+	control |= pi->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT;
+	put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
+
+	if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16) {
+		fcs = crc16(0, (u8 *)tx_skb->data, tx_skb->len - 2);
+		put_unaligned_le16(fcs, tx_skb->data + tx_skb->len - 2);
+	}
+
+	err = hci_send_acl(pi->conn->hcon, tx_skb, 0);
 	if (err < 0)
-		kfree_skb(skb);
+		kfree_skb(tx_skb);
 
 	return err;
 }
 
 static int l2cap_streaming_send(struct sock *sk)
 {
-	struct sk_buff *skb, *tx_skb;
+	struct sk_buff *skb;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	u16 control, fcs;
 	int err;
 
 	while ((skb = sk->sk_send_head)) {
-		tx_skb = skb_clone(skb, GFP_ATOMIC);
-
-		control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
-		control |= pi->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT;
-		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
-
-		if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16) {
-			fcs = crc16(0, (u8 *)tx_skb->data, tx_skb->len - 2);
-			put_unaligned_le16(fcs, tx_skb->data + tx_skb->len - 2);
-		}
-
-		err = l2cap_do_send(sk, tx_skb);
+		err = l2cap_do_send(sk, skb);
 		if (err < 0) {
 			l2cap_send_disconn_req(pi->conn, sk);
 			return err;
@@ -1293,8 +1294,7 @@ static int l2cap_streaming_send(struct sock *sk)
 static int l2cap_retransmit_frame(struct sock *sk, u8 tx_seq)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	struct sk_buff *skb, *tx_skb;
-	u16 control, fcs;
+	struct sk_buff *skb;
 	int err;
 
 	skb = skb_peek(TX_QUEUE(sk));
@@ -1312,23 +1312,13 @@ static int l2cap_retransmit_frame(struct sock *sk, u8 tx_seq)
 			break;
 		}
 
-		tx_skb = skb_clone(skb, GFP_ATOMIC);
-		bt_cb(skb)->retries++;
-		control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
-		control |= (pi->req_seq << L2CAP_CTRL_REQSEQ_SHIFT)
-				| (tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
-		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
-
-		if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16) {
-			fcs = crc16(0, (u8 *)tx_skb->data, tx_skb->len - 2);
-			put_unaligned_le16(fcs, tx_skb->data + tx_skb->len - 2);
-		}
-
-		err = l2cap_do_send(sk, tx_skb);
+		err = l2cap_do_send(sk, skb);
 		if (err < 0) {
 			l2cap_send_disconn_req(pi->conn, sk);
 			return err;
 		}
+		bt_cb(skb)->retries++;
+
 		break;
 	} while(1);
 	return 0;
@@ -1336,41 +1326,27 @@ static int l2cap_retransmit_frame(struct sock *sk, u8 tx_seq)
 
 static int l2cap_ertm_send(struct sock *sk)
 {
-	struct sk_buff *skb, *tx_skb;
+	struct sk_buff *skb;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	u16 control, fcs;
 	int err;
 
 	if (pi->conn_state & L2CAP_CONN_WAIT_ACK)
 		return 0;
 
 	while ((skb = sk->sk_send_head) && (!l2cap_tx_window_full(sk))) {
-		tx_skb = skb_clone(skb, GFP_ATOMIC);
-
 		if (pi->remote_max_tx &&
 				bt_cb(skb)->retries == pi->remote_max_tx) {
 			l2cap_send_disconn_req(pi->conn, sk);
 			break;
 		}
 
-		bt_cb(skb)->retries++;
-
-		control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
-		control |= (pi->req_seq << L2CAP_CTRL_REQSEQ_SHIFT)
-				| (pi->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
-		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
-
-
-		if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16) {
-			fcs = crc16(0, (u8 *)skb->data, tx_skb->len - 2);
-			put_unaligned_le16(fcs, skb->data + tx_skb->len - 2);
-		}
-
-		err = l2cap_do_send(sk, tx_skb);
+		err = l2cap_do_send(sk, skb);
 		if (err < 0) {
 			l2cap_send_disconn_req(pi->conn, sk);
 			return err;
 		}
+
+		bt_cb(skb)->retries++;
 		__mod_retrans_timer();
 
 		bt_cb(skb)->tx_seq = pi->next_tx_seq;
-- 
1.6.3.3

