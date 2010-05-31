Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: jprvita@profusion.mobi, gustavo@padovan.org, marcel@holtmann.org
Subject: [PATCH 11/11] Bluetooth: Fix handle of received P-bit
Date: Mon, 31 May 2010 16:05:27 -0300
Message-Id: <1275332727-16263-11-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1275332727-16263-10-git-send-email-padovan@profusion.mobi>
References: <1275332727-16263-1-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-2-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-3-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-4-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-5-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-6-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-7-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-8-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-9-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-10-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

This is a protocol error. We shall send a F-bit in response
to any P-bit received.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index e5b766d..f116307 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1420,8 +1420,15 @@ static void l2cap_retransmit_one_frame(struct sock *sk, u8 tx_seq)
 	tx_skb = skb_clone(skb, GFP_ATOMIC);
 	bt_cb(skb)->retries++;
 	control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
+
+	if (pi->conn_state & L2CAP_CONN_SEND_FBIT) {
+		control |= L2CAP_CTRL_FINAL;
+		pi->conn_state &= ~L2CAP_CONN_SEND_FBIT;
+	}
+
 	control |= (pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT)
 			| (tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
+
 	put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
 	if (pi->fcs == L2CAP_FCS_CRC16) {
@@ -3383,7 +3390,6 @@ static inline void l2cap_send_i_or_rr_or_rnr(struct sock *sk)
 	u16 control = 0;
 
 	pi->frames_sent = 0;
-	pi->conn_state |= L2CAP_CONN_SEND_FBIT;
 
 	control |= pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 
@@ -3952,6 +3958,7 @@ static inline void l2cap_data_channel_rrframe(struct sock *sk, u16 rx_control)
 	l2cap_drop_acked_frames(sk);
 
 	if (rx_control & L2CAP_CTRL_POLL) {
+		pi->conn_state |= L2CAP_CONN_SEND_FBIT;
 		if (pi->conn_state & L2CAP_CONN_SREJ_SENT) {
 			if ((pi->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
 					(pi->unacked_frames > 0))
@@ -4019,6 +4026,8 @@ static inline void l2cap_data_channel_srejframe(struct sock *sk, u16 rx_control)
 	if (rx_control & L2CAP_CTRL_POLL) {
 		pi->expected_ack_seq = tx_seq;
 		l2cap_drop_acked_frames(sk);
+
+		pi->conn_state |= L2CAP_CONN_SEND_FBIT;
 		l2cap_retransmit_one_frame(sk, tx_seq);
 
 		spin_lock_bh(&pi->send_lock);
@@ -4053,6 +4062,9 @@ static inline void l2cap_data_channel_rnrframe(struct sock *sk, u16 rx_control)
 	pi->expected_ack_seq = tx_seq;
 	l2cap_drop_acked_frames(sk);
 
+	if (rx_control & L2CAP_CTRL_POLL)
+		pi->conn_state |= L2CAP_CONN_SEND_FBIT;
+
 	if (!(pi->conn_state & L2CAP_CONN_SREJ_SENT)) {
 		del_timer(&pi->retrans_timer);
 		if (rx_control & L2CAP_CTRL_POLL)
-- 
1.6.4.4
