Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 3/5] ipv6: Add checks for 6LOWPAN ARP type
Date: Tue, 10 Dec 2013 13:37:35 +0200
Message-Id: <1386675457-26024-4-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1386675457-26024-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1386675457-26024-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Acked-by: David S. Miller <davem@davemloft.net>
---
 net/ipv6/addrconf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 12c97d8..d125fcd 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1816,6 +1816,7 @@ static int ipv6_generate_eui64(u8 *eui, struct net_device *dev)
 		return addrconf_ifid_sit(eui, dev);
 	case ARPHRD_IPGRE:
 		return addrconf_ifid_gre(eui, dev);
+	case ARPHRD_6LOWPAN:
 	case ARPHRD_IEEE802154:
 		return addrconf_ifid_eui64(eui, dev);
 	case ARPHRD_IEEE1394:
@@ -2658,7 +2659,8 @@ static void addrconf_dev_config(struct net_device *dev)
 	    (dev->type != ARPHRD_INFINIBAND) &&
 	    (dev->type != ARPHRD_IEEE802154) &&
 	    (dev->type != ARPHRD_IEEE1394) &&
-	    (dev->type != ARPHRD_TUNNEL6)) {
+	    (dev->type != ARPHRD_TUNNEL6) &&
+	    (dev->type != ARPHRD_6LOWPAN)) {
 		/* Alas, we support only Ethernet autoconfiguration. */
 		return;
 	}
-- 
1.8.3.1

