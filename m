Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 4/7] dis: Move code from android to profiles
Date: Thu, 12 Nov 2015 17:46:25 +0200
Message-Id: <1447343188-21628-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1447343188-21628-1-git-send-email-luiz.dentz@gmail.com>
References: <1447343188-21628-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is a place holder until the code is ported to use shared API so it
can be shared by android and D-Bus daemon.
---
 Makefile.am                            | 2 +-
 android/Android.mk                     | 2 +-
 android/Makefile.am                    | 3 ++-
 android/hog.c                          | 2 +-
 {android => profiles/deviceinfo}/dis.c | 2 +-
 {android => profiles/deviceinfo}/dis.h | 0
 6 files changed, 6 insertions(+), 5 deletions(-)
 rename {android => profiles/deviceinfo}/dis.c (99%)
 rename {android => profiles/deviceinfo}/dis.h (100%)

diff --git a/Makefile.am b/Makefile.am
index 34fb27f..3a29412 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -403,7 +403,7 @@ unit_test_hog_SOURCES = unit/test-hog.c \
 			android/hog.h android/hog.c \
 			profiles/scanparam/scpp.h profiles/scanparam/scpp.c \
 			profiles/battery/bas.h profiles/battery/bas.c \
-			android/dis.h android/dis.c \
+			profiles/deviceinfo/dis.h profiles/deviceinfo/dis.c \
 			src/log.h src/log.c \
 			attrib/att.h attrib/att.c \
 			attrib/gatt.h attrib/gatt.c \
diff --git a/android/Android.mk b/android/Android.mk
index 03afacd..1399178 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -40,7 +40,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/main.c \
 	bluez/android/bluetooth.c \
 	bluez/profiles/scanparam/scpp.c \
-	bluez/android/dis.c \
+	bluez/profiles/deviceinfo/dis.c \
 	bluez/profiles/battery/bas.c \
 	bluez/android/hog.c \
 	bluez/android/hidhost.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 128e9dd..7d66929 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -30,7 +30,8 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/hidhost.h android/hidhost.c \
 				profiles/scanparam/scpp.h \
 				profiles/scanparam/scpp.c \
-				android/dis.h android/dis.c \
+				profiles/deviceinfo/dis.h \
+				profiles/deviceinfo/dis.c \
 				profiles/battery/bas.h profiles/battery/bas.c \
 				android/hog.h android/hog.c \
 				android/ipc-common.h \
diff --git a/android/hog.c b/android/hog.c
index e0decac..ab1e008 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -54,7 +54,7 @@
 #include "btio/btio.h"
 
 #include "profiles/scanparam/scpp.h"
-#include "android/dis.h"
+#include "profiles/deviceinfo/dis.h"
 #include "profiles/battery/bas.h"
 #include "android/hog.h"
 
diff --git a/android/dis.c b/profiles/deviceinfo/dis.c
similarity index 99%
rename from android/dis.c
rename to profiles/deviceinfo/dis.c
index 0c20850..91c5d39 100644
--- a/android/dis.c
+++ b/profiles/deviceinfo/dis.c
@@ -42,7 +42,7 @@
 #include "attrib/att.h"
 #include "attrib/gatt.h"
 
-#include "android/dis.h"
+#include "profiles/deviceinfo/dis.h"
 
 #define PNP_ID_SIZE	7
 
diff --git a/android/dis.h b/profiles/deviceinfo/dis.h
similarity index 100%
rename from android/dis.h
rename to profiles/deviceinfo/dis.h
-- 
2.4.3

