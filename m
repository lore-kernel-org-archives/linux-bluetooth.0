Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Fix header include
Date: Wed, 20 Aug 2014 16:06:47 +0300
Message-Id: <1408540007-7621-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Since Android KitKat we can use sys/prctl.h and sys/capability.h
as specified in the manual page. Fixes also build warnings:
...
warning: implicit declaration of function 'prctl'
[-Wimplicit-function-declaration]
  if (prctl(PR_SET_KEEPCAPS, 1) < 0) {
  ^
...
---
 android/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/android/main.c b/android/main.c
index 0a0c150..5299789 100644
--- a/android/main.c
+++ b/android/main.c
@@ -36,10 +36,8 @@
 #include <unistd.h>
 
 #include <sys/signalfd.h>
-#if defined(ANDROID)
+#include <sys/prctl.h>
 #include <sys/capability.h>
-#include <linux/prctl.h>
-#endif
 
 #include <glib.h>
 
-- 
1.9.1

