Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/13] Bluetooth: Remove unnecessary L2CAP channel state check
Date: Mon, 29 Apr 2013 19:35:42 +0300
Message-Id: <1367253345-12482-11-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
References: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In l2cap_att_channel() we're only interested in the BT_CONNECTED state
so this state can directly be passed to l2cap_global_chan_by_scid().
This way there's no need to do any additional state check later.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index aa4bc70..e373b9d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6357,16 +6357,13 @@ static void l2cap_att_channel(struct l2cap_conn *conn,
 {
 	struct l2cap_chan *chan;
 
-	chan = l2cap_global_chan_by_scid(0, L2CAP_CID_ATT,
+	chan = l2cap_global_chan_by_scid(BT_CONNECTED, L2CAP_CID_ATT,
 					 conn->src, conn->dst);
 	if (!chan)
 		goto drop;
 
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
-	if (chan->state != BT_BOUND && chan->state != BT_CONNECTED)
-		goto drop;
-
 	if (chan->imtu < skb->len)
 		goto drop;
 
-- 
1.7.10.4

