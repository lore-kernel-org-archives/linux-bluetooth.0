Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <ulrik.lauren@stericsson.com>, <kanak.gupta@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/5] Bluetooth: Refactor loop in l2cap_retransmit_one_frame
Date: Wed, 16 Nov 2011 09:32:20 +0100
Message-ID: <1321432342-8606-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1321432342-8606-1-git-send-email-szymon.janc@tieto.com>
References: <1321432342-8606-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This make it easier to see what is the real reason for loop to exit.
skb_queue_next return valid skb or garbage, not NULL.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/l2cap_core.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bd65b3e..26925a8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1318,14 +1318,12 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u16 tx_seq)
 	if (!skb)
 		return;
 
-	do {
-		if (bt_cb(skb)->tx_seq == tx_seq)
-			break;
-
+	while (bt_cb(skb)->tx_seq != tx_seq) {
 		if (skb_queue_is_last(&chan->tx_q, skb))
 			return;
 
-	} while ((skb = skb_queue_next(&chan->tx_q, skb)));
+		skb = skb_queue_next(&chan->tx_q, skb);
+	}
 
 	if (chan->remote_max_tx &&
 			bt_cb(skb)->retries == chan->remote_max_tx) {
-- 
on behalf of ST-Ericsson

