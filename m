Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/2] mcap: Rename mcap-lib to mcap
Date: Thu,  2 Oct 2014 15:25:16 +0300
Message-Id: <1412252717-11671-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.plugins                       | 2 +-
 android/Android.mk                     | 4 ++--
 android/Makefile.am                    | 4 ++--
 android/health.c                       | 2 +-
 android/mcaptest.c                     | 2 +-
 profiles/health/hdp.c                  | 2 +-
 profiles/health/hdp_util.c             | 2 +-
 profiles/health/{mcap-lib.c => mcap.c} | 2 +-
 profiles/health/{mcap-lib.h => mcap.h} | 0
 9 files changed, 10 insertions(+), 10 deletions(-)
 rename profiles/health/{mcap-lib.c => mcap.c} (99%)
 rename profiles/health/{mcap-lib.h => mcap.h} (100%)

diff --git a/Makefile.plugins b/Makefile.plugins
index 7fd0e50..0448b91 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -64,7 +64,7 @@ builtin_sources += profiles/input/hog.c profiles/input/uhid_copy.h \
 
 if EXPERIMENTAL
 builtin_modules += health
-builtin_sources += profiles/health/mcap-lib.h profiles/health/mcap-lib.c \
+builtin_sources += profiles/health/mcap.h profiles/health/mcap.c \
 			profiles/health/hdp_main.c profiles/health/hdp_types.h \
 			profiles/health/hdp_manager.h \
 			profiles/health/hdp_manager.c \
diff --git a/android/Android.mk b/android/Android.mk
index 3ace786..eb67690 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -56,7 +56,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/handsfree-client.c \
 	bluez/android/gatt.c \
 	bluez/android/health.c \
-	bluez/profiles/health/mcap-lib.c \
+	bluez/profiles/health/mcap.c \
 	bluez/src/log.c \
 	bluez/src/shared/mgmt.c \
 	bluez/src/shared/util.c \
@@ -211,7 +211,7 @@ LOCAL_SRC_FILES := \
 	bluez/btio/btio.c \
 	bluez/lib/bluetooth.c \
 	bluez/lib/hci.c \
-	bluez/profiles/health/mcap-lib.c \
+	bluez/profiles/health/mcap.c \
 	bluez/android/mcaptest.c \
 
 LOCAL_C_INCLUDES := \
diff --git a/android/Makefile.am b/android/Makefile.am
index 4953531..75802dd 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -45,7 +45,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/handsfree-client.c android/handsfree-client.h \
 				android/gatt.h android/gatt.c \
 				android/health.h android/health.c \
-				profiles/health/mcap-lib.h profiles/health/mcap-lib.c \
+				profiles/health/mcap.h profiles/health/mcap.c \
 				attrib/att.c attrib/att.h \
 				attrib/gatt.c attrib/gatt.h \
 				attrib/gattrib.c attrib/gattrib.h \
@@ -95,7 +95,7 @@ noinst_PROGRAMS += android/mcaptest
 android_mcaptest_SOURCES = android/mcaptest.c \
 				src/log.h src/log.c \
 				btio/btio.h btio/btio.c \
-				profiles/health/mcap-lib.h profiles/health/mcap-lib.c
+				profiles/health/mcap.h profiles/health/mcap.c
 android_mcaptest_CFLAGS = $(AM_CFLAGS)
 android_mcaptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
diff --git a/android/health.c b/android/health.c
index 5d161e0..75811aa 100644
--- a/android/health.c
+++ b/android/health.c
@@ -43,7 +43,7 @@
 #include "src/shared/queue.h"
 #include "src/uuid-helper.h"
 #include "src/sdp-client.h"
-#include "profiles/health/mcap-lib.h"
+#include "profiles/health/mcap.h"
 
 #include "hal-msg.h"
 #include "ipc-common.h"
diff --git a/android/mcaptest.c b/android/mcaptest.c
index 638220b..5ef030c 100644
--- a/android/mcaptest.c
+++ b/android/mcaptest.c
@@ -38,7 +38,7 @@
 
 #include "btio/btio.h"
 #include "lib/l2cap.h"
-#include "profiles/health/mcap-lib.h"
+#include "profiles/health/mcap.h"
 
 enum {
 	MODE_NONE,
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index d2e634a..c1ce1b8 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -45,7 +45,7 @@
 #include "hdp_types.h"
 #include "hdp_util.h"
 #include "hdp.h"
-#include "mcap-lib.h"
+#include "mcap.h"
 
 #define ECHO_TIMEOUT	1 /* second */
 #define HDP_ECHO_LEN	15
diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index c524054..af50b01 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -48,7 +48,7 @@
 #include "src/log.h"
 #include "src/dbus-common.h"
 
-#include "mcap-lib.h"
+#include "mcap.h"
 #include "hdp_types.h"
 #include "hdp.h"
 #include "hdp_util.h"
diff --git a/profiles/health/mcap-lib.c b/profiles/health/mcap.c
similarity index 99%
rename from profiles/health/mcap-lib.c
rename to profiles/health/mcap.c
index 1706d9f..a20a7ad 100644
--- a/profiles/health/mcap-lib.c
+++ b/profiles/health/mcap.c
@@ -38,7 +38,7 @@
 #include "btio/btio.h"
 #include "src/log.h"
 
-#include "mcap-lib.h"
+#include "mcap.h"
 
 #define MCAP_BTCLOCK_HALF (MCAP_BTCLOCK_FIELD / 2)
 #define CLK CLOCK_MONOTONIC
diff --git a/profiles/health/mcap-lib.h b/profiles/health/mcap.h
similarity index 100%
rename from profiles/health/mcap-lib.h
rename to profiles/health/mcap.h
-- 
1.9.1

