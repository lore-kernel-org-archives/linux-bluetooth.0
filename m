Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 9/9] android: Fix build error with autotools
Date: Thu, 17 Oct 2013 11:55:28 +0300
Message-Id: <1382000128-23762-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1382000128-23762-1-git-send-email-luiz.dentz@gmail.com>
References: <1382000128-23762-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

  CC       android/android_libbt_internal_la-hal_bluetooth.lo
android/hal_bluetooth.c:26:28: fatal error: cutils/sockets.h: No such file or directory
 #include <cutils/sockets.h>
                            ^

Apparently sockets.h is not used for anything, so for now remove it and
once it is actually necessary add local cutils/sockets.h so it can be
build with autotools as well.
---
 android/hal_bluetooth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/hal_bluetooth.c b/android/hal_bluetooth.c
index cf8f3ae..e6b6210 100644
--- a/android/hal_bluetooth.c
+++ b/android/hal_bluetooth.c
@@ -23,7 +23,6 @@
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
 
-#include <cutils/sockets.h>
 #include <cutils/properties.h>
 
 #define LOG_TAG "BlueZ"
-- 
1.8.3.1

