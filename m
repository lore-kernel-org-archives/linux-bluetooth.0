Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 7/7] android: Add PAN skeleton
Date: Thu, 17 Oct 2013 11:26:46 +0300
Message-Id: <1381998406-16662-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381998406-16662-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381998406-16662-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add skeleton for pan Android HAL. This is modified version
from Frederic Danis earlier patch set.
---
 android/Android.mk      |    1 +
 android/hal-bluetooth.c |    4 ++
 android/hal-pan.c       |  120 +++++++++++++++++++++++++++++++++++++++++++++++
 android/hal.h           |    1 +
 4 files changed, 126 insertions(+)
 create mode 100644 android/hal-pan.c

diff --git a/android/Android.mk b/android/Android.mk
index 25b4048..f273094 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -54,6 +54,7 @@ LOCAL_SRC_FILES := \
 	hal-bluetooth.c \
 	hal-bt-sock.c \
 	hal-hidhost.c \
+	hal-pan.c \
 
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 488606d..5f9d00b 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -23,6 +23,7 @@
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
 #include <hardware/bt_hh.h>
+#include <hardware/bt_pan.h>
 
 #include <cutils/sockets.h>
 #include <cutils/properties.h>
@@ -289,6 +290,9 @@ static const void *get_profile_interface(const char *profile_id)
 	if (!strcmp(profile_id, BT_PROFILE_HIDHOST_ID))
 		return bt_get_hidhost_interface();
 
+	if (!strcmp(profile_id, BT_PROFILE_PAN_ID))
+		return bt_get_pan_interface();
+
 	return NULL;
 }
 
diff --git a/android/hal-pan.c b/android/hal-pan.c
new file mode 100644
index 0000000..2f5c256
--- /dev/null
+++ b/android/hal-pan.c
@@ -0,0 +1,120 @@
+/*
+ * Copyright (C) 2013 Intel Corporation
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
+ *
+ */
+
+#include <stdbool.h>
+
+#include <hardware/bluetooth.h>
+#include <hardware/bt_pan.h>
+
+#define LOG_TAG "BlueZ"
+#include <cutils/log.h>
+
+const btpan_callbacks_t *bt_pan_cbacks = NULL;
+
+static bool interface_ready(void)
+{
+	return bt_pan_cbacks != NULL;
+}
+
+static bt_status_t bt_pan_enable(int local_role)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int bt_pan_get_local_role(void)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BTPAN_ROLE_NONE;
+
+	return BTPAN_ROLE_NONE;
+}
+
+static bt_status_t bt_pan_connect(const bt_bdaddr_t *bd_addr, int local_role,
+					int remote_role)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static bt_status_t bt_pan_disconnect(const bt_bdaddr_t *bd_addr)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static bt_status_t bt_pan_init(const btpan_callbacks_t *callbacks)
+{
+	ALOGI(__func__);
+
+	bt_pan_cbacks = callbacks;
+
+	/* TODO: start HID Host thread */
+
+	/* TODO: enable service */
+
+	return BT_STATUS_SUCCESS;
+}
+
+static void bt_pan_cleanup()
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return;
+
+	/* TODO: disable service */
+
+	/* TODO: stop PAN thread */
+
+	bt_pan_cbacks = NULL;
+}
+
+static btpan_interface_t bt_pan_if = {
+	.size = sizeof(bt_pan_if),
+	.init = bt_pan_init,
+	.enable = bt_pan_enable,
+	.get_local_role = bt_pan_get_local_role,
+	.connect = bt_pan_connect,
+	.disconnect = bt_pan_disconnect,
+	.cleanup = bt_pan_cleanup
+};
+
+btpan_interface_t *bt_get_pan_interface()
+{
+	return &bt_pan_if;
+}
diff --git a/android/hal.h b/android/hal.h
index be69339..38b90b2 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -17,3 +17,4 @@
 
 btsock_interface_t *bt_get_sock_interface(void);
 bthh_interface_t *bt_get_hidhost_interface(void);
+btpan_interface_t *bt_get_pan_interface(void);
-- 
1.7.10.4

