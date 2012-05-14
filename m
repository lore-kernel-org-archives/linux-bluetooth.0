Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: pkrystad@codeaurora.org
Subject: [PATCH] Bluetooth: Initialize the transmit queue for L2CAP streaming mode
Date: Mon, 14 May 2012 14:49:27 -0700
Message-Id: <1337032167-30454-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Commit 105bdf9ec19e729bacdb33861c74fcf3eb39eb37 introduced a
regression in L2CAP streaming mode due to rearranged initialization
code that is shared between ERTM and streaming mode.  This change
makes sure the transmit queue is initialized in both modes.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 869beb3..7adfcec 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2349,6 +2349,8 @@ static inline int l2cap_ertm_init(struct l2cap_chan *chan)
 	chan->sdu_last_frag = NULL;
 	chan->sdu_len = 0;
 
+	skb_queue_head_init(&chan->tx_q);
+
 	if (chan->mode != L2CAP_MODE_ERTM)
 		return 0;
 
@@ -2360,7 +2362,6 @@ static inline int l2cap_ertm_init(struct l2cap_chan *chan)
 	INIT_DELAYED_WORK(&chan->ack_timer, l2cap_ack_timeout);
 
 	skb_queue_head_init(&chan->srej_q);
-	skb_queue_head_init(&chan->tx_q);
 
 	INIT_LIST_HEAD(&chan->srej_l);
 	err = l2cap_seq_list_init(&chan->srej_list, chan->tx_win);
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
