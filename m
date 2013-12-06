Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Use min_t for calculating chan->imtu
Date: Fri,  6 Dec 2013 07:01:54 +0200
Message-Id: <1386306115-30686-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since there's a nice convenient helper for calculating the minimum of
two values, let's use that one.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6e6f308af036..8f42cae96dc3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -505,11 +505,7 @@ static void l2cap_le_flowctl_init(struct l2cap_chan *chan)
 	chan->sdu_len = 0;
 	chan->tx_credits = 0;
 	chan->rx_credits = le_max_credits;
-
-	if (chan->imtu < L2CAP_LE_DEFAULT_MPS)
-		chan->mps = chan->imtu;
-	else
-		chan->mps = L2CAP_LE_DEFAULT_MPS;
+	chan->imtu = min_t(u16, chan->imtu, L2CAP_LE_DEFAULT_MPS);
 
 	skb_queue_head_init(&chan->tx_q);
 }
-- 
1.8.4.2

