Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 09/14] android: sdp: Reuse BlueZ SDP server in Android
Date: Thu,  3 Oct 2013 17:38:15 +0300
Message-Id: <1380811100-30144-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1380811100-30144-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380811100-30144-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Reuse existing SDP server code in Android GPL daemon.
---
 Makefile.android     |    7 +++++--
 android/Android.mk   |    7 +++++++
 android/bt_adapter.c |    5 ++++-
 android/main.c       |   27 +++++++++++++++++++++++++++
 android/main.h       |   25 +++++++++++++++++++++++++
 5 files changed, 68 insertions(+), 3 deletions(-)
 create mode 100644 android/main.h

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
index 115a9d7..5ac68ba 100644
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
 
@@ -36,6 +42,7 @@ LOCAL_CFLAGS += -DSOCK_CLOEXEC=02000000 -DSOCK_NONBLOCK=04000
 
 LOCAL_SHARED_LIBRARIES := \
 	libglib \
+	libbluetooth \
 
 LOCAL_MODULE := bluetoothd
 LOCAL_REQUIRED_MODULES := libbluetooth
diff --git a/android/bt_adapter.c b/android/bt_adapter.c
index e21d50c..5016243 100644
--- a/android/bt_adapter.c
+++ b/android/bt_adapter.c
@@ -23,6 +23,7 @@
 
 #include "bt_adapter.h"
 #include "log.h"
+#include "main.h"
 #include "src/shared/mgmt.h"
 
 struct bt_adapter *bt_adapter_new(uint16_t index, struct mgmt *mgmt_if)
@@ -45,7 +46,7 @@ void adapter_start(struct bt_adapter *adapter)
 
 	/* TODO: CB: report scan mode */
 
-	/* TODO: SDP start here */
+	sdp_start();
 
 	/* TODO: CB: report state on */
 }
@@ -53,4 +54,6 @@ void adapter_start(struct bt_adapter *adapter)
 void adapter_stop(struct bt_adapter *adapter)
 {
 	DBG("disabled %u", adapter->dev_id);
+
+	sdp_stop();
 }
diff --git a/android/main.c b/android/main.c
index ae31f65..cbbeabc 100644
--- a/android/main.c
+++ b/android/main.c
@@ -36,6 +36,9 @@
 #include <glib.h>
 
 #include "log.h"
+#include "hcid.h"
+#include "sdpd.h"
+#include "main.h"
 
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
@@ -43,12 +46,36 @@
 
 #define SHUTDOWN_GRACE_SECONDS 10
 
+struct main_opts main_opts;
+
 static GMainLoop *event_loop;
 static struct mgmt *mgmt_if = NULL;
 
 static uint8_t mgmt_version = 0;
 static uint8_t mgmt_revision = 0;
 
+int sdp_start(void)
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
+void sdp_stop(void)
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
diff --git a/android/main.h b/android/main.h
new file mode 100644
index 0000000..6ecad14
--- /dev/null
+++ b/android/main.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+int sdp_start(void);
+void sdp_stop(void);
-- 
1.7.10.4

