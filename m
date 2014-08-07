Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix confusion between parent and child channel for 6lowpan
Date: Thu,  7 Aug 2014 10:03:32 +0300
Message-Id: <1407395012-30446-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407395012-30446-1-git-send-email-johan.hedberg@gmail.com>
References: <1407395012-30446-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The new_connection L2CAP channel callback creates a new channel based on
the provided parent channel. The 6lowpan code was confusingly naming the
child channel "pchan" and the parent channel "chan". This patch swaps
the names.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/6lowpan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 206b65ccd5b8..35ebe79c87b0 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -772,16 +772,16 @@ static inline void chan_ready_cb(struct l2cap_chan *chan)
 	ifup(dev->netdev);
 }
 
-static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan *chan)
+static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan *pchan)
 {
-	struct l2cap_chan *pchan;
+	struct l2cap_chan *chan;
 
-	pchan = chan_open(chan);
-	pchan->ops = chan->ops;
+	chan = chan_open(pchan);
+	chan->ops = pchan->ops;
 
 	BT_DBG("chan %p pchan %p", chan, pchan);
 
-	return pchan;
+	return chan;
 }
 
 static void delete_netdev(struct work_struct *work)
-- 
1.9.3

