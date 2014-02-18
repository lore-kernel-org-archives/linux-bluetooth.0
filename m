Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/4] shared: Move AVDTP implementation
Date: Tue, 18 Feb 2014 16:40:34 +0200
Message-Id: <1392734435-2182-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392734435-2182-1-git-send-email-luiz.dentz@gmail.com>
References: <1392734435-2182-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves AVDTP implementation to shared since it does already contain
some unit tests it can be reused by e.g. audio plugin.
---
 Makefile.am                     | 2 +-
 android/Android.mk              | 2 +-
 android/Makefile.am             | 2 +-
 android/a2dp.c                  | 2 +-
 {android => src/shared}/avdtp.c | 0
 {android => src/shared}/avdtp.h | 0
 unit/test-avdtp.c               | 2 +-
 7 files changed, 5 insertions(+), 5 deletions(-)
 rename {android => src/shared}/avdtp.c (100%)
 rename {android => src/shared}/avdtp.h (100%)

diff --git a/Makefile.am b/Makefile.am
index ba9e5b3..0697c14 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -272,7 +272,7 @@ unit_tests += unit/test-avdtp
 unit_test_avdtp_SOURCES = unit/test-avdtp.c \
 				src/shared/util.h src/shared/util.c \
 				src/log.h src/log.c \
-				android/avdtp.c android/avdtp.h
+				src/shared/avdtp.c src/shared/avdtp.h
 unit_test_avdtp_LDADD = @GLIB_LIBS@
 
 unit_tests += unit/test-avctp
diff --git a/android/Android.mk b/android/Android.mk
index 763056c..5134d81 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -36,7 +36,6 @@ LOCAL_SRC_FILES := \
 	bluez/android/socket.c \
 	bluez/android/ipc.c \
 	bluez/android/audio-ipc.c \
-	bluez/android/avdtp.c \
 	bluez/android/a2dp.c \
 	bluez/android/avrcp.c \
 	bluez/android/pan.c \
@@ -48,6 +47,7 @@ LOCAL_SRC_FILES := \
 	bluez/src/shared/ringbuf.c \
 	bluez/src/shared/hfp.c \
 	bluez/src/shared/io-glib.c \
+	bluez/src/shared/avdtp.c \
 	bluez/src/shared/avctp.c \
 	bluez/src/shared/avrcp.c \
 	bluez/src/sdpd-database.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index d1b3119..50b5a3b 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -31,11 +31,11 @@ android_bluetoothd_SOURCES = android/main.c \
 				src/shared/hfp.h src/shared/hfp.c \
 				src/shared/avctp.h src/shared/avctp.c \
 				src/shared/avrcp.h src/shared/avrcp.c \
+				src/shared/avdtp.h src/shared/avdtp.c \
 				android/bluetooth.h android/bluetooth.c \
 				android/hidhost.h android/hidhost.c \
 				android/ipc.h android/ipc.c \
 				android/audio-ipc.h android/audio-ipc.c \
-				android/avdtp.h android/avdtp.c \
 				android/a2dp.h android/a2dp.c \
 				android/avrcp.h android/avrcp.c \
 				android/socket.h android/socket.c \
diff --git a/android/a2dp.c b/android/a2dp.c
index 5d7dc78..f0a28ed 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -39,12 +39,12 @@
 #include "lib/sdp_lib.h"
 #include "profiles/audio/a2dp-codecs.h"
 #include "src/log.h"
+#include "src/shared/avdtp.h"
 #include "a2dp.h"
 #include "hal-msg.h"
 #include "ipc.h"
 #include "utils.h"
 #include "bluetooth.h"
-#include "avdtp.h"
 #include "avrcp.h"
 #include "audio-msg.h"
 #include "audio-ipc.h"
diff --git a/android/avdtp.c b/src/shared/avdtp.c
similarity index 100%
rename from android/avdtp.c
rename to src/shared/avdtp.c
diff --git a/android/avdtp.h b/src/shared/avdtp.h
similarity index 100%
rename from android/avdtp.h
rename to src/shared/avdtp.h
diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 8fe5ce3..d8137f2 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -37,7 +37,7 @@
 
 #include "src/shared/util.h"
 #include "src/log.h"
-#include "android/avdtp.h"
+#include "src/shared/avdtp.h"
 
 struct test_pdu {
 	bool valid;
-- 
1.8.5.3

