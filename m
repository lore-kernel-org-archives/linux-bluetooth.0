Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: L2CAP: Derive rx credits from MTU and MPS
Date: Tue,  4 Sep 2018 13:39:21 +0300
Message-Id: <20180904103922.25504-3-luiz.dentz@gmail.com>
In-Reply-To: <20180904103922.25504-1-luiz.dentz@gmail.com>
References: <20180904103922.25504-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Give enough rx credits for a full packet instead of using an arbitrary
number which may not be enough depending on the MTU and MPS which can
cause interruptions while waiting for more credits, also remove
debugfs entry for l2cap_le_max_credits.

With these changes the credits are restored after each SDU is received
instead of using fixed threshold, this way it is garanteed that there
will always be enough credits to send a packet without waiting more
credits to arrive.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h |  2 --
 net/bluetooth/l2cap_core.c    | 42 ++++++++++++++++++++++-------------
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 17296675a0b1..3555440e14fc 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -455,8 +455,6 @@ struct l2cap_conn_param_update_rsp {
 #define L2CAP_CONN_PARAM_ACCEPTED	0x0000
 #define L2CAP_CONN_PARAM_REJECTED	0x0001
 
-#define L2CAP_LE_MAX_CREDITS		10
-
 struct l2cap_le_conn_req {
 	__le16     psm;
 	__le16     scid;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8a60db6261f7..3fb2d757df88 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -51,8 +51,6 @@ static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN | L2CAP_FEAT_UCD;
 static LIST_HEAD(chan_list);
 static DEFINE_RWLOCK(chan_list_lock);
 
-static u16 le_max_credits = L2CAP_LE_MAX_CREDITS;
-
 static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 				       u8 code, u8 ident, u16 dlen, void *data);
 static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
@@ -518,9 +516,10 @@ static void l2cap_le_flowctl_init(struct l2cap_chan *chan)
 	chan->sdu_last_frag = NULL;
 	chan->sdu_len = 0;
 	chan->tx_credits = 0;
-	chan->rx_credits = le_max_credits;
 	/* Derive MPS from connection MTU to stop HCI fragmentation */
 	chan->mps = min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_SIZE);
+	/* Give enough credits for a full packet */
+	chan->rx_credits = (chan->imtu / chan->mps) + 1;
 
 	skb_queue_head_init(&chan->tx_q);
 }
@@ -6702,13 +6701,10 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 	struct l2cap_le_credits pkt;
 	u16 return_credits;
 
-	/* We return more credits to the sender only after the amount of
-	 * credits falls below half of the initial amount.
-	 */
-	if (chan->rx_credits >= (le_max_credits + 1) / 2)
-		return;
+	return_credits = ((chan->imtu / chan->mps) + 1) - chan->rx_credits;
 
-	return_credits = le_max_credits - chan->rx_credits;
+	if (!return_credits)
+		return;
 
 	BT_DBG("chan %p returning %u credits to sender", chan, return_credits);
 
@@ -6722,6 +6718,21 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 	l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CREDITS, sizeof(pkt), &pkt);
 }
 
+static int l2cap_le_recv(struct l2cap_chan *chan, struct sk_buff *skb)
+{
+	int err;
+
+	BT_DBG("SDU reassemble complete: chan %p skb->len %u", chan, skb->len);
+
+	/* Wait recv to confirm reception before updating the credits */
+	err = chan->ops->recv(chan, skb);
+
+	/* Update credits whenever an SDU is received */
+	l2cap_chan_le_send_credits(chan);
+
+	return err;
+}
+
 static int l2cap_le_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	int err;
@@ -6740,7 +6751,11 @@ static int l2cap_le_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 	chan->rx_credits--;
 	BT_DBG("rx_credits %u -> %u", chan->rx_credits + 1, chan->rx_credits);
 
-	l2cap_chan_le_send_credits(chan);
+	/* Update if remote had run out of credits, this should only happens
+	 * if the remote is not using the entire MPS.
+	 */
+	if (!chan->rx_credits)
+		l2cap_chan_le_send_credits(chan);
 
 	err = 0;
 
@@ -6766,7 +6781,7 @@ static int l2cap_le_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 		}
 
 		if (skb->len == sdu_len)
-			return chan->ops->recv(chan, skb);
+			return l2cap_le_recv(chan, skb);
 
 		chan->sdu = skb;
 		chan->sdu_len = sdu_len;
@@ -6788,7 +6803,7 @@ static int l2cap_le_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 	skb = NULL;
 
 	if (chan->sdu->len == chan->sdu_len) {
-		err = chan->ops->recv(chan, chan->sdu);
+		err = l2cap_le_recv(chan, chan->sdu);
 		if (!err) {
 			chan->sdu = NULL;
 			chan->sdu_last_frag = NULL;
@@ -7647,9 +7662,6 @@ int __init l2cap_init(void)
 	l2cap_debugfs = debugfs_create_file("l2cap", 0444, bt_debugfs,
 					    NULL, &l2cap_debugfs_fops);
 
-	debugfs_create_u16("l2cap_le_max_credits", 0644, bt_debugfs,
-			   &le_max_credits);
-
 	return 0;
 }
 
-- 
2.17.1
