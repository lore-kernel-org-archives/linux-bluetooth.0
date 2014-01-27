Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Fix disconnecting L2CAP when a credits overflow occurs
Date: Mon, 27 Jan 2014 15:11:35 -0800
Message-Id: <1390864295-4259-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1390864295-4259-1-git-send-email-johan.hedberg@gmail.com>
References: <1390864295-4259-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The L2CAP specification requires us to disconnect an L2CAP channel if
the remote side gives us credits beyond 65535. This patch makes sure we
disconnect the channel in such a situation.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fbc9709abccf..d2ef49b54aa2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -42,6 +42,8 @@
 #include "amp.h"
 #include "6lowpan.h"
 
+#define LE_FLOWCTL_MAX_CREDITS 65535
+
 bool disable_ertm;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN | L2CAP_FEAT_UCD;
@@ -5473,7 +5475,7 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
 {
 	struct l2cap_le_credits *pkt;
 	struct l2cap_chan *chan;
-	u16 cid, credits;
+	u16 cid, credits, max_credits;
 
 	if (cmd_len != sizeof(*pkt))
 		return -EPROTO;
@@ -5488,6 +5490,17 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
 	if (!chan)
 		return -EBADSLT;
 
+	max_credits = LE_FLOWCTL_MAX_CREDITS - chan->tx_credits;
+	if (credits > max_credits) {
+		BT_ERR("LE credits overflow");
+		l2cap_send_disconn_req(chan, ECONNRESET);
+
+		/* Return 0 so that we don't trigger an unnecessary
+		 * command reject packet.
+		 */
+		return 0;
+	}
+
 	chan->tx_credits += credits;
 
 	while (chan->tx_credits && !skb_queue_empty(&chan->tx_q)) {
-- 
1.8.5.3

