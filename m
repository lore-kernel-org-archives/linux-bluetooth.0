Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 09/11] android: Rename hal_bt_sock.c to hal-bt-sock.c
Date: Wed, 16 Oct 2013 17:36:36 +0300
Message-Id: <1381934198-7955-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381934198-7955-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381934198-7955-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/Android.mk    |    2 +-
 android/hal-bt-sock.c |   85 +++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal_bt_sock.c |   85 -------------------------------------------------
 3 files changed, 86 insertions(+), 86 deletions(-)
 create mode 100644 android/hal-bt-sock.c
 delete mode 100644 android/hal_bt_sock.c

diff --git a/android/Android.mk b/android/Android.mk
index 021bb91..fb4383d 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -52,7 +52,7 @@ include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
 	hal-bluetooth.c \
-	hal_bt_sock.c \
+	hal-bt-sock.c \
 
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
diff --git a/android/hal-bt-sock.c b/android/hal-bt-sock.c
new file mode 100644
index 0000000..3a6d173
--- /dev/null
+++ b/android/hal-bt-sock.c
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
diff --git a/android/hal_bt_sock.c b/android/hal_bt_sock.c
deleted file mode 100644
index 3a6d173..0000000
--- a/android/hal_bt_sock.c
+++ /dev/null
@@ -1,85 +0,0 @@
-/*
- * Copyright (C) 2013 Intel Corporation
- *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
- */
-
-#include <stdlib.h>
-
-#include <hardware/bluetooth.h>
-#include <hardware/bt_sock.h>
-
-#define LOG_TAG "BlueZ"
-#include <cutils/log.h>
-
-static bt_status_t btsock_listen_rfcomm(const char *service_name,
-					const uint8_t *uuid, int chan,
-					int *sock, int flags)
-{
-	ALOGD(__func__);
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static bt_status_t listen(btsock_type_t type, const char *service_name,
-					const uint8_t *uuid, int chan,
-					int *sock, int flags)
-{
-	if ((!uuid && chan <= 0) || !sock) {
-		ALOGE("%s: invalid params: uuid %p, chan %d, sock %p",
-						__func__, uuid, chan, sock);
-		return BT_STATUS_PARM_INVALID;
-	}
-
-	ALOGD("%s: uuid %p chan %d sock %p type %d service_name %s",
-			__func__, uuid, chan, sock, type, service_name);
-
-	switch (type) {
-	case BTSOCK_RFCOMM:
-		return btsock_listen_rfcomm(service_name, uuid, chan,
-								sock, flags);
-	default:
-		ALOGE("%s: Socket type %d not supported", __func__, type);
-		break;
-	}
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static bt_status_t connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
-					const uint8_t *uuid, int chan,
-					int *sock, int flags)
-{
-	if ((!uuid && chan <= 0) || !bdaddr || !sock) {
-		ALOGE("invalid params: bd_addr %p, uuid %p, chan %d, sock %p",
-					bdaddr, uuid, chan, sock);
-		return BT_STATUS_PARM_INVALID;
-	}
-
-	ALOGD("%s: uuid %p chan %d sock %p type %d", __func__, uuid, chan,
-								sock, type);
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static btsock_interface_t btsock_if = {
-	sizeof(btsock_if),
-	listen,
-	connect
-};
-
-btsock_interface_t *bt_get_sock_interface(void)
-{
-	return &btsock_if;
-}
-- 
1.7.10.4

