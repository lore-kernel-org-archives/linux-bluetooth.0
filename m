Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 5/7] route: Exporting ip6_route_add() so that Bluetooth 6LoWPAN can use it
Date: Wed, 30 Oct 2013 11:00:59 +0200
Message-Id: <1383123661-15087-6-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1383123661-15087-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1383123661-15087-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
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

