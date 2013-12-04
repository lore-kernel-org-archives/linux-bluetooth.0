Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 31/31] Bluetooth: Add debugfs controls for LE CoC MPS and Credits
Date: Wed,  4 Dec 2013 16:11:27 +0200
Message-Id: <1386166287-13693-32-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
References: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds entries to debugfs to control the values used for the
MPS and Credits for LE Flow Control Mode.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ccfee0194a2b..abcd17220706 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -49,6 +49,9 @@ static u8 l2cap_fixed_chan[8] = { L2CAP_FC_L2CAP | L2CAP_FC_CONNLESS, };
 static LIST_HEAD(chan_list);
 static DEFINE_RWLOCK(chan_list_lock);
 
+static u16 le_max_credits = L2CAP_LE_MAX_CREDITS;
+static u16 le_default_mps = L2CAP_LE_DEFAULT_MPS;
+
 static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 				       u8 code, u8 ident, u16 dlen, void *data);
 static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
@@ -501,7 +504,7 @@ void l2cap_le_flowctl_init(struct l2cap_chan *chan)
 	chan->omtu = L2CAP_LE_MIN_MTU;
 	chan->mode = L2CAP_MODE_LE_FLOWCTL;
 	chan->tx_credits = 0;
-	chan->rx_credits = L2CAP_LE_MAX_CREDITS;
+	chan->rx_credits = le_max_credits;
 
 	if (chan->imtu < L2CAP_LE_DEFAULT_MPS)
 		chan->mps = chan->imtu;
@@ -1214,7 +1217,7 @@ static void l2cap_le_flowctl_start(struct l2cap_chan *chan)
 	if (chan->imtu < L2CAP_LE_DEFAULT_MPS)
 		chan->mps = chan->imtu;
 	else
-		chan->mps = L2CAP_LE_DEFAULT_MPS;
+		chan->mps = le_default_mps;
 
 	skb_queue_head_init(&chan->tx_q);
 
@@ -6829,10 +6832,10 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 	/* We return more credits to the sender only after the amount of
 	 * credits falls below half of the initial amount.
 	 */
-	if (chan->rx_credits >= L2CAP_LE_MAX_CREDITS / 2)
+	if (chan->rx_credits >= le_max_credits / 2)
 		return;
 
-	return_credits = L2CAP_LE_MAX_CREDITS - chan->rx_credits;
+	return_credits = le_max_credits - chan->rx_credits;
 
 	BT_DBG("chan %p returning %u credits to sender", chan, return_credits);
 
@@ -7446,6 +7449,11 @@ int __init l2cap_init(void)
 	l2cap_debugfs = debugfs_create_file("l2cap", 0444, bt_debugfs,
 					    NULL, &l2cap_debugfs_fops);
 
+	debugfs_create_u16("l2cap_le_max_credits", 0444, bt_debugfs,
+			   &le_max_credits);
+	debugfs_create_u16("l2cap_le_default_mps", 0444, bt_debugfs,
+			   &le_default_mps);
+
 	return 0;
 }
 
-- 
1.8.4.2

