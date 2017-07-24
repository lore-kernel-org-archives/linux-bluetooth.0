Return-Path: <stephen@networkplumber.org>
From: Stephen Hemminger <stephen@networkplumber.org>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	pablo@netfilter.org,
	kadlec@blackhole.kfki.hu,
	fw@strlen.de
Cc: netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH net-next 1/6] bnxt: fix unsigned comparsion with 0
Date: Mon, 24 Jul 2017 10:25:18 -0700
Message-Id: <20170724172523.13135-2-sthemmin@microsoft.com>
In-Reply-To: <20170724172523.13135-1-sthemmin@microsoft.com>
References: <20170724172523.13135-1-sthemmin@microsoft.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Fixes warning because location is u32 and can never be netative
warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index be6acadcb202..96b8c0db10f9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -520,7 +520,7 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 	struct flow_keys *fkeys;
 	int i, rc = -EINVAL;
 
-	if (fs->location < 0 || fs->location >= BNXT_NTP_FLTR_MAX_FLTR)
+	if (fs->location >= BNXT_NTP_FLTR_MAX_FLTR)
 		return rc;
 
 	for (i = 0; i < BNXT_NTP_FLTR_HASH_SIZE; i++) {
-- 
2.11.0
