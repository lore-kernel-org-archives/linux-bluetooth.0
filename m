Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 14 Dec 2013 12:43:36 +0800
Message-ID: <CAPgLHd9zXw3039hXeoRPMt-0k7E1MRbrhS1tsKoWDvLU1ooV5w@mail.gmail.com>
Subject: [PATCH -next] Bluetooth: remove unused including <linux/version.h>
From: Wei Yongjun <weiyj.lk@gmail.com>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com
Cc: yongjun_wei@trendmicro.com.cn, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove including <linux/version.h> that don't need it.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 net/bluetooth/6lowpan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index ba840fe..18c48e1 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -11,7 +11,6 @@
    GNU General Public License for more details.
 */
 
-#include <linux/version.h>
 #include <linux/if_arp.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
