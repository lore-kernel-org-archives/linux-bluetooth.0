Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org,
	ulisses@profusion.mobi
Cc: pkrystad@codeaurora.org
Subject: [PATCH 11/25] Bluetooth: Update l2cap_send_i_or_rr_or_rnr to fit the spec better
Date: Thu, 17 May 2012 20:53:41 -0700
Message-Id: <1337313235-26535-12-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
References: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This action now exactly matches what is defined in the ERTM
specification, including clearing the remote busy flag and setting the
retransmit timer rather than retransmitting frames directly.  The spec
does not retransmit frames as part of this action, since
retransmission is only triggered by REJ, SREJ, or an RR with the final
bit set.  struct l2cap_ctrl is also used to set up header values.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0f130f7..3a10a30 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1757,18 +1757,6 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 	return sent;
 }
 
-static int l2cap_retransmit_frames(struct l2cap_chan *chan)
-{
-	int ret;
-
-	if (!skb_queue_empty(&chan->tx_q))
-		chan->tx_send_head = chan->tx_q.next;
-
-	chan->next_tx_seq = chan->expected_ack_seq;
-	ret = l2cap_ertm_send(chan);
-	return ret;
-}
-
 static void l2cap_send_ack(struct l2cap_chan *chan)
 {
 	struct l2cap_ctrl control;
@@ -4192,25 +4180,35 @@ static int l2cap_check_fcs(struct l2cap_chan *chan,  struct sk_buff *skb)
 
 static inline void l2cap_send_i_or_rr_or_rnr(struct l2cap_chan *chan)
 {
-	u32 control = 0;
+	struct l2cap_ctrl control;
 
-	chan->frames_sent = 0;
+	BT_DBG("chan %p", chan);
 
-	control |= __set_reqseq(chan, chan->buffer_seq);
+	memset(&control, 0, sizeof(control));
+	control.sframe = 1;
+	control.final = 1;
+	control.reqseq = chan->buffer_seq;
+	set_bit(CONN_SEND_FBIT, &chan->conn_state);
 
 	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
-		control |= __set_ctrl_super(chan, L2CAP_SUPER_RNR);
-		set_bit(CONN_RNR_SENT, &chan->conn_state);
+		control.super = L2CAP_SUPER_RNR;
+		l2cap_send_sframe(chan, &control);
 	}
 
-	if (test_bit(CONN_REMOTE_BUSY, &chan->conn_state))
-		l2cap_retransmit_frames(chan);
+	if (test_and_clear_bit(CONN_REMOTE_BUSY, &chan->conn_state) &&
+	    chan->unacked_frames > 0)
+		__set_retrans_timer(chan);
 
+	/* Send pending iframes */
 	l2cap_ertm_send(chan);
 
 	if (!test_bit(CONN_LOCAL_BUSY, &chan->conn_state) &&
-			chan->frames_sent == 0) {
-		control |= __set_ctrl_super(chan, L2CAP_SUPER_RR);
+	    test_bit(CONN_SEND_FBIT, &chan->conn_state)) {
+		/* F-bit wasn't sent in an s-frame or i-frame yet, so
+		 * send it now.
+		 */
+		control.super = L2CAP_SUPER_RR;
+		l2cap_send_sframe(chan, &control);
 	}
 }
 
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
