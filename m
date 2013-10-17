Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/5] build: Add haltest command line tester
Date: Thu, 17 Oct 2013 22:28:37 +0200
Message-Id: <1382041721-19960-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

This is intended for testing Android daemon and HAL library on Linux.
---
 Makefile.android | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Makefile.android b/Makefile.android
index 3459a4d..3bc95be 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -31,6 +31,20 @@ android_libhal_internal_la_SOURCES = android/hal.h android/hal_bluetooth.c \
 					android/cutils/log.h \
 					android/cutils/properties.h
 android_libhal_internal_la_CPPFLAGS = -I$(srcdir)/android
+
+noinst_PROGRAMS += android/haltest
+
+android_haltest_SOURCES = android/client/haltest.c \
+				android/client/pollhandler.c \
+				android/client/terminal.c \
+				android/client/history.c \
+				android/client/textconv.c \
+				android/client/if-bt.c
+
+android_haltest_LDADD = android/libhal-internal.la
+
+android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
+
 endif
 
 EXTRA_DIST += android/Android.mk android/log.c
-- 
1.8.4.rc3

