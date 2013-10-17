Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/5] build: Add missing Android files to EXTRA_DIST
Date: Thu, 17 Oct 2013 22:28:41 +0200
Message-Id: <1382041721-19960-5-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1382041721-19960-1-git-send-email-szymon.janc@gmail.com>
References: <1382041721-19960-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

---
 Makefile.android | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Makefile.android b/Makefile.android
index 00d962d..8ae3ddc 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -48,7 +48,24 @@ android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
 
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
+		android/client/terminal.h
 
 EXTRA_DIST += android/hal-ipc-api.txt
 
-- 
1.8.4.rc3

