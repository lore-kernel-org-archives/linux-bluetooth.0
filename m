Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/2] android: Add Socket Bluetooth HAL template
Date: Tue, 24 Sep 2013 11:31:56 +0300
Message-Id: <1380011516-7847-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1380011516-7847-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380011516-7847-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

bt_sock HAL handles Bluetooth sockets for Android.
---
 android/Android.mk    |    1 +
 android/hal_bt_sock.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 android/hal_bt_sock.c

diff --git a/android/Android.mk b/android/Android.mk
index ca9501f..93de803 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -32,6 +32,7 @@ include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
 	hal_bluetooth.c \
+	hal_bt_sock.c \
 
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
diff --git a/android/hal_bt_sock.c b/android/hal_bt_sock.c
new file mode 100644
index 0000000..cd36e1f
--- /dev/null
+++ b/android/hal_bt_sock.c
@@ -0,0 +1,86 @@
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
+					const uint8_t *uuid, int channel,
+					int *sock_fd, int flags)
+{
+	ALOGI(__func__);
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static bt_status_t btsock_listen(btsock_type_t type, const char *service_name,
+					const uint8_t *uuid, int channel,
+					int *sock_fd, int flags)
+{
+	if ((uuid == NULL && channel <= 0) || sock_fd == NULL) {
+		ALOGE("%s: invalid params: uuid %p, chan %d, sock %p",
+					__func__, uuid, channel, sock_fd);
+		return BT_STATUS_PARM_INVALID;
+	}
+
+	ALOGI("%s: uuid %p chan %d sock %p type %d service_name %s",
+			__func__, uuid, channel, sock_fd, type, service_name);
+
+	switch (type) {
+	case BTSOCK_RFCOMM:
+		return btsock_listen_rfcomm(service_name, uuid, channel,
+					    sock_fd, flags);
+	default:
+		ALOGE("%s: Socket type %d not supported", __func__, type);
+	}
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static bt_status_t btsock_connect(const bt_bdaddr_t *bd_addr,
+					btsock_type_t type,
+					const uint8_t *uuid, int channel,
+					int *sock_fd, int flags)
+{
+	if ((uuid == NULL && channel <= 0) || bd_addr == NULL ||
+							sock_fd == NULL) {
+		ALOGE("invalid params: bd_addr %p, uuid %p, chan %d, sock %p",
+					bd_addr, uuid, channel, sock_fd);
+		return BT_STATUS_PARM_INVALID;
+	}
+
+	ALOGI("%s: uuid %p chan %d sock %p type %d", __func__,
+						uuid, channel, sock_fd, type);
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static btsock_interface_t sock_if = {
+	sizeof(sock_if),
+	btsock_listen,
+	btsock_connect
+};
+
+btsock_interface_t *bt_get_sock_interface(void)
+{
+	return &sock_if;
+}
-- 
1.7.10.4

