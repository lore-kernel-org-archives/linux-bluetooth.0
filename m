Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] scpp: Move code from android to profiles
Date: Wed, 11 Nov 2015 16:05:12 +0200
Message-Id: <1447250715-10804-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1447250715-10804-1-git-send-email-luiz.dentz@gmail.com>
References: <1447250715-10804-1-git-send-email-luiz.dentz@gmail.com>
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
 {android => profiles/scanparam}/scpp.c | 2 +-
 {android => profiles/scanparam}/scpp.h | 0
 6 files changed, 6 insertions(+), 5 deletions(-)
 rename {android => profiles/scanparam}/scpp.c (99%)
 rename {android => profiles/scanparam}/scpp.h (100%)

diff --git a/Makefile.am b/Makefile.am
index 1027613..34fb27f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -401,7 +401,7 @@ unit_tests += unit/test-hog
 unit_test_hog_SOURCES = unit/test-hog.c \
 			$(btio_sources) \
 			android/hog.h android/hog.c \
-			android/scpp.h android/scpp.c \
+			profiles/scanparam/scpp.h profiles/scanparam/scpp.c \
 			profiles/battery/bas.h profiles/battery/bas.c \
 			android/dis.h android/dis.c \
 			src/log.h src/log.c \
diff --git a/android/Android.mk b/android/Android.mk
index 2f1f6bb..03afacd 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -39,7 +39,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := \
 	bluez/android/main.c \
 	bluez/android/bluetooth.c \
-	bluez/android/scpp.c \
+	bluez/profiles/scanparam/scpp.c \
 	bluez/android/dis.c \
 	bluez/profiles/battery/bas.c \
 	bluez/android/hog.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 63bcb63..128e9dd 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -28,7 +28,8 @@ android_bluetoothd_SOURCES = android/main.c \
 				src/eir.h src/eir.c \
 				android/bluetooth.h android/bluetooth.c \
 				android/hidhost.h android/hidhost.c \
-				android/scpp.h android/scpp.c \
+				profiles/scanparam/scpp.h \
+				profiles/scanparam/scpp.c \
 				android/dis.h android/dis.c \
 				profiles/battery/bas.h profiles/battery/bas.c \
 				android/hog.h android/hog.c \
diff --git a/android/hog.c b/android/hog.c
index 93e0655..e0decac 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -53,7 +53,7 @@
 
 #include "btio/btio.h"
 
-#include "android/scpp.h"
+#include "profiles/scanparam/scpp.h"
 #include "android/dis.h"
 #include "profiles/battery/bas.h"
 #include "android/hog.h"
diff --git a/android/scpp.c b/profiles/scanparam/scpp.c
similarity index 99%
rename from android/scpp.c
rename to profiles/scanparam/scpp.c
index a432733..df65d2c 100644
--- a/android/scpp.c
+++ b/profiles/scanparam/scpp.c
@@ -44,7 +44,7 @@
 #include "attrib/gattrib.h"
 #include "attrib/gatt.h"
 
-#include "android/scpp.h"
+#include "profiles/scanparam/scpp.h"
 
 #define SCAN_INTERVAL_WIN_UUID		0x2A4F
 #define SCAN_REFRESH_UUID		0x2A31
diff --git a/android/scpp.h b/profiles/scanparam/scpp.h
similarity index 100%
rename from android/scpp.h
rename to profiles/scanparam/scpp.h
-- 
2.4.3

