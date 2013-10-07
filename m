Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/2] android: Add PAN skeleton
Date: Mon,  7 Oct 2013 16:39:18 +0300
Message-Id: <1381153158-13207-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381153158-13207-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381153158-13207-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Frederic Danis <frederic.danis@linux.intel.com>

---
 android/Android.mk      |    1 +
 android/hal.h           |    1 +
 android/hal_bluetooth.c |    4 ++
 android/hal_pan.c       |  130 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 136 insertions(+)
 create mode 100644 android/hal_pan.c

diff --git a/android/Android.mk b/android/Android.mk
index d1cd2bc..453dcd3 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -65,6 +65,7 @@ LOCAL_SRC_FILES := \
 	hal_bt_sock.c \
 	hal_msg_client.c \
 	hal_hidhost.c \
+	hal_pan.c \
 
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
diff --git a/android/hal.h b/android/hal.h
index be69339..38b90b2 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -17,3 +17,4 @@
 
 btsock_interface_t *bt_get_sock_interface(void);
 bthh_interface_t *bt_get_hidhost_interface(void);
+btpan_interface_t *bt_get_pan_interface(void);
diff --git a/android/hal_bluetooth.c b/android/hal_bluetooth.c
index 46cc794..636c1fe 100644
--- a/android/hal_bluetooth.c
+++ b/android/hal_bluetooth.c
@@ -23,6 +23,7 @@
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
 #include <hardware/bt_hh.h>
+#include <hardware/bt_pan.h>
 
 #include <cutils/sockets.h>
 #include <cutils/properties.h>
@@ -313,6 +314,9 @@ static const void *get_profile_interface(const char *profile_id)
 	if (is_profile(profile_id, BT_PROFILE_HIDHOST_ID))
 		return bt_get_hidhost_interface();
 
+	if (is_profile(profile_id, BT_PROFILE_PAN_ID))
+		return bt_get_pan_interface();
+
 	return NULL;
 }
 
diff --git a/android/hal_pan.c b/android/hal_pan.c
new file mode 100644
index 0000000..064b086
--- /dev/null
+++ b/android/hal_pan.c
@@ -0,0 +1,130 @@
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
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int bt_pan_get_local_role(void)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BTPAN_ROLE_NONE;
+
+	return BTPAN_ROLE_NONE;
+}
+
+static bt_status_t bt_pan_connect(const bt_bdaddr_t *bd_addr, int local_role,
+					int remote_role)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	if (bd_addr == NULL) {
+		ALOGE("invalid parameters, bd_addr:%p",  bd_addr);
+		return BT_STATUS_PARM_INVALID;
+	}
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static bt_status_t bt_pan_disconnect(const bt_bdaddr_t *bd_addr)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	if (bd_addr == NULL) {
+		ALOGE("invalid parameters, bd_addr:%p",  bd_addr);
+		return BT_STATUS_PARM_INVALID;
+	}
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static bt_status_t bt_pan_init(const btpan_callbacks_t *callbacks)
+{
+	ALOGI(__func__);
+
+	/* store reference to user callbacks */
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
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
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
+	sizeof(bt_pan_if),
+	bt_pan_init,
+	bt_pan_enable,
+	bt_pan_get_local_role,
+	bt_pan_connect,
+	bt_pan_disconnect,
+	bt_pan_cleanup
+};
+
+btpan_interface_t *bt_get_pan_interface()
+{
+	return &bt_pan_if;
+}
-- 
1.7.10.4

