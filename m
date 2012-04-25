Return-Path: <cyrus@holtmann.org>
From: Manoj <manojkr.sharma@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Anurag Gupta <anurag.gupta@stericsson.com>,
	Manoj <manojkr.sharma@stericsson.com>
Subject: [PATCH 1/2] Bluetooth: Fix L2CAP ERTM packet queue corruption
Date: Wed, 25 Apr 2012 13:59:03 +0530
Message-ID: <1335342544-17320-1-git-send-email-manojkr.sharma@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While running in L2CAP ERTM mode, sometimes ERTM packet queue
gets corrupted because though method l2cap_ertm_send() is not
thread-safe, it is called simultaneously from multiple
threads.

Signed-off-by: Manoj <manojkr.sharma@stericsson.com>
---
 net/bluetooth/l2cap_core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 19807c9..a9319e2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1713,6 +1713,7 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 	if (chan->state != BT_CONNECTED)
 		return -ENOTCONN;
 
+	mutex_lock(&chan->conn->chan_lock);
 	while ((skb = chan->tx_send_head) && (!l2cap_tx_window_full(chan))) {
 
 		if (chan->remote_max_tx &&
@@ -1765,7 +1766,7 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 		else
 			chan->tx_send_head = skb_queue_next(&chan->tx_q, skb);
 	}
-
+	mutex_unlock(&chan->conn->chan_lock);
 	return nsent;
 }
 
-- 
1.6.6.1

