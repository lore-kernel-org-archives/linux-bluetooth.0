Return-Path: <stephen@networkplumber.org>
From: Stephen Hemminger <stephen@networkplumber.org>
To: yisen.zhuang@huawei.com,
	salil.mehta@huawei.com,
	davem@davemloft.net,
	marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH net-next 1/3] bluetooth: 6lowpan dev_close never returns error
Date: Tue, 18 Jul 2017 15:59:25 -0700
Message-Id: <20170718225927.15944-2-sthemmin@microsoft.com>
In-Reply-To: <20170718225927.15944-1-sthemmin@microsoft.com>
References: <20170718225927.15944-1-sthemmin@microsoft.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The function dev_close in current kernel will never return an
error. Later changes will make it void.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 net/bluetooth/6lowpan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index ab3b654b05cc..e542b8959d88 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -621,9 +621,7 @@ static void ifdown(struct net_device *netdev)
 	int err;
 
 	rtnl_lock();
-	err = dev_close(netdev);
-	if (err < 0)
-		BT_INFO("iface %s cannot be closed (%d)", netdev->name, err);
+	dev_close(netdev);
 	rtnl_unlock();
 }
 
-- 
2.11.0
