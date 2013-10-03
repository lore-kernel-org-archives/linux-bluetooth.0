Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix switch statement order for L2CAP fixed channels
Date: Wed,  2 Oct 2013 23:46:54 -0700
Message-Id: <1380782814-35670-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The switch statement for the various L2CAP fixed channel handlers
is not really ordered.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 814563d..0661ca6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6466,9 +6466,6 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 	BT_DBG("len %d, cid 0x%4.4x", len, cid);
 
 	switch (cid) {
-	case L2CAP_CID_LE_SIGNALING:
-		l2cap_le_sig_channel(conn, skb);
-		break;
 	case L2CAP_CID_SIGNALING:
 		l2cap_sig_channel(conn, skb);
 		break;
@@ -6483,6 +6480,10 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		l2cap_att_channel(conn, skb);
 		break;
 
+	case L2CAP_CID_LE_SIGNALING:
+		l2cap_le_sig_channel(conn, skb);
+		break;
+
 	case L2CAP_CID_SMP:
 		if (smp_sig_channel(conn, skb))
 			l2cap_conn_del(conn->hcon, EACCES);
-- 
1.8.3.1

