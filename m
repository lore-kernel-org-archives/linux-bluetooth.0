Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 10/15] android: sdp: Reuse BlueZ SDP server in Android
Date: Tue,  8 Oct 2013 13:33:52 +0300
Message-Id: <1381228437-5553-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381228437-5553-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381228437-5553-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Reuse existing SDP server code in Android GPL daemon.
---
 Makefile.android     |    7 +++++--
 android/Android.mk   |    7 +++++++
 android/bt_adapter.c |    2 --
 android/main.c       |   28 ++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/Makefile.android b/Makefile.android
index 9a2c486..d576b52 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -2,9 +2,12 @@ if ANDROID
 noinst_PROGRAMS += android/bluetoothd
 
 android_bluetoothd_SOURCES = android/main.c src/log.c \
+				src/sdpd-database.c src/sdpd-server.c \
+				src/sdpd-service.c src/sdpd-request.c \
 				src/shared/util.h src/shared/util.c \
-				src/shared/mgmt.h src/shared/mgmt.c
-android_bluetoothd_LDADD = @GLIB_LIBS@
+				src/shared/mgmt.h src/shared/mgmt.c \
+				android/bt_adapter.h android/bt_adapter.c
+android_bluetoothd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 endif
 
 EXTRA_DIST += android/Android.mk android/log.c
diff --git a/android/Android.mk b/android/Android.mk
index 8f95a66..e7a70d0 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -17,6 +17,11 @@ LOCAL_SRC_FILES := \
 	log.c \
 	../src/shared/mgmt.c \
 	../src/shared/util.c \
+	bt_adapter.c \
+	../src/sdpd-database.c \
+	../src/sdpd-service.c \
+	../src/sdpd-request.c \
+	../src/sdpd-server.c \
 
 LOCAL_C_INCLUDES := \
 	$(call include-path-for, glib) \
@@ -25,6 +30,7 @@ LOCAL_C_INCLUDES := \
 LOCAL_C_INCLUDES += \
 	$(LOCAL_PATH)/../ \
 	$(LOCAL_PATH)/../src \
+	$(LOCAL_PATH)/../lib \
 
 LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
 
@@ -39,6 +45,7 @@ LOCAL_CFLAGS += -DSOCK_CLOEXEC=02000000 -DSOCK_NONBLOCK=04000
 
 LOCAL_SHARED_LIBRARIES := \
 	libglib \
+	libbluetooth \
 
 LOCAL_MODULE := bluetoothd
 LOCAL_REQUIRED_MODULES := libbluetooth
diff --git a/android/bt_adapter.c b/android/bt_adapter.c
index e21d50c..6b758bf 100644
--- a/android/bt_adapter.c
+++ b/android/bt_adapter.c
@@ -45,8 +45,6 @@ void adapter_start(struct bt_adapter *adapter)
 
 	/* TODO: CB: report scan mode */
 
-	/* TODO: SDP start here */
-
 	/* TODO: CB: report state on */
 }
 
diff --git a/android/main.c b/android/main.c
index 3580ac7..7968ed0 100644
--- a/android/main.c
+++ b/android/main.c
@@ -36,6 +36,8 @@
 #include <glib.h>
 
 #include "log.h"
+#include "hcid.h"
+#include "sdpd.h"
 
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
@@ -43,12 +45,36 @@
 
 #define SHUTDOWN_GRACE_SECONDS 10
 
+struct main_opts main_opts;
+
 static GMainLoop *event_loop;
 static struct mgmt *mgmt_if = NULL;
 
 static uint8_t mgmt_version = 0;
 static uint8_t mgmt_revision = 0;
 
+static int sdp_start(void)
+{
+	DBG("");
+
+	/* TODO: add logic */
+
+	/* sdpd-server use these settings */
+	memset(&main_opts, 0, sizeof(main_opts));
+
+	/* Use params: mtu = 0, flags = 0 */
+	return start_sdp_server(0, 0);
+}
+
+static void sdp_stop(void)
+{
+	DBG("");
+
+	/* TODO: add logic */
+
+	stop_sdp_server();
+}
+
 static gboolean quit_eventloop(gpointer user_data)
 {
 	g_main_loop_quit(event_loop);
@@ -287,11 +313,13 @@ int main(int argc, char *argv[])
 	sigaction(SIGTERM, &sa, NULL);
 
 	init_mgmt_interface();
+	sdp_start();
 
 	DBG("Entering main loop");
 
 	g_main_loop_run(event_loop);
 
+	sdp_stop();
 	cleanup_mgmt_interface();
 	g_main_loop_unref(event_loop);
 
-- 
1.7.10.4

