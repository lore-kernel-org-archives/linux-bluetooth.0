Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 3/5] route: Exporting ip6_route_add() so that BLE 6LoWPAN can use it
Date: Wed, 23 Oct 2013 09:52:42 +0300
Message-Id: <1382511164-1989-4-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1382511164-1989-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1382511164-1989-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 net/ipv6/route.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index c979dd9..d7c200f 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1662,6 +1662,7 @@ out:
 		dst_free(&rt->dst);
 	return err;
 }
+EXPORT_SYMBOL_GPL(ip6_route_add);
 
 static int __ip6_del_rt(struct rt6_info *rt, struct nl_info *info)
 {
-- 
1.7.11.7

