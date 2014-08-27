Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Set exact Android version
Date: Wed, 27 Aug 2014 14:54:20 +0300
Message-Id: <1409140460-14029-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For local build set exact current Android version.
---
 android/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index 4b93c5b..24714c4 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -1,6 +1,6 @@
 if ANDROID
 
-AM_CFLAGS += -DANDROID_VERSION=0xFFFFFF
+AM_CFLAGS += -DANDROID_VERSION=0x040404
 
 android_plugindir = $(abs_top_srcdir)/android/.libs
 
-- 
1.9.1

