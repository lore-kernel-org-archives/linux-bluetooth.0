Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] tools/btmgmt: Fix compilation warning on Android
Date: Fri, 13 Feb 2015 20:16:14 +0100
Message-Id: <1423854975-16515-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1423854975-16515-1-git-send-email-szymon.janc@tieto.com>
References: <1423854975-16515-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

isspace requires ctype.h include.

external/bluetooth/bluez/tools/btmgmt.c: In function 'get_input':
external/bluetooth/bluez/tools/btmgmt.c:834:2: warning: implicit
   declaration of function 'isspace' [-Wimplicit-function-declaration]
  while (len && isspace(buf[len - 1]))
  ^
---
 tools/btmgmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 75f64c2..7cf82e2 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -38,6 +38,7 @@
 #include <getopt.h>
 #include <stdbool.h>
 #include <wordexp.h>
+#include <ctype.h>
 
 #include <readline/readline.h>
 #include <readline/history.h>
-- 
1.9.3

