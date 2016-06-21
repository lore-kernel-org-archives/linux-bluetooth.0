Return-Path: <linux-wpan-owner@vger.kernel.org>
From: Alexander Aring <aar@pengutronix.de>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de,
	dan.carpenter@oracle.com, Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 2/2] 6lowpan: ndisc: add missing 802.15.4 only check
Date: Tue, 21 Jun 2016 10:27:19 +0200
Message-Id: <20160621082719.9903-2-aar@pengutronix.de>
In-Reply-To: <20160621082719.9903-1-aar@pengutronix.de>
References: <20160621082719.9903-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a missing check to handle short address parsing for
802.15.4 6LoWPAN only.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/ndisc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/6lowpan/ndisc.c b/net/6lowpan/ndisc.c
index 030504e..79c5fa9 100644
--- a/net/6lowpan/ndisc.c
+++ b/net/6lowpan/ndisc.c
@@ -47,6 +47,9 @@ static int lowpan_ndisc_parse_options(const struct net_device *dev,
 				      struct nd_opt_hdr *nd_opt,
 				      struct ndisc_options *ndopts)
 {
+	if (!lowpan_is_ll(dev, LOWPAN_LLTYPE_IEEE802154))
+		return 0;
+
 	switch (nd_opt->nd_opt_type) {
 	case ND_OPT_SOURCE_LL_ADDR:
 	case ND_OPT_TARGET_LL_ADDR:
-- 
2.9.0

