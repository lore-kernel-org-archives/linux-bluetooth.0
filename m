Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix test for lookup_dev return value
Date: Thu, 12 Dec 2013 09:53:21 +0200
Message-Id: <1386834801-1635-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386834801-1635-1-git-send-email-johan.hedberg@gmail.com>
References: <1386834801-1635-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The condition wouldn't have previously caused -ENOENT to be returned if
dev was NULL. The proper condition should be if (!dev || !dev->netdev).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/6lowpan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 3cbb1d14c304..5ad8b483efa3 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -330,7 +330,7 @@ int bt_6lowpan_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 		return -ENOENT;
 
 	dev = lookup_dev(conn);
-	if (dev && !dev->netdev)
+	if (!dev || !dev->netdev)
 		return -ENOENT;
 
 	err = recv_pkt(skb, dev->netdev, conn);
-- 
1.8.4.2

