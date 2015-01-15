Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Add helpers for src/dst bdaddr type conversion
Date: Thu, 15 Jan 2015 13:06:44 +0200
Message-Id: <1421320005-26037-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The current bdaddr_type() usage in l2cap_core.c is a bit funny in that
it's always passed a hci_conn + a hci_conn member. Because of this only
the hci_conn is really needed. Since the second parameter is always
either hcon->src_type or hcon->dst type this patch adds two helper
functions for each purpose: bdaddr_src_type() and bdaddr_dst_type().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4e7477d34eb8..b080133010e2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -63,10 +63,10 @@ static void l2cap_send_disconn_req(struct l2cap_chan *chan, int err);
 static void l2cap_tx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
 		     struct sk_buff_head *skbs, u8 event);
 
-static inline __u8 bdaddr_type(struct hci_conn *hcon, __u8 type)
+static inline u8 bdaddr_type(u8 link_type, u8 bdaddr_type)
 {
-	if (hcon->type == LE_LINK) {
-		if (type == ADDR_LE_DEV_PUBLIC)
+	if (link_type == LE_LINK) {
+		if (bdaddr_type == ADDR_LE_DEV_PUBLIC)
 			return BDADDR_LE_PUBLIC;
 		else
 			return BDADDR_LE_RANDOM;
@@ -75,6 +75,16 @@ static inline __u8 bdaddr_type(struct hci_conn *hcon, __u8 type)
 	return BDADDR_BREDR;
 }
 
+static inline u8 bdaddr_src_type(struct hci_conn *hcon)
+{
+	return bdaddr_type(hcon->type, hcon->src_type);
+}
+
+static inline u8 bdaddr_dst_type(struct hci_conn *hcon)
+{
+	return bdaddr_type(hcon->type, hcon->dst_type);
+}
+
 /* ---- L2CAP channels ---- */
 
 static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
@@ -646,7 +656,7 @@ static void l2cap_conn_update_id_addr(struct work_struct *work)
 	list_for_each_entry(chan, &conn->chan_l, list) {
 		l2cap_chan_lock(chan);
 		bacpy(&chan->dst, &hcon->dst);
-		chan->dst_type = bdaddr_type(hcon, hcon->dst_type);
+		chan->dst_type = bdaddr_dst_type(hcon);
 		l2cap_chan_unlock(chan);
 	}
 
@@ -3790,8 +3800,8 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 
 	bacpy(&chan->src, &conn->hcon->src);
 	bacpy(&chan->dst, &conn->hcon->dst);
-	chan->src_type = bdaddr_type(conn->hcon, conn->hcon->src_type);
-	chan->dst_type = bdaddr_type(conn->hcon, conn->hcon->dst_type);
+	chan->src_type = bdaddr_src_type(conn->hcon);
+	chan->dst_type = bdaddr_dst_type(conn->hcon);
 	chan->psm  = psm;
 	chan->dcid = scid;
 	chan->local_amp_id = amp_id;
@@ -5441,8 +5451,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 
 	bacpy(&chan->src, &conn->hcon->src);
 	bacpy(&chan->dst, &conn->hcon->dst);
-	chan->src_type = bdaddr_type(conn->hcon, conn->hcon->src_type);
-	chan->dst_type = bdaddr_type(conn->hcon, conn->hcon->dst_type);
+	chan->src_type = bdaddr_src_type(conn->hcon);
+	chan->dst_type = bdaddr_dst_type(conn->hcon);
 	chan->psm  = psm;
 	chan->dcid = scid;
 	chan->omtu = mtu;
@@ -6881,7 +6891,7 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 	 */
 	if (hcon->type == LE_LINK &&
 	    hci_bdaddr_list_lookup(&hcon->hdev->blacklist, &hcon->dst,
-				   bdaddr_type(hcon, hcon->dst_type))) {
+				   bdaddr_dst_type(hcon))) {
 		kfree_skb(skb);
 		return;
 	}
@@ -7123,7 +7133,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 
 	/* Update source addr of the socket */
 	bacpy(&chan->src, &hcon->src);
-	chan->src_type = bdaddr_type(hcon, hcon->src_type);
+	chan->src_type = bdaddr_src_type(hcon);
 
 	__l2cap_chan_add(conn, chan);
 
@@ -7246,7 +7256,7 @@ void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 	if (!conn)
 		return;
 
-	dst_type = bdaddr_type(hcon, hcon->dst_type);
+	dst_type = bdaddr_dst_type(hcon);
 
 	/* If device is blocked, do not create channels for it */
 	if (hci_bdaddr_list_lookup(&hdev->blacklist, &hcon->dst, dst_type))
@@ -7270,7 +7280,7 @@ void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 		if (chan) {
 			bacpy(&chan->src, &hcon->src);
 			bacpy(&chan->dst, &hcon->dst);
-			chan->src_type = bdaddr_type(hcon, hcon->src_type);
+			chan->src_type = bdaddr_src_type(hcon);
 			chan->dst_type = dst_type;
 
 			__l2cap_chan_add(conn, chan);
-- 
2.1.0

