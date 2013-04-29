Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/13] Bluetooth: Rename L2CAP_CID_LE_DATA to L2CAP_CID_ATT
Date: Mon, 29 Apr 2013 19:35:35 +0300
Message-Id: <1367253345-12482-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
References: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In future Core Specification versions the ATT CID will be just one of
many possible CIDs that can be used for data transfer. Therefore, it
makes sense to rename the define for the ATT CID to something less
ambigous.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h |    2 +-
 net/bluetooth/l2cap_core.c    |   14 +++++++-------
 net/bluetooth/l2cap_sock.c    |    4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 2f52a28..c31ac21 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -247,7 +247,7 @@ struct l2cap_conn_rsp {
 #define L2CAP_CID_SIGNALING	0x0001
 #define L2CAP_CID_CONN_LESS	0x0002
 #define L2CAP_CID_A2MP		0x0003
-#define L2CAP_CID_LE_DATA	0x0004
+#define L2CAP_CID_ATT		0x0004
 #define L2CAP_CID_LE_SIGNALING	0x0005
 #define L2CAP_CID_SMP		0x0006
 #define L2CAP_CID_DYN_START	0x0040
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6bf5d19..d5e4404 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -504,8 +504,8 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 		if (conn->hcon->type == LE_LINK) {
 			/* LE connection */
 			chan->omtu = L2CAP_DEFAULT_MTU;
-			chan->scid = L2CAP_CID_LE_DATA;
-			chan->dcid = L2CAP_CID_LE_DATA;
+			chan->scid = L2CAP_CID_ATT;
+			chan->dcid = L2CAP_CID_ATT;
 		} else {
 			/* Alloc CID for connection-oriented socket */
 			chan->scid = l2cap_alloc_cid(conn);
@@ -1344,7 +1344,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	BT_DBG("");
 
 	/* Check if we have socket listening on cid */
-	pchan = l2cap_global_chan_by_scid(BT_LISTEN, L2CAP_CID_LE_DATA,
+	pchan = l2cap_global_chan_by_scid(BT_LISTEN, L2CAP_CID_ATT,
 					  conn->src, conn->dst);
 	if (!pchan)
 		return;
@@ -1792,7 +1792,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 
 	auth_type = l2cap_get_auth_type(chan);
 
-	if (chan->dcid == L2CAP_CID_LE_DATA)
+	if (chan->dcid == L2CAP_CID_ATT)
 		hcon = hci_connect(hdev, LE_LINK, dst, dst_type,
 				   chan->sec_level, auth_type);
 	else
@@ -6360,7 +6360,7 @@ static void l2cap_att_channel(struct l2cap_conn *conn,
 {
 	struct l2cap_chan *chan;
 
-	chan = l2cap_global_chan_by_scid(0, L2CAP_CID_LE_DATA,
+	chan = l2cap_global_chan_by_scid(0, L2CAP_CID_ATT,
 					 conn->src, conn->dst);
 	if (!chan)
 		goto drop;
@@ -6411,7 +6411,7 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		l2cap_conless_channel(conn, psm, skb);
 		break;
 
-	case L2CAP_CID_LE_DATA:
+	case L2CAP_CID_ATT:
 		l2cap_att_channel(conn, skb);
 		break;
 
@@ -6537,7 +6537,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			continue;
 		}
 
-		if (chan->scid == L2CAP_CID_LE_DATA) {
+		if (chan->scid == L2CAP_CID_ATT) {
 			if (!status && encrypt) {
 				chan->sec_level = hcon->sec_level;
 				l2cap_chan_ready(chan);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 141e7b0..16b3e51 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -466,7 +466,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 static bool l2cap_valid_mtu(struct l2cap_chan *chan, u16 mtu)
 {
 	switch (chan->scid) {
-	case L2CAP_CID_LE_DATA:
+	case L2CAP_CID_ATT:
 		if (mtu < L2CAP_LE_MIN_MTU)
 			return false;
 		break;
@@ -630,7 +630,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		conn = chan->conn;
 
 		/*change security for LE channels */
-		if (chan->scid == L2CAP_CID_LE_DATA) {
+		if (chan->scid == L2CAP_CID_ATT) {
 			if (!conn->hcon->out) {
 				err = -EINVAL;
 				break;
-- 
1.7.10.4

