Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@gmail.com>
Subject: [RFC 5/8] android: Fix missing include in HAL library
Date: Thu, 17 Oct 2013 10:47:06 +0200
Message-ID: <1381999629-9589-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1381999629-9589-1-git-send-email-szymon.janc@tieto.com>
References: <1381999629-9589-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

This fix following build error on Linux:

make --no-print-directory all-am
  CC       android/android_haltest-hal_bluetooth.o
android/hal_bluetooth.c: In function ‘start_bt_daemon’:
android/hal_bluetooth.c:60:4: error: implicit declaration of function
    ‘strcmp’ [-Werror=implicit-function-declaration]
        if (!strcmp(val, "running")) {
        ^
android/hal_bluetooth.c: In function ‘open_bluetooth’:
android/hal_bluetooth.c:364:2: error: implicit declaration of function
     ‘memset’ [-Werror=implicit-function-declaration]
      memset(dev, 0, sizeof(bluetooth_device_t));
      ^
android/hal_bluetooth.c:364:2: error: incompatible implicit declaration
     of built-in function ‘memset’ [-Werror]
     cc1: all warnings being treated as errors
     make[1]: *** [android/android_haltest-hal_bluetooth.o] Error 1
---
 android/hal_bluetooth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/hal_bluetooth.c b/android/hal_bluetooth.c
index a34dc91..e92da41 100644
--- a/android/hal_bluetooth.c
+++ b/android/hal_bluetooth.c
@@ -19,6 +19,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <stdbool.h>
+#include <string.h>
 
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
-- 
1.8.4

