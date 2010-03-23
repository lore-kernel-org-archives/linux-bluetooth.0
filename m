Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi, ulisses@profusion.mobi
Subject: [PATCH 10/19] Bluetooth: Use a l2cap_pinfo struct instead l2cap_pi() macro
Date: Tue, 23 Mar 2010 16:48:37 -0300
Message-Id: <1269373726-13209-11-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269373726-13209-10-git-send-email-padovan@profusion.mobi>
References: <1269373726-13209-1-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-2-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-3-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-4-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-5-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-6-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-7-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-8-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-9-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-10-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Trivial clean up.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 4dd130d..428be03 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1300,7 +1300,7 @@ static int l2cap_streaming_send(struct sock *sk)
 		control |= pi->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT;
 		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
-		if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16) {
+		if (pi->fcs == L2CAP_FCS_CRC16) {
 			fcs = crc16(0, (u8 *)tx_skb->data, tx_skb->len - 2);
 			put_unaligned_le16(fcs, tx_skb->data + tx_skb->len - 2);
 		}
@@ -1353,7 +1353,7 @@ static int l2cap_retransmit_frame(struct sock *sk, u8 tx_seq)
 				| (tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
 		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
-		if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16) {
+		if (pi->fcs == L2CAP_FCS_CRC16) {
 			fcs = crc16(0, (u8 *)tx_skb->data, tx_skb->len - 2);
 			put_unaligned_le16(fcs, tx_skb->data + tx_skb->len - 2);
 		}
@@ -1401,7 +1401,7 @@ static int l2cap_ertm_send(struct sock *sk)
 		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
 
-		if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16) {
+		if (pi->fcs == L2CAP_FCS_CRC16) {
 			fcs = crc16(0, (u8 *)skb->data, tx_skb->len - 2);
 			put_unaligned_le16(fcs, skb->data + tx_skb->len - 2);
 		}
@@ -3576,10 +3576,10 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 		pi->expected_ack_seq = tx_seq;
 		l2cap_drop_acked_frames(sk);
 
-		del_timer(&l2cap_pi(sk)->retrans_timer);
+		del_timer(&pi->retrans_timer);
 		if (rx_control & L2CAP_CTRL_POLL) {
 			u16 control = L2CAP_CTRL_FINAL;
-			l2cap_send_rr_or_rnr(l2cap_pi(sk), control);
+			l2cap_send_rr_or_rnr(pi, control);
 		}
 		break;
 	}
@@ -3688,7 +3688,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		goto done;
 
 	default:
-		BT_DBG("sk %p: bad mode 0x%2.2x", sk, l2cap_pi(sk)->mode);
+		BT_DBG("sk %p: bad mode 0x%2.2x", sk, pi->mode);
 		break;
 	}
 
-- 
1.6.4.4
