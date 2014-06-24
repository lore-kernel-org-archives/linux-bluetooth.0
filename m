Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/12] android/dis: Strip dependencies from deviceinfo plugin
Date: Tue, 24 Jun 2014 11:36:09 +0300
Message-Id: <1403598979-31032-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403598979-31032-1-git-send-email-luiz.dentz@gmail.com>
References: <1403598979-31032-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This strip any dependecy from deviceinfo plugin so the code can be reused
by HoG implementation.
---
 android/Android.mk  |   1 +
 android/Makefile.am |   1 +
 android/dis.c       | 154 ++++++++++++++++++++++++----------------------------
 android/dis.h       |  32 +++++++++++
 4 files changed, 106 insertions(+), 82 deletions(-)
 create mode 100644 android/dis.h

diff --git a/android/Android.mk b/android/Android.mk
index fc7b59d..7485c0f 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -35,6 +35,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := \
 	bluez/android/main.c \
 	bluez/android/bluetooth.c \
+	bluez/android/dis.c \
 	bluez/android/hog.c \
 	bluez/android/hidhost.c \
 	bluez/android/socket.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 51c8253..0349f38 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -38,6 +38,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				src/shared/uhid.h src/shared/uhid.c \
 				android/bluetooth.h android/bluetooth.c \
 				android/hidhost.h android/hidhost.c \
+				android/dis.h android/dis.c \
 				android/hog.h android/hog.c \
 				android/ipc-common.h \
 				android/ipc.h android/ipc.c \
diff --git a/android/dis.c b/android/dis.c
index 208598a..7914293 100644
--- a/android/dis.c
+++ b/android/dis.c
@@ -29,55 +29,86 @@
 
 #include <glib.h>
 
+#include "src/log.h"
+
 #include "lib/uuid.h"
-#include "src/plugin.h"
-#include "src/adapter.h"
-#include "src/device.h"
-#include "src/profile.h"
-#include "src/service.h"
 #include "src/shared/util.h"
+
 #include "attrib/gattrib.h"
-#include "src/attio.h"
 #include "attrib/att.h"
 #include "attrib/gatt.h"
-#include "src/log.h"
+
+#include "android/dis.h"
 
 #define PNP_ID_SIZE	7
 
-struct deviceinfo {
-	struct btd_device	*dev;		/* Device reference */
+struct bt_dis {
+	int			ref_count;
+	uint8_t			source;
+	uint16_t		vendor;
+	uint16_t		product;
+	uint16_t		version;
 	GAttrib			*attrib;	/* GATT connection */
-	guint			attioid;	/* Att watcher id */
-	struct att_range	*svc_range;	/* DeviceInfo range */
+	struct gatt_primary	*primary;	/* Primary details */
 	GSList			*chars;		/* Characteristics */
 };
 
 struct characteristic {
 	struct gatt_char	attr;	/* Characteristic */
-	struct deviceinfo	*d;	/* deviceinfo where the char belongs */
+	struct bt_dis		*d;	/* deviceinfo where the char belongs */
 };
 
-static void deviceinfo_driver_remove(struct btd_service *service)
+static void dis_free(struct bt_dis *dis)
+{
+	if (dis->attrib)
+		g_attrib_unref(dis->attrib);
+
+	g_slist_free_full(dis->chars, g_free);
+
+	g_free(dis->primary);
+	g_free(dis);
+}
+
+struct bt_dis *bt_dis_new(void *primary)
 {
-	struct deviceinfo *d = btd_service_get_user_data(service);
+	struct bt_dis *dis;
 
-	if (d->attioid > 0)
-		btd_device_remove_attio_callback(d->dev, d->attioid);
+	dis = g_try_new0(struct bt_dis, 1);
+	if (!dis)
+		return NULL;
 
-	if (d->attrib != NULL)
-		g_attrib_unref(d->attrib);
+	if (primary)
+		dis->primary = g_memdup(primary, sizeof(*dis->primary));
 
-	g_slist_free_full(d->chars, g_free);
+	return bt_dis_ref(dis);
+}
+
+struct bt_dis *bt_dis_ref(struct bt_dis *dis)
+{
+	if (!dis)
+		return NULL;
 
-	btd_device_unref(d->dev);
-	g_free(d->svc_range);
-	g_free(d);
+	__sync_fetch_and_add(&dis->ref_count, 1);
+
+	return dis;
+}
+
+void bt_dis_unref(struct bt_dis *dis)
+{
+	if (!dis)
+		return;
+
+	if (__sync_sub_and_fetch(&dis->ref_count, 1))
+		return;
+
+	dis_free(dis);
 }
 
 static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
 	struct characteristic *ch = user_data;
+	struct bt_dis *dis = ch->d;
 	uint8_t value[PNP_ID_SIZE];
 	ssize_t vlen;
 
@@ -97,8 +128,10 @@ static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
 		return;
 	}
 
-	btd_device_set_pnpid(ch->d->dev, value[0], get_le16(&value[1]),
-				get_le16(&value[3]), get_le16(&value[5]));
+	dis->source = value[0];
+	dis->vendor = get_le16(&value[1]);
+	dis->product = get_le16(&value[3]);
+	dis->version = get_le16(&value[5]);
 }
 
 static void process_deviceinfo_char(struct characteristic *ch)
@@ -111,7 +144,7 @@ static void process_deviceinfo_char(struct characteristic *ch)
 static void configure_deviceinfo_cb(uint8_t status, GSList *characteristics,
 								void *user_data)
 {
-	struct deviceinfo *d = user_data;
+	struct bt_dis *d = user_data;
 	GSList *l;
 
 	if (status != 0) {
@@ -136,71 +169,28 @@ static void configure_deviceinfo_cb(uint8_t status, GSList *characteristics,
 		process_deviceinfo_char(ch);
 	}
 }
-static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
-{
-	struct deviceinfo *d = user_data;
-
-	d->attrib = g_attrib_ref(attrib);
-
-	gatt_discover_char(d->attrib, d->svc_range->start, d->svc_range->end,
-					NULL, configure_deviceinfo_cb, d);
-}
 
-static void attio_disconnected_cb(gpointer user_data)
+bool bt_dis_attach(struct bt_dis *dis, void *attrib)
 {
-	struct deviceinfo *d = user_data;
+	struct gatt_primary *primary = dis->primary;
 
-	g_attrib_unref(d->attrib);
-	d->attrib = NULL;
-}
-
-static int deviceinfo_register(struct btd_service *service,
-						struct gatt_primary *prim)
-{
-	struct btd_device *device = btd_service_get_device(service);
-	struct deviceinfo *d;
+	if (dis->attrib || !primary)
+		return false;
 
-	d = g_new0(struct deviceinfo, 1);
-	d->dev = btd_device_ref(device);
-	d->svc_range = g_new0(struct att_range, 1);
-	d->svc_range->start = prim->range.start;
-	d->svc_range->end = prim->range.end;
+	dis->attrib = g_attrib_ref(attrib);
 
-	btd_service_set_user_data(service, d);
+	gatt_discover_char(dis->attrib, primary->range.start,
+						primary->range.end, NULL,
+						configure_deviceinfo_cb, dis);
 
-	d->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
-						attio_disconnected_cb, d);
-	return 0;
+	return true;
 }
 
-static int deviceinfo_driver_probe(struct btd_service *service)
+void bt_dis_detach(struct bt_dis *dis)
 {
-	struct btd_device *device = btd_service_get_device(service);
-	struct gatt_primary *prim;
-
-	prim = btd_device_get_primary(device, DEVICE_INFORMATION_UUID);
-	if (prim == NULL)
-		return -EINVAL;
-
-	return deviceinfo_register(service, prim);
-}
-
-static struct btd_profile deviceinfo_profile = {
-	.name		= "deviceinfo",
-	.remote_uuid	= DEVICE_INFORMATION_UUID,
-	.device_probe	= deviceinfo_driver_probe,
-	.device_remove	= deviceinfo_driver_remove
-};
-
-static int deviceinfo_init(void)
-{
-	return btd_profile_register(&deviceinfo_profile);
-}
+	if (!dis->attrib)
+		return;
 
-static void deviceinfo_exit(void)
-{
-	btd_profile_unregister(&deviceinfo_profile);
+	g_attrib_unref(dis->attrib);
+	dis->attrib = NULL;
 }
-
-BLUETOOTH_PLUGIN_DEFINE(deviceinfo, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-					deviceinfo_init, deviceinfo_exit)
diff --git a/android/dis.h b/android/dis.h
new file mode 100644
index 0000000..6cc0b58
--- /dev/null
+++ b/android/dis.h
@@ -0,0 +1,32 @@
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
+struct bt_dis;
+
+struct bt_dis *bt_dis_new(void *primary);
+
+struct bt_dis *bt_dis_ref(struct bt_dis *dis);
+void bt_dis_unref(struct bt_dis *dis);
+
+bool bt_dis_attach(struct bt_dis *dis, void *gatt);
+void bt_dis_detach(struct bt_dis *dis);
-- 
1.9.3

