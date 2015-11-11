Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] bas: Move code from android to profiles
Date: Wed, 11 Nov 2015 16:05:11 +0200
Message-Id: <1447250715-10804-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1447250715-10804-1-git-send-email-luiz.dentz@gmail.com>
References: <1447250715-10804-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is a place holder until the code is ported to use shared API so it
can be shared by android and D-Bus daemon.
---
 Makefile.am                         | 2 +-
 android/Android.mk                  | 2 +-
 android/Makefile.am                 | 2 +-
 android/hog.c                       | 2 +-
 {android => profiles/battery}/bas.c | 2 +-
 {android => profiles/battery}/bas.h | 0
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename {android => profiles/battery}/bas.c (99%)
 rename {android => profiles/battery}/bas.h (100%)

diff --git a/Makefile.am b/Makefile.am
index 614922e..1027613 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -402,7 +402,7 @@ unit_test_hog_SOURCES = unit/test-hog.c \
 			$(btio_sources) \
 			android/hog.h android/hog.c \
 			android/scpp.h android/scpp.c \
-			android/bas.h android/bas.c \
+			profiles/battery/bas.h profiles/battery/bas.c \
 			android/dis.h android/dis.c \
 			src/log.h src/log.c \
 			attrib/att.h attrib/att.c \
diff --git a/android/Android.mk b/android/Android.mk
index 89ca2c2..2f1f6bb 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -41,7 +41,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/bluetooth.c \
 	bluez/android/scpp.c \
 	bluez/android/dis.c \
-	bluez/android/bas.c \
+	bluez/profiles/battery/bas.c \
 	bluez/android/hog.c \
 	bluez/android/hidhost.c \
 	bluez/android/socket.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index cb32bc3..63bcb63 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -30,7 +30,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/hidhost.h android/hidhost.c \
 				android/scpp.h android/scpp.c \
 				android/dis.h android/dis.c \
-				android/bas.h android/bas.c \
+				profiles/battery/bas.h profiles/battery/bas.c \
 				android/hog.h android/hog.c \
 				android/ipc-common.h \
 				android/ipc.h android/ipc.c \
diff --git a/android/hog.c b/android/hog.c
index 3af9329..93e0655 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -55,7 +55,7 @@
 
 #include "android/scpp.h"
 #include "android/dis.h"
-#include "android/bas.h"
+#include "profiles/battery/bas.h"
 #include "android/hog.h"
 
 #define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
diff --git a/android/bas.c b/profiles/battery/bas.c
similarity index 99%
rename from android/bas.c
rename to profiles/battery/bas.c
index 7a1c4ca..de369fd 100644
--- a/android/bas.c
+++ b/profiles/battery/bas.c
@@ -43,7 +43,7 @@
 #include "attrib/att.h"
 #include "attrib/gatt.h"
 
-#include "android/bas.h"
+#include "profiles/battery/bas.h"
 
 #define ATT_NOTIFICATION_HEADER_SIZE 3
 #define ATT_READ_RESPONSE_HEADER_SIZE 1
diff --git a/android/bas.h b/profiles/battery/bas.h
similarity index 100%
rename from android/bas.h
rename to profiles/battery/bas.h
-- 
2.4.3

