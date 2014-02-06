Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] android/avrcp: Decouple AVRCP logic from btio
Date: Thu,  6 Feb 2014 18:06:11 +0200
Message-Id: <1391702774-18972-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The patch makes AVRCP to be channel-agnostic so that it might be used in
unit tests. The idea is that all AVRCP logic would come to avrcp-lib and
channel stuff got to avrcp.
---
 android/Android.mk  |  1 +
 android/Makefile.am |  1 +
 android/avrcp-lib.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/avrcp-lib.h | 34 +++++++++++++++++++++++
 android/avrcp.c     | 60 ++++++----------------------------------
 5 files changed, 125 insertions(+), 51 deletions(-)
 create mode 100644 android/avrcp-lib.c
 create mode 100644 android/avrcp-lib.h

diff --git a/android/Android.mk b/android/Android.mk
index 20105e6..9b10cfe 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -30,6 +30,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/avdtp.c \
 	bluez/android/a2dp.c \
 	bluez/android/avctp.c \
+	bluez/android/avrcp-lib.c \
 	bluez/android/avrcp.c \
 	bluez/android/pan.c \
 	bluez/android/handsfree.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 5baa8db..3032940 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -36,6 +36,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/avdtp.h android/avdtp.c \
 				android/a2dp.h android/a2dp.c \
 				android/avctp.h android/avctp.c \
+				android/avrcp-lib.h android/avrcp-lib.c \
 				android/avrcp.h android/avrcp.c \
 				android/socket.h android/socket.c \
 				android/pan.h android/pan.c \
diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
new file mode 100644
index 0000000..6dcc8ac
--- /dev/null
+++ b/android/avrcp-lib.c
@@ -0,0 +1,80 @@
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
+#include <glib.h>
+
+#include "lib/bluetooth.h"
+
+#include "src/log.h"
+
+#include "avctp.h"
+#include "avrcp-lib.h"
+
+static GSList *devices = NULL;
+
+void avrcp_device_remove(struct avrcp_device *dev)
+{
+	devices = g_slist_remove(devices, dev);
+	avrcp_device_free(dev);
+}
+
+void avrcp_free_all(void)
+{
+	g_slist_free_full(devices, avrcp_device_free);
+	devices = NULL;
+}
+
+struct avrcp_device *avrcp_device_new(const bdaddr_t *dst)
+{
+	struct avrcp_device *dev;
+
+	dev = g_new0(struct avrcp_device, 1);
+	bacpy(&dev->dst, dst);
+	devices = g_slist_prepend(devices, dev);
+
+	return dev;
+}
+
+static int device_cmp(gconstpointer s, gconstpointer user_data)
+{
+	const struct avrcp_device *dev = s;
+	const bdaddr_t *dst = user_data;
+
+	return bacmp(&dev->dst, dst);
+}
+
+struct avrcp_device *avrcp_find(const bdaddr_t *dst)
+{
+	GSList *l;
+
+	l = g_slist_find_custom(devices, dst, device_cmp);
+	if (!l)
+		return NULL;
+
+	return l->data;
+}
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
new file mode 100644
index 0000000..bf6872e
--- /dev/null
+++ b/android/avrcp-lib.h
@@ -0,0 +1,34 @@
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
+struct avrcp_device {
+	bdaddr_t	dst;
+	struct avctp	*session;
+	GIOChannel      *io;
+};
+
+struct avrcp_device *avrcp_device_new(const bdaddr_t *dst);
+void avrcp_device_free(void *data);
+void avrcp_device_remove(struct avrcp_device *dev);
+void avrcp_free_all(void);
+struct avrcp_device *avrcp_find(const bdaddr_t *dst);
diff --git a/android/avrcp.c b/android/avrcp.c
index 7ee5a8a..22f0a04 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -38,6 +38,7 @@
 #include "hal-msg.h"
 #include "ipc.h"
 #include "avctp.h"
+#include "avrcp-lib.h"
 
 #define L2CAP_PSM_AVCTP 0x17
 
@@ -48,15 +49,8 @@
 
 static bdaddr_t adapter_addr;
 static uint32_t record_id = 0;
-static GSList *devices = NULL;
 static GIOChannel *server = NULL;
 
-struct avrcp_device {
-	bdaddr_t	dst;
-	struct avctp	*session;
-	GIOChannel	*io;
-};
-
 static const struct ipc_handler cmd_handlers[] = {
 };
 
@@ -128,7 +122,7 @@ static sdp_record_t *avrcp_record(void)
 	return record;
 }
 
-static void avrcp_device_free(void *data)
+void avrcp_device_free(void *data)
 {
 	struct avrcp_device *dev = data;
 
@@ -143,31 +137,6 @@ static void avrcp_device_free(void *data)
 	g_free(dev);
 }
 
-static void avrcp_device_remove(struct avrcp_device *dev)
-{
-	devices = g_slist_remove(devices, dev);
-	avrcp_device_free(dev);
-}
-
-static struct avrcp_device *avrcp_device_new(const bdaddr_t *dst)
-{
-	struct avrcp_device *dev;
-
-	dev = g_new0(struct avrcp_device, 1);
-	bacpy(&dev->dst, dst);
-	devices = g_slist_prepend(devices, dev);
-
-	return dev;
-}
-
-static int device_cmp(gconstpointer s, gconstpointer user_data)
-{
-	const struct avrcp_device *dev = s;
-	const bdaddr_t *dst = user_data;
-
-	return bacmp(&dev->dst, dst);
-}
-
 static void disconnect_cb(void *data)
 {
 	struct avrcp_device *dev = data;
@@ -186,7 +155,6 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	char address[18];
 	uint16_t imtu, omtu;
 	GError *gerr = NULL;
-	GSList *l;
 	int fd;
 
 	if (err) {
@@ -209,13 +177,9 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	ba2str(&dst, address);
 
-	l = g_slist_find_custom(devices, &dst, device_cmp);
-	if (l) {
-		dev = l->data;
-		if (dev->session) {
-			error("Unexpected connection");
-			return;
-		}
+	if (avrcp_find(&dst)) {
+		error("Unexpected connection");
+		return;
 	} else {
 		DBG("Incoming connection from %s", address);
 		dev = avrcp_device_new(&dst);
@@ -293,8 +257,7 @@ void bt_avrcp_unregister(void)
 {
 	DBG("");
 
-	g_slist_free_full(devices, avrcp_device_free);
-	devices = NULL;
+	avrcp_free_all();
 
 	ipc_unregister(HAL_SERVICE_ID_AVRCP);
 
@@ -331,12 +294,10 @@ void bt_avrcp_connect(const bdaddr_t *dst)
 {
 	struct avrcp_device *dev;
 	char addr[18];
-	GSList *l;
 
 	DBG("");
 
-	l = g_slist_find_custom(devices, dst, device_cmp);
-	if (l)
+	if (avrcp_find(dst))
 		return;
 
 	dev = avrcp_device_new(dst);
@@ -352,16 +313,13 @@ void bt_avrcp_connect(const bdaddr_t *dst)
 void bt_avrcp_disconnect(const bdaddr_t *dst)
 {
 	struct avrcp_device *dev;
-	GSList *l;
 
 	DBG("");
 
-	l = g_slist_find_custom(devices, dst, device_cmp);
-	if (!l)
+	dev = avrcp_find(dst);
+	if (!dev)
 		return;
 
-	dev = l->data;
-
 	if (dev->session) {
 		avctp_shutdown(dev->session);
 		return;
-- 
1.8.3.2

