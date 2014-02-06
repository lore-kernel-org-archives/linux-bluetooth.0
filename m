Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/pan: Use ioctl instead of sysfs for setting forward delay
Date: Thu,  6 Feb 2014 11:55:15 +0100
Message-Id: <1391684115-16870-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Using sysfs is causing problems due to filesystem permissions
(bluetoothd is running as bluetooth user) and bluetoothd already has
required capabilities for setting forward delay through ioctl.
---
This should be applied on top of "[PATCH v2 0/5] Android PAN fixes"

 android/pan.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index eeeadeb..ae4079a 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -33,6 +33,9 @@
 #include <sys/wait.h>
 #include <net/if.h>
 #include <linux/sockios.h>
+#include <netinet/in.h>
+#include <netinet/ip6.h>
+#include <linux/if_bridge.h>
 
 #include "btio/btio.h"
 #include "lib/bluetooth.h"
@@ -54,7 +57,6 @@
 #define BNEP_BRIDGE "bt-pan"
 #define BNEP_PANU_INTERFACE "bt-pan"
 #define BNEP_NAP_INTERFACE "bt-pan%d"
-#define FORWARD_DELAY_PATH "/sys/class/net/"BNEP_BRIDGE"/bridge/forward_delay"
 
 static bdaddr_t adapter_addr;
 GSList *devices = NULL;
@@ -80,25 +82,22 @@ static struct {
 	.bridge = false,
 };
 
-
-static int set_forward_delay(void)
+static int set_forward_delay(int sk)
 {
-	int fd, ret;
-
-	fd = open(FORWARD_DELAY_PATH, O_RDWR);
-	if (fd < 0) {
-		int err = -errno;
+	unsigned long args[4] = { BRCTL_SET_BRIDGE_FORWARD_DELAY, 0 ,0, 0 };
+	struct ifreq ifr;
 
-		error("pan: open forward delay file failed: %d (%s)",
-							-err, strerror(-err));
+	memset(&ifr, 0, sizeof(ifr));
+	strncpy(ifr.ifr_name, BNEP_BRIDGE, IFNAMSIZ);
+	ifr.ifr_data = (char *) args;
 
-		return err;
+	if (ioctl(sk, SIOCDEVPRIVATE, &ifr) < 0) {
+		error("pan: setting forward delay failed: %d (%s)",
+						-errno, strerror(-errno));
+		return -1;
 	}
 
-	ret = write(fd, "0", sizeof("0"));
-	close(fd);
-
-	return ret;
+	return 0;
 }
 
 static int nap_create_bridge(void)
@@ -122,7 +121,7 @@ static int nap_create_bridge(void)
 		}
 	}
 
-	err = set_forward_delay();
+	err = set_forward_delay(sk);
 	if (err < 0)
 		ioctl(sk, SIOCBRDELBR, BNEP_BRIDGE);
 
-- 
1.8.3.2

