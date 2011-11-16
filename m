Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <ulrik.lauren@stericsson.com>, <kanak.gupta@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/5] Bluetooth: Simplify l2cap_add_to_srej_queue
Date: Wed, 16 Nov 2011 09:32:19 +0100
Message-ID: <1321432342-8606-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1321432342-8606-1-git-send-email-szymon.janc@tieto.com>
References: <1321432342-8606-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make it easier to see what is loop break condition.
skb_queue_next return valid skb or garbage, not NULL.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/l2cap_core.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 276817a..bd65b3e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3562,14 +3562,10 @@ static int l2cap_add_to_srej_queue(struct l2cap_chan *chan, struct sk_buff *skb,
 	bt_cb(skb)->sar = sar;
 
 	next_skb = skb_peek(&chan->srej_q);
-	if (!next_skb) {
-		__skb_queue_tail(&chan->srej_q, skb);
-		return 0;
-	}
 
 	tx_seq_offset = __seq_offset(chan, tx_seq, chan->buffer_seq);
 
-	do {
+	while (next_skb) {
 		if (bt_cb(next_skb)->tx_seq == tx_seq)
 			return -EINVAL;
 
@@ -3582,9 +3578,10 @@ static int l2cap_add_to_srej_queue(struct l2cap_chan *chan, struct sk_buff *skb,
 		}
 
 		if (skb_queue_is_last(&chan->srej_q, next_skb))
-			break;
-
-	} while ((next_skb = skb_queue_next(&chan->srej_q, next_skb)));
+			next_skb = NULL;
+		else
+			next_skb = skb_queue_next(&chan->srej_q, next_skb);
+	}
 
 	__skb_queue_tail(&chan->srej_q, skb);
 
-- 
on behalf of ST-Ericsson

