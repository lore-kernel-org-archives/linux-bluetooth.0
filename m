Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] android: Add initial skeleton for pan in the daemon
Date: Mon,  4 Nov 2013 12:56:56 +0200
Message-Id: <1383562617-9029-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1383562617-9029-1-git-send-email-luiz.dentz@gmail.com>
References: <1383562617-9029-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/Android.mk  |  1 +
 android/Makefile.am |  1 +
 android/main.c      |  9 +++++++++
 android/pan.c       | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/pan.h       | 25 +++++++++++++++++++++++++
 5 files changed, 89 insertions(+)
 create mode 100644 android/pan.c
 create mode 100644 android/pan.h

diff --git a/android/Android.mk b/android/Android.mk
index 6f537ea..77fd5a0 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -26,6 +26,7 @@ LOCAL_SRC_FILES := \
 	socket.c \
 	ipc.c ipc.h \
 	a2dp.c \
+	pan.c \
 	../src/log.c \
 	../src/shared/mgmt.c \
 	../src/shared/util.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index df7f8ec..3c51390 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -21,6 +21,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/ipc.h android/ipc.c \
 				android/a2dp.h android/a2dp.c \
 				android/socket.h android/socket.c \
+				android/pan.h android/pan.c \
 				btio/btio.h btio/btio.c \
 				src/sdp-client.h src/sdp-client.c
 
diff --git a/android/main.c b/android/main.c
index 75ed4bb..29b3882 100644
--- a/android/main.c
+++ b/android/main.c
@@ -54,6 +54,7 @@
 #include "hal-msg.h"
 #include "ipc.h"
 #include "a2dp.h"
+#include "pan.h"
 
 /* TODO: Consider to remove PLATFORM_SDKVERSION check if requirement
 *  for minimal Android platform version increases. */
@@ -107,6 +108,11 @@ static void service_register(void *buf, uint16_t len)
 			goto error;
 
 		break;
+	case HAL_SERVICE_ID_PAN:
+		if (!bt_a2dp_register(hal_notif_io, adapter_bdaddr))
+			goto error;
+
+		break;
 	default:
 		DBG("service %u not supported", m->service_id);
 		goto error;
@@ -143,6 +149,9 @@ static void service_unregister(void *buf, uint16_t len)
 	case HAL_SERVICE_ID_A2DP:
 		bt_a2dp_unregister();
 		break;
+	case HAL_SERVICE_ID_PAN:
+		bt_pan_unregister();
+		break;
 	default:
 		/* This would indicate bug in HAL, as unregister should not be
 		 * called in init failed */
diff --git a/android/pan.c b/android/pan.c
new file mode 100644
index 0000000..4b988ac
--- /dev/null
+++ b/android/pan.c
@@ -0,0 +1,53 @@
+/*
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
+#include "pan.h"
+
+static GIOChannel *notification_io = NULL;
+
+bool bt_pan_register(GIOChannel *io, const bdaddr_t *addr)
+{
+	DBG("");
+
+	notification_io = g_io_channel_ref(io);
+
+	return true;
+}
+
+void bt_pan_unregister(void)
+{
+	DBG("");
+
+	g_io_channel_unref(notification_io);
+	notification_io = NULL;
+}
diff --git a/android/pan.h b/android/pan.h
new file mode 100644
index 0000000..318f318
--- /dev/null
+++ b/android/pan.h
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
+bool bt_pan_register(GIOChannel *io, const bdaddr_t *addr);
+void bt_pan_unregister(void);
-- 
1.8.3.1

