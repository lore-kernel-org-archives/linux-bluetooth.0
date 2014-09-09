Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 06/39] android/hf-client: Add hf-client daemon skeleton
Date: Tue,  9 Sep 2014 21:56:51 +0200
Message-Id: <1410292644-23497-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Makefile.am |  1 +
 android/hf-client.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 android/hf-client.c

diff --git a/android/Makefile.am b/android/Makefile.am
index 49fbddc..e92ccf1 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -52,6 +52,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/socket.h android/socket.c \
 				android/pan.h android/pan.c \
 				android/handsfree.h android/handsfree.c \
+				android/hf-client.c android/hf-client.h \
 				android/gatt.h android/gatt.c \
 				android/health.h android/health.c \
 				android/mcap-lib.h android/mcap-lib.c \
diff --git a/android/hf-client.c b/android/hf-client.c
new file mode 100644
index 0000000..f1566d0
--- /dev/null
+++ b/android/hf-client.c
@@ -0,0 +1,69 @@
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
+#include <stdlib.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <unistd.h>
+#include <glib.h>
+
+#include "lib/bluetooth.h"
+#include "ipc.h"
+#include "ipc-common.h"
+#include "src/log.h"
+#include "utils.h"
+
+#include "hal-msg.h"
+#include "hf-client.h"
+
+static bdaddr_t adapter_addr;
+
+static struct ipc *hal_ipc = NULL;
+
+static const struct ipc_handler cmd_handlers[] = {
+};
+
+bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
+{
+	DBG("");
+
+	bacpy(&adapter_addr, addr);
+
+	hal_ipc = ipc;
+	ipc_register(hal_ipc, HAL_SERVICE_ID_HF_CLIENT, cmd_handlers,
+						G_N_ELEMENTS(cmd_handlers));
+
+	return true;
+}
+
+void bt_hf_client_unregister(void)
+{
+	DBG("");
+
+	ipc_unregister(hal_ipc, HAL_SERVICE_ID_HANDSFREE);
+	hal_ipc = NULL;
+}
-- 
1.8.4

