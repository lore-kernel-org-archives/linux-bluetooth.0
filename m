Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/2] android: Avoid creating symlinks in lib/
Date: Fri, 4 Apr 2014 12:48:54 +0200
Message-ID: <1396608535-13182-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add bluetooth-headers module which is fake static library
to provide headers from lib/ directory in proper manner, i.e. from
bluetooth/ directory. Headers are copied to intermediates directory
and proper include path is added by build system once dependency to
this module is added. It's not longer necessary to specify lib/
directory on include path for each module.

This is to avoid modyfing source repository by creating symlinks in
lib/ directory - now it's possible to build BlueZ without touching
source repository at all.
---
 android/Android.mk | 64 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 3a62485..c31b57e 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -74,27 +74,14 @@ LOCAL_C_INCLUDES := \
 
 LOCAL_C_INCLUDES += \
 	$(LOCAL_PATH)/bluez \
-	$(LOCAL_PATH)/bluez/lib \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
 LOCAL_SHARED_LIBRARIES := \
 	libglib \
 
-lib_headers := \
-	bluetooth.h \
-	hci.h \
-	hci_lib.h \
-	l2cap.h \
-	sdp_lib.h \
-	sdp.h \
-	rfcomm.h \
-	sco.h \
-	bnep.h \
-
-$(shell mkdir -p $(LOCAL_PATH)/bluez/lib/bluetooth)
-
-$(foreach file,$(lib_headers), $(shell ln -sf ../$(file) $(LOCAL_PATH)/bluez/lib/bluetooth/$(file)))
+LOCAL_STATIC_LIBRARIES := \
+	bluetooth-headers \
 
 LOCAL_MODULE_TAGS := optional
 
@@ -215,10 +202,12 @@ LOCAL_SRC_FILES := \
 
 LOCAL_C_INCLUDES := \
 	$(LOCAL_PATH)/bluez \
-	$(LOCAL_PATH)/bluez/lib \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
+LOCAL_STATIC_LIBRARIES := \
+	bluetooth-headers \
+
 LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
 LOCAL_MODULE_TAGS := debug
 LOCAL_MODULE := btmon
@@ -285,10 +274,12 @@ LOCAL_SRC_FILES := \
 
 LOCAL_C_INCLUDES := \
 	$(LOCAL_PATH)/bluez \
-	$(LOCAL_PATH)/bluez/lib \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
+LOCAL_STATIC_LIBRARIES := \
+	bluetooth-headers \
+
 LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
 LOCAL_MODULE_TAGS := debug
 LOCAL_MODULE := l2test
@@ -350,10 +341,12 @@ LOCAL_SRC_FILES := \
 
 LOCAL_C_INCLUDES := \
 	$(LOCAL_PATH)/bluez \
-	$(LOCAL_PATH)/bluez/lib \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
+LOCAL_STATIC_LIBRARIES := \
+	bluetooth-headers \
+
 LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
 LOCAL_MODULE_TAGS := debug
 LOCAL_MODULE := btmgmt
@@ -374,10 +367,12 @@ LOCAL_SRC_FILES := \
 
 LOCAL_C_INCLUDES := \
 	$(LOCAL_PATH)/bluez \
-	$(LOCAL_PATH)/bluez/lib \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
+LOCAL_STATIC_LIBRARIES := \
+	bluetooth-headers \
+
 LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
 LOCAL_MODULE_TAGS := debug
 LOCAL_MODULE := hcitool
@@ -395,11 +390,11 @@ LOCAL_SRC_FILES := \
 	bluez/lib/bluetooth.c \
 	bluez/lib/hci.c \
 
-LOCAL_C_INCLUDES := \
-	$(LOCAL_PATH)/bluez/lib \
-
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
+LOCAL_STATIC_LIBRARIES := \
+	bluetooth-headers \
+
 LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
 LOCAL_MODULE_TAGS := debug
 LOCAL_MODULE := l2ping
@@ -417,11 +412,11 @@ LOCAL_SRC_FILES := \
 	bluez/lib/bluetooth.c \
 	bluez/lib/hci.c \
 
-LOCAL_C_INCLUDES := \
-	$(LOCAL_PATH)/bluez/lib \
-
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
+LOCAL_STATIC_LIBRARIES := \
+	bluetooth-headers \
+
 LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
 LOCAL_MODULE_TAGS := debug
 LOCAL_MODULE := avtest
@@ -490,3 +485,22 @@ LOCAL_REQUIRED_MODULES := \
 include $(BUILD_EXECUTABLE)
 
 endif
+
+#
+# bluetooth-headers
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_MODULE := bluetooth-headers
+LOCAL_NODULE_TAGS := optional
+LOCAL_MODULE_CLASS := STATIC_LIBRARIES
+
+include_path := $(local-intermediates-dir)/include
+include_files := $(wildcard $(LOCAL_PATH)/bluez/lib/*.h)
+$(shell mkdir -p $(include_path)/bluetooth)
+$(foreach file,$(include_files),$(shell cp -u $(file) $(include_path)/bluetooth))
+
+LOCAL_EXPORT_C_INCLUDE_DIRS := $(include_path)
+
+include $(BUILD_STATIC_LIBRARY)
\ No newline at end of file
-- 
1.9.1

