Return-Path: <aar@pengutronix.de>
From: Alexander Aring <aar@pengutronix.de>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de,
	marcel@holtmann.org,
	jukka.rissanen@linux.intel.com,
	hannes@stressinduktion.org,
	stefan@osg.samsung.com,
	mcr@sandelman.ca,
	werner@almesberger.net,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexander Aring <aar@pengutronix.de>
Subject: [PATCHv3 net-next 03/12] 6lowpan: remove ipv6 module request
Date: Tue, 14 Jun 2016 13:52:30 +0200
Message-Id: <20160614115239.17788-4-aar@pengutronix.de>
In-Reply-To: <20160614115239.17788-1-aar@pengutronix.de>
References: <20160614115239.17788-1-aar@pengutronix.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Since we use exported function from ipv6 kernel module we don't need to
request the module anymore to have ipv6 functionality.

Acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index 801404c..1c7a42b 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -158,8 +158,6 @@ static int __init lowpan_module_init(void)
 		return ret;
 	}
 
-	request_module_nowait("ipv6");
-
 	request_module_nowait("nhc_dest");
 	request_module_nowait("nhc_fragment");
 	request_module_nowait("nhc_hop");
-- 
2.8.3
