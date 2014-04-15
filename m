Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] tools/hciattach: Fix missing includes
Date: Tue, 15 Apr 2014 13:30:53 +0200
Message-Id: <1397561453-23047-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to writev manual one should include <sys/uio.h> to use it.

This fix following warnings with bionic:
external/bluetooth/bluez/tools/hciattach_tialt.c: In function
    'texas_load_firmware':
external/bluetooth/bluez/tools/hciattach_tialt.c:142:4: warning:
    implicit declaration of function 'writev'
    [-Wimplicit-function-declaration]
target thumb C: hciattach <= external/bluetooth/bluez/tools/
    hciattach_ath3k.c
target thumb C: hciattach <= external/bluetooth/bluez/tools/
    hciattach_qualcomm.c
external/bluetooth/bluez/tools/hciattach_qualcomm.c: In function
    'qualcomm_load_firmware':
external/bluetooth/bluez/tools/hciattach_qualcomm.c:147:4: warning:
    implicit declaration of function 'writev'
    [-Wimplicit-function-declaration]
---
 tools/hciattach_qualcomm.c | 1 +
 tools/hciattach_tialt.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/hciattach_qualcomm.c b/tools/hciattach_qualcomm.c
index 0e02e1e..eb72a0f 100644
--- a/tools/hciattach_qualcomm.c
+++ b/tools/hciattach_qualcomm.c
@@ -40,6 +40,7 @@
 #include <sys/poll.h>
 #include <sys/param.h>
 #include <sys/ioctl.h>
+#include <sys/uio.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
diff --git a/tools/hciattach_tialt.c b/tools/hciattach_tialt.c
index c3caa49..5c7f3a5 100644
--- a/tools/hciattach_tialt.c
+++ b/tools/hciattach_tialt.c
@@ -39,6 +39,7 @@
 #include <sys/poll.h>
 #include <sys/param.h>
 #include <sys/ioctl.h>
+#include <sys/uio.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
-- 
1.9.1

