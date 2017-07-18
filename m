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
Subject: [PATCH net-next 2/3] hns: remove useless void cast
Date: Tue, 18 Jul 2017 15:59:26 -0700
Message-Id: <20170718225927.15944-3-sthemmin@microsoft.com>
In-Reply-To: <20170718225927.15944-1-sthemmin@microsoft.com>
References: <20170718225927.15944-1-sthemmin@microsoft.com>
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to cast away return value of dev_close.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
index a8db27e86a11..78cb20c67aa6 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -595,7 +595,7 @@ static void hns_nic_self_test(struct net_device *ndev,
 		set_bit(NIC_STATE_TESTING, &priv->state);
 
 		if (if_running)
-			(void)dev_close(ndev);
+			dev_close(ndev);
 
 		for (i = 0; i < SELF_TEST_TPYE_NUM; i++) {
 			if (!st_param[i][1])
-- 
2.11.0
