Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	Andrei.Emeltchenko.news@gmail.com
Cc: pkrystad@codeaurora.org
Subject: [RFCv0 07/21] Bluetooth: Add new ERTM receive states for channel move
Date: Wed, 25 Jul 2012 16:50:59 -0700
Message-Id: <1343260274-11953-8-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 107 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b71d62f..a327f02 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -974,6 +974,7 @@ static void l2cap_send_conn_req(struct l2cap_chan *chan)
 
 	l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_REQ, sizeof(req), &req);
 }
+
 static void l2cap_move_setup(struct l2cap_chan *chan)
 {
 	struct sk_buff *skb;
@@ -5145,6 +5146,106 @@ static int l2cap_rx_state_srej_sent(struct l2cap_chan *chan,
 	return err;
 }
 
+static int l2cap_finish_move(struct l2cap_chan *chan)
+{
+	int err = 0;
+
+	BT_DBG("chan %p", chan);
+
+	chan->move_role = L2CAP_MOVE_ROLE_NONE;
+	chan->rx_state = L2CAP_RX_STATE_RECV;
+
+	if (chan->hs_hcon)
+		chan->conn->mtu = chan->hs_hcon->hdev->acl_mtu;
+	else
+		chan->conn->mtu = chan->conn->hcon->hdev->acl_mtu;
+
+	/* Placeholder - resegment based on new conn->mtu */
+	/*err = l2cap_resegment(chan);*/
+
+	return err;
+}
+
+static int l2cap_rx_state_wait_p(struct l2cap_chan *chan, 
+				 struct l2cap_ctrl *control,
+				 struct sk_buff *skb, u8 event)
+{
+	int err = -EPROTO;
+
+	BT_DBG("chan %p, control %p, skb %p, event %d", chan, control, skb,
+	       event);
+
+	if (!control->poll)
+		return err;
+
+	l2cap_process_reqseq(chan, control->reqseq);
+
+	if (!skb_queue_empty(&chan->tx_q))
+		chan->tx_send_head = skb_peek(&chan->tx_q);
+	else
+		chan->tx_send_head = NULL;
+
+	/* Rewind next_tx_seq to the point expected
+	 * by the receiver.
+	 */
+	chan->next_tx_seq = control->reqseq;
+	chan->unacked_frames = 0;
+
+	err = l2cap_finish_move(chan);
+
+	if (err)
+		return err;
+
+	set_bit(CONN_SEND_FBIT, &chan->conn_state);
+	l2cap_send_i_or_rr_or_rnr(chan);
+
+	if (event == L2CAP_EV_RECV_IFRAME)
+		err = -EPROTO;
+	else
+		err = l2cap_rx_state_recv(chan, control, NULL, event);
+
+	return err;
+}
+
+static int l2cap_rx_state_wait_f(struct l2cap_chan *chan,
+				 struct l2cap_ctrl *control,
+				 struct sk_buff *skb, u8 event)
+{
+	int err = -EPROTO;
+
+	if (control->final) {
+		clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
+		chan->move_role = L2CAP_MOVE_ROLE_NONE;
+
+		chan->rx_state = L2CAP_RX_STATE_RECV;
+		l2cap_process_reqseq(chan, control->reqseq);
+
+		if (!skb_queue_empty(&chan->tx_q))
+			chan->tx_send_head = skb_peek(&chan->tx_q);
+		else
+			chan->tx_send_head = NULL;
+
+		/* Rewind next_tx_seq to the point expected
+		 * by the receiver.
+		 */
+		chan->next_tx_seq = control->reqseq;
+		chan->unacked_frames = 0;
+
+		if (chan->hs_hcon)
+			chan->conn->mtu = chan->hs_hcon->hdev->acl_mtu;
+		else
+			chan->conn->mtu = chan->conn->hcon->hdev->acl_mtu;
+
+		/* Placeholder - resegment based on new conn->mtu */
+		/*err = l2cap_resegment(chan);*/
+
+		if (!err)
+			err = l2cap_rx_state_recv(chan, control, skb, event);
+	}
+
+	return err;
+}
+
 static bool __valid_reqseq(struct l2cap_chan *chan, u16 reqseq)
 {
 	/* Make sure reqseq is for a packet that has been sent but not acked */
@@ -5171,6 +5272,12 @@ static int l2cap_rx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
 			err = l2cap_rx_state_srej_sent(chan, control, skb,
 						       event);
 			break;
+		case L2CAP_RX_STATE_WAIT_P:
+			err = l2cap_rx_state_wait_p(chan, control, skb, event);
+			break;
+		case L2CAP_RX_STATE_WAIT_F:
+			err = l2cap_rx_state_wait_f(chan, control, skb, event);
+			break;
 		default:
 			/* shut it down */
 			break;
-- 
1.7.11.2

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
