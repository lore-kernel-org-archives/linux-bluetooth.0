Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>,
	<kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] Bluetooth: Fix possible missing I-Frame acknowledgement
Date: Tue, 7 Feb 2012 15:43:01 +0100
Message-ID: <1328625782-19624-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make l2cap_ertm_send return number of pending I-Frames transmitted
instead of all (pending + retransmitted) I-Frames transmitted.

As only pending I-Frames are considered as acknowledgement, this could
lead to situation when no ACK was sent in __l2cap_send_ack (if only
already transmitted I-Frames were retransmitted).

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/l2cap_core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 09cd860..5bb298d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1448,8 +1448,10 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 
 		chan->next_tx_seq = __next_seq(chan, chan->next_tx_seq);
 
-		if (bt_cb(skb)->retries == 1)
+		if (bt_cb(skb)->retries == 1) {
 			chan->unacked_frames++;
+			nsent++;
+		}
 
 		chan->frames_sent++;
 
@@ -1457,8 +1459,6 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 			chan->tx_send_head = NULL;
 		else
 			chan->tx_send_head = skb_queue_next(&chan->tx_q, skb);
-
-		nsent++;
 	}
 
 	return nsent;
-- 
on behalf of ST-Ericsson

