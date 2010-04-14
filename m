Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi, ulisses@profusion.mobi
Subject: [PATCH 1/7] Bluetooth: Fix bug when retransmitting I-frames
Date: Wed, 14 Apr 2010 16:41:46 -0300
Message-Id: <1271274112-7806-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1271274112-7806-1-git-send-email-padovan@profusion.mobi>
References: <1271274112-7806-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

If there is no frames to retransmit l2cap was crashing the kernel, now
we check if the queue is empty first.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index c699fe9..d38bfc2 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3530,7 +3530,8 @@ expected:
 		if (pi->conn_state & L2CAP_CONN_REJ_ACT)
 			pi->conn_state &= ~L2CAP_CONN_REJ_ACT;
 		else {
-			sk->sk_send_head = TX_QUEUE(sk)->next;
+			if (!skb_queue_empty(TX_QUEUE(sk)))
+				sk->sk_send_head = TX_QUEUE(sk)->next;
 			pi->next_tx_seq = pi->expected_ack_seq;
 			l2cap_ertm_send(sk);
 		}
@@ -3577,7 +3578,8 @@ static inline void l2cap_data_channel_rrframe(struct sock *sk, u16 rx_control)
 		if (pi->conn_state & L2CAP_CONN_REJ_ACT)
 			pi->conn_state &= ~L2CAP_CONN_REJ_ACT;
 		else {
-			sk->sk_send_head = TX_QUEUE(sk)->next;
+			if (!skb_queue_empty(TX_QUEUE(sk)))
+				sk->sk_send_head = TX_QUEUE(sk)->next;
 			pi->next_tx_seq = pi->expected_ack_seq;
 			l2cap_ertm_send(sk);
 		}
@@ -3609,12 +3611,14 @@ static inline void l2cap_data_channel_rejframe(struct sock *sk, u16 rx_control)
 		if (pi->conn_state & L2CAP_CONN_REJ_ACT)
 			pi->conn_state &= ~L2CAP_CONN_REJ_ACT;
 		else {
-			sk->sk_send_head = TX_QUEUE(sk)->next;
+			if (!skb_queue_empty(TX_QUEUE(sk)))
+				sk->sk_send_head = TX_QUEUE(sk)->next;
 			pi->next_tx_seq = pi->expected_ack_seq;
 			l2cap_ertm_send(sk);
 		}
 	} else {
-		sk->sk_send_head = TX_QUEUE(sk)->next;
+		if (!skb_queue_empty(TX_QUEUE(sk)))
+			sk->sk_send_head = TX_QUEUE(sk)->next;
 		pi->next_tx_seq = pi->expected_ack_seq;
 		l2cap_ertm_send(sk);
 
-- 
1.6.4.4
