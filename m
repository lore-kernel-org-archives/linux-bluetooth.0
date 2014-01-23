Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/8] android: Add initial skeleton for AVRCP in the daemon
Date: Thu, 23 Jan 2014 18:39:53 +0200
Message-Id: <1390495198-28400-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1390495198-28400-1-git-send-email-luiz.dentz@gmail.com>
References: <1390495198-28400-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/Android.mk                          |  1 +
 android/Makefile.am                         |  1 +
 plugins/external-dummy.c => android/avrcp.c | 32 ++++++++++++++++++++++-------
 android/{hidhost.h => avrcp.h}              |  6 +++---
 android/main.c                              | 11 ++++++++++
 5 files changed, 41 insertions(+), 10 deletions(-)
 copy plugins/external-dummy.c => android/avrcp.c (62%)
 copy android/{hidhost.h => avrcp.h} (84%)

diff --git a/android/Android.mk b/android/Android.mk
index b43119e..45ceeb2 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -29,6 +29,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/avdtp.c \
 	bluez/android/a2dp.c \
 	bluez/android/avctp.c \
+	bluez/android/avrcp.c \
 	bluez/android/pan.c \
 	bluez/src/log.c \
 	bluez/src/shared/mgmt.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 41694ee..47e7551 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -34,6 +34,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/avdtp.h android/avdtp.c \
 				android/a2dp.h android/a2dp.c \
 				android/avctp.h android/avctp.c \
+				android/avrcp.h android/avrcp.c \
 				android/socket.h android/socket.c \
 				android/pan.h android/pan.c \
 				btio/btio.h btio/btio.c \
diff --git a/plugins/external-dummy.c b/android/avrcp.c
similarity index 62%
copy from plugins/external-dummy.c
copy to android/avrcp.c
index ff31290..707506b 100644
--- a/plugins/external-dummy.c
+++ b/android/avrcp.c
@@ -2,6 +2,9 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
  *  the Free Software Foundation; either version 2 of the License, or
@@ -22,20 +25,35 @@
 #include <config.h>
 #endif
 
-#include "plugin.h"
+#include <stdbool.h>
+#include <glib.h>
+
+#include "lib/bluetooth.h"
 #include "log.h"
+#include "avrcp.h"
+#include "hal-msg.h"
+#include "ipc.h"
+
+static bdaddr_t adapter_addr;
+
+static const struct ipc_handler cmd_handlers[] = {
+};
 
-static int dummy_init(void)
+bool bt_avrcp_register(const bdaddr_t *addr)
 {
 	DBG("");
 
-	return 0;
+	bacpy(&adapter_addr, addr);
+
+	ipc_register(HAL_SERVICE_ID_AVRCP, cmd_handlers,
+						G_N_ELEMENTS(cmd_handlers));
+
+	return true;
 }
 
-static void dummy_exit(void)
+void bt_avrcp_unregister(void)
 {
 	DBG("");
-}
 
-BLUETOOTH_PLUGIN_DEFINE(external_dummy, VERSION,
-		BLUETOOTH_PLUGIN_PRIORITY_LOW, dummy_init, dummy_exit)
+	ipc_unregister(HAL_SERVICE_ID_AVRCP);
+}
diff --git a/android/hidhost.h b/android/avrcp.h
similarity index 84%
copy from android/hidhost.h
copy to android/avrcp.h
index ea14446..6fe7fbf 100644
--- a/android/hidhost.h
+++ b/android/avrcp.h
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2013  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -21,5 +21,5 @@
  *
  */
 
-bool bt_hid_register(const bdaddr_t *addr);
-void bt_hid_unregister(void);
+bool bt_avrcp_register(const bdaddr_t *addr);
+void bt_avrcp_unregister(void);
diff --git a/android/main.c b/android/main.c
index 8983a84..c353c4a 100644
--- a/android/main.c
+++ b/android/main.c
@@ -55,6 +55,7 @@
 #include "ipc.h"
 #include "a2dp.h"
 #include "pan.h"
+#include "avrcp.h"
 
 #define STARTUP_GRACE_SECONDS 5
 #define SHUTDOWN_GRACE_SECONDS 10
@@ -107,6 +108,13 @@ static void service_register(const void *buf, uint16_t len)
 		}
 
 		break;
+	case HAL_SERVICE_ID_AVRCP:
+		if (!bt_avrcp_register(&adapter_bdaddr)) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+
+		break;
 	default:
 		DBG("service %u not supported", m->service_id);
 		status = HAL_STATUS_FAILED;
@@ -149,6 +157,9 @@ static void service_unregister(const void *buf, uint16_t len)
 	case HAL_SERVICE_ID_PAN:
 		bt_pan_unregister();
 		break;
+	case HAL_SERVICE_ID_AVRCP:
+		bt_avrcp_unregister();
+		break;
 	default:
 		/* This would indicate bug in HAL, as unregister should not be
 		 * called in init failed */
-- 
1.8.4.2

