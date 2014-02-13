Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3] android/avrcp: Decouple AVRCP logic from btio
Date: Thu, 13 Feb 2014 17:20:07 +0200
Message-Id: <1392304807-19488-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The patch makes AVRCP to be channel-agnostic so that it might be used in
unit tests. The idea is that all AVRCP logic would come to avrcp-lib and
channel stuff got to avrcp.
---
 android/Android.mk  |  1 +
 android/Makefile.am |  1 +
 android/avrcp-lib.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/avrcp-lib.h | 29 ++++++++++++++++++++
 android/avrcp.c     | 28 ++++++++++++-------
 5 files changed, 128 insertions(+), 9 deletions(-)
 create mode 100644 android/avrcp-lib.c
 create mode 100644 android/avrcp-lib.h

diff --git a/android/Android.mk b/android/Android.mk
index 20602f3..72676e1 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -39,6 +39,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/avdtp.c \
 	bluez/android/a2dp.c \
 	bluez/android/avctp.c \
+	bluez/android/avrcp-lib.c \
 	bluez/android/avrcp.c \
 	bluez/android/pan.c \
 	bluez/android/handsfree.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 1913b42..07cc851 100644
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
index 0000000..b2b1b82
--- /dev/null
+++ b/android/avrcp-lib.c
@@ -0,0 +1,78 @@
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
+
+#include "src/log.h"
+
+#include "avctp.h"
+#include "avrcp-lib.h"
+
+struct avrcp {
+	struct avctp	*session;
+};
+
+void avrcp_free(void *data)
+{
+	struct avrcp *session = data;
+
+	if (session->session)
+		avctp_shutdown(session->session);
+
+	g_free(session);
+}
+
+struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu,
+							uint16_t version)
+{
+	struct avrcp *session;
+
+	session = g_new0(struct avrcp, 1);
+
+	session->session = avctp_new(fd, imtu, omtu, version);
+	if (!session->session) {
+		g_free(session);
+		return NULL;
+	}
+
+	return session;
+}
+
+void avrcp_set_destroy_cb(struct avrcp *session, avctp_destroy_cb_t cb,
+							void *user_data)
+{
+	avctp_set_destroy_cb(session->session, cb, user_data);
+}
+
+int avrcp_init_uinput(struct avrcp *session, const char *name,
+							const char *address)
+{
+	return avctp_init_uinput(session->session, name, address);
+}
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
new file mode 100644
index 0000000..8490722
--- /dev/null
+++ b/android/avrcp-lib.h
@@ -0,0 +1,29 @@
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
+struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
+void avrcp_free(void *data);
+void avrcp_set_destroy_cb(struct avrcp *session, avctp_destroy_cb_t cb,
+							void *user_data);
+int avrcp_init_uinput(struct avrcp *session, const char *name,
+							const char *address);
diff --git a/android/avrcp.c b/android/avrcp.c
index b8304f5..a2bb1df 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -38,6 +38,7 @@
 #include "hal-msg.h"
 #include "ipc.h"
 #include "avctp.h"
+#include "avrcp-lib.h"
 
 #define L2CAP_PSM_AVCTP 0x17
 
@@ -53,7 +54,7 @@ static GIOChannel *server = NULL;
 
 struct avrcp_device {
 	bdaddr_t	dst;
-	struct avctp	*session;
+	struct avrcp	*session;
 	GIOChannel	*io;
 };
 
@@ -133,7 +134,7 @@ static void avrcp_device_free(void *data)
 	struct avrcp_device *dev = data;
 
 	if (dev->session)
-		avctp_shutdown(dev->session);
+		avrcp_free(dev->session);
 
 	if (dev->io) {
 		g_io_channel_shutdown(dev->io, FALSE, NULL);
@@ -168,6 +169,17 @@ static int device_cmp(gconstpointer s, gconstpointer user_data)
 	return bacmp(&dev->dst, dst);
 }
 
+static struct avrcp_device *avrcp_find(const bdaddr_t *dst)
+{
+	GSList *l;
+
+	l = g_slist_find_custom(devices, dst, device_cmp);
+	if (!l)
+		return NULL;
+
+	return l->data;
+}
+
 static void disconnect_cb(void *data)
 {
 	struct avrcp_device *dev = data;
@@ -222,17 +234,17 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	}
 
 	fd = g_io_channel_unix_get_fd(chan);
-	dev->session = avctp_new(fd, imtu, omtu, 0x0100);
 
+	dev->session = avrcp_new(fd, imtu, omtu, 0x0100);
 	if (!dev->session) {
 		avrcp_device_free(dev);
 		return;
 	}
 
-	avctp_set_destroy_cb(dev->session, disconnect_cb, dev);
+	avrcp_set_destroy_cb(dev->session, disconnect_cb, dev);
 
 	/* FIXME: get the real name of the device */
-	avctp_init_uinput(dev->session, "bluetooth", address);
+	avrcp_init_uinput(dev->session, "bluetooth", address);
 
 	g_io_channel_set_close_on_unref(chan, FALSE);
 
@@ -331,12 +343,10 @@ void bt_avrcp_connect(const bdaddr_t *dst)
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
@@ -363,7 +373,7 @@ void bt_avrcp_disconnect(const bdaddr_t *dst)
 	dev = l->data;
 
 	if (dev->session) {
-		avctp_shutdown(dev->session);
+		avrcp_free(dev->session);
 		return;
 	}
 
-- 
1.8.3.2

