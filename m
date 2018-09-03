Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: L2CAP: Detect if remote is not able to use the whole MPS
Date: Mon,  3 Sep 2018 20:12:17 +0300
Message-Id: <20180903171217.4408-3-luiz.dentz@gmail.com>
In-Reply-To: <20180903171217.4408-1-luiz.dentz@gmail.com>
References: <20180903171217.4408-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the remote is not able to fully utilize the MPS choosen recalculate
the credits based on the actual amount it is sending that way it can
still send packets of MTU size without credits dropping to 0.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3fb2d757df88..79226374c0d8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6787,6 +6787,14 @@ static int l2cap_le_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 		chan->sdu_len = sdu_len;
 		chan->sdu_last_frag = skb;
 
+		/* Detect if remote is not able to use the selected MPS */
+		if (skb->len < chan->mps) {
+			/* Adjust the number of credits */
+			BT_DBG("chan->mps %u -> %u", chan->mps, skb->len);
+			chan->mps = skb->len;
+			l2cap_chan_le_send_credits(chan);
+		}
+
 		return 0;
 	}
 
-- 
2.17.1
