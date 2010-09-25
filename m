Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 3/6] Bluetooth: Simplify L2CAP Streaming mode sending
Date: Fri, 24 Sep 2010 22:01:41 -0300
Message-Id: <1285376504-3541-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1285376504-3541-3-git-send-email-gustavo@padovan.org>
References: <1285376504-3541-1-git-send-email-gustavo@padovan.org>
 <1285376504-3541-2-git-send-email-gustavo@padovan.org>
 <1285376504-3541-3-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

As we don't have any error control on the Streaming mode, i.e., we don't
need to keep a copy of the skb for later resending we don't need to
call skb_clone() on it.
Then we can go one further here, and dequeue the skb before sending it,
that also means we don't need to look to sk->sk_send_head anymore.

The patch saves memory and time when sending Streaming mode data, so
it is good to mainline.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |   24 +++++++-----------------
 1 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 9fad312..f2062aa 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1441,33 +1441,23 @@ static inline void l2cap_do_send(struct sock *sk, struct sk_buff *skb)
 
 static void l2cap_streaming_send(struct sock *sk)
 {
-	struct sk_buff *skb, *tx_skb;
+	struct sk_buff *skb;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	u16 control, fcs;
 
-	while ((skb = sk->sk_send_head)) {
-		tx_skb = skb_clone(skb, GFP_ATOMIC);
-
-		control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
+	while ((skb = skb_dequeue(TX_QUEUE(sk)))) {
+		control = get_unaligned_le16(skb->data + L2CAP_HDR_SIZE);
 		control |= pi->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT;
-		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
+		put_unaligned_le16(control, skb->data + L2CAP_HDR_SIZE);
 
 		if (pi->fcs == L2CAP_FCS_CRC16) {
-			fcs = crc16(0, (u8 *)tx_skb->data, tx_skb->len - 2);
-			put_unaligned_le16(fcs, tx_skb->data + tx_skb->len - 2);
+			fcs = crc16(0, (u8 *)skb->data, skb->len - 2);
+			put_unaligned_le16(fcs, skb->data + skb->len - 2);
 		}
 
-		l2cap_do_send(sk, tx_skb);
+		l2cap_do_send(sk, skb);
 
 		pi->next_tx_seq = (pi->next_tx_seq + 1) % 64;
-
-		if (skb_queue_is_last(TX_QUEUE(sk), skb))
-			sk->sk_send_head = NULL;
-		else
-			sk->sk_send_head = skb_queue_next(TX_QUEUE(sk), skb);
-
-		skb = skb_dequeue(TX_QUEUE(sk));
-		kfree_skb(skb);
 	}
 }
 
-- 
1.7.2.2

