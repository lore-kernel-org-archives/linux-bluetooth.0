Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Fix compilation error
Date: Wed, 23 Oct 2013 15:53:05 +0300
Message-Id: <1382532785-5873-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The patch fixes errors with undefined symbols EXIT_FAILURE on Android.
---
 android/hal-ipc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 2d58038..1e32774 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -24,6 +24,7 @@
 #include <poll.h>
 #include <unistd.h>
 #include <stdint.h>
+#include <stdlib.h>
 
 #include <cutils/properties.h>
 
-- 
1.8.1.2

