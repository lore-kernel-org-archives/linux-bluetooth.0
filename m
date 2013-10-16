Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 10/11] android: Add HID Host skeleton
Date: Wed, 16 Oct 2013 17:08:47 +0300
Message-Id: <1381932528-31584-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381932528-31584-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381932528-31584-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add skeleton for hidhost Android HAL. This is modified version
from Frederic Danis earlier patch set.
---
 android/Android.mk      |    1 +
 android/hal-bluetooth.c |    4 +
 android/hal-hidhost.c   |  204 +++++++++++++++++++++++++++++++++++++++++++++++
 android/hal.h           |    1 +
 4 files changed, 210 insertions(+)
 create mode 100644 android/hal-hidhost.c

diff --git a/android/Android.mk b/android/Android.mk
index fb4383d..ab2171c 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -53,6 +53,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := \
 	hal-bluetooth.c \
 	hal-bt-sock.c \
+	hal-hidhost.c \
 
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 89b8ebb..488606d 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -22,6 +22,7 @@
 
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
+#include <hardware/bt_hh.h>
 
 #include <cutils/sockets.h>
 #include <cutils/properties.h>
@@ -285,6 +286,9 @@ static const void *get_profile_interface(const char *profile_id)
 	if (!strcmp(profile_id, BT_PROFILE_SOCKETS_ID))
 		return bt_get_sock_interface();
 
+	if (!strcmp(profile_id, BT_PROFILE_HIDHOST_ID))
+		return bt_get_hidhost_interface();
+
 	return NULL;
 }
 
diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
new file mode 100644
index 0000000..27cd1be
--- /dev/null
+++ b/android/hal-hidhost.c
@@ -0,0 +1,204 @@
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
+static bt_status_t bt_hidhost_disconnect(bt_bdaddr_t *bd_addr)
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
+static bt_status_t bt_hidhost_virtual_unplug(bt_bdaddr_t *bd_addr)
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
+static bt_status_t bt_hidhost_set_info(bt_bdaddr_t *bd_addr,
+						bthh_hid_info_t hid_info)
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
+static bt_status_t bt_hidhost_get_protocol(bt_bdaddr_t *bd_addr,
+					bthh_protocol_mode_t protocolMode)
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
+static bt_status_t bt_hidhost_set_protocol(bt_bdaddr_t *bd_addr,
+					bthh_protocol_mode_t protocolMode)
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
+static bt_status_t bt_hidhost_get_report(bt_bdaddr_t *bd_addr,
+						bthh_report_type_t reportType,
+						uint8_t reportId,
+						int bufferSize)
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
+static bt_status_t bt_hidhost_set_report(bt_bdaddr_t *bd_addr,
+						bthh_report_type_t reportType,
+						char *report)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!bd_addr || !report)
+		return BT_STATUS_PARM_INVALID;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static bt_status_t bt_hidhost_send_data(bt_bdaddr_t *bd_addr, char *data)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!bd_addr || !data)
+		return BT_STATUS_PARM_INVALID;
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
+	ALOGD(__func__);
+
+	if (!interface_ready())
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
diff --git a/android/hal.h b/android/hal.h
index 40fbf03..be69339 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -16,3 +16,4 @@
  */
 
 btsock_interface_t *bt_get_sock_interface(void);
+bthh_interface_t *bt_get_hidhost_interface(void);
-- 
1.7.10.4

