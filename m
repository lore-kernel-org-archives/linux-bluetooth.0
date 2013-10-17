Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 6/9] build: Enable building HAL as libbt-internal.la
Date: Thu, 17 Oct 2013 11:55:25 +0300
Message-Id: <1382000128-23762-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1382000128-23762-1-git-send-email-luiz.dentz@gmail.com>
References: <1382000128-23762-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.android | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile.android b/Makefile.android
index 4d7da39..6d7437d 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -10,6 +10,12 @@ android_bluetoothd_SOURCES =	android/main.c \
 				src/shared/mgmt.h src/shared/mgmt.c
 
 android_bluetoothd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+
+noinst_LTLIBRARIES += android/libbt-internal.la
+
+android_libbt_internal_la_SOURCES = android/hal.h android/hal_bluetooth.c \
+					android/hal_bt_sock.c
+android_libbt_internal_la_CPPFLAGS = -I$(srcdir)/android
 endif
 
 EXTRA_DIST += android/Android.mk android/log.c
-- 
1.8.3.1

