Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/9] Bluetooth: Fix reference counting of global L2CAP channels
Date: Thu,  7 Aug 2014 10:12:23 +0300
Message-Id: <1407395551-30810-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407395551-30810-1-git-send-email-johan.hedberg@gmail.com>
References: <1407395551-30810-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When looking up entries from the global L2CAP channel list there needs
to be a guarantee that other code doesn't go and remove the entry after
a channel has been returned by the lookup function. This patch makes
sure that the channel reference is incremented before the read lock is
released in the global channel lookup functions. The patch also adds the
corresponding l2cap_chan_put() calls once the channels pointers are
no-longer needed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 46547b920f88..a49e9646a6b9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1440,6 +1440,7 @@ static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid,
 			src_match = !bacmp(&c->src, src);
 			dst_match = !bacmp(&c->dst, dst);
 			if (src_match && dst_match) {
+				l2cap_chan_hold(c);
 				read_unlock(&chan_list_lock);
 				return c;
 			}
@@ -1453,6 +1454,9 @@ static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid,
 		}
 	}
 
+	if (c1)
+		l2cap_chan_hold(c1);
+
 	read_unlock(&chan_list_lock);
 
 	return c1;
@@ -1475,13 +1479,13 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	/* Client ATT sockets should override the server one */
 	if (__l2cap_get_chan_by_dcid(conn, L2CAP_CID_ATT))
-		return;
+		goto put;
 
 	dst_type = bdaddr_type(hcon, hcon->dst_type);
 
 	/* If device is blocked, do not create a channel for it */
 	if (hci_bdaddr_list_lookup(&hdev->blacklist, &hcon->dst, dst_type))
-		return;
+		goto put;
 
 	/* For LE slave connections, make sure the connection interval
 	 * is in the range of the minium and maximum interval that has
@@ -1517,6 +1521,8 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 clean:
 	l2cap_chan_unlock(pchan);
+put:
+	l2cap_chan_put(pchan);
 }
 
 static void l2cap_conn_ready(struct l2cap_conn *conn)
@@ -1794,6 +1800,7 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
 			src_match = !bacmp(&c->src, src);
 			dst_match = !bacmp(&c->dst, dst);
 			if (src_match && dst_match) {
+				l2cap_chan_hold(c);
 				read_unlock(&chan_list_lock);
 				return c;
 			}
@@ -1807,6 +1814,9 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
 		}
 	}
 
+	if (c1)
+		l2cap_chan_hold(c1);
+
 	read_unlock(&chan_list_lock);
 
 	return c1;
@@ -3884,6 +3894,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 response:
 	l2cap_chan_unlock(pchan);
 	mutex_unlock(&conn->chan_lock);
+	l2cap_chan_put(pchan);
 
 sendresp:
 	rsp.scid   = cpu_to_le16(scid);
@@ -5497,6 +5508,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 response_unlock:
 	l2cap_chan_unlock(pchan);
 	mutex_unlock(&conn->chan_lock);
+	l2cap_chan_put(pchan);
 
 	if (result == L2CAP_CR_PEND)
 		return 0;
@@ -6844,8 +6856,10 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_chan *chan;
 
-	if (hcon->type != ACL_LINK)
+	if (hcon->type != ACL_LINK) {
+		chan = NULL;
 		goto drop;
+	}
 
 	chan = l2cap_global_chan_by_psm(0, psm, &hcon->src, &hcon->dst,
 					ACL_LINK);
@@ -6865,10 +6879,13 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 	bt_cb(skb)->psm = psm;
 
 	if (!chan->ops->recv(chan, skb))
-		return;
+		goto put;
 
 drop:
 	kfree_skb(skb);
+put:
+	if (chan)
+		l2cap_chan_put(chan);
 }
 
 static void l2cap_att_channel(struct l2cap_conn *conn,
@@ -6877,8 +6894,10 @@ static void l2cap_att_channel(struct l2cap_conn *conn,
 	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_chan *chan;
 
-	if (hcon->type != LE_LINK)
+	if (hcon->type != LE_LINK) {
+		chan = NULL;
 		goto drop;
+	}
 
 	chan = l2cap_global_chan_by_scid(BT_CONNECTED, L2CAP_CID_ATT,
 					 &hcon->src, &hcon->dst);
@@ -6891,10 +6910,13 @@ static void l2cap_att_channel(struct l2cap_conn *conn,
 		goto drop;
 
 	if (!chan->ops->recv(chan, skb))
-		return;
+		goto put;
 
 drop:
 	kfree_skb(skb);
+put:
+	if (chan)
+		l2cap_chan_put(chan);
 }
 
 static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
-- 
1.9.3

