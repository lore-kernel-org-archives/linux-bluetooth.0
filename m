Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Block ATT connection on LE when device is blocked
Date: Fri, 18 Oct 2013 03:43:01 -0700
Message-Id: <1382092981-48006-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the remote LE device is blocked, then do not create a L2CAP
channel for it. Without a channel, all packets for that connection
will be dropped.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9757297..bf1f34e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1382,14 +1382,16 @@ static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid,
 
 static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 {
+	struct hci_conn *hcon = conn->hcon;
 	struct sock *parent;
 	struct l2cap_chan *chan, *pchan;
+	__u8 dst_type;
 
 	BT_DBG("");
 
 	/* Check if we have socket listening on cid */
 	pchan = l2cap_global_chan_by_scid(BT_LISTEN, L2CAP_CID_ATT,
-					  &conn->hcon->src, &conn->hcon->dst);
+					  &hcon->src, &hcon->dst);
 	if (!pchan)
 		return;
 
@@ -1397,6 +1399,12 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	if (__l2cap_get_chan_by_dcid(conn, L2CAP_CID_ATT))
 		return;
 
+	dst_type = bdaddr_type(hcon, hcon->dst_type);
+
+	/* If device is blocked, do not create a channel for it */
+	if (hci_blacklist_lookup(hcon->hdev, &hcon->dst, dst_type))
+		return;
+
 	parent = pchan->sk;
 
 	lock_sock(parent);
@@ -1407,10 +1415,10 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	chan->dcid = L2CAP_CID_ATT;
 
-	bacpy(&chan->src, &conn->hcon->src);
-	bacpy(&chan->dst, &conn->hcon->dst);
-	chan->src_type = bdaddr_type(conn->hcon, conn->hcon->src_type);
-	chan->dst_type = bdaddr_type(conn->hcon, conn->hcon->dst_type);
+	bacpy(&chan->src, &hcon->src);
+	bacpy(&chan->dst, &hcon->dst);
+	chan->src_type = bdaddr_type(hcon, hcon->src_type);
+	chan->dst_type = dst_type;
 
 	__l2cap_chan_add(conn, chan);
 
@@ -6438,6 +6446,9 @@ static void l2cap_att_channel(struct l2cap_conn *conn,
 
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
+	if (hci_blacklist_lookup(hcon->hdev, &hcon->dst, hcon->dst_type))
+		goto drop;
+
 	if (chan->imtu < skb->len)
 		goto drop;
 
-- 
1.8.3.1

