Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] android: Refactor paths in Android.mk
Date: Wed, 22 Jan 2014 00:45:53 +0100
Message-Id: <1390347953-29901-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Using source paths relative to android/ directory created mess in
Android's obj directory since object files are created also relative
to bluetoothd_intermediates (thus can be created outside it).

To avoid this we set LOCAL_PATH to absolute path (in terms of Android
build root) of directory in which bluez/ is located and change and
update source paths accordingly.

This also allows us to build in future glib and sbc easily using
Android.mk in BlueZ.
---
 android/Android.mk | 224 ++++++++++++++++++++++++++---------------------------
 1 file changed, 112 insertions(+), 112 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 3b8d471..43e6036 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -1,7 +1,7 @@
-LOCAL_PATH := $(call my-dir)
+LOCAL_PATH := external/bluetooth
 
 # Retrieve BlueZ version from configure.ac file
-BLUEZ_VERSION := $(shell grep ^AC_INIT $(LOCAL_PATH)/../configure.ac | cpp -P -D'AC_INIT(_,v)=v')
+BLUEZ_VERSION := $(shell grep ^AC_INIT $(LOCAL_PATH)/bluez/configure.ac | cpp -P -D'AC_INIT(_,v)=v')
 
 # Specify pathmap for glib
 pathmap_INCL += glib:external/bluetooth/glib
@@ -20,41 +20,41 @@ BLUEZ_COMMON_CFLAGS += -Wno-pointer-arith -Wno-missing-field-initializers
 include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
-	main.c \
-	bluetooth.c \
-	hidhost.c \
-	socket.c \
-	ipc.c \
-	audio-ipc.c \
-	avdtp.c \
-	a2dp.c \
-	pan.c \
-	../src/log.c \
-	../src/shared/mgmt.c \
-	../src/shared/util.c \
-	../src/shared/queue.c \
-	../src/shared/io-glib.c \
-	../src/sdpd-database.c \
-	../src/sdpd-service.c \
-	../src/sdpd-request.c \
-	../src/sdpd-server.c \
-	../src/uuid-helper.c \
-	../src/eir.c \
-	../lib/sdp.c \
-	../lib/bluetooth.c \
-	../lib/hci.c \
-	../btio/btio.c \
-	../src/sdp-client.c \
-	../profiles/network/bnep.c \
+	bluez/android/main.c \
+	bluez/android/bluetooth.c \
+	bluez/android/hidhost.c \
+	bluez/android/socket.c \
+	bluez/android/ipc.c \
+	bluez/android/audio-ipc.c \
+	bluez/android/avdtp.c \
+	bluez/android/a2dp.c \
+	bluez/android/pan.c \
+	bluez/src/log.c \
+	bluez/src/shared/mgmt.c \
+	bluez/src/shared/util.c \
+	bluez/src/shared/queue.c \
+	bluez/src/shared/io-glib.c \
+	bluez/src/sdpd-database.c \
+	bluez/src/sdpd-service.c \
+	bluez/src/sdpd-request.c \
+	bluez/src/sdpd-server.c \
+	bluez/src/uuid-helper.c \
+	bluez/src/eir.c \
+	bluez/lib/sdp.c \
+	bluez/lib/bluetooth.c \
+	bluez/lib/hci.c \
+	bluez/btio/btio.c \
+	bluez/src/sdp-client.c \
+	bluez/profiles/network/bnep.c \
 
 LOCAL_C_INCLUDES := \
 	$(call include-path-for, glib) \
 	$(call include-path-for, glib)/glib \
 
 LOCAL_C_INCLUDES += \
-	$(LOCAL_PATH)/../ \
-	$(LOCAL_PATH)/../src \
-	$(LOCAL_PATH)/../lib \
+	$(LOCAL_PATH)/bluez \
+	$(LOCAL_PATH)/bluez/src \
+	$(LOCAL_PATH)/bluez/lib \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
@@ -72,9 +72,9 @@ lib_headers := \
 	sco.h \
 	bnep.h \
 
-$(shell mkdir -p $(LOCAL_PATH)/../lib/bluetooth)
+$(shell mkdir -p $(LOCAL_PATH)/bluez/lib/bluetooth)
 
-$(foreach file,$(lib_headers), $(shell ln -sf ../$(file) $(LOCAL_PATH)/../lib/bluetooth/$(file)))
+$(foreach file,$(lib_headers), $(shell ln -sf ../$(file) $(LOCAL_PATH)/bluez/lib/bluetooth/$(file)))
 
 LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE := bluetoothd
@@ -88,13 +88,13 @@ include $(BUILD_EXECUTABLE)
 include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
-	hal-ipc.c \
-	hal-bluetooth.c \
-	hal-sock.c \
-	hal-hidhost.c \
-	hal-pan.c \
-	hal-a2dp.c \
-	hal-utils.c \
+	bluez/android/hal-ipc.c \
+	bluez/android/hal-bluetooth.c \
+	bluez/android/hal-sock.c \
+	bluez/android/hal-hidhost.c \
+	bluez/android/hal-pan.c \
+	bluez/android/hal-a2dp.c \
+	bluez/android/hal-utils.c \
 
 LOCAL_C_INCLUDES += \
 	$(call include-path-for, system-core) \
@@ -120,20 +120,20 @@ include $(BUILD_SHARED_LIBRARY)
 include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
-	client/haltest.c \
-	client/pollhandler.c \
-	client/terminal.c \
-	client/history.c \
-	client/tabcompletion.c \
-	client/if-audio.c \
-	client/if-av.c \
-	client/if-bt.c \
-	client/if-hf.c \
-	client/if-hh.c \
-	client/if-pan.c \
-	client/if-sock.c \
-	client/if-gatt.c \
-	hal-utils.c \
+	bluez/android/client/haltest.c \
+	bluez/android/client/pollhandler.c \
+	bluez/android/client/terminal.c \
+	bluez/android/client/history.c \
+	bluez/android/client/tabcompletion.c \
+	bluez/android/client/if-audio.c \
+	bluez/android/client/if-av.c \
+	bluez/android/client/if-bt.c \
+	bluez/android/client/if-hf.c \
+	bluez/android/client/if-hh.c \
+	bluez/android/client/if-pan.c \
+	bluez/android/client/if-sock.c \
+	bluez/android/client/if-gatt.c \
+	bluez/android/hal-utils.c \
 
 LOCAL_C_INCLUDES += \
 	$(call include-path-for, system-core) \
@@ -156,32 +156,32 @@ include $(BUILD_EXECUTABLE)
 include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
-	../monitor/main.c \
-	../monitor/mainloop.c \
-	../monitor/display.c \
-	../monitor/hcidump.c \
-	../monitor/btsnoop.c \
-	../monitor/control.c \
-	../monitor/packet.c \
-	../monitor/l2cap.c \
-	../monitor/uuid.c \
-	../monitor/sdp.c \
-	../monitor/vendor.c \
-	../monitor/lmp.c \
-	../monitor/crc.c \
-	../monitor/ll.c \
-	../monitor/hwdb.c \
-	../monitor/ellisys.c \
-	../monitor/analyze.c \
-	../src/shared/util.c \
-	../src/shared/queue.c \
-	../lib/hci.c \
-	../lib/bluetooth.c \
+	bluez/monitor/main.c \
+	bluez/monitor/mainloop.c \
+	bluez/monitor/display.c \
+	bluez/monitor/hcidump.c \
+	bluez/monitor/btsnoop.c \
+	bluez/monitor/control.c \
+	bluez/monitor/packet.c \
+	bluez/monitor/l2cap.c \
+	bluez/monitor/uuid.c \
+	bluez/monitor/sdp.c \
+	bluez/monitor/vendor.c \
+	bluez/monitor/lmp.c \
+	bluez/monitor/crc.c \
+	bluez/monitor/ll.c \
+	bluez/monitor/hwdb.c \
+	bluez/monitor/ellisys.c \
+	bluez/monitor/analyze.c \
+	bluez/src/shared/util.c \
+	bluez/src/shared/queue.c \
+	bluez/lib/hci.c \
+	bluez/lib/bluetooth.c \
 
 LOCAL_C_INCLUDES := \
-	$(LOCAL_PATH)/.. \
-	$(LOCAL_PATH)/../lib \
-	$(LOCAL_PATH)/../src/shared \
+	$(LOCAL_PATH)/bluez \
+	$(LOCAL_PATH)/bluez/lib \
+	$(LOCAL_PATH)/bluez/src/shared \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
@@ -198,13 +198,13 @@ include $(BUILD_EXECUTABLE)
 include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
-	../tools/btproxy.c \
-	../monitor/mainloop.c \
-	../src/shared/util.c \
+	bluez/tools/btproxy.c \
+	bluez/monitor/mainloop.c \
+	bluez/src/shared/util.c \
 
 LOCAL_C_INCLUDES := \
-	$(LOCAL_PATH)/.. \
-	$(LOCAL_PATH)/../src/shared \
+	$(LOCAL_PATH)/bluez \
+	$(LOCAL_PATH)/bluez/src/shared \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
@@ -220,7 +220,7 @@ include $(BUILD_EXECUTABLE)
 
 include $(CLEAR_VARS)
 
-LOCAL_SRC_FILES := hal-audio.c
+LOCAL_SRC_FILES := bluez/android/hal-audio.c
 
 LOCAL_C_INCLUDES = \
 	$(call include-path-for, system-core) \
@@ -244,14 +244,14 @@ include $(BUILD_SHARED_LIBRARY)
 include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
-	../tools/l2test.c \
-	../lib/bluetooth.c \
-	../lib/hci.c \
+	bluez/tools/l2test.c \
+	bluez/lib/bluetooth.c \
+	bluez/lib/hci.c \
 
 LOCAL_C_INCLUDES := \
-	$(LOCAL_PATH)/.. \
-	$(LOCAL_PATH)/../lib \
-	$(LOCAL_PATH)/../src/shared \
+	$(LOCAL_PATH)/bluez \
+	$(LOCAL_PATH)/bluez/lib \
+	$(LOCAL_PATH)/bluez/src/shared \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
@@ -268,13 +268,13 @@ include $(BUILD_EXECUTABLE)
 include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
-	bluetoothd-snoop.c \
-	../monitor/mainloop.c \
-	../src/shared/btsnoop.c \
+	bluez/android/bluetoothd-snoop.c \
+	bluez/monitor/mainloop.c \
+	bluez/src/shared/btsnoop.c \
 
 LOCAL_C_INCLUDES := \
-	$(LOCAL_PATH)/.. \
-	$(LOCAL_PATH)/../lib \
+	$(LOCAL_PATH)/bluez \
+	$(LOCAL_PATH)/bluez/lib \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
@@ -291,7 +291,7 @@ include $(CLEAR_VARS)
 
 LOCAL_MODULE := init.bluetooth.rc
 LOCAL_MODULE_CLASS := ETC
-LOCAL_SRC_FILES := $(LOCAL_MODULE)
+LOCAL_SRC_FILES := bluez/android/$(LOCAL_MODULE)
 LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)
 
@@ -304,20 +304,20 @@ include $(BUILD_PREBUILT)
 include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
-	../tools/btmgmt.c \
-	../lib/bluetooth.c \
-	../lib/sdp.c \
-	../monitor/mainloop.c \
-	../src/shared/io-mainloop.c \
-	../src/shared/mgmt.c \
-	../src/shared/queue.c \
-	../src/shared/util.c \
-	../src/uuid-helper.c \
+	bluez/tools/btmgmt.c \
+	bluez/lib/bluetooth.c \
+	bluez/lib/sdp.c \
+	bluez/monitor/mainloop.c \
+	bluez/src/shared/io-mainloop.c \
+	bluez/src/shared/mgmt.c \
+	bluez/src/shared/queue.c \
+	bluez/src/shared/util.c \
+	bluez/src/uuid-helper.c \
 
 LOCAL_C_INCLUDES := \
-	$(LOCAL_PATH)/.. \
-	$(LOCAL_PATH)/../src \
-	$(LOCAL_PATH)/../lib \
+	$(LOCAL_PATH)/bluez \
+	$(LOCAL_PATH)/bluez/src \
+	$(LOCAL_PATH)/bluez/lib \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
@@ -334,12 +334,12 @@ include $(BUILD_EXECUTABLE)
 include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
-	../tools/l2ping.c \
-	../lib/bluetooth.c \
-	../lib/hci.c \
+	bluez/tools/l2ping.c \
+	bluez/lib/bluetooth.c \
+	bluez/lib/hci.c \
 
 LOCAL_C_INCLUDES := \
-	$(LOCAL_PATH)/../lib \
+	$(LOCAL_PATH)/bluez/lib \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
-- 
1.8.5.2

