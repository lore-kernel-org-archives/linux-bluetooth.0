Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@gmail.com>
Subject: [RFC 2/8] build: Add haltest command line tester
Date: Thu, 17 Oct 2013 10:47:03 +0200
Message-ID: <1381999629-9589-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1381999629-9589-1-git-send-email-szymon.janc@tieto.com>
References: <1381999629-9589-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

This is intended for testing Android daemon and HAL library on Linux.
---
 Makefile.android | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Makefile.android b/Makefile.android
index 4d7da39..e4482b2 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -10,8 +10,35 @@ android_bluetoothd_SOURCES =	android/main.c \
 				src/shared/mgmt.h src/shared/mgmt.c
 
 android_bluetoothd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+
+noinst_PROGRAMS += android/haltest
+
+android_haltest_SOURCES =	android/client/haltest.c \
+				android/client/pollhandler.c \
+				android/client/terminal.c \
+				android/client/history.c \
+				android/client/textconv.c \
+				android/client/if-bt.c \
+				android/hal_bluetooth.c \
+				android/hal_bt_sock.c \
+				android/hardware/bt_hf.h \
+				android/hardware/hardware.h \
+				android/hardware/bt_hh.h \
+				android/hardware/bluetooth.h \
+				android/hardware/bt_hl.h \
+				android/hardware/bt_gatt_server.h \
+				android/hardware/bt_av.h \
+				android/hardware/bt_gatt_types.h \
+				android/hardware/bt_gatt.h \
+				android/hardware/bt_rc.h \
+				android/hardware/bt_gatt_client.h \
+				android/hardware/bt_pan.h
+
+android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
+
 endif
 
 EXTRA_DIST += android/Android.mk android/log.c
 
 EXTRA_DIST += android/hal-ipc-api.txt
+
-- 
1.8.4

