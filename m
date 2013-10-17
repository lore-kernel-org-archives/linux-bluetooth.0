Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@gmail.com>
Subject: [RFC 6/8] android: Fix missing include in HAL library
Date: Thu, 17 Oct 2013 10:47:07 +0200
Message-ID: <1381999629-9589-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1381999629-9589-1-git-send-email-szymon.janc@tieto.com>
References: <1381999629-9589-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

This fix following build error on Linux:

  CC       android/android_haltest-hal_bt_sock.o
android/hal_bt_sock.c:86:21: error: no previous declaration
     for ‘bt_get_sock_interface’ [-Werror=missing-declarations]
 btsock_interface_t *bt_get_sock_interface(void)
                     ^
cc1: all warnings being treated as errors
make[1]: *** [android/android_haltest-hal_bt_sock.o] Error 1
---
 android/hal_bt_sock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal_bt_sock.c b/android/hal_bt_sock.c
index 397d1fa..3fcf9ec 100644
--- a/android/hal_bt_sock.c
+++ b/android/hal_bt_sock.c
@@ -27,6 +27,8 @@
 #include "android_compat.h"
 #endif
 
+#include "hal.h"
+
 static bt_status_t btsock_listen_rfcomm(const char *service_name,
 					const uint8_t *uuid, int chan,
 					int *sock, int flags)
-- 
1.8.4

