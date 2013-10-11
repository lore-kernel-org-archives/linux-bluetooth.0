Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 2/4] android: Add Socket Bluetooth HAL template
Date: Fri, 11 Oct 2013 10:45:53 +0300
Message-Id: <1381477555-11319-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381477555-11319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381477555-11319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

bt_sock HAL handles Bluetooth sockets for Android.
---
 android/Android.mk    |    1 +
 android/hal_bt_sock.c |   85 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 android/hal_bt_sock.c

diff --git a/android/Android.mk b/android/Android.mk
index 553b673..0e025ac 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -38,6 +38,7 @@ include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
 	hal_bluetooth.c \
+	hal_bt_sock.c \
 
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
diff --git a/android/hal_bt_sock.c b/android/hal_bt_sock.c
new file mode 100644
index 0000000..3a6d173
--- /dev/null
+++ b/android/hal_bt_sock.c
@@ -0,0 +1,85 @@
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
+#include <stdlib.h>
+
+#include <hardware/bluetooth.h>
+#include <hardware/bt_sock.h>
+
+#define LOG_TAG "BlueZ"
+#include <cutils/log.h>
+
+static bt_status_t btsock_listen_rfcomm(const char *service_name,
+					const uint8_t *uuid, int chan,
+					int *sock, int flags)
+{
+	ALOGD(__func__);
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static bt_status_t listen(btsock_type_t type, const char *service_name,
+					const uint8_t *uuid, int chan,
+					int *sock, int flags)
+{
+	if ((!uuid && chan <= 0) || !sock) {
+		ALOGE("%s: invalid params: uuid %p, chan %d, sock %p",
+						__func__, uuid, chan, sock);
+		return BT_STATUS_PARM_INVALID;
+	}
+
+	ALOGD("%s: uuid %p chan %d sock %p type %d service_name %s",
+			__func__, uuid, chan, sock, type, service_name);
+
+	switch (type) {
+	case BTSOCK_RFCOMM:
+		return btsock_listen_rfcomm(service_name, uuid, chan,
+								sock, flags);
+	default:
+		ALOGE("%s: Socket type %d not supported", __func__, type);
+		break;
+	}
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static bt_status_t connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
+					const uint8_t *uuid, int chan,
+					int *sock, int flags)
+{
+	if ((!uuid && chan <= 0) || !bdaddr || !sock) {
+		ALOGE("invalid params: bd_addr %p, uuid %p, chan %d, sock %p",
+					bdaddr, uuid, chan, sock);
+		return BT_STATUS_PARM_INVALID;
+	}
+
+	ALOGD("%s: uuid %p chan %d sock %p type %d", __func__, uuid, chan,
+								sock, type);
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static btsock_interface_t btsock_if = {
+	sizeof(btsock_if),
+	listen,
+	connect
+};
+
+btsock_interface_t *bt_get_sock_interface(void)
+{
+	return &btsock_if;
+}
-- 
1.7.10.4

