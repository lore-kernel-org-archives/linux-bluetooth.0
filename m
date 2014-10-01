Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: 6lowpan: Memory leak as the skb is not freed
Date: Wed,  1 Oct 2014 10:00:53 +0300
Message-Id: <1412146853-1968-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The earlier multicast commit 36b3dd250dde ("Bluetooth: 6lowpan:
Ensure header compression does not corrupt IPv6 header") lost one
skb free which then caused memory leak.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index f0432ae..bcbee3d 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -625,6 +625,8 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
 		send_mcast_pkt(skb, netdev);
 	}
 
+	kfree_skb(skb);
+
 	if (err)
 		BT_DBG("ERROR: xmit failed (%d)", err);
 
-- 
1.8.3.1

