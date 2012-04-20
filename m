Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>, Arik Nemtsov <arik@wizery.com>
Subject: [PATCH 1/2] Bluetooth: Search global l2cap channels by src/dst addresses
Date: Fri, 20 Apr 2012 15:46:07 -0300
Message-Id: <1334947568-3437-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ido Yariv <ido@wizery.com>

The cid or psm and the source address might not be enough to uniquely
identify a global channel, especially when the source address is our
own.

For instance, when trying to communicate with two LE devices in master
mode, data received from the both devices is sent to the same socket.

Fix this by taking the destination address into account when choosing
the socket.

Signed-off-by: Ido Yariv <ido@wizery.com>
Signed-off-by: Arik Nemtsov <arik@wizery.com>
Tested-by: João Paulo Rechi Vita <jprvita@openbossa.org>
---
 net/bluetooth/l2cap_core.c |   43 +++++++++++++++++++++++++++++++------------
 1 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 97bb212..23d1fbd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1067,10 +1067,11 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 	mutex_unlock(&conn->chan_lock);
 }
 
-/* Find socket with cid and source bdaddr.
+/* Find socket with cid and source/destination bdaddr.
  * Returns closest match, locked.
  */
-static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid, bdaddr_t *src)
+static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid,
+						bdaddr_t *src, bdaddr_t *dst)
 {
 	struct l2cap_chan *c, *c1 = NULL;
 
@@ -1083,14 +1084,22 @@ static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid, bdaddr_t
 			continue;
 
 		if (c->scid == cid) {
+			int src_match, dst_match;
+			int src_any, dst_any;
+
 			/* Exact match. */
-			if (!bacmp(&bt_sk(sk)->src, src)) {
+			src_match = !bacmp(&bt_sk(sk)->src, src);
+			dst_match = !bacmp(&bt_sk(sk)->dst, dst);
+			if (src_match && dst_match) {
 				read_unlock(&chan_list_lock);
 				return c;
 			}
 
 			/* Closest match */
-			if (!bacmp(&bt_sk(sk)->src, BDADDR_ANY))
+			src_any = !bacmp(&bt_sk(sk)->src, BDADDR_ANY);
+			dst_any = !bacmp(&bt_sk(sk)->dst, BDADDR_ANY);
+			if ((src_match && dst_any) || (src_any && dst_match) ||
+							(src_any && dst_any))
 				c1 = c;
 		}
 	}
@@ -1109,7 +1118,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	/* Check if we have socket listening on cid */
 	pchan = l2cap_global_chan_by_scid(BT_LISTEN, L2CAP_CID_LE_DATA,
-							conn->src);
+							conn->src, conn->dst);
 	if (!pchan)
 		return;
 
@@ -1337,10 +1346,12 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 
 /* ---- Socket interface ---- */
 
-/* Find socket with psm and source bdaddr.
+/* Find socket with psm and source / destination bdaddr.
  * Returns closest match.
  */
-static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm, bdaddr_t *src)
+static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
+							bdaddr_t *src,
+							bdaddr_t *dst)
 {
 	struct l2cap_chan *c, *c1 = NULL;
 
@@ -1353,14 +1364,22 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm, bdaddr
 			continue;
 
 		if (c->psm == psm) {
+			int src_match, dst_match;
+			int src_any, dst_any;
+
 			/* Exact match. */
-			if (!bacmp(&bt_sk(sk)->src, src)) {
+			src_match = !bacmp(&bt_sk(sk)->src, src);
+			dst_match = !bacmp(&bt_sk(sk)->dst, dst);
+			if (src_match && dst_match) {
 				read_unlock(&chan_list_lock);
 				return c;
 			}
 
 			/* Closest match */
-			if (!bacmp(&bt_sk(sk)->src, BDADDR_ANY))
+			src_any = !bacmp(&bt_sk(sk)->src, BDADDR_ANY);
+			dst_any = !bacmp(&bt_sk(sk)->dst, BDADDR_ANY);
+			if ((src_match && dst_any) || (src_any && dst_match) ||
+							(src_any && dst_any))
 				c1 = c;
 		}
 	}
@@ -2887,7 +2906,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	BT_DBG("psm 0x%2.2x scid 0x%4.4x", __le16_to_cpu(psm), scid);
 
 	/* Check if we have socket listening on psm */
-	pchan = l2cap_global_chan_by_psm(BT_LISTEN, psm, conn->src);
+	pchan = l2cap_global_chan_by_psm(BT_LISTEN, psm, conn->src, conn->dst);
 	if (!pchan) {
 		result = L2CAP_CR_BAD_PSM;
 		goto sendresp;
@@ -4627,7 +4646,7 @@ static inline int l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm, str
 {
 	struct l2cap_chan *chan;
 
-	chan = l2cap_global_chan_by_psm(0, psm, conn->src);
+	chan = l2cap_global_chan_by_psm(0, psm, conn->src, conn->dst);
 	if (!chan)
 		goto drop;
 
@@ -4652,7 +4671,7 @@ static inline int l2cap_att_channel(struct l2cap_conn *conn, u16 cid, struct sk_
 {
 	struct l2cap_chan *chan;
 
-	chan = l2cap_global_chan_by_scid(0, cid, conn->src);
+	chan = l2cap_global_chan_by_scid(0, cid, conn->src, conn->dst);
 	if (!chan)
 		goto drop;
 
-- 
1.7.7.6

