Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Alexander Aring <aar@pengutronix.de>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org,
	Alexander Aring <aar@pengutronix.de>
Subject: [PATCH linux-wpan/radvd for-upstream 1/2] device-linux: replace ARPHRD_IEEE802154 to ARPHRD_6LOWPAN
Date: Tue,  2 Aug 2016 16:37:51 +0200
Message-Id: <20160802143752.12831-2-aar@pengutronix.de>
In-Reply-To: <20160802143752.12831-1-aar@pengutronix.de>
References: <20160802143752.12831-1-aar@pengutronix.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes the ARPHRD_IEEE802154 to ARPHRD_6LOWPAN. The IEEE
802.15.4 6lowpan module changed the ARPHRD_IEEE802154 type to
ARPHRD_6LOWPAN. Nowadays it's use ARPHRD_6LOWPAN which is also used by
BTLE 6LoWPAN. Both interfaces uses an EUI64 address and the handling to
get the link-layer address should be the same.

There is no backward compatibility for 802.15.4 6LoWPAN before we
changed the ARPHRD. Anyway if somebody wants that it should be patched
manually. When the ARPHRD was ARPHRD_IEEE802154 the 802.15.4 6lowpan was
anyway in a somehow unusable state.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 device-linux.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/device-linux.c b/device-linux.c
index de83f2e..7301927 100644
--- a/device-linux.c
+++ b/device-linux.c
@@ -22,6 +22,10 @@
 #define IPV6_ADDR_LINKLOCAL   0x0020U
 #endif
 
+#ifndef ARPHRD_6LOWPAN
+#define ARPHRD_6LOWPAN	825	/* IPv6 over LoWPAN */
+#endif
+
 static char const *hwstr(unsigned short sa_family);
 
 /*
@@ -79,12 +83,10 @@ int update_device_info(int sock, struct Interface *iface)
 		iface->sllao.if_maxmtu = -1;
 		break;
 #endif				/* ARPHDR_ARCNET */
-#ifdef ARPHRD_IEEE802154
-	case ARPHRD_IEEE802154:
+	case ARPHRD_6LOWPAN:
 		iface->sllao.if_hwaddr_len = 64;
 		iface->sllao.if_prefix_len = 64;
 		break;
-#endif
 	default:
 		iface->sllao.if_hwaddr_len = -1;
 		iface->sllao.if_prefix_len = -1;
@@ -382,6 +384,9 @@ static char const *hwstr(unsigned short sa_family)
 		rc = "ARPHRD_IEEE802154_PHY";
 		break;
 #endif
+	case ARPHRD_6LOWPAN:
+		rc = "ARPHRD_6LOWPAN";
+		break;
 	case ARPHRD_VOID:
 		rc = "ARPHRD_VOID";
 		break;
-- 
2.9.0

