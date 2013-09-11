Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] monitor: Add missing include
Date: Wed, 11 Sep 2013 16:03:28 +0200
Message-ID: <1378908208-17063-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bionic library requires explicit include for data types used in ioctl
call. This fix following build error with bionic:

target  C: btmon <= external/bluetooth/bluez/monitor/display.c
external/bluetooth/bluez/monitor/display.c: In function 'num_columns':
external/bluetooth/bluez/monitor/display.c:59:18: error: storage size
    of 'ws' isn't known
---
 monitor/display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/display.c b/monitor/display.c
index 7b6fc98..b8dce1f 100644
--- a/monitor/display.c
+++ b/monitor/display.c
@@ -35,6 +35,7 @@
 #include <sys/wait.h>
 #include <sys/prctl.h>
 #include <sys/ioctl.h>
+#include <termios.h>
 
 #include "display.h"
 
-- 
1.8.4

