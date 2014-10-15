Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/5] android/map-client: Add initial files
Date: Wed, 15 Oct 2014 16:27:57 +0200
Message-Id: <1413383281-17292-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1413383281-17292-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1413383281-17292-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds initial daemon code for MAP client profile.
---
 android/Android.mk   |  1 +
 android/Makefile.am  |  1 +
 android/main.c       | 12 ++++++++++++
 android/map-client.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 android/map-client.h | 26 ++++++++++++++++++++++++++
 5 files changed, 84 insertions(+)
 create mode 100644 android/map-client.c
 create mode 100644 android/map-client.h

diff --git a/android/Android.mk b/android/Android.mk
index 2b59fb8..aefe41c 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -57,6 +57,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/gatt.c \
 	bluez/android/health.c \
 	bluez/profiles/health/mcap.c \
+	bluez/android/map-client.c \
 	bluez/src/log.c \
 	bluez/src/shared/mgmt.c \
 	bluez/src/shared/util.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index b013095..b3eb1c5 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -46,6 +46,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/gatt.h android/gatt.c \
 				android/health.h android/health.c \
 				profiles/health/mcap.h profiles/health/mcap.c \
+				android/map-client.h android/map-client.c \
 				attrib/att.c attrib/att.h \
 				attrib/gatt.c attrib/gatt.h \
 				attrib/gattrib.c attrib/gattrib.h \
diff --git a/android/main.c b/android/main.c
index 703b3b6..b5f6937 100644
--- a/android/main.c
+++ b/android/main.c
@@ -62,6 +62,7 @@
 #include "gatt.h"
 #include "health.h"
 #include "handsfree-client.h"
+#include "map-client.h"
 #include "utils.h"
 
 #define DEFAULT_VENDOR "BlueZ"
@@ -235,6 +236,14 @@ static void service_register(const void *buf, uint16_t len)
 		}
 
 		break;
+	case HAL_SERVICE_ID_MAP_CLIENT:
+		if (!bt_map_client_register(hal_ipc, &adapter_bdaddr,
+								m->mode)) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+
+		break;
 	default:
 		DBG("service %u not supported", m->service_id);
 		status = HAL_STATUS_FAILED;
@@ -288,6 +297,9 @@ static bool unregister_service(uint8_t id)
 	case HAL_SERVICE_ID_HANDSFREE_CLIENT:
 		bt_hf_client_unregister();
 		break;
+	case HAL_SERVICE_ID_MAP_CLIENT:
+		bt_map_client_unregister();
+		break;
 	default:
 		DBG("service %u not supported", id);
 		return false;
diff --git a/android/map-client.c b/android/map-client.c
new file mode 100644
index 0000000..4556461
--- /dev/null
+++ b/android/map-client.c
@@ -0,0 +1,44 @@
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
+#include <stdlib.h>
+#include <stdint.h>
+
+#include "ipc.h"
+#include "lib/bluetooth.h"
+#include "map-client.h"
+
+bool bt_map_client_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
+{
+	return false;
+}
+
+void bt_map_client_unregister(void)
+{
+
+}
diff --git a/android/map-client.h b/android/map-client.h
new file mode 100644
index 0000000..0e63072
--- /dev/null
+++ b/android/map-client.h
@@ -0,0 +1,26 @@
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
+bool bt_map_client_register(struct ipc *ipc, const bdaddr_t *addr,
+								uint8_t mode);
+void bt_map_client_unregister(void);
-- 
1.9.3

