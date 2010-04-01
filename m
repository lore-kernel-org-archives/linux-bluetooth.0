Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 12/34] Bluetooth: Split l2cap_data_channel_sframe()
Date: Thu,  1 Apr 2010 17:23:30 -0300
Message-Id: <1270153432-6477-13-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1270153432-6477-12-git-send-email-padovan@profusion.mobi>
References: <1270153432-6477-1-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-2-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-3-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-4-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-5-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-6-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-7-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-8-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-9-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-10-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-11-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-12-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Create a function for each type fo S-frame and avoid a lot of nested
code.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |  205 ++++++++++++++++++++++++++++---------------------
 1 files changed, 116 insertions(+), 89 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 12104f4..2f32e91 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3471,120 +3471,147 @@ expected:
 	return 0;
 }
 
-static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, struct sk_buff *skb)
+static inline void l2cap_data_channel_rrframe(struct sock *sk, u16 rx_control)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	u8 tx_seq = __get_reqseq(rx_control);
 
-	BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb->len);
-
-	if (L2CAP_CTRL_FINAL & rx_control) {
-		del_timer(&pi->monitor_timer);
-		if (pi->unacked_frames > 0)
-			__mod_retrans_timer();
-		pi->conn_state &= ~L2CAP_CONN_WAIT_F;
-	}
+	if (rx_control & L2CAP_CTRL_POLL) {
+		l2cap_send_i_or_rr_or_rnr(sk);
+		pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
 
-	switch (rx_control & L2CAP_CTRL_SUPERVISE) {
-	case L2CAP_SUPER_RCV_READY:
-		if (rx_control & L2CAP_CTRL_POLL) {
-			l2cap_send_i_or_rr_or_rnr(sk);
-			pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
-
-		} else if (rx_control & L2CAP_CTRL_FINAL) {
-			pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
-			pi->expected_ack_seq = tx_seq;
-			l2cap_drop_acked_frames(sk);
-
-			if (pi->conn_state & L2CAP_CONN_REJ_ACT)
-				pi->conn_state &= ~L2CAP_CONN_REJ_ACT;
-			else {
-				sk->sk_send_head = TX_QUEUE(sk)->next;
-				pi->next_tx_seq = pi->expected_ack_seq;
-				l2cap_ertm_send(sk);
-			}
+	} else if (rx_control & L2CAP_CTRL_FINAL) {
+		pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+		pi->expected_ack_seq = tx_seq;
+		l2cap_drop_acked_frames(sk);
 
-		} else {
-			pi->expected_ack_seq = tx_seq;
-			l2cap_drop_acked_frames(sk);
+		if (pi->conn_state & L2CAP_CONN_REJ_ACT)
+			pi->conn_state &= ~L2CAP_CONN_REJ_ACT;
+		else {
+			sk->sk_send_head = TX_QUEUE(sk)->next;
+			pi->next_tx_seq = pi->expected_ack_seq;
+			l2cap_ertm_send(sk);
+		}
 
-			if ((pi->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
-			    (pi->unacked_frames > 0))
-				__mod_retrans_timer();
+	} else {
+		pi->expected_ack_seq = tx_seq;
+		l2cap_drop_acked_frames(sk);
 
-			pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
-			if (pi->conn_state & L2CAP_CONN_SREJ_SENT)
-				l2cap_send_ack(pi);
-			else
-				l2cap_ertm_send(sk);
-		}
-		break;
+		if ((pi->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
+				(pi->unacked_frames > 0))
+			__mod_retrans_timer();
 
-	case L2CAP_SUPER_REJECT:
 		pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+		if (pi->conn_state & L2CAP_CONN_SREJ_SENT)
+			l2cap_send_ack(pi);
+		else
+			l2cap_ertm_send(sk);
+	}
+}
 
-		pi->expected_ack_seq = __get_reqseq(rx_control);
-		l2cap_drop_acked_frames(sk);
+static inline void l2cap_data_channel_rejframe(struct sock *sk, u16 rx_control)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	u8 tx_seq = __get_reqseq(rx_control);
 
-		if (rx_control & L2CAP_CTRL_FINAL) {
-			if (pi->conn_state & L2CAP_CONN_REJ_ACT)
-				pi->conn_state &= ~L2CAP_CONN_REJ_ACT;
-			else {
-				sk->sk_send_head = TX_QUEUE(sk)->next;
-				pi->next_tx_seq = pi->expected_ack_seq;
-				l2cap_ertm_send(sk);
-			}
-		} else {
+	pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+
+	pi->expected_ack_seq = __get_reqseq(rx_control);
+	l2cap_drop_acked_frames(sk);
+
+	if (rx_control & L2CAP_CTRL_FINAL) {
+		if (pi->conn_state & L2CAP_CONN_REJ_ACT)
+			pi->conn_state &= ~L2CAP_CONN_REJ_ACT;
+		else {
 			sk->sk_send_head = TX_QUEUE(sk)->next;
 			pi->next_tx_seq = pi->expected_ack_seq;
 			l2cap_ertm_send(sk);
-
-			if (pi->conn_state & L2CAP_CONN_WAIT_F) {
-				pi->srej_save_reqseq = tx_seq;
-				pi->conn_state |= L2CAP_CONN_REJ_ACT;
-			}
 		}
+	} else {
+		sk->sk_send_head = TX_QUEUE(sk)->next;
+		pi->next_tx_seq = pi->expected_ack_seq;
+		l2cap_ertm_send(sk);
 
-		break;
+		if (pi->conn_state & L2CAP_CONN_WAIT_F) {
+			pi->srej_save_reqseq = tx_seq;
+			pi->conn_state |= L2CAP_CONN_REJ_ACT;
+		}
+	}
+}
+static inline void l2cap_data_channel_srejframe(struct sock *sk, u16 rx_control)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	u8 tx_seq = __get_reqseq(rx_control);
 
-	case L2CAP_SUPER_SELECT_REJECT:
-		pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+	pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
 
-		if (rx_control & L2CAP_CTRL_POLL) {
-			pi->expected_ack_seq = tx_seq;
-			l2cap_drop_acked_frames(sk);
-			l2cap_retransmit_frame(sk, tx_seq);
-			l2cap_ertm_send(sk);
-			if (pi->conn_state & L2CAP_CONN_WAIT_F) {
-				pi->srej_save_reqseq = tx_seq;
-				pi->conn_state |= L2CAP_CONN_SREJ_ACT;
-			}
-		} else if (rx_control & L2CAP_CTRL_FINAL) {
-			if ((pi->conn_state & L2CAP_CONN_SREJ_ACT) &&
-					pi->srej_save_reqseq == tx_seq)
-				pi->conn_state &= ~L2CAP_CONN_SREJ_ACT;
-			else
-				l2cap_retransmit_frame(sk, tx_seq);
+	if (rx_control & L2CAP_CTRL_POLL) {
+		pi->expected_ack_seq = tx_seq;
+		l2cap_drop_acked_frames(sk);
+		l2cap_retransmit_frame(sk, tx_seq);
+		l2cap_ertm_send(sk);
+		if (pi->conn_state & L2CAP_CONN_WAIT_F) {
+			pi->srej_save_reqseq = tx_seq;
+			pi->conn_state |= L2CAP_CONN_SREJ_ACT;
 		}
-		else {
+	} else if (rx_control & L2CAP_CTRL_FINAL) {
+		if ((pi->conn_state & L2CAP_CONN_SREJ_ACT) &&
+				pi->srej_save_reqseq == tx_seq)
+			pi->conn_state &= ~L2CAP_CONN_SREJ_ACT;
+		else
 			l2cap_retransmit_frame(sk, tx_seq);
-			if (pi->conn_state & L2CAP_CONN_WAIT_F) {
-				pi->srej_save_reqseq = tx_seq;
-				pi->conn_state |= L2CAP_CONN_SREJ_ACT;
-			}
+	}
+	else {
+		l2cap_retransmit_frame(sk, tx_seq);
+		if (pi->conn_state & L2CAP_CONN_WAIT_F) {
+			pi->srej_save_reqseq = tx_seq;
+			pi->conn_state |= L2CAP_CONN_SREJ_ACT;
 		}
+	}
+}
+
+static inline void l2cap_data_channel_rnrframe(struct sock *sk, u16 rx_control)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	u8 tx_seq = __get_reqseq(rx_control);
+
+	pi->conn_state |= L2CAP_CONN_REMOTE_BUSY;
+	pi->expected_ack_seq = tx_seq;
+	l2cap_drop_acked_frames(sk);
+
+	del_timer(&pi->retrans_timer);
+	if (rx_control & L2CAP_CTRL_POLL) {
+		u16 control = L2CAP_CTRL_FINAL;
+		l2cap_send_rr_or_rnr(pi, control);
+	}
+}
+
+static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, struct sk_buff *skb)
+{
+	BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb->len);
+
+	if (L2CAP_CTRL_FINAL & rx_control) {
+		del_timer(&l2cap_pi(sk)->monitor_timer);
+		if (l2cap_pi(sk)->unacked_frames > 0)
+			__mod_retrans_timer();
+		l2cap_pi(sk)->conn_state &= ~L2CAP_CONN_WAIT_F;
+	}
+
+	switch (rx_control & L2CAP_CTRL_SUPERVISE) {
+	case L2CAP_SUPER_RCV_READY:
+		l2cap_data_channel_rrframe(sk, rx_control);
 		break;
 
-	case L2CAP_SUPER_RCV_NOT_READY:
-		pi->conn_state |= L2CAP_CONN_REMOTE_BUSY;
-		pi->expected_ack_seq = tx_seq;
-		l2cap_drop_acked_frames(sk);
+	case L2CAP_SUPER_REJECT:
+		l2cap_data_channel_rejframe(sk, rx_control);
+		break;
 
-		del_timer(&pi->retrans_timer);
-		if (rx_control & L2CAP_CTRL_POLL) {
-			u16 control = L2CAP_CTRL_FINAL;
-			l2cap_send_rr_or_rnr(pi, control);
-		}
+	case L2CAP_SUPER_SELECT_REJECT:
+		l2cap_data_channel_srejframe(sk, rx_control);
+		break;
+
+	case L2CAP_SUPER_RCV_NOT_READY:
+		l2cap_data_channel_rnrframe(sk, rx_control);
 		break;
 	}
 
-- 
1.6.4.4
