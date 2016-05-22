Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bernd Kuhls <bernd.kuhls@writeme.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bernd Kuhls <bernd.kuhls@writeme.com>
Subject: [PATCH 1/1] tools/bneptest.c: Remove include linux/if_bridge.h to fix musl build
Date: Sun, 22 May 2016 11:45:11 +0200
Message-Id: <1463910311-31244-1-git-send-email-bernd.kuhls@writeme.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Inspired by busybox commit:
https://git.busybox.net/busybox/commit/networking/brctl.c?id=5fa6d1a632505789409a2ba6cf8e112529f9db18

The build error was found by the autobuilders of the buildroot project:
http://autobuild.buildroot.net/results/eba/ebaa0bcb9c325aa6ed0bbd6c7ec75d44befa7645/build-end.log

Signed-off-by: Bernd Kuhls <bernd.kuhls@writeme.com>
---
 tools/bneptest.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/bneptest.c b/tools/bneptest.c
index 1404252..b832d72 100644
--- a/tools/bneptest.c
+++ b/tools/bneptest.c
@@ -36,7 +36,17 @@
 #include <net/if.h>
 #include <linux/sockios.h>
 #include <netinet/in.h>
-#include <linux/if_bridge.h>
+/* #include <linux/if_bridge.h>
+ * breaks on musl: we already included netinet/in.h,
+ * if we also include <linux/if_bridge.h> here, we get this:
+ * In file included from /usr/include/linux/if_bridge.h:18,
+ *                  from networking/brctl.c:67:
+ * /usr/include/linux/in6.h:32: error: redefinition of 'struct in6_addr'
+ * /usr/include/linux/in6.h:49: error: redefinition of 'struct sockaddr_in6'
+ * /usr/include/linux/in6.h:59: error: redefinition of 'struct ipv6_mreq'
+ */
+/* From <linux/if_bridge.h> */
+#define BRCTL_SET_BRIDGE_FORWARD_DELAY 8
 
 #include <glib.h>
 
-- 
2.8.1

