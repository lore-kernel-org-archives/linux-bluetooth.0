Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/13] android/handsfree: Add initial files
Date: Sun,  2 Feb 2014 22:09:12 +0100
Message-Id: <1391375364-27106-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
References: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds initial HAL and daemon code for Handsfree profile.
---
 android/Android.mk      |  2 ++
 android/Makefile.am     |  2 ++
 android/hal-bluetooth.c |  3 ++
 android/hal-handsfree.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal.h           |  2 ++
 android/handsfree.c     | 41 +++++++++++++++++++++
 android/handsfree.h     | 25 +++++++++++++
 android/main.c          | 14 ++++++++
 8 files changed, 185 insertions(+)
 create mode 100644 android/hal-handsfree.c
 create mode 100644 android/handsfree.c
 create mode 100644 android/handsfree.h

diff --git a/android/Android.mk b/android/Android.mk
index 03f2d8b..c16f29a 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -32,6 +32,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/avctp.c \
 	bluez/android/avrcp.c \
 	bluez/android/pan.c \
+	bluez/android/handsfree.c \
 	bluez/src/log.c \
 	bluez/src/shared/mgmt.c \
 	bluez/src/shared/util.c \
@@ -108,6 +109,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/hal-pan.c \
 	bluez/android/hal-a2dp.c \
 	bluez/android/hal-avrcp.c \
+	bluez/android/hal-handsfree.c \
 	bluez/android/hal-utils.c \
 
 LOCAL_C_INCLUDES += \
diff --git a/android/Makefile.am b/android/Makefile.am
index e065c0c..23e30c9 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -37,6 +37,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/avrcp.h android/avrcp.c \
 				android/socket.h android/socket.c \
 				android/pan.h android/pan.c \
+				android/handsfree.h android/handsfree.c \
 				btio/btio.h btio/btio.c \
 				src/sdp-client.h src/sdp-client.c \
 				profiles/network/bnep.h profiles/network/bnep.c
@@ -51,6 +52,7 @@ android_bluetooth_default_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hal-pan.c \
 					android/hal-a2dp.c \
 					android/hal-avrcp.c \
+					android/hal-handsfree.c \
 					android/hardware/bluetooth.h \
 					android/hardware/bt_av.h \
 					android/hardware/bt_gatt.h \
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 0dac158..67c91e4 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -765,6 +765,9 @@ static const void *get_profile_interface(const char *profile_id)
 	if (!strcmp(profile_id, BT_PROFILE_AV_RC_ID))
 		return bt_get_avrcp_interface();
 
+	if (!strcmp(profile_id, BT_PROFILE_HANDSFREE_ID))
+		return bt_get_handsfree_interface();
+
 	return NULL;
 }
 
diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
new file mode 100644
index 0000000..181e05f
--- /dev/null
+++ b/android/hal-handsfree.c
@@ -0,0 +1,96 @@
+/*
+ * Copyright (C) 2014 Intel Corporation
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
+#include <string.h>
+
+#include "hal-log.h"
+#include "hal.h"
+#include "hal-msg.h"
+#include "hal-ipc.h"
+
+static const bthf_callbacks_t *cbs = NULL;
+
+static bool interface_ready(void)
+{
+	return cbs != NULL;
+}
+
+/* handlers will be called from notification thread context,
+ * index in table equals to 'opcode - HAL_MINIMUM_EVENT' */
+static const struct hal_ipc_handler ev_handlers[] = {
+
+};
+
+static bt_status_t init(bthf_callbacks_t *callbacks)
+{
+	struct hal_cmd_register_module cmd;
+	int ret;
+
+	DBG("");
+
+	if (interface_ready())
+		return BT_STATUS_DONE;
+
+	cbs = callbacks;
+
+	hal_ipc_register(HAL_SERVICE_ID_HANDSFREE, ev_handlers,
+				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
+
+	cmd.service_id = HAL_SERVICE_ID_HANDSFREE;
+
+	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
+
+	if (ret != BT_STATUS_SUCCESS) {
+		cbs = NULL;
+		hal_ipc_unregister(HAL_SERVICE_ID_HANDSFREE);
+	}
+
+	return ret;
+}
+
+static void cleanup(void)
+{
+	struct hal_cmd_unregister_module cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return;
+
+	cbs = NULL;
+
+	cmd.service_id = HAL_SERVICE_ID_HANDSFREE;
+
+	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
+
+	hal_ipc_unregister(HAL_SERVICE_ID_HANDSFREE);
+}
+
+static bthf_interface_t iface = {
+	.size = sizeof(iface),
+	.init = init,
+	.cleanup = cleanup
+};
+
+bthf_interface_t *bt_get_handsfree_interface(void)
+{
+	return &iface;
+}
diff --git a/android/hal.h b/android/hal.h
index 1ff4fbd..5005b49 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -21,12 +21,14 @@
 #include <hardware/bt_pan.h>
 #include <hardware/bt_av.h>
 #include <hardware/bt_rc.h>
+#include <hardware/bt_hf.h>
 
 btsock_interface_t *bt_get_sock_interface(void);
 bthh_interface_t *bt_get_hidhost_interface(void);
 btpan_interface_t *bt_get_pan_interface(void);
 btav_interface_t *bt_get_a2dp_interface(void);
 btrc_interface_t *bt_get_avrcp_interface(void);
+bthf_interface_t *bt_get_handsfree_interface(void);
 
 void bt_thread_associate(void);
 void bt_thread_disassociate(void);
diff --git a/android/handsfree.c b/android/handsfree.c
new file mode 100644
index 0000000..fb48ff1
--- /dev/null
+++ b/android/handsfree.c
@@ -0,0 +1,41 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdbool.h>
+
+#include "lib/bluetooth.h"
+#include "handsfree.h"
+
+bool bt_handsfree_register(const bdaddr_t *addr)
+{
+	return false;
+}
+
+void bt_handsfree_unregister(void)
+{
+
+}
diff --git a/android/handsfree.h b/android/handsfree.h
new file mode 100644
index 0000000..799fcb6
--- /dev/null
+++ b/android/handsfree.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+bool bt_handsfree_register(const bdaddr_t *addr);
+void bt_handsfree_unregister(void);
diff --git a/android/main.c b/android/main.c
index 417dbc3..d9d0572 100644
--- a/android/main.c
+++ b/android/main.c
@@ -56,6 +56,7 @@
 #include "a2dp.h"
 #include "pan.h"
 #include "avrcp.h"
+#include "handsfree.h"
 
 #define STARTUP_GRACE_SECONDS 5
 #define SHUTDOWN_GRACE_SECONDS 10
@@ -115,6 +116,13 @@ static void service_register(const void *buf, uint16_t len)
 		}
 
 		break;
+	case HAL_SERVICE_ID_HANDSFREE:
+		if (!bt_handsfree_register(&adapter_bdaddr)) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+
+		break;
 	default:
 		DBG("service %u not supported", m->service_id);
 		status = HAL_STATUS_FAILED;
@@ -160,6 +168,9 @@ static void service_unregister(const void *buf, uint16_t len)
 	case HAL_SERVICE_ID_AVRCP:
 		bt_avrcp_unregister();
 		break;
+	case HAL_SERVICE_ID_HANDSFREE:
+		bt_handsfree_unregister();
+		break;
 	default:
 		/* This would indicate bug in HAL, as unregister should not be
 		 * called in init failed */
@@ -338,6 +349,9 @@ static void cleanup_services(void)
 		case HAL_SERVICE_ID_PAN:
 			bt_pan_unregister();
 			break;
+		case HAL_SERVICE_ID_HANDSFREE:
+			bt_handsfree_unregister();
+			break;
 		}
 
 		services[i] = false;
-- 
1.8.5.3

