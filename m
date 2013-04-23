Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove unneeded parameter from L2CAP ATT channel handling
Date: Tue, 23 Apr 2013 00:59:00 -0700
Message-Id: <1366703940-27816-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The CID is fixed to L2CAP ATT channel and so there is no need to hand it
down to the handling function. Just use a constant instead.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index eae1d9f..a76d1ac 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6314,12 +6314,13 @@ drop:
 	kfree_skb(skb);
 }
 
-static void l2cap_att_channel(struct l2cap_conn *conn, u16 cid,
+static void l2cap_att_channel(struct l2cap_conn *conn,
 			      struct sk_buff *skb)
 {
 	struct l2cap_chan *chan;
 
-	chan = l2cap_global_chan_by_scid(0, cid, conn->src, conn->dst);
+	chan = l2cap_global_chan_by_scid(0, L2CAP_CID_LE_DATA,
+					 conn->src, conn->dst);
 	if (!chan)
 		goto drop;
 
@@ -6368,7 +6369,7 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		break;
 
 	case L2CAP_CID_LE_DATA:
-		l2cap_att_channel(conn, cid, skb);
+		l2cap_att_channel(conn, skb);
 		break;
 
 	case L2CAP_CID_SMP:
-- 
1.8.1.4

