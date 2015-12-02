Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Chih-Wei Huang <cwhuang@android-x86.org>
To: linux-bluetooth@vger.kernel.org
Cc: Chih-Wei Huang <cwhuang@linux.org.tw>
Subject: [PATCH 2/3] android: fix building errors of the 64-bit targets
Date: Wed,  2 Dec 2015 21:19:04 +0800
Message-Id: <1449062345-31502-3-git-send-email-cwhuang@linux.org.tw>
In-Reply-To: <1449062345-31502-1-git-send-email-cwhuang@linux.org.tw>
References: <1449062345-31502-1-git-send-email-cwhuang@linux.org.tw>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some functions prototypes are not implicitly declared for
the Android 6.0 64-bit targets:

  external/bluetooth/bluez/android/hal-ipc.c: In function 'notification_handler':
  external/bluetooth/bluez/android/hal-ipc.c:143:3: error: implicit declaration of function 'memset' [-Werror=implicit-function-declaration]
     memset(&msg, 0, sizeof(msg));
     ^
  external/bluetooth/bluez/android/hal-ipc.c:143:3: warning: incompatible implicit declaration of built-in function 'memset'
  external/bluetooth/bluez/android/hal-ipc.c:158:4: error: implicit declaration of function 'strerror' [-Werror=implicit-function-declaration]
      error("Receiving notifications failed: %s",
      ^
  external/bluetooth/bluez/android/log.c: In function 'init_logd':
  external/bluetooth/bluez/android/log.c:175:2: error: implicit declaration of function 'memset' [-Werror=implicit-function-declaration]
    memset(&addr, 0, sizeof(addr));
    ^

Signed-off-by: Chih-Wei Huang <cwhuang@linux.org.tw>
---
 android/hal-ipc.c | 2 ++
 android/log.c     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 363072c..474ccb7 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -17,6 +17,7 @@
 
 #include <pthread.h>
 #include <errno.h>
+#include <error.h>
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <stdbool.h>
@@ -24,6 +25,7 @@
 #include <unistd.h>
 #include <stdint.h>
 #include <stdlib.h>
+#include <string.h>
 
 #include <cutils/properties.h>
 
diff --git a/android/log.c b/android/log.c
index 35917c6..dfbd48b 100644
--- a/android/log.c
+++ b/android/log.c
@@ -29,6 +29,7 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 #include <stdbool.h>
 #include <time.h>
-- 
1.9.1

