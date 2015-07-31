Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org,
	lukasz.duda@nordicsemi.no, jukka.rissanen@linux.intel.com,
	Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv2 bluetooth-next 1/2] bluetooth: 6lowpan: change netdev_priv to lowpan_dev
Date: Fri, 31 Jul 2015 14:38:07 +0200
Message-Id: <1438346288-14546-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438346288-14546-1-git-send-email-alex.aring@gmail.com>
References: <1438346288-14546-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The usually way to get the btle lowpan private data is to use the
introduced lowpan_dev inline function. This patch will cleanup by using
lowpan_dev consequently.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/bluetooth/6lowpan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 0ffe2e2..24ed5b0 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -859,7 +859,7 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
 	SET_NETDEV_DEV(netdev, &chan->conn->hcon->hdev->dev);
 	SET_NETDEV_DEVTYPE(netdev, &bt_type);
 
-	*dev = netdev_priv(netdev);
+	*dev = lowpan_dev(netdev);
 	(*dev)->netdev = netdev;
 	(*dev)->hdev = chan->conn->hcon->hdev;
 	INIT_LIST_HEAD(&(*dev)->peers);
-- 
2.5.0

