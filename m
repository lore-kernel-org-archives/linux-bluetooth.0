Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH] android/client: Define Android version for host
Date: Wed, 30 Oct 2013 15:47:22 +0100
Message-ID: <1383144442-16239-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch defines PLATFORM_SDK_VERSION like it is handled in
Android.mk. This value corresponds to current copy of headers
from Android committed to bluez.
---
 android/Makefile.am |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index 5690e93..de27dcf 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -61,7 +61,8 @@ android_haltest_SOURCES = android/client/haltest.c \
 
 android_haltest_LDADD = android/libhal-internal.la
 
-android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
+android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
+			-DPLATFORM_SDK_VERSION=18
 
 android_haltest_LDFLAGS = -pthread
 
-- 
1.7.9.5

