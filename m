Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android: Cleanup Android.mk
Date: Tue,  7 Jan 2014 16:27:33 +0100
Message-Id: <1389108453-19758-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove not needed headers file in source list (Android build handles
this), explicitly mark packages as optional and fix bluetooth.default
dependencies (it should not depend on haltest as it is optional debug
package and should not be installed in user build).
---
 android/Android.mk | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 27631cc..16339b1 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -25,8 +25,8 @@ LOCAL_SRC_FILES := \
 	bluetooth.c \
 	hidhost.c \
 	socket.c \
-	ipc.c ipc.h \
-	audio-ipc.c audio-ipc.h \
+	ipc.c \
+	audio-ipc.c \
 	avdtp.c \
 	a2dp.c \
 	pan.c \
@@ -75,6 +75,8 @@ $(shell mkdir -p $(LOCAL_PATH)/../lib/bluetooth)
 
 $(foreach file,$(lib_headers), $(shell ln -sf ../$(file) $(LOCAL_PATH)/../lib/bluetooth/$(file)))
 
+LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
+LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE := bluetoothd
 
 include $(BUILD_EXECUTABLE)
@@ -107,7 +109,7 @@ LOCAL_MODULE := bluetooth.default
 LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
 LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE_CLASS := SHARED_LIBRARIES
-LOCAL_REQUIRED_MODULES := haltest bluetoothd
+LOCAL_REQUIRED_MODULES := bluetoothd bluetoothd-snoop
 
 include $(BUILD_SHARED_LIBRARY)
 
@@ -146,7 +148,8 @@ LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
 LOCAL_SHARED_LIBRARIES := libhardware
 
-LOCAL_MODULE_TAGS := optional
+LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
+LOCAL_MODULE_TAGS := debug
 LOCAL_MODULE := haltest
 
 include $(BUILD_EXECUTABLE)
@@ -159,42 +162,23 @@ include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
 	../monitor/main.c \
-	../monitor/bt.h \
-	../monitor/mainloop.h \
 	../monitor/mainloop.c \
-	../monitor/display.h \
 	../monitor/display.c \
-	../monitor/hcidump.h \
 	../monitor/hcidump.c \
-	../monitor/btsnoop.h \
 	../monitor/btsnoop.c \
-	../monitor/control.h \
 	../monitor/control.c \
-	../monitor/packet.h \
 	../monitor/packet.c \
-	../monitor/l2cap.h \
 	../monitor/l2cap.c \
-	../monitor/uuid.h \
 	../monitor/uuid.c \
-	../monitor/sdp.h \
 	../monitor/sdp.c \
-	../monitor/vendor.h \
 	../monitor/vendor.c \
-	../monitor/lmp.h \
 	../monitor/lmp.c \
-	../monitor/crc.h \
 	../monitor/crc.c \
-	../monitor/ll.h \
 	../monitor/ll.c \
-	../monitor/hwdb.h \
 	../monitor/hwdb.c \
-	../monitor/ellisys.h \
 	../monitor/ellisys.c \
-	../monitor/analyze.h \
 	../monitor/analyze.c \
-	../src/shared/util.h \
 	../src/shared/util.c \
-	../src/shared/queue.h \
 	../src/shared/queue.c \
 	../lib/hci.c \
 	../lib/bluetooth.c \
-- 
1.8.3.2

