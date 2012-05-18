Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org,
	ulisses@profusion.mobi
Cc: pkrystad@codeaurora.org
Subject: [PATCH 09/25] Bluetooth: Refactor l2cap_send_ack
Date: Thu, 17 May 2012 20:53:39 -0700
Message-Id: <1337313235-26535-10-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
References: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

The function now encapsulates more of the logic to either immediately
send an ack if the transmit window is over 75% full, or wait for the
ack timer to expire if the transmit window is not full enough.  It is
also able to push out waiting iframes that can carry an
acknowledgement.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   68 ++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ce8bffd..9c3f51c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1769,28 +1769,54 @@ static int l2cap_retransmit_frames(struct l2cap_chan *chan)
 	return ret;
 }
 
-static void __l2cap_send_ack(struct l2cap_chan *chan)
-{
-	u32 control = 0;
-
-	control |= __set_reqseq(chan, chan->buffer_seq);
-
-	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
-		control |= __set_ctrl_super(chan, L2CAP_SUPER_RNR);
-		set_bit(CONN_RNR_SENT, &chan->conn_state);
-		return;
-	}
-
-	if (l2cap_ertm_send(chan) > 0)
-		return;
-
-	control |= __set_ctrl_super(chan, L2CAP_SUPER_RR);
-}
-
 static void l2cap_send_ack(struct l2cap_chan *chan)
 {
-	__clear_ack_timer(chan);
-	__l2cap_send_ack(chan);
+	struct l2cap_ctrl control;
+	u16 frames_to_ack = __seq_offset(chan, chan->buffer_seq,
+					 chan->last_acked_seq);
+	int threshold;
+
+	BT_DBG("chan %p last_acked_seq %d buffer_seq %d",
+	       chan, chan->last_acked_seq, chan->buffer_seq);
+
+	memset(&control, 0, sizeof(control));
+	control.sframe = 1;
+
+	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state) &&
+	    chan->rx_state == L2CAP_RX_STATE_RECV) {
+		__clear_ack_timer(chan);
+		control.super = L2CAP_SUPER_RNR;
+		control.reqseq = chan->buffer_seq;
+		l2cap_send_sframe(chan, &control);
+	} else {
+		if (!test_bit(CONN_REMOTE_BUSY, &chan->conn_state)) {
+			l2cap_ertm_send(chan);
+			/* If any i-frames were sent, they included an ack */
+			if (chan->buffer_seq == chan->last_acked_seq)
+				frames_to_ack = 0;
+		}
+
+		/* Ack now if the tx window is 3/4ths full.
+		 * Calculate without mul or div
+		 */
+		threshold = chan->tx_win;
+		threshold += threshold << 1;
+		threshold >>= 2;
+
+		BT_DBG("frames_to_ack %d, threshold %d", (int)frames_to_ack,
+		       threshold);
+
+		if (frames_to_ack >= threshold) {
+			__clear_ack_timer(chan);
+			control.super = L2CAP_SUPER_RR;
+			control.reqseq = chan->buffer_seq;
+			l2cap_send_sframe(chan, &control);
+			frames_to_ack = 0;
+		}
+
+		if (frames_to_ack)
+			__set_ack_timer(chan);
+	}
 }
 
 static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
@@ -2536,7 +2562,7 @@ static void l2cap_ack_timeout(struct work_struct *work)
 
 	l2cap_chan_lock(chan);
 
-	__l2cap_send_ack(chan);
+	l2cap_send_ack(chan);
 
 	l2cap_chan_unlock(chan);
 
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
