Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v4 2/6] ipv6: Add checks for RAWIP ARP type
Date: Wed, 13 Nov 2013 12:11:31 +0200
Message-Id: <1384337495-9043-3-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1384337495-9043-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1384337495-9043-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/ipv6/addrconf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d6ff126..cde1061 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1797,6 +1797,7 @@ static int ipv6_generate_eui64(u8 *eui, struct net_device *dev)
 		return addrconf_ifid_sit(eui, dev);
 	case ARPHRD_IPGRE:
 		return addrconf_ifid_gre(eui, dev);
+	case ARPHRD_RAWIP:
 	case ARPHRD_IEEE802154:
 		return addrconf_ifid_eui64(eui, dev);
 	case ARPHRD_IEEE1394:
@@ -2681,7 +2682,8 @@ static void addrconf_dev_config(struct net_device *dev)
 	    (dev->type != ARPHRD_INFINIBAND) &&
 	    (dev->type != ARPHRD_IEEE802154) &&
 	    (dev->type != ARPHRD_IEEE1394) &&
-	    (dev->type != ARPHRD_TUNNEL6)) {
+	    (dev->type != ARPHRD_TUNNEL6) &&
+	    (dev->type != ARPHRD_RAWIP)) {
 		/* Alas, we support only Ethernet autoconfiguration. */
 		return;
 	}
-- 
1.8.3.1

