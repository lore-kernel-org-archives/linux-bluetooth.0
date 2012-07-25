Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	Andrei.Emeltchenko.news@gmail.com
Cc: pkrystad@codeaurora.org
Subject: [RFCv0 06/21] Bluetooth: Channel move request handling
Date: Wed, 25 Jul 2012 16:50:58 -0700
Message-Id: <1343260274-11953-7-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 93 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 176a81d..b71d62f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -974,6 +974,37 @@ static void l2cap_send_conn_req(struct l2cap_chan *chan)
 
 	l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_REQ, sizeof(req), &req);
 }
+static void l2cap_move_setup(struct l2cap_chan *chan)
+{
+	struct sk_buff *skb;
+
+	BT_DBG("chan %p", chan);
+
+	__clear_retrans_timer(chan);
+	__clear_monitor_timer(chan);
+	__clear_ack_timer(chan);
+
+	chan->retry_count = 0;
+	skb_queue_walk(&chan->tx_q, skb) {
+		if (bt_cb(skb)->control.retries)
+			bt_cb(skb)->control.retries = 1;
+		else
+			break;
+	}
+
+	chan->expected_tx_seq = chan->buffer_seq;
+
+	clear_bit(CONN_REJ_ACT, &chan->conn_state);
+	clear_bit(CONN_SREJ_ACT, &chan->conn_state);
+	l2cap_seq_list_clear(&chan->retrans_list);
+	l2cap_seq_list_clear(&chan->srej_list);
+	skb_queue_purge(&chan->srej_q);
+
+	chan->tx_state = L2CAP_TX_STATE_XMIT;
+	chan->rx_state = L2CAP_RX_STATE_MOVE;
+
+	set_bit(CONN_REMOTE_BUSY, &chan->conn_state);
+}
 
 static void l2cap_chan_ready(struct l2cap_chan *chan)
 {
@@ -4117,7 +4148,67 @@ static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
 
 	chan = l2cap_get_chan_by_dcid(conn, icid);
 
-	/* Placeholder: Always refuse */
+	if (!chan)
+		goto send_move_response;
+
+	if (chan->scid < L2CAP_CID_DYN_START || (chan->mode != L2CAP_MODE_ERTM
+	    && chan->mode != L2CAP_MODE_STREAMING))
+		goto send_move_response;
+
+	if (chan->chan_id == req->dest_amp_id) {
+		result = L2CAP_MR_SAME_ID;
+		goto send_move_response;
+	}
+
+	if (req->dest_amp_id) {
+		struct hci_dev *hdev;
+		hdev = hci_dev_get(req->dest_amp_id);
+		if (!hdev || !test_bit(HCI_UP, &hdev->flags)) {
+			if (hdev)
+				hci_dev_put(hdev);
+
+			result = L2CAP_MR_BAD_ID;
+			goto send_move_response;
+		}
+		hci_dev_put(hdev);
+	}
+
+	if (((chan->move_state != L2CAP_MOVE_STABLE &&
+	    chan->move_state != L2CAP_MOVE_WAIT_PREPARE) ||
+	    chan->move_role != L2CAP_MOVE_ROLE_NONE) &&
+	    bacmp(conn->src, conn->dst) > 0) {
+		result = L2CAP_MR_COLLISION;
+		goto send_move_response;
+	}
+
+	if (chan->chan_policy == BT_CHANNEL_POLICY_BREDR_ONLY) {
+		result = L2CAP_MR_NOT_ALLOWED;
+		goto send_move_response;
+	}
+
+	chan->move_cmd_ident = cmd->ident;
+	chan->move_role = L2CAP_MOVE_ROLE_RESPONDER;
+	l2cap_move_setup(chan);
+	chan->move_id = req->dest_amp_id;
+	icid = chan->dcid;
+
+	if (req->dest_amp_id == 0) {
+		/* Moving to BR/EDR */
+		if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
+			chan->move_state = L2CAP_MOVE_WAIT_LOCAL_BUSY;
+			result = L2CAP_MR_PEND;
+		} else {
+			chan->move_state = L2CAP_MOVE_WAIT_CONFIRM;
+			result = L2CAP_MR_SUCCESS;
+		}
+	} else {
+		chan->move_state = L2CAP_MOVE_WAIT_PREPARE;
+		/* Placeholder - uncomment when amp functions are available */
+		/*amp_accept_physical(chan, req->dest_amp_id);*/
+		result = L2CAP_MR_PEND;
+	}
+
+send_move_response:
 	l2cap_send_move_chan_rsp(conn, cmd->ident, icid, result);
 
 	if (chan)
-- 
1.7.11.2

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
