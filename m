Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] android: Add A2DP skeleton
Date: Mon, 21 Oct 2013 11:39:21 +0300
Message-Id: <1382344761-8358-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds initial skeleton for A2DP Android HAL.
---
 Makefile.android |  1 +
 android/hal-av.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal.h    |  2 ++
 3 files changed, 97 insertions(+)
 create mode 100644 android/hal-av.c

diff --git a/Makefile.android b/Makefile.android
index 8196583..ec9e4be 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -18,6 +18,7 @@ android_libhal_internal_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hal-sock.c \
 					android/hal-hidhost.c \
 					android/hal-pan.c \
+					android/hal-av.c \
 					android/hardware/bluetooth.h \
 					android/hardware/bt_av.h \
 					android/hardware/bt_gatt.h \
diff --git a/android/hal-av.c b/android/hal-av.c
new file mode 100644
index 0000000..ef45066
--- /dev/null
+++ b/android/hal-av.c
@@ -0,0 +1,94 @@
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
+#include <stddef.h>
+
+#include <hardware/bluetooth.h>
+#include <hardware/bt_av.h>
+
+#include "hal-log.h"
+#include "hal.h"
+
+const btav_callbacks_t *cbs = NULL;
+
+static bool interface_ready(void)
+{
+	return cbs != NULL;
+}
+
+static bt_status_t av_connect(bt_bdaddr_t *bd_addr)
+{
+	DBG("");
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
+static bt_status_t av_disconnect(bt_bdaddr_t *bd_addr)
+{
+	DBG("");
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
+static bt_status_t av_init(btav_callbacks_t *callbacks)
+{
+	DBG("");
+
+	cbs = callbacks;
+
+	/* TODO: enable service */
+
+	return BT_STATUS_SUCCESS;
+}
+
+static void av_cleanup()
+{
+	DBG("");
+
+	if (!interface_ready())
+		return;
+
+	/* TODO: disable service */
+
+	cbs = NULL;
+}
+
+static btav_interface_t iface = {
+	.size = sizeof(iface),
+	.init = av_init,
+	.connect = av_connect,
+	.disconnect = av_disconnect,
+	.cleanup = av_cleanup
+};
+
+btav_interface_t *bt_get_av_interface()
+{
+	return &iface;
+}
diff --git a/android/hal.h b/android/hal.h
index a548e48..d984336 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -18,7 +18,9 @@
 #include <hardware/bt_sock.h>
 #include <hardware/bt_hh.h>
 #include <hardware/bt_pan.h>
+#include <hardware/bt_av.h>
 
 btsock_interface_t *bt_get_sock_interface(void);
 bthh_interface_t *bt_get_hidhost_interface(void);
 btpan_interface_t *bt_get_pan_interface(void);
+btav_interface_t *bt_get_av_interface(void);
-- 
1.8.3.1

