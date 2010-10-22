Return-Path: <cyrus@holtmann.org>
From: Haijun Liu <haijun.liu@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <padovan@profusion.mobi>, Haijun Liu <haijun.liu@atheros.com>
Subject: [PATCH 2/2 v2] Bluetooth: Fix system crash bug of no send queue protect
Date: Fri, 22 Oct 2010 10:26:59 +0800
Message-ID: <1287714419-13545-2-git-send-email-haijun.liu@atheros.com>
In-Reply-To: <1287714419-13545-1-git-send-email-haijun.liu@atheros.com>
References: <1287714419-13545-1-git-send-email-haijun.liu@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

During test session with another vendor's bt stack, found that
without lock protect for TX_QUEUE(sk) will cause system crash while
data transfer over AMP controller. So I just add lock protect for
TX_QUEUE(sk).

Signed-off-by: Haijun Liu <haijun.liu@atheros.com>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap.c         |   25 +++++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index c819c8b..276c7ea 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -304,6 +304,7 @@ struct sock_del_list {
 #define SREJ_QUEUE(sk) (&l2cap_pi(sk)->srej_queue)
 #define BUSY_QUEUE(sk) (&l2cap_pi(sk)->busy_queue)
 #define SREJ_LIST(sk) (&l2cap_pi(sk)->srej_l.list)
+#define TX_QUEUE_LOCK(sk) (&l2cap_pi(sk)->tx_queue.lock)
 
 struct srej_list {
 	__u8	tx_seq;
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 879f386..153614f 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1432,16 +1432,18 @@ static void l2cap_drop_acked_frames(struct sock *sk)
 {
 	struct sk_buff *skb;
 
+	spin_lock_bh(TX_QUEUE_LOCK(sk));
 	while ((skb = skb_peek(TX_QUEUE(sk))) &&
 			l2cap_pi(sk)->unacked_frames) {
 		if (bt_cb(skb)->tx_seq == l2cap_pi(sk)->expected_ack_seq)
 			break;
 
-		skb = skb_dequeue(TX_QUEUE(sk));
+		skb = __skb_dequeue(TX_QUEUE(sk));
 		kfree_skb(skb);
 
 		l2cap_pi(sk)->unacked_frames--;
 	}
+	spin_unlock_bh(TX_QUEUE_LOCK(sk));
 
 	if (!l2cap_pi(sk)->unacked_frames)
 		del_timer(&l2cap_pi(sk)->retrans_timer);
@@ -1484,18 +1486,24 @@ static void l2cap_retransmit_one_frame(struct sock *sk, u8 tx_seq)
 	struct sk_buff *skb, *tx_skb;
 	u16 control, fcs;
 
+	spin_lock_bh(TX_QUEUE_LOCK(sk));
 	skb = skb_peek(TX_QUEUE(sk));
-	if (!skb)
+	if (!skb) {
+		spin_unlock_bh(TX_QUEUE_LOCK(sk));
 		return;
+	}
 
 	do {
 		if (bt_cb(skb)->tx_seq == tx_seq)
 			break;
 
-		if (skb_queue_is_last(TX_QUEUE(sk), skb))
+		if (skb_queue_is_last(TX_QUEUE(sk), skb)) {
+			spin_unlock_bh(TX_QUEUE_LOCK(sk));
 			return;
+		}
 
 	} while ((skb = skb_queue_next(TX_QUEUE(sk), skb)));
+	spin_unlock_bh(TX_QUEUE_LOCK(sk));
 
 	if (pi->remote_max_tx &&
 			bt_cb(skb)->retries == pi->remote_max_tx) {
@@ -1535,12 +1543,14 @@ static int l2cap_ertm_send(struct sock *sk)
 	if (sk->sk_state != BT_CONNECTED)
 		return -ENOTCONN;
 
+	spin_lock_bh(TX_QUEUE_LOCK(sk));
 	while ((skb = sk->sk_send_head) && (!l2cap_tx_window_full(sk))) {
 
 		if (pi->remote_max_tx &&
 				bt_cb(skb)->retries == pi->remote_max_tx) {
+			spin_unlock_bh(TX_QUEUE_LOCK(sk));
 			l2cap_send_disconn_req(pi->conn, sk, ECONNABORTED);
-			break;
+			return nsent;
 		}
 
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
@@ -1581,6 +1591,7 @@ static int l2cap_ertm_send(struct sock *sk)
 
 		nsent++;
 	}
+	spin_unlock_bh(TX_QUEUE_LOCK(sk));
 
 	return nsent;
 }
@@ -1590,8 +1601,10 @@ static int l2cap_retransmit_frames(struct sock *sk)
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	int ret;
 
+	spin_lock_bh(TX_QUEUE_LOCK(sk));
 	if (!skb_queue_empty(TX_QUEUE(sk)))
 		sk->sk_send_head = TX_QUEUE(sk)->next;
+	spin_unlock_bh(TX_QUEUE_LOCK(sk));
 
 	pi->next_tx_seq = pi->expected_ack_seq;
 	ret = l2cap_ertm_send(sk);
@@ -1806,9 +1819,11 @@ static inline int l2cap_sar_segment_sdu(struct sock *sk, struct msghdr *msg, siz
 		len -= buflen;
 		size += buflen;
 	}
+	spin_lock_bh(TX_QUEUE_LOCK(sk));
 	skb_queue_splice_tail(&sar_queue, TX_QUEUE(sk));
 	if (sk->sk_send_head == NULL)
 		sk->sk_send_head = sar_queue.next;
+	spin_unlock_bh(TX_QUEUE_LOCK(sk));
 
 	return size;
 }
@@ -1878,10 +1893,12 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 				err = PTR_ERR(skb);
 				goto done;
 			}
+			spin_lock_bh(TX_QUEUE_LOCK(sk));
 			__skb_queue_tail(TX_QUEUE(sk), skb);
 
 			if (sk->sk_send_head == NULL)
 				sk->sk_send_head = skb;
+			spin_unlock_bh(TX_QUEUE_LOCK(sk));
 
 		} else {
 		/* Segment SDU into multiples PDUs */
-- 
1.6.3.3

