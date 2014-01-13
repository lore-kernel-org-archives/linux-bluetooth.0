Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/pan: Generate file path in compile time
Date: Mon, 13 Jan 2014 10:08:20 +0100
Message-Id: <1389604100-26189-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This reduce need of using snprintf function and removes need of manual
buffer size calculation.
---
 android/pan.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 205da71..dfd7762 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -50,9 +50,9 @@
 #include "bluetooth.h"
 
 #define SVC_HINT_NETWORKING 0x02
-#define BNEP_BRIDGE	"bnep"
-#define FORWARD_DELAY_PATH	"/sys/class/net/%s/bridge/forward_delay"
-#define DELAY_PATH_MAX	41
+
+#define BNEP_BRIDGE "bnep"
+#define FORWARD_DELAY_PATH "/sys/class/net/"BNEP_BRIDGE"/bridge/forward_delay"
 
 static bdaddr_t adapter_addr;
 GSList *devices = NULL;
@@ -470,11 +470,8 @@ failed:
 static int set_forward_delay(void)
 {
 	int fd, ret;
-	char path[DELAY_PATH_MAX];
-
-	snprintf(path, sizeof(path), FORWARD_DELAY_PATH, BNEP_BRIDGE);
 
-	fd = open(path, O_RDWR);
+	fd = open(FORWARD_DELAY_PATH, O_RDWR);
 	if (fd < 0)
 		return -errno;
 
-- 
1.8.3.2

