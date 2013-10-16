Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 5/6] android: sdp: Reuse BlueZ SDP server in Android
Date: Wed, 16 Oct 2013 11:46:54 +0300
Message-Id: <1381913215-17957-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381913215-17957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381913215-17957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Reuse existing SDP server code in Android GPL daemon.
---
 Makefile.android   |    4 +++-
 android/Android.mk |    8 ++++++++
 android/main.c     |    5 +++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Makefile.android b/Makefile.android
index 7371a77..48af2e2 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -2,9 +2,11 @@ if ANDROID
 noinst_PROGRAMS += android/bluetoothd
 
 android_bluetoothd_SOURCES = android/main.c src/log.c \
+				src/sdpd-database.c src/sdpd-server.c \
+				src/sdpd-service.c src/sdpd-request.c \
 				src/shared/util.h src/shared/util.c \
 				src/shared/mgmt.h src/shared/mgmt.c
-android_bluetoothd_LDADD = @GLIB_LIBS@
+android_bluetoothd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 endif
 
 EXTRA_DIST += android/Android.mk android/log.c
diff --git a/android/Android.mk b/android/Android.mk
index 4996080..560fb0a 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -17,6 +17,13 @@ LOCAL_SRC_FILES := \
 	log.c \
 	../src/shared/mgmt.c \
 	../src/shared/util.c \
+	../src/sdpd-database.c \
+	../src/sdpd-service.c \
+	../src/sdpd-request.c \
+	../src/sdpd-server.c \
+	../lib/sdp.c \
+	../lib/bluetooth.c \
+	../lib/hci.c \
 
 LOCAL_C_INCLUDES := \
 	$(call include-path-for, glib) \
@@ -25,6 +32,7 @@ LOCAL_C_INCLUDES := \
 LOCAL_C_INCLUDES += \
 	$(LOCAL_PATH)/../ \
 	$(LOCAL_PATH)/../src \
+	$(LOCAL_PATH)/../lib \
 
 LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
 
diff --git a/android/main.c b/android/main.c
index ba25b84..2b8675d 100644
--- a/android/main.c
+++ b/android/main.c
@@ -36,6 +36,7 @@
 #include <glib.h>
 
 #include "log.h"
+#include "sdpd.h"
 
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
@@ -267,10 +268,14 @@ int main(int argc, char *argv[])
 	if (!init_mgmt_interface())
 		return EXIT_FAILURE;
 
+	/* Use params: mtu = 0, flags = 0 */
+	start_sdp_server(0, 0);
+
 	DBG("Entering main loop");
 
 	g_main_loop_run(event_loop);
 
+	stop_sdp_server();
 	cleanup_mgmt_interface();
 	g_main_loop_unref(event_loop);
 
-- 
1.7.10.4

