Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 20/31] Bluetooth: Add LE flow control discipline
Date: Wed,  4 Dec 2013 16:11:16 +0200
Message-Id: <1386166287-13693-21-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
References: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds the necessary discipline for reacting to LE L2CAP
Credits packets, sending those packets, and modifying the known credits
accordingly.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 68 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b99bdc53c57b..fd3804dc8ca6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2543,7 +2543,9 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 
 	switch (chan->mode) {
 	case L2CAP_MODE_LE_FLOWCTL:
-		chan->tx_credits--;
+		if (!chan->tx_credits)
+			return -EAGAIN;
+
 		/* fall through */
 	case L2CAP_MODE_BASIC:
 		/* Check outgoing MTU */
@@ -5551,6 +5553,42 @@ response:
 	return 0;
 }
 
+static inline int l2cap_le_credits(struct l2cap_conn *conn,
+				   struct l2cap_cmd_hdr *cmd, u16 cmd_len,
+				   u8 *data)
+{
+	struct l2cap_le_credits *pkt;
+	struct l2cap_chan *chan;
+	u16 cid, credits;
+
+	if (cmd_len != sizeof(*pkt))
+		return -EPROTO;
+
+	pkt = (struct l2cap_le_credits *) data;
+	cid	= __le16_to_cpu(pkt->cid);
+	credits	= __le16_to_cpu(pkt->credits);
+
+	BT_DBG("cid 0x%4.4x credits 0x%4.4x", cid, credits);
+
+	chan = l2cap_get_chan_by_dcid(conn, cid);
+	if (!chan)
+		return -EBADSLT;
+
+	chan->tx_credits += credits;
+
+	while (chan->tx_credits && !skb_queue_empty(&chan->tx_q)) {
+		l2cap_do_send(chan, skb_dequeue(&chan->tx_q));
+		chan->tx_credits--;
+	}
+
+	if (chan->tx_credits)
+		chan->ops->resume(chan);
+
+	l2cap_chan_unlock(chan);
+
+	return 0;
+}
+
 static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 				   struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				   u8 *data)
@@ -5576,6 +5614,10 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 		err = l2cap_le_connect_req(conn, cmd, cmd_len, data);
 		break;
 
+	case L2CAP_LE_CREDITS:
+		err = l2cap_le_credits(conn, cmd, cmd_len, data);
+		break;
+
 	case L2CAP_DISCONN_REQ:
 		err = l2cap_disconnect_req(conn, cmd, cmd_len, data);
 		break;
@@ -6636,6 +6678,22 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 	l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CREDITS, sizeof(pkt), &pkt);
 }
 
+static int l2cap_le_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
+{
+	if (!chan->rx_credits)
+		return -ENOBUFS;
+
+	if (chan->imtu < skb->len)
+		return -ENOBUFS;
+
+	chan->rx_credits--;
+	BT_DBG("rx_credits %u -> %u", chan->rx_credits + 1, chan->rx_credits);
+
+	l2cap_chan_le_send_credits(chan);
+
+	return chan->ops->recv(chan, skb);
+}
+
 static void l2cap_data_channel(struct l2cap_conn *conn, u16 cid,
 			       struct sk_buff *skb)
 {
@@ -6666,9 +6724,11 @@ static void l2cap_data_channel(struct l2cap_conn *conn, u16 cid,
 
 	switch (chan->mode) {
 	case L2CAP_MODE_LE_FLOWCTL:
-		chan->rx_credits--;
-		l2cap_chan_le_send_credits(chan);
-		/* fall through */
+		if (l2cap_le_data_rcv(chan, skb) < 0)
+			goto drop;
+
+		goto done;
+
 	case L2CAP_MODE_BASIC:
 		/* If socket recv buffers overflows we drop data here
 		 * which is *bad* because L2CAP has to be reliable.
-- 
1.8.4.2

