Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 1/4] android: Add sample init.bluetooth.rc file
Date: Tue, 14 Jan 2014 16:28:00 +0100
Message-Id: <1389713283-13038-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This file is intended to be included from device init.rc.
---
 android/Android.mk        | 16 +++++++++++++++-
 android/Makefile.am       |  1 +
 android/init.bluetooth.rc | 27 +++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 android/init.bluetooth.rc

diff --git a/android/Android.mk b/android/Android.mk
index ae52ab4..f13e703 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -109,7 +109,7 @@ LOCAL_MODULE := bluetooth.default
 LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
 LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE_CLASS := SHARED_LIBRARIES
-LOCAL_REQUIRED_MODULES := bluetoothd bluetoothd-snoop
+LOCAL_REQUIRED_MODULES := bluetoothd bluetoothd-snoop init.bluetooth.rc
 
 include $(BUILD_SHARED_LIBRARY)
 
@@ -263,3 +263,17 @@ LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE := bluetoothd-snoop
 
 include $(BUILD_EXECUTABLE)
+
+#
+# init.bleutooth.rc
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_MODULE := init.bluetooth.rc
+LOCAL_MODULE_CLASS := ETC
+LOCAL_SRC_FILES := $(LOCAL_MODULE)
+LOCAL_MODULE_TAGS := optional
+LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)
+
+include $(BUILD_PREBUILT)
diff --git a/android/Makefile.am b/android/Makefile.am
index 7806f79..b205019 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -134,6 +134,7 @@ android_audio_a2dp_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
 endif
 
 EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
+		android/init.bluetooth.rc \
 		android/pics-gap.txt android/pics-hid.txt \
 		android/pics-pan.txt android/pics-did.txt \
 		android/pics-opp.txt android/pics-pbap.txt \
diff --git a/android/init.bluetooth.rc b/android/init.bluetooth.rc
new file mode 100644
index 0000000..e2be9e8
--- /dev/null
+++ b/android/init.bluetooth.rc
@@ -0,0 +1,27 @@
+chown bluetooth bluetooth /data/misc/bluetooth
+
+chown bluetooth bluetooth /dev/uhid
+
+on property:bluetooth.start=bluetoothd
+    start bluetoothd
+
+on property:bluetooth.stop=bluetoothd
+    stop bluetoothd
+
+on property:bluetooth.start=bluetoothd-snoop
+    start bluetoothd-snoop
+
+on property:bluetooth.stop=bluetoothd-snoop
+    stop bluetoothd-snoop
+
+service bluetoothd /system/bin/logwrapper /system/bin/bluetoothd
+    class main
+    group bluetooth net_admin
+    disabled
+    oneshot
+
+service bluetoothd-snoop /system/bin/bluetoothd-snoop
+    class main
+    group bluetooth net_admin
+    disabled
+    oneshot
-- 
1.8.3.2

