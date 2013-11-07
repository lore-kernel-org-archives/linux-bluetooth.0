Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/4] android: Remove includes from adapter.h
Date: Thu, 7 Nov 2013 10:10:36 +0100
Message-ID: <1383815437-521-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383815437-521-1-git-send-email-szymon.janc@tieto.com>
References: <1383815437-521-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is internal header and dependencies should be included in
respective .c files.
---
 android/adapter.c | 1 +
 android/adapter.h | 6 ------
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 69b3695..a84aaf8 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -26,6 +26,7 @@
 #endif
 
 #include <errno.h>
+#include <stdlib.h>
 
 #include <glib.h>
 
diff --git a/android/adapter.h b/android/adapter.h
index 08f4f48..c62b859 100644
--- a/android/adapter.h
+++ b/android/adapter.h
@@ -21,12 +21,6 @@
  *
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-
-#include "lib/bluetooth.h"
-
 typedef void (*bt_adapter_ready)(int err);
 
 void bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
-- 
1.8.4.2

