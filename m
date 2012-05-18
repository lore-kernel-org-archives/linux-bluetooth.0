Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org,
	ulisses@profusion.mobi
Cc: pkrystad@codeaurora.org
Subject: [PATCH 15/25] Bluetooth: Reassemble all available data when retransmissions succeed.
Date: Thu, 17 May 2012 20:53:45 -0700
Message-Id: <1337313235-26535-16-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
References: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

As retransmitted packets arrive, attempt to reassemble SDUs.  If all
requested retransmissions have been received, acknowledge them and
transition back to the RECV state.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4efab1b..7091f64 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4501,8 +4501,36 @@ void l2cap_chan_busy(struct l2cap_chan *chan, int busy)
 
 static int l2cap_rx_queued_iframes(struct l2cap_chan *chan)
 {
-	/* Placeholder */
-	return 0;
+	int err = 0;
+	/* Pass sequential frames to l2cap_reassemble_sdu()
+	 * until a gap is encountered.
+	 */
+
+	BT_DBG("chan %p", chan);
+
+	while (!test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
+		struct sk_buff *skb;
+		BT_DBG("Searching for skb with txseq %d (queue len %d)",
+		       chan->buffer_seq, skb_queue_len(&chan->srej_q));
+
+		skb = l2cap_ertm_seq_in_queue(&chan->srej_q, chan->buffer_seq);
+
+		if (!skb)
+			break;
+
+		skb_unlink(skb, &chan->srej_q);
+		chan->buffer_seq = __next_seq(chan, chan->buffer_seq);
+		err = l2cap_reassemble_sdu(chan, skb, &bt_cb(skb)->control);
+		if (err)
+			break;
+	}
+
+	if (skb_queue_empty(&chan->srej_q)) {
+		chan->rx_state = L2CAP_RX_STATE_RECV;
+		l2cap_send_ack(chan);
+	}
+
+	return err;
 }
 
 static void l2cap_handle_srej(struct l2cap_chan *chan,
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
