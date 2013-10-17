Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 8/8] build: Add missing android files to EXTRA_DIST
Date: Thu, 17 Oct 2013 10:47:09 +0200
Message-ID: <1381999629-9589-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1381999629-9589-1-git-send-email-szymon.janc@tieto.com>
References: <1381999629-9589-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.android | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Makefile.android b/Makefile.android
index 5abfeaa..da3b699 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -39,7 +39,33 @@ android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
 
 endif
 
-EXTRA_DIST += android/Android.mk android/log.c
+EXTRA_DIST += android/Android.mk android/log.c android/device.c \
+		android/adapter.c android/main.c android/hal-msg.h \
+		android/hal.h
+
+EXTRA_DIST += android/hal_bt_sock.c android/hal_bluetooth.c
+
+EXTRA_DIST += android/client/terminal.c \
+		android/client/haltest.c \
+		android/client/hwmodule.c \
+		android/client/pollhandler.c \
+		android/client/history.c \
+		android/client/if-bt.c \
+		android/client/textconv.c \
+		android/client/textconv.h \
+		android/client/if-main.h \
+		android/client/pollhandler.h \
+		android/client/history.h \
+		android/client/terminal.h \
+		android/android_compat.h
+
+EXTRA_DIST += android/hardware/bt_gatt_client.h android/hardware/bt_hl.h \
+		android/hardware/bt_hh.h android/hardware/bt_av.h \
+		android/hardware/bluetooth.h android/hardware/bt_rc.h \
+		android/hardware/hardware.h android/hardware/bt_gatt_types.h \
+		android/hardware/bt_hf.h android/hardware/bt_gatt_server.h \
+		android/hardware/bt_pan.h android/hardware/bt_gatt.h \
+		android/hardware/bt_sock.h
 
 EXTRA_DIST += android/hal-ipc-api.txt
 
-- 
1.8.4

