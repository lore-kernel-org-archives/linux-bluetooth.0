Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Correct chan->psm endian conversions
Date: Fri,  9 Mar 2012 14:16:17 +0200
Message-Id: <1331295377-6097-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

chan->psm is kept in __le16 format which was not always taken
into account. Fix several bugs related to extra conversion.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0d00a6d..6679167 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -307,7 +307,7 @@ void l2cap_chan_destroy(struct l2cap_chan *chan)
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 {
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
-			chan->psm, chan->dcid);
+			__le16_to_cpu(chan->psm), chan->dcid);
 
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
@@ -1182,7 +1182,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
 	int err;
 
 	BT_DBG("%s -> %s psm 0x%2.2x", batostr(src), batostr(dst),
-							chan->psm);
+						__le16_to_cpu(chan->psm));
 
 	hdev = hci_get_route(dst, src);
 	if (!hdev)
@@ -1647,7 +1647,7 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
 	lh->cid = cpu_to_le16(chan->dcid);
 	lh->len = cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
-	put_unaligned_le16(chan->psm, skb_put(skb, 2));
+	put_unaligned(chan->psm, skb_put(skb, 2));
 
 	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
 	if (unlikely(err < 0)) {
@@ -2679,7 +2679,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
 	__le16 psm = req->psm;
 
-	BT_DBG("psm 0x%2.2x scid 0x%4.4x", psm, scid);
+	BT_DBG("psm 0x%2.2x scid 0x%4.4x", __le16_to_cpu(psm), scid);
 
 	/* Check if we have socket listening on psm */
 	pchan = l2cap_global_chan_by_psm(BT_LISTEN, psm, conn->src);
@@ -4484,7 +4484,7 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		break;
 
 	case L2CAP_CID_CONN_LESS:
-		psm = get_unaligned_le16(skb->data);
+		psm = get_unaligned((__le16 *) skb->data);
 		skb_pull(skb, 2);
 		l2cap_conless_channel(conn, psm, skb);
 		break;
-- 
1.7.9

