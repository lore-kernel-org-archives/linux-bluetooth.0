Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	marcel@holtmann.org
Cc: pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Subject: [RFC 2/8] Bluetooth: Initialize new l2cap_chan structure members
Date: Wed, 25 Apr 2012 16:36:13 -0700
Message-Id: <1335396979-11692-3-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
References: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Structure members used by ERTM or streaming mode need to be
initialized when an ERTM or streaming mode link is configured.  Some
duplicate code is also eliminated by moving in to the ERTM init
function.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index beb7194..35c0a29 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2315,17 +2315,30 @@ static inline int l2cap_ertm_init(struct l2cap_chan *chan)
 {
 	int err;
 
+	chan->next_tx_seq = 0;
+	chan->expected_tx_seq = 0;
 	chan->expected_ack_seq = 0;
 	chan->unacked_frames = 0;
 	chan->buffer_seq = 0;
 	chan->num_acked = 0;
 	chan->frames_sent = 0;
+	chan->last_acked_seq = 0;
+	chan->sdu = NULL;
+	chan->sdu_last_frag = NULL;
+	chan->sdu_len = 0;
+
+	if (chan->mode != L2CAP_MODE_ERTM)
+		return 0;
+
+	chan->rx_state = L2CAP_RX_STATE_RECV;
+	chan->tx_state = L2CAP_TX_STATE_XMIT;
 
 	INIT_DELAYED_WORK(&chan->retrans_timer, l2cap_retrans_timeout);
 	INIT_DELAYED_WORK(&chan->monitor_timer, l2cap_monitor_timeout);
 	INIT_DELAYED_WORK(&chan->ack_timer, l2cap_ack_timeout);
 
 	skb_queue_head_init(&chan->srej_q);
+	skb_queue_head_init(&chan->tx_q);
 
 	INIT_LIST_HEAD(&chan->srej_l);
 	err = l2cap_seq_list_init(&chan->srej_list, chan->tx_win);
@@ -3193,10 +3206,8 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 		l2cap_state_change(chan, BT_CONNECTED);
 
-		chan->next_tx_seq = 0;
-		chan->expected_tx_seq = 0;
-		skb_queue_head_init(&chan->tx_q);
-		if (chan->mode == L2CAP_MODE_ERTM)
+		if (chan->mode == L2CAP_MODE_ERTM ||
+					chan->mode == L2CAP_MODE_STREAMING)
 			err = l2cap_ertm_init(chan);
 
 		if (err < 0)
@@ -3328,10 +3339,8 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		set_default_fcs(chan);
 
 		l2cap_state_change(chan, BT_CONNECTED);
-		chan->next_tx_seq = 0;
-		chan->expected_tx_seq = 0;
-		skb_queue_head_init(&chan->tx_q);
-		if (chan->mode ==  L2CAP_MODE_ERTM)
+		if (chan->mode ==  L2CAP_MODE_ERTM ||
+					chan->mode == L2CAP_MODE_STREAMING)
 			err = l2cap_ertm_init(chan);
 
 		if (err < 0)
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
