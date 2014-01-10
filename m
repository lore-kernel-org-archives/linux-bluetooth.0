Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] android: Convert libhal-internal to a plugin
Date: Fri, 10 Jan 2014 14:14:07 +0200
Message-Id: <1389356048-4333-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389356048-4333-1-git-send-email-luiz.dentz@gmail.com>
References: <1389356048-4333-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This convert the static library libhal-internal.la to
bluetooth.default.la when building with autotools.
---
 android/Makefile.am | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index 97173db..4b843b2 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -39,9 +39,9 @@ android_bluetoothd_SOURCES = android/main.c \
 
 android_bluetoothd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
-noinst_LTLIBRARIES += android/libhal-internal.la
+plugin_LTLIBRARIES += android/bluetooth.default.la
 
-android_libhal_internal_la_SOURCES = android/hal.h android/hal-bluetooth.c \
+android_bluetooth_default_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hal-sock.c \
 					android/hal-hidhost.c \
 					android/hal-pan.c \
@@ -63,8 +63,10 @@ android_libhal_internal_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hal-log.h \
 					android/hal-ipc.h android/hal-ipc.c
 
-android_libhal_internal_la_CPPFLAGS = -I$(srcdir)/android \
+android_bluetooth_default_la_CPPFLAGS = -I$(srcdir)/android \
 					-DPLATFORM_SDK_VERSION=19
+android_bluetooth_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
+					-no-undefined
 
 noinst_PROGRAMS += android/haltest
 
@@ -87,7 +89,7 @@ android_haltest_SOURCES = android/client/haltest.c \
 				android/client/hwmodule.c \
 				android/hal-utils.h android/hal-utils.c
 
-android_haltest_LDADD = android/libhal-internal.la
+android_haltest_LDADD = android/bluetooth.default.la
 
 android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
 				-DPLATFORM_SDK_VERSION=19
@@ -110,7 +112,7 @@ android_android_tester_SOURCES = emulator/btdev.h emulator/btdev.c \
 android_android_tester_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
 
 android_android_tester_LDADD = lib/libbluetooth-internal.la \
-				android/libhal-internal.la @GLIB_LIBS@
+				android/bluetooth.default.la @GLIB_LIBS@
 
 android_android_tester_LDFLAGS = -pthread
 
-- 
1.8.4.2

