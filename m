Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH] android: Bump PLATFORM_SDK_VERSION to KitKat
Date: Mon, 4 Nov 2013 11:06:13 +0100
Message-ID: <1383559573-19508-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This updates PLATFORM_SDK_VERSION to 19 since
bluetooth headers were updated already.
---
 android/Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index 5eb8f01..acbc0f5 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -71,7 +71,7 @@ android_haltest_SOURCES = android/client/haltest.c \
 android_haltest_LDADD = android/libhal-internal.la
 
 android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
-				-DPLATFORM_SDK_VERSION=18
+				-DPLATFORM_SDK_VERSION=19
 
 android_haltest_LDFLAGS = -pthread
 
-- 
1.7.9.5

