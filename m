Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] android: Add initial skeleton for a2dp in the daemon
Date: Mon,  4 Nov 2013 12:56:54 +0200
Message-Id: <1383562617-9029-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/Android.mk  |  1 +
 android/Makefile.am |  1 +
 android/a2dp.c      | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/a2dp.h      | 25 ++++++++++++++++++++++++
 android/main.c      |  9 +++++++++
 5 files changed, 92 insertions(+)
 create mode 100644 android/a2dp.c
 create mode 100644 android/a2dp.h

diff --git a/android/Android.mk b/android/Android.mk
index 443ac7a..6f537ea 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -25,6 +25,7 @@ LOCAL_SRC_FILES := \
 	hid.c \
 	socket.c \
 	ipc.c ipc.h \
+	a2dp.c \
 	../src/log.c \
 	../src/shared/mgmt.c \
 	../src/shared/util.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index acbc0f5..df7f8ec 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -19,6 +19,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/adapter.h android/adapter.c \
 				android/hid.h android/hid.c \
 				android/ipc.h android/ipc.c \
+				android/a2dp.h android/a2dp.c \
 				android/socket.h android/socket.c \
 				btio/btio.h btio/btio.c \
 				src/sdp-client.h src/sdp-client.c
diff --git a/android/a2dp.c b/android/a2dp.c
new file mode 100644
index 0000000..64e5278
--- /dev/null
+++ b/android/a2dp.c
@@ -0,0 +1,56 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
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
+#include <stdint.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <glib.h>
+
+#include "lib/bluetooth.h"
+#include "log.h"
+#include "a2dp.h"
+
+static GIOChannel *notification_io = NULL;
+
+bool bt_a2dp_register(GIOChannel *io, const bdaddr_t *addr)
+{
+	DBG("");
+
+	notification_io = g_io_channel_ref(io);
+
+	return true;
+}
+
+void bt_a2dp_unregister(void)
+{
+	DBG("");
+
+	g_io_channel_unref(notification_io);
+	notification_io = NULL;
+}
diff --git a/android/a2dp.h b/android/a2dp.h
new file mode 100644
index 0000000..b8b14bb
--- /dev/null
+++ b/android/a2dp.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
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
+bool bt_a2dp_register(GIOChannel *io, const bdaddr_t *addr);
+void bt_a2dp_unregister(void);
diff --git a/android/main.c b/android/main.c
index 1d3f10f..efa8c37 100644
--- a/android/main.c
+++ b/android/main.c
@@ -53,6 +53,7 @@
 #include "hid.h"
 #include "hal-msg.h"
 #include "ipc.h"
+#include "a2dp.h"
 
 /* TODO: Consider to remove PLATFORM_SDKVERSION check if requirement
 *  for minimal Android platform version increases. */
@@ -101,6 +102,11 @@ static void service_register(void *buf, uint16_t len)
 			goto error;
 
 		break;
+	case HAL_SERVICE_ID_A2DP:
+		if (!bt_a2dp_register(hal_notif_io, adapter_bdaddr))
+			goto error;
+
+		break;
 	default:
 		DBG("service %u not supported", m->service_id);
 		goto error;
@@ -134,6 +140,9 @@ static void service_unregister(void *buf, uint16_t len)
 	case HAL_SERVICE_ID_HIDHOST:
 		bt_hid_unregister();
 		break;
+	case HAL_SERVICE_ID_A2DP:
+		bt_a2dp_unregister();
+		break;
 	default:
 		/* This would indicate bug in HAL, as unregister should not be
 		 * called in init failed */
-- 
1.8.3.1

