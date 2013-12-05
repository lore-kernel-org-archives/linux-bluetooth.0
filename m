Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 19/32] Bluetooth: Implement returning of LE L2CAP credits
Date: Thu,  5 Dec 2013 15:11:17 +0200
Message-Id: <1386249090-10236-20-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
References: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We should return credits to the remote side whenever they fall below a
certain level (in our case under half of the initially given amount).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8a1c528908fb..4857c182a3be 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6608,6 +6608,32 @@ drop:
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
+	if (chan->rx_credits >= (L2CAP_LE_MAX_CREDITS + 1) / 2)
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
-- 
1.8.4.2

