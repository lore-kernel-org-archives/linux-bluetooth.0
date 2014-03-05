Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	alex.bluesman.smirnov@gmail.com,
	dbaryshkov@gmail.com,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH net-next 2/2] 6lowpan: move 6lowpan header to include/net
Date: Wed,  5 Mar 2014 14:29:05 +0100
Message-Id: <1394026145-18981-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1394026145-18981-1-git-send-email-alex.aring@gmail.com>
References: <1394026145-18981-1-git-send-email-alex.aring@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This header is used by bluetooth and ieee802154 branch. This patch
move this header to the include/net directory to avoid a use of a
relative path in include.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 {net/ieee802154 => include/net}/6lowpan.h | 0
 net/bluetooth/6lowpan.c                   | 2 +-
 net/ieee802154/6lowpan_iphc.c             | 3 +--
 net/ieee802154/6lowpan_rtnl.c             | 2 +-
 net/ieee802154/reassembly.c               | 2 +-
 5 files changed, 4 insertions(+), 5 deletions(-)
 rename {net/ieee802154 => include/net}/6lowpan.h (100%)

diff --git a/net/ieee802154/6lowpan.h b/include/net/6lowpan.h
similarity index 100%
rename from net/ieee802154/6lowpan.h
rename to include/net/6lowpan.h
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index adb3ea0..73492b9 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -27,7 +27,7 @@
 
 #include "6lowpan.h"
 
-#include "../ieee802154/6lowpan.h" /* for the compression support */
+#include <net/6lowpan.h> /* for the compression support */
 
 #define IFACE_NAME_TEMPLATE "bt%d"
 #define EUI64_ADDR_LEN 8
diff --git a/net/ieee802154/6lowpan_iphc.c b/net/ieee802154/6lowpan_iphc.c
index 860aa2d..211b568 100644
--- a/net/ieee802154/6lowpan_iphc.c
+++ b/net/ieee802154/6lowpan_iphc.c
@@ -54,11 +54,10 @@
 #include <linux/if_arp.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <net/6lowpan.h>
 #include <net/ipv6.h>
 #include <net/af_ieee802154.h>
 
-#include "6lowpan.h"
-
 /*
  * Uncompress address function for source and
  * destination address(non-multicast).
diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index e472618..1bbab89 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -52,10 +52,10 @@
 #include <net/af_ieee802154.h>
 #include <net/ieee802154.h>
 #include <net/ieee802154_netdev.h>
+#include <net/6lowpan.h>
 #include <net/ipv6.h>
 
 #include "reassembly.h"
-#include "6lowpan.h"
 
 static LIST_HEAD(lowpan_devices);
 
diff --git a/net/ieee802154/reassembly.c b/net/ieee802154/reassembly.c
index 4511fc2..1cc2336 100644
--- a/net/ieee802154/reassembly.c
+++ b/net/ieee802154/reassembly.c
@@ -24,10 +24,10 @@
 #include <linux/export.h>
 
 #include <net/ieee802154_netdev.h>
+#include <net/6lowpan.h>
 #include <net/ipv6.h>
 #include <net/inet_frag.h>
 
-#include "6lowpan.h"
 #include "reassembly.h"
 
 static struct inet_frags lowpan_frags;
-- 
1.9.0
