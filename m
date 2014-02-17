Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] shared: Move AVCTP implementation
Date: Mon, 17 Feb 2014 11:47:30 +0200
Message-Id: <1392630452-22411-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392630452-22411-1-git-send-email-luiz.dentz@gmail.com>
References: <1392630452-22411-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves AVCTP implementation to shared since it does already contain
some unit tests it can be reused by e.g. audio plugin.
---
 Makefile.am                     | 2 +-
 android/Makefile.am             | 2 +-
 {android => src/shared}/avctp.c | 0
 {android => src/shared}/avctp.h | 0
 src/shared/avrcp.c              | 2 +-
 unit/test-avctp.c               | 2 +-
 6 files changed, 4 insertions(+), 4 deletions(-)
 rename {android => src/shared}/avctp.c (100%)
 rename {android => src/shared}/avctp.h (100%)

diff --git a/Makefile.am b/Makefile.am
index 11f2aa1..a80c390 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -279,7 +279,7 @@ unit_tests += unit/test-avctp
 unit_test_avctp_SOURCES = unit/test-avctp.c \
 				src/shared/util.h src/shared/util.c \
 				src/log.h src/log.c \
-				android/avctp.c android/avctp.h
+				src/shared/avctp.c src/shared/avctp.h
 unit_test_avctp_LDADD = @GLIB_LIBS@
 
 unit_tests += unit/test-gdbus-client
diff --git a/android/Makefile.am b/android/Makefile.am
index 3cc0687..d1b3119 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -29,6 +29,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				src/shared/mgmt.h src/shared/mgmt.c \
 				src/shared/ringbuf.h src/shared/ringbuf.c \
 				src/shared/hfp.h src/shared/hfp.c \
+				src/shared/avctp.h src/shared/avctp.c \
 				src/shared/avrcp.h src/shared/avrcp.c \
 				android/bluetooth.h android/bluetooth.c \
 				android/hidhost.h android/hidhost.c \
@@ -36,7 +37,6 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/audio-ipc.h android/audio-ipc.c \
 				android/avdtp.h android/avdtp.c \
 				android/a2dp.h android/a2dp.c \
-				android/avctp.h android/avctp.c \
 				android/avrcp.h android/avrcp.c \
 				android/socket.h android/socket.c \
 				android/pan.h android/pan.c \
diff --git a/android/avctp.c b/src/shared/avctp.c
similarity index 100%
rename from android/avctp.c
rename to src/shared/avctp.c
diff --git a/android/avctp.h b/src/shared/avctp.h
similarity index 100%
rename from android/avctp.h
rename to src/shared/avctp.h
diff --git a/src/shared/avrcp.c b/src/shared/avrcp.c
index 32bd703..1325284 100644
--- a/src/shared/avrcp.c
+++ b/src/shared/avrcp.c
@@ -32,7 +32,7 @@
 
 #include "src/log.h"
 
-#include "android/avctp.h"
+#include "avctp.h"
 #include "avrcp.h"
 
 struct avrcp {
diff --git a/unit/test-avctp.c b/unit/test-avctp.c
index be1dfd7..83bf2c5 100644
--- a/unit/test-avctp.c
+++ b/unit/test-avctp.c
@@ -38,7 +38,7 @@
 #include "src/shared/util.h"
 #include "src/log.h"
 
-#include "android/avctp.h"
+#include "src/shared/avctp.h"
 
 struct test_pdu {
 	bool valid;
-- 
1.8.5.3

