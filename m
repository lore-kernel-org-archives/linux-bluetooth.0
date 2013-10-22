Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/5] android: Remove not needed include
Date: Tue, 22 Oct 2013 15:24:59 +0200
Message-Id: <1382448299-16887-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382448299-16887-1-git-send-email-szymon.janc@tieto.com>
References: <1382448299-16887-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/android/main.c b/android/main.c
index ba153a5..d4916ca 100644
--- a/android/main.c
+++ b/android/main.c
@@ -39,10 +39,6 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 
-#if defined(ANDROID)
-#include <private/android_filesystem_config.h>
-#endif
-
 #include <glib.h>
 
 #include "log.h"
-- 
1.8.4

