Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 11/14] Bluetooth: Fix handle of received P-bit
Date: Sat,  5 Jun 2010 04:50:15 -0300
Message-Id: <1275724218-29453-12-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275724218-29453-11-git-send-email-gustavo@padovan.org>
References: <1275724218-29453-1-git-send-email-gustavo@padovan.org>
 <1275724218-29453-2-git-send-email-gustavo@padovan.org>
 <1275724218-29453-3-git-send-email-gustavo@padovan.org>
 <1275724218-29453-4-git-send-email-gustavo@padovan.org>
 <1275724218-29453-5-git-send-email-gustavo@padovan.org>
 <1275724218-29453-6-git-send-email-gustavo@padovan.org>
 <1275724218-29453-7-git-send-email-gustavo@padovan.org>
 <1275724218-29453-8-git-send-email-gustavo@padovan.org>
 <1275724218-29453-9-git-send-email-gustavo@padovan.org>
 <1275724218-29453-10-git-send-email-gustavo@padovan.org>
 <1275724218-29453-11-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

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
1.7.1
