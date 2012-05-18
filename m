Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org,
	ulisses@profusion.mobi
Cc: pkrystad@codeaurora.org
Subject: [PATCH 03/25] Bluetooth: Refactor l2cap_streaming_send
Date: Thu, 17 May 2012 20:53:33 -0700
Message-Id: <1337313235-26535-4-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
References: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This new implementation uses struct l2cap_ctrl to compose the
streaming mode headers.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   48 ++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a131403..93c7e67 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1647,29 +1647,45 @@ static void l2cap_drop_acked_frames(struct l2cap_chan *chan)
 		__clear_retrans_timer(chan);
 }
 
-static void l2cap_streaming_send(struct l2cap_chan *chan)
+static int l2cap_streaming_send(struct l2cap_chan *chan,
+				struct sk_buff_head *skbs)
 {
 	struct sk_buff *skb;
-	u32 control;
-	u16 fcs;
+	struct l2cap_ctrl *control;
 
-	while ((skb = skb_dequeue(&chan->tx_q))) {
-		control = __get_control(chan, skb->data + L2CAP_HDR_SIZE);
-		control |= __set_txseq(chan, chan->next_tx_seq);
-		control |= __set_ctrl_sar(chan, bt_cb(skb)->control.sar);
-		__put_control(chan, control, skb->data + L2CAP_HDR_SIZE);
+	BT_DBG("chan %p, skbs %p", chan, skbs);
+
+	if (chan->state != BT_CONNECTED)
+		return -ENOTCONN;
+
+	skb_queue_splice_tail_init(skbs, &chan->tx_q);
+
+	while (!skb_queue_empty(&chan->tx_q)) {
+
+		skb = skb_dequeue(&chan->tx_q);
+
+		bt_cb(skb)->control.retries = 1;
+		control = &bt_cb(skb)->control;
+
+		control->reqseq = 0;
+		control->txseq = chan->next_tx_seq;
+
+		__pack_control(chan, control, skb);
 
 		if (chan->fcs == L2CAP_FCS_CRC16) {
-			fcs = crc16(0, (u8 *)skb->data,
-						skb->len - L2CAP_FCS_SIZE);
-			put_unaligned_le16(fcs,
-					skb->data + skb->len - L2CAP_FCS_SIZE);
+			u16 fcs = crc16(0, (u8 *) skb->data, skb->len);
+			put_unaligned_le16(fcs, skb_put(skb, L2CAP_FCS_SIZE));
 		}
 
 		l2cap_do_send(chan, skb);
 
+		BT_DBG("Sent txseq %d", (int)control->txseq);
+
 		chan->next_tx_seq = __next_seq(chan, chan->next_tx_seq);
+		chan->frames_sent++;
 	}
+
+	return 0;
 }
 
 static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u16 tx_seq)
@@ -2133,13 +2149,11 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 		if (err)
 			break;
 
-		if (chan->mode == L2CAP_MODE_ERTM) {
+		if (chan->mode == L2CAP_MODE_ERTM)
 			err = l2cap_tx(chan, 0, &seg_queue,
 				       L2CAP_EV_DATA_REQUEST);
-		} else {
-			skb_queue_splice_tail_init(&seg_queue, &chan->tx_q);
-			l2cap_streaming_send(chan);
-		}
+		else
+			err = l2cap_streaming_send(chan, &seg_queue);
 
 		if (!err)
 			err = len;
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
