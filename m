Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Fix respecting le_default_mps value
Date: Mon, 27 Jan 2014 15:11:33 -0800
Message-Id: <1390864295-4259-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's a le_default_mps variable that can be modified through debugfs
but it was never actually used for determining our MPS value. This patch
fixes the MPS initialization to use the variable instead of a fixed
value.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cc340700573e..5a30fc72f4ba 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -482,7 +482,7 @@ static void l2cap_le_flowctl_init(struct l2cap_chan *chan)
 	chan->sdu_len = 0;
 	chan->tx_credits = 0;
 	chan->rx_credits = le_max_credits;
-	chan->mps = min_t(u16, chan->imtu, L2CAP_LE_DEFAULT_MPS);
+	chan->mps = min_t(u16, chan->imtu, le_default_mps);
 
 	skb_queue_head_init(&chan->tx_q);
 }
-- 
1.8.5.3

