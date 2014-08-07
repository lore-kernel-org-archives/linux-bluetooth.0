Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/9] Bluetooth: Remove special ATT data channel handling
Date: Thu,  7 Aug 2014 10:12:30 +0300
Message-Id: <1407395551-30810-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407395551-30810-1-git-send-email-johan.hedberg@gmail.com>
References: <1407395551-30810-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that we've got the fixed channel infrastructure cleaned up in a
generic way there's no longer a need to have a dedicated function for
handling data on the ATT channel. Instead the generic
l2cap_data_channel() handler will be able to do the exact same thing.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 80 ----------------------------------------------
 1 file changed, 80 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a1bd591253d5..fbe8c37f1a9e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1420,51 +1420,6 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 	mutex_unlock(&conn->chan_lock);
 }
 
-/* Find socket with cid and source/destination bdaddr.
- * Returns closest match, locked.
- */
-static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid,
-						    bdaddr_t *src,
-						    bdaddr_t *dst)
-{
-	struct l2cap_chan *c, *c1 = NULL;
-
-	read_lock(&chan_list_lock);
-
-	list_for_each_entry(c, &chan_list, global_l) {
-		if (state && c->state != state)
-			continue;
-
-		if (c->scid == cid) {
-			int src_match, dst_match;
-			int src_any, dst_any;
-
-			/* Exact match. */
-			src_match = !bacmp(&c->src, src);
-			dst_match = !bacmp(&c->dst, dst);
-			if (src_match && dst_match) {
-				l2cap_chan_hold(c);
-				read_unlock(&chan_list_lock);
-				return c;
-			}
-
-			/* Closest match */
-			src_any = !bacmp(&c->src, BDADDR_ANY);
-			dst_any = !bacmp(&c->dst, BDADDR_ANY);
-			if ((src_match && dst_any) || (src_any && dst_match) ||
-			    (src_any && dst_any))
-				c1 = c;
-		}
-	}
-
-	if (c1)
-		l2cap_chan_hold(c1);
-
-	read_unlock(&chan_list_lock);
-
-	return c1;
-}
-
 static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 {
 	struct hci_conn *hcon = conn->hcon;
@@ -6855,37 +6810,6 @@ put:
 		l2cap_chan_put(chan);
 }
 
-static void l2cap_att_channel(struct l2cap_conn *conn,
-			      struct sk_buff *skb)
-{
-	struct hci_conn *hcon = conn->hcon;
-	struct l2cap_chan *chan;
-
-	if (hcon->type != LE_LINK) {
-		chan = NULL;
-		goto drop;
-	}
-
-	chan = l2cap_global_chan_by_scid(BT_CONNECTED, L2CAP_CID_ATT,
-					 &hcon->src, &hcon->dst);
-	if (!chan)
-		goto drop;
-
-	BT_DBG("chan %p, len %d", chan, skb->len);
-
-	if (chan->imtu < skb->len)
-		goto drop;
-
-	if (!chan->ops->recv(chan, skb))
-		goto put;
-
-drop:
-	kfree_skb(skb);
-put:
-	if (chan)
-		l2cap_chan_put(chan);
-}
-
 static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct l2cap_hdr *lh = (void *) skb->data;
@@ -6931,10 +6855,6 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		l2cap_conless_channel(conn, psm, skb);
 		break;
 
-	case L2CAP_CID_ATT:
-		l2cap_att_channel(conn, skb);
-		break;
-
 	case L2CAP_CID_LE_SIGNALING:
 		l2cap_le_sig_channel(conn, skb);
 		break;
-- 
1.9.3

