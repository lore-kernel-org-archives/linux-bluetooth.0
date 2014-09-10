Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 03/16] android/hf-client: Add hf-client daemon skeleton
Date: Wed, 10 Sep 2014 13:34:01 +0200
Message-Id: <1410348854-26249-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410348854-26249-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410348854-26249-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Makefile.am |  1 +
 android/hf-client.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/hf-client.h | 25 +++++++++++++++++++
 android/main.c      |  9 +++++++
 4 files changed, 104 insertions(+)
 create mode 100644 android/hf-client.c
 create mode 100644 android/hf-client.h

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
diff --git a/android/hf-client.h b/android/hf-client.h
new file mode 100644
index 0000000..1eb69ff
--- /dev/null
+++ b/android/hf-client.h
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
+bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr);
+void bt_hf_client_unregister(void);
diff --git a/android/main.c b/android/main.c
index b03a2df..49257d4 100644
--- a/android/main.c
+++ b/android/main.c
@@ -60,6 +60,7 @@
 #include "handsfree.h"
 #include "gatt.h"
 #include "health.h"
+#include "hf-client.h"
 
 #define STARTUP_GRACE_SECONDS 5
 #define SHUTDOWN_GRACE_SECONDS 10
@@ -145,6 +146,14 @@ static void service_register(const void *buf, uint16_t len)
 		}
 
 		break;
+	case HAL_SERVICE_ID_HF_CLIENT:
+		if (!bt_hf_client_register(hal_ipc, &adapter_bdaddr)) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+
+		break;
+
 	default:
 		DBG("service %u not supported", m->service_id);
 		status = HAL_STATUS_FAILED;
-- 
1.8.4

