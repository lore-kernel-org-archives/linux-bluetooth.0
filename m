Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] client/display: Fix compilation warning on Android
Date: Fri, 13 Feb 2015 20:16:15 +0100
Message-Id: <1423854975-16515-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1423854975-16515-1-git-send-email-szymon.janc@tieto.com>
References: <1423854975-16515-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

isprint requires ctype.h include.

target thumb C: btmgmt <= external/bluetooth/bluez/client/display.c
external/bluetooth/bluez/client/display.c: In function 'rl_hexdump':
external/bluetooth/bluez/client/display.c:81:3: warning: implicit
    declaration of function 'isprint' [-Wimplicit-function-declaration]
   str[(i % 16) + 51] = isprint(buf[i]) ? buf[i] : '.';
   ^
---
 client/display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/display.c b/client/display.c
index 619973c..d85b9d0 100644
--- a/client/display.c
+++ b/client/display.c
@@ -29,6 +29,7 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <stdbool.h>
+#include <ctype.h>
 #include <readline/readline.h>
 
 #include "display.h"
-- 
1.9.3

