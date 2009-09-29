Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 4/7] Bluetooth: send ReqSeq on I-frames
Date: Tue, 29 Sep 2009 01:42:26 -0300
Message-Id: <1254199349-19713-4-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1254199349-19713-3-git-send-email-gustavo@las.ic.unicamp.br>
References: <1254199349-19713-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1254199349-19713-2-git-send-email-gustavo@las.ic.unicamp.br>
 <1254199349-19713-3-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

A ERTM channel can acknowledge received I-frames by sending a I-frame with
the proper ReqSeq value (i.e. ReqSeq is set to ExpectedTxSeq).

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 include/net/bluetooth/l2cap.h |    1 -
 net/bluetooth/l2cap.c         |    8 ++++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 9516f4b..327eb57 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -324,7 +324,6 @@ struct l2cap_pinfo {
 
 	__u8		next_tx_seq;
 	__u8		expected_ack_seq;
-	__u8		req_seq;
 	__u8		expected_tx_seq;
 	__u8		buffer_seq;
 	__u8		buffer_seq_srej;
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 658e27c..ed245c4 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1329,7 +1329,7 @@ static int l2cap_retransmit_frame(struct sock *sk, u8 tx_seq)
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
 		bt_cb(skb)->retries++;
 		control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
-		control |= (pi->req_seq << L2CAP_CTRL_REQSEQ_SHIFT)
+		control |= (pi->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT)
 				| (tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
 		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
@@ -1371,7 +1371,7 @@ static int l2cap_ertm_send(struct sock *sk)
 		bt_cb(skb)->retries++;
 
 		control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
-		control |= (pi->req_seq << L2CAP_CTRL_REQSEQ_SHIFT)
+		control |= (pi->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT)
 				| (pi->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
 		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
@@ -3288,12 +3288,16 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	u8 tx_seq = __get_txseq(rx_control);
+	u8 req_seq = __get_reqseq(rx_control);
 	u16 tx_control = 0;
 	u8 sar = rx_control >> L2CAP_CTRL_SAR_SHIFT;
 	int err = 0;
 
 	BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb->len);
 
+	pi->expected_ack_seq = req_seq;
+	l2cap_drop_acked_frames(sk);
+
 	if (tx_seq == pi->expected_tx_seq)
 		goto expected;
 
-- 
1.6.3.3
