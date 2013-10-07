Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/2] android: Add HID Host skeleton
Date: Mon,  7 Oct 2013 16:39:17 +0300
Message-Id: <1381153158-13207-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381153158-13207-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381153158-13207-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Frederic Danis <frederic.danis@linux.intel.com>

---
 android/Android.mk      |    1 +
 android/hal.h           |    1 +
 android/hal_bluetooth.c |    4 +
 android/hal_hidhost.c   |  232 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 238 insertions(+)
 create mode 100644 android/hal_hidhost.c

diff --git a/android/Android.mk b/android/Android.mk
index cb156d3..d1cd2bc 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -64,6 +64,7 @@ LOCAL_SRC_FILES := \
 	hal_cb_thread.c \
 	hal_bt_sock.c \
 	hal_msg_client.c \
+	hal_hidhost.c \
 
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
diff --git a/android/hal.h b/android/hal.h
index 40fbf03..be69339 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -16,3 +16,4 @@
  */
 
 btsock_interface_t *bt_get_sock_interface(void);
+bthh_interface_t *bt_get_hidhost_interface(void);
diff --git a/android/hal_bluetooth.c b/android/hal_bluetooth.c
index f8139a7..46cc794 100644
--- a/android/hal_bluetooth.c
+++ b/android/hal_bluetooth.c
@@ -22,6 +22,7 @@
 
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
+#include <hardware/bt_hh.h>
 
 #include <cutils/sockets.h>
 #include <cutils/properties.h>
@@ -309,6 +310,9 @@ static const void *get_profile_interface(const char *profile_id)
 	if (is_profile(profile_id, BT_PROFILE_SOCKETS_ID))
 		return bt_get_sock_interface();
 
+	if (is_profile(profile_id, BT_PROFILE_HIDHOST_ID))
+		return bt_get_hidhost_interface();
+
 	return NULL;
 }
 
diff --git a/android/hal_hidhost.c b/android/hal_hidhost.c
new file mode 100644
index 0000000..7340b11
--- /dev/null
+++ b/android/hal_hidhost.c
@@ -0,0 +1,232 @@
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
+#include <hardware/bt_hh.h>
+
+#define LOG_TAG "BlueZ"
+#include <cutils/log.h>
+
+bthh_callbacks_t *bt_hh_cbacks;
+
+static bool interface_ready(void)
+{
+	return bt_hh_cbacks != NULL;
+}
+
+static bt_status_t bt_hidhost_connect(bt_bdaddr_t *bd_addr)
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
+static bt_status_t bt_hidhost_disconnect(bt_bdaddr_t *bd_addr)
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
+static bt_status_t bt_hidhost_virtual_unplug(bt_bdaddr_t *bd_addr)
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
+static bt_status_t bt_hidhost_set_info(bt_bdaddr_t *bd_addr,
+						bthh_hid_info_t hid_info)
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
+static bt_status_t bt_hidhost_get_protocol(bt_bdaddr_t *bd_addr,
+					bthh_protocol_mode_t protocolMode)
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
+static bt_status_t bt_hidhost_set_protocol(bt_bdaddr_t *bd_addr,
+					bthh_protocol_mode_t protocolMode)
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
+static bt_status_t bt_hidhost_get_report(bt_bdaddr_t *bd_addr,
+						bthh_report_type_t reportType,
+						uint8_t reportId,
+						int bufferSize)
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
+static bt_status_t bt_hidhost_set_report(bt_bdaddr_t *bd_addr,
+						bthh_report_type_t reportType,
+						char *report)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	if (bd_addr == NULL || report == NULL) {
+		ALOGE("invalid parameters, bd_addr:%p",  bd_addr);
+		return BT_STATUS_PARM_INVALID;
+	}
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static bt_status_t bt_hidhost_send_data(bt_bdaddr_t *bd_addr, char *data)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	if (bd_addr == NULL || data == NULL) {
+		ALOGE("invalid parameters, bd_addr:%p",  bd_addr);
+		return BT_STATUS_PARM_INVALID;
+	}
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static bt_status_t bt_hidhost_init(bthh_callbacks_t *callbacks)
+{
+	ALOGI(__func__);
+
+	/* store reference to user callbacks */
+	bt_hh_cbacks = callbacks;
+
+	/* TODO: start HID Host thread */
+
+	/* TODO: enable service */
+
+	return BT_STATUS_SUCCESS;
+}
+
+static void bt_hidhost_cleanup(void)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return;
+
+	/* TODO: disable service */
+
+	/* TODO: stop HID Host thread */
+
+	bt_hh_cbacks = NULL;
+}
+
+static bthh_interface_t bt_hidhost_if = {
+	sizeof(bt_hidhost_if),
+	bt_hidhost_init,
+	bt_hidhost_connect,
+	bt_hidhost_disconnect,
+	bt_hidhost_virtual_unplug,
+	bt_hidhost_set_info,
+	bt_hidhost_get_protocol,
+	bt_hidhost_set_protocol,
+	bt_hidhost_get_report,
+	bt_hidhost_set_report,
+	bt_hidhost_send_data,
+	bt_hidhost_cleanup
+};
+
+bthh_interface_t *bt_get_hidhost_interface(void)
+{
+	return &bt_hidhost_if;
+}
-- 
1.7.10.4

