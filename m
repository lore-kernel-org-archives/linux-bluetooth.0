Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC] android: Add support for Valgrind in debug variants
Date: Thu, 23 Jan 2014 18:54:04 +0100
Message-ID: <1390499644-8027-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1390499644-8027-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1390499644-8027-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch automatically builds BlueZ in a way it can be easily run
with Valgrind which is available in AOSP tree.

For userdebug and eng variant, bluetoothd will have additional
dependency to necessary Valgrind modules and bluetoothd binary will not
be stripped. Special version of init.bluetooth.rc is also provided
which defines bluetoothd service to be run using Valgrind with proper
environment and it will be installed automatically as well.
---
 android/Android.mk              | 13 +++++++++++++
 android/init.bluetooth.rc-debug | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 android/init.bluetooth.rc-debug

diff --git a/android/Android.mk b/android/Android.mk
index c274295..55093d2 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -80,6 +80,15 @@ $(foreach file,$(lib_headers), $(shell ln -sf ../$(file) $(LOCAL_PATH)/bluez/lib
 LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE := bluetoothd
 
+ifneq (,$(filter userdebug eng,$(TARGET_BUILD_VARIANT)))
+LOCAL_STRIP_MODULE := false
+LOCAL_REQUIRED_MODULES := valgrind \
+	memcheck-$(TARGET_ARCH)-linux \
+	vgpreload_core-$(TARGET_ARCH)-linux \
+	vgpreload_memcheck-$(TARGET_ARCH)-linux \
+	default.supp
+endif
+
 include $(BUILD_EXECUTABLE)
 
 #
@@ -294,7 +303,11 @@ include $(CLEAR_VARS)
 
 LOCAL_MODULE := init.bluetooth.rc
 LOCAL_MODULE_CLASS := ETC
+ifneq (,$(filter userdebug eng,$(TARGET_BUILD_VARIANT)))
+LOCAL_SRC_FILES := bluez/android/$(LOCAL_MODULE)-debug
+else
 LOCAL_SRC_FILES := bluez/android/$(LOCAL_MODULE)
+endif
 LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)
 
diff --git a/android/init.bluetooth.rc-debug b/android/init.bluetooth.rc-debug
new file mode 100644
index 0000000..c6c382c
--- /dev/null
+++ b/android/init.bluetooth.rc-debug
@@ -0,0 +1,39 @@
+# required permissions
+on boot
+    chown bluetooth bluetooth /data/misc/bluetooth
+    chown bluetooth bluetooth /dev/uhid
+
+# services
+on property:bluetooth.start=daemon
+    setprop bluetooth.start none
+    start bluetoothd
+
+on property:bluetooth.stop=daemon
+    setprop bluetooth.stop none
+    stop bluetoothd
+
+on property:bluetooth.start=snoop
+    setprop bluetooth.start none
+    start bluetoothd-snoop
+
+on property:bluetooth.stop=snoop
+    setprop bluetooth.stop none
+    stop bluetoothd-snoop
+
+service bluetoothd /system/bin/logwrapper /system/bin/valgrind --leak-check=full /system/bin/bluetoothd
+    setenv G_SLICE always-malloc
+    setenv G_DEBUG gc-friendly
+    class main
+    # init does not yet support setting capabilities so run as root,
+    # bluetoothd drop uid to bluetooth with the right linux capabilities
+    group bluetooth
+    disabled
+    oneshot
+
+service bluetoothd-snoop /system/bin/logwrapper /system/bin/bluetoothd-snoop
+    class main
+    # init does not yet support setting capabilities so run as root,
+    # bluetoothd-snoop drops unneeded linux capabilities
+    group nobody
+    disabled
+    oneshot
-- 
1.8.5.2

