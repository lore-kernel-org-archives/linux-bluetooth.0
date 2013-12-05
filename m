Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 26/32] Bluetooth: Fix suspending the L2CAP socket if we start with 0 credits
Date: Thu,  5 Dec 2013 15:11:24 +0200
Message-Id: <1386249090-10236-27-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
References: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If the peer gives us zero credits in its connection request or response
we must call the suspend channel callback so the BT_SK_SUSPEND flag gets
set and user space is blocked from sending data to the socket.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ddb61564fe6a..b6dc613febd5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1202,6 +1202,9 @@ static void l2cap_le_flowctl_start(struct l2cap_chan *chan)
 	chan->sdu_len = 0;
 
 	skb_queue_head_init(&chan->tx_q);
+
+	if (!chan->tx_credits)
+		chan->ops->suspend(chan);
 }
 
 static void l2cap_chan_ready(struct l2cap_chan *chan)
-- 
1.8.4.2

