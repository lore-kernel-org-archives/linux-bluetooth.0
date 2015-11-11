Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] hog: Move code from android to profiles
Date: Wed, 11 Nov 2015 16:05:14 +0200
Message-Id: <1447250715-10804-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1447250715-10804-1-git-send-email-luiz.dentz@gmail.com>
References: <1447250715-10804-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is a place holder until the code is ported to use shared API so it
can be shared by android and D-Bus daemon.
---
 Makefile.am                               | 2 +-
 android/Android.mk                        | 2 +-
 android/Makefile.am                       | 3 ++-
 android/hidhost.c                         | 2 +-
 android/hog.c => profiles/input/hog-lib.c | 2 +-
 android/hog.h => profiles/input/hog-lib.h | 0
 unit/test-hog.c                           | 2 +-
 7 files changed, 7 insertions(+), 6 deletions(-)
 rename android/hog.c => profiles/input/hog-lib.c (99%)
 rename android/hog.h => profiles/input/hog-lib.h (100%)

diff --git a/Makefile.am b/Makefile.am
index 3a29412..444f6d5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -400,7 +400,7 @@ unit_tests += unit/test-hog
 
 unit_test_hog_SOURCES = unit/test-hog.c \
 			$(btio_sources) \
-			android/hog.h android/hog.c \
+			profiles/input/hog-lib.h profiles/input/hog-lib.c \
 			profiles/scanparam/scpp.h profiles/scanparam/scpp.c \
 			profiles/battery/bas.h profiles/battery/bas.c \
 			profiles/deviceinfo/dis.h profiles/deviceinfo/dis.c \
diff --git a/android/Android.mk b/android/Android.mk
index 1399178..694a94e 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -42,7 +42,7 @@ LOCAL_SRC_FILES := \
 	bluez/profiles/scanparam/scpp.c \
 	bluez/profiles/deviceinfo/dis.c \
 	bluez/profiles/battery/bas.c \
-	bluez/android/hog.c \
+	bluez/profiles/input/hog-lib.c \
 	bluez/android/hidhost.c \
 	bluez/android/socket.c \
 	bluez/android/ipc.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 7d66929..154f8db 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -33,7 +33,8 @@ android_bluetoothd_SOURCES = android/main.c \
 				profiles/deviceinfo/dis.h \
 				profiles/deviceinfo/dis.c \
 				profiles/battery/bas.h profiles/battery/bas.c \
-				android/hog.h android/hog.c \
+				profiles/input/hog-lib.h \
+				profiles/input/hog-lib.c \
 				android/ipc-common.h \
 				android/ipc.h android/ipc.c \
 				android/avdtp.h android/avdtp.c \
diff --git a/android/hidhost.c b/android/hidhost.c
index a2b820f..591ca95 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -44,13 +44,13 @@
 #include "src/sdp-client.h"
 #include "src/uuid-helper.h"
 #include "src/log.h"
+#include "profiles/input/hog-lib.h"
 
 #include "hal-msg.h"
 #include "ipc-common.h"
 #include "ipc.h"
 #include "bluetooth.h"
 #include "gatt.h"
-#include "hog.h"
 #include "hidhost.h"
 #include "utils.h"
 
diff --git a/android/hog.c b/profiles/input/hog-lib.c
similarity index 99%
rename from android/hog.c
rename to profiles/input/hog-lib.c
index ab1e008..a45e59f 100644
--- a/android/hog.c
+++ b/profiles/input/hog-lib.c
@@ -56,7 +56,7 @@
 #include "profiles/scanparam/scpp.h"
 #include "profiles/deviceinfo/dis.h"
 #include "profiles/battery/bas.h"
-#include "android/hog.h"
+#include "profiles/input/hog-lib.h"
 
 #define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
 
diff --git a/android/hog.h b/profiles/input/hog-lib.h
similarity index 100%
rename from android/hog.h
rename to profiles/input/hog-lib.h
diff --git a/unit/test-hog.c b/unit/test-hog.c
index 24731d7..9f026e5 100644
--- a/unit/test-hog.c
+++ b/unit/test-hog.c
@@ -37,7 +37,7 @@
 
 #include "attrib/gattrib.h"
 
-#include "android/hog.h"
+#include "profiles/input/hog-lib.h"
 
 struct test_pdu {
 	bool valid;
-- 
2.4.3

