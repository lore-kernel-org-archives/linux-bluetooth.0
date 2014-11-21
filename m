Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/4] android/a2dp-sink: Add skeleton for a2dp sink daemon
Date: Fri, 21 Nov 2014 16:13:54 +0100
Message-Id: <1416582835-7712-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1416582835-7712-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1416582835-7712-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds stubs for a2dp sink role in daemon. As Sink uses the same HAL
API, daemon can use the same structs and defines as Source does.
---
 android/Android.mk  |  1 +
 android/Makefile.am |  1 +
 android/a2dp-sink.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/a2dp-sink.h | 25 ++++++++++++++++
 4 files changed, 111 insertions(+)
 create mode 100644 android/a2dp-sink.c
 create mode 100644 android/a2dp-sink.h

diff --git a/android/Android.mk b/android/Android.mk
index 70dbc42..1b7b8ef 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -46,6 +46,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/ipc.c \
 	bluez/android/avdtp.c \
 	bluez/android/a2dp.c \
+	bluez/android/a2dp-sink.c \
 	bluez/android/avctp.c \
 	bluez/android/avrcp.c \
 	bluez/android/avrcp-lib.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 58fe81a..e290740 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -36,6 +36,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/ipc.h android/ipc.c \
 				android/avdtp.h android/avdtp.c \
 				android/a2dp.h android/a2dp.c \
+				android/a2dp-sink.h android/a2dp-sink.c \
 				android/avctp.h android/avctp.c \
 				android/avrcp.h android/avrcp.c \
 				android/avrcp-lib.h android/avrcp-lib.c \
diff --git a/android/a2dp-sink.c b/android/a2dp-sink.c
new file mode 100644
index 0000000..07508c0
--- /dev/null
+++ b/android/a2dp-sink.c
@@ -0,0 +1,84 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdbool.h>
+#include <glib.h>
+
+#include "lib/bluetooth.h"
+#include "hal-log.h"
+#include "hal-msg.h"
+#include "ipc.h"
+#include "a2dp-sink.h"
+
+static struct ipc *hal_ipc = NULL;
+
+static void bt_a2dp_sink_connect(const void *buf, uint16_t len)
+{
+	/* TODO */
+
+	DBG("");
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_A2DP_SINK, HAL_OP_A2DP_CONNECT,
+							HAL_STATUS_UNSUPPORTED);
+}
+
+static void bt_a2dp_sink_disconnect(const void *buf, uint16_t len)
+{
+	/* TODO */
+
+	DBG("");
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_A2DP_SINK, HAL_OP_A2DP_DISCONNECT,
+							HAL_STATUS_UNSUPPORTED);
+}
+
+static const struct ipc_handler cmd_handlers[] = {
+	/* HAL_OP_A2DP_CONNECT */
+	{ bt_a2dp_sink_connect, false, sizeof(struct hal_cmd_a2dp_connect) },
+	/* HAL_OP_A2DP_DISCONNECT */
+	{ bt_a2dp_sink_disconnect, false,
+				sizeof(struct hal_cmd_a2dp_disconnect) },
+};
+
+bool bt_a2dp_sink_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
+{
+	DBG("");
+
+	hal_ipc = ipc;
+	ipc_register(hal_ipc, HAL_SERVICE_ID_A2DP_SINK, cmd_handlers,
+						G_N_ELEMENTS(cmd_handlers));
+
+	return true;
+}
+
+void bt_a2dp_sink_unregister(void)
+{
+	DBG("");
+
+	ipc_unregister(hal_ipc, HAL_SERVICE_ID_A2DP_SINK);
+	hal_ipc = NULL;
+}
diff --git a/android/a2dp-sink.h b/android/a2dp-sink.h
new file mode 100644
index 0000000..d2c5ff4
--- /dev/null
+++ b/android/a2dp-sink.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+bool bt_a2dp_sink_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
+void bt_a2dp_sink_unregister(void);
-- 
1.9.1

