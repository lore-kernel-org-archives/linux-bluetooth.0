Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] android/mce: Add Android MCE header
Date: Mon, 22 Sep 2014 13:01:45 +0200
Message-Id: <1411383708-28621-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1411383708-28621-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1411383708-28621-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This header file has been taken from Codeaurora forum.
---
 android/Makefile.am       |  1 +
 android/hardware/bt_mce.h | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 android/hardware/bt_mce.h

diff --git a/android/Makefile.am b/android/Makefile.am
index b576fda..9980c4c 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -90,6 +90,7 @@ android_bluetooth_default_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hardware/bt_rc.h \
 					android/hardware/bt_sock.h \
 					android/hardware/bt_hf_client.h \
+					android/hardware/bt_mce.h \
 					android/hardware/hardware.h \
 					android/cutils/properties.h \
 					android/ipc-common.h \
diff --git a/android/hardware/bt_mce.h b/android/hardware/bt_mce.h
new file mode 100644
index 0000000..c87f64e
--- /dev/null
+++ b/android/hardware/bt_mce.h
@@ -0,0 +1,57 @@
+/*
+ * Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ * Not a Contribution
+ *
+ * Copyright (C) 2012 The Android Open Source Project
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+
+#ifndef ANDROID_INCLUDE_BT_MCE_H
+#define ANDROID_INCLUDE_BT_MCE_H
+
+__BEGIN_DECLS
+
+/** MAS instance description */
+typedef struct
+{
+    int  id;
+    int  scn;
+    int  msg_types;
+    char *p_name;
+} btmce_mas_instance_t;
+
+/** callback for get_remote_mas_instances */
+typedef void (*btmce_remote_mas_instances_callback)(bt_status_t status, bt_bdaddr_t *bd_addr,
+                                                    int num_instances, btmce_mas_instance_t *instances);
+
+typedef struct {
+    /** set to sizeof(btmce_callbacks_t) */
+    size_t      size;
+    btmce_remote_mas_instances_callback  remote_mas_instances_cb;
+} btmce_callbacks_t;
+
+typedef struct {
+    /** set to size of this struct */
+    size_t size;
+
+    /** register BT MCE callbacks */
+    bt_status_t (*init)(btmce_callbacks_t *callbacks);
+
+    /** search for MAS instances on remote device */
+    bt_status_t (*get_remote_mas_instances)(bt_bdaddr_t *bd_addr);
+} btmce_interface_t;
+
+__END_DECLS
+
+#endif /* ANDROID_INCLUDE_BT_MCE_H */
-- 
1.9.3

