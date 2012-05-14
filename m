Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: pkrystad@codeaurora.org
Subject: [PATCH] Bluetooth: Update tx_send_head when sending ERTM data
Date: Mon, 14 May 2012 11:24:33 -0700
Message-Id: <1337019873-27017-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Commit 94122bbe9c8c4ad7ba9f02f9a30bfc95672c404e introduced a problem
where tx_send_head was not set to point to the first skb in the ERTM
transmit queue, which stalled data transmission.  This change sets
that pointer when transmission is not already in progress.

Reported-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2b30bd7..869beb3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2104,7 +2104,10 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 		if (err)
 			break;
 
+		if (chan->mode == L2CAP_MODE_ERTM && chan->tx_send_head == NULL)
+			chan->tx_send_head = seg_queue.next;
 		skb_queue_splice_tail_init(&seg_queue, &chan->tx_q);
+
 		if (chan->mode == L2CAP_MODE_ERTM)
 			err = l2cap_ertm_send(chan);
 		else
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
