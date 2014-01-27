Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Fix disconnecting L2CAP channel for credits violation
Date: Mon, 27 Jan 2014 15:11:34 -0800
Message-Id: <1390864295-4259-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1390864295-4259-1-git-send-email-johan.hedberg@gmail.com>
References: <1390864295-4259-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The L2CAP specification requires us to disconnect a channel if the
remote device sends us data when it doesn't have any credits to do so.
This patch makes sure that we send the appropriate L2CAP Disconnect
request in this situation.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5a30fc72f4ba..fbc9709abccf 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6635,6 +6635,7 @@ static int l2cap_le_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 
 	if (!chan->rx_credits) {
 		BT_ERR("No credits to receive LE L2CAP data");
+		l2cap_send_disconn_req(chan, ECONNRESET);
 		return -ENOBUFS;
 	}
 
-- 
1.8.5.3

