Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 19/31] Bluetooth: Implement returning of LE L2CAP credits
Date: Wed,  4 Dec 2013 16:11:15 +0200
Message-Id: <1386166287-13693-20-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
References: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We should return credits to the remote side whenever they fall below a
certain level (in our case under half of the initially given amount).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8a1c528908fb..b99bdc53c57b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2542,8 +2542,10 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 	}
 
 	switch (chan->mode) {
-	case L2CAP_MODE_BASIC:
 	case L2CAP_MODE_LE_FLOWCTL:
+		chan->tx_credits--;
+		/* fall through */
+	case L2CAP_MODE_BASIC:
 		/* Check outgoing MTU */
 		if (len > chan->omtu)
 			return -EMSGSIZE;
@@ -6608,6 +6610,32 @@ drop:
 	return 0;
 }
 
+static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
+{
+	struct l2cap_conn *conn = chan->conn;
+	struct l2cap_le_credits pkt;
+	u16 return_credits;
+
+	/* We return more credits to the sender only after the amount of
+	 * credits falls below half of the initial amount.
+	 */
+	if (chan->rx_credits >= L2CAP_LE_MAX_CREDITS / 2)
+		return;
+
+	return_credits = L2CAP_LE_MAX_CREDITS - chan->rx_credits;
+
+	BT_DBG("chan %p returning %u credits to sender", chan, return_credits);
+
+	chan->rx_credits += return_credits;
+
+	pkt.cid     = cpu_to_le16(chan->scid);
+	pkt.credits = cpu_to_le16(return_credits);
+
+	chan->ident = l2cap_get_ident(conn);
+
+	l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CREDITS, sizeof(pkt), &pkt);
+}
+
 static void l2cap_data_channel(struct l2cap_conn *conn, u16 cid,
 			       struct sk_buff *skb)
 {
@@ -6638,6 +6666,9 @@ static void l2cap_data_channel(struct l2cap_conn *conn, u16 cid,
 
 	switch (chan->mode) {
 	case L2CAP_MODE_LE_FLOWCTL:
+		chan->rx_credits--;
+		l2cap_chan_le_send_credits(chan);
+		/* fall through */
 	case L2CAP_MODE_BASIC:
 		/* If socket recv buffers overflows we drop data here
 		 * which is *bad* because L2CAP has to be reliable.
-- 
1.8.4.2

