Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/12] android/scpp: Strip dependencies from scan plugin
Date: Tue, 24 Jun 2014 11:36:14 +0300
Message-Id: <1403598979-31032-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403598979-31032-1-git-send-email-luiz.dentz@gmail.com>
References: <1403598979-31032-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This strip any dependecy from scan plugin so the code can be reused
by HoG implementation.
---
 android/Android.mk  |   1 +
 android/Makefile.am |   1 +
 android/scpp.c      | 168 ++++++++++++++++++++++++----------------------------
 android/scpp.h      |  32 ++++++++++
 4 files changed, 110 insertions(+), 92 deletions(-)
 create mode 100644 android/scpp.h

diff --git a/android/Android.mk b/android/Android.mk
index 7485c0f..fdc352a 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -36,6 +36,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/main.c \
 	bluez/android/bluetooth.c \
 	bluez/android/dis.c \
+	bluez/android/scpp.c \
 	bluez/android/hog.c \
 	bluez/android/hidhost.c \
 	bluez/android/socket.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 0349f38..ffcb199 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -39,6 +39,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/bluetooth.h android/bluetooth.c \
 				android/hidhost.h android/hidhost.c \
 				android/dis.h android/dis.c \
+				android/scpp.h android/scpp.c \
 				android/hog.h android/hog.c \
 				android/ipc-common.h \
 				android/ipc.h android/ipc.c \
diff --git a/android/scpp.c b/android/scpp.c
index 3eece9d..c73a015 100644
--- a/android/scpp.c
+++ b/android/scpp.c
@@ -29,18 +29,18 @@
 #include <stdbool.h>
 #include <errno.h>
 
-#include "lib/uuid.h"
+#include <glib.h>
+
 #include "src/log.h"
-#include "src/plugin.h"
-#include "src/adapter.h"
-#include "src/device.h"
-#include "src/profile.h"
-#include "src/service.h"
+
+#include "lib/uuid.h"
 #include "src/shared/util.h"
+
 #include "attrib/att.h"
 #include "attrib/gattrib.h"
 #include "attrib/gatt.h"
-#include "src/attio.h"
+
+#include "android/scpp.h"
 
 #define SCAN_INTERVAL_WIN_UUID		0x2A4F
 #define SCAN_REFRESH_UUID		0x2A31
@@ -49,11 +49,10 @@
 #define SCAN_WINDOW		0x0030
 #define SERVER_REQUIRES_REFRESH	0x00
 
-struct scan {
-	struct btd_device *device;
+struct bt_scpp {
+	int ref_count;
 	GAttrib *attrib;
-	struct att_range range;
-	guint attioid;
+	struct gatt_primary *primary;
 	uint16_t interval;
 	uint16_t window;
 	uint16_t iwhandle;
@@ -61,6 +60,50 @@ struct scan {
 	guint refresh_cb_id;
 };
 
+static void scpp_free(struct bt_scpp *scan)
+{
+	if (scan->attrib)
+		g_attrib_unref(scan->attrib);
+
+	g_free(scan->primary);
+	g_free(scan);
+}
+
+struct bt_scpp *bt_scpp_new(void *primary)
+{
+	struct bt_scpp *scan;
+
+	scan = g_try_new0(struct bt_scpp, 1);
+	if (!scan)
+		return NULL;
+
+	if (primary)
+		scan->primary = g_memdup(primary, sizeof(*scan->primary));
+
+	return bt_scpp_ref(scan);
+}
+
+struct bt_scpp *bt_scpp_ref(struct bt_scpp *scan)
+{
+	if (!scan)
+		return NULL;
+
+	__sync_fetch_and_add(&scan->ref_count, 1);
+
+	return scan;
+}
+
+void bt_scpp_unref(struct bt_scpp *scan)
+{
+	if (!scan)
+		return;
+
+	if (__sync_sub_and_fetch(&scan->ref_count, 1))
+		return;
+
+	scpp_free(scan);
+}
+
 static void write_scan_params(GAttrib *attrib, uint16_t handle)
 {
 	uint8_t value[4];
@@ -74,7 +117,7 @@ static void write_scan_params(GAttrib *attrib, uint16_t handle)
 static void refresh_value_cb(const uint8_t *pdu, uint16_t len,
 						gpointer user_data)
 {
-	struct scan *scan = user_data;
+	struct bt_scpp *scan = user_data;
 
 	DBG("Server requires refresh: %d", pdu[3]);
 
@@ -85,7 +128,7 @@ static void refresh_value_cb(const uint8_t *pdu, uint16_t len,
 static void ccc_written_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct scan *scan = user_data;
+	struct bt_scpp *scan = user_data;
 
 	if (status != 0) {
 		error("Write Scan Refresh CCC failed: %s",
@@ -103,7 +146,7 @@ static void ccc_written_cb(guint8 status, const guint8 *pdu,
 static void discover_descriptor_cb(uint8_t status, GSList *descs,
 								void *user_data)
 {
-	struct scan *scan = user_data;
+	struct bt_scpp *scan = user_data;
 	struct gatt_desc *desc;
 	uint8_t value[2];
 
@@ -123,7 +166,7 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 static void refresh_discovered_cb(uint8_t status, GSList *chars,
 								void *user_data)
 {
-	struct scan *scan = user_data;
+	struct bt_scpp *scan = user_data;
 	struct gatt_char *chr;
 	uint16_t start, end;
 	bt_uuid_t uuid;
@@ -143,7 +186,7 @@ static void refresh_discovered_cb(uint8_t status, GSList *chars,
 	DBG("Scan Refresh handle: 0x%04x", chr->value_handle);
 
 	start = chr->value_handle + 1;
-	end = scan->range.end;
+	end = scan->primary->range.end;
 
 	if (start > end)
 		return;
@@ -158,7 +201,7 @@ static void refresh_discovered_cb(uint8_t status, GSList *chars,
 
 static void iwin_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 {
-	struct scan *scan = user_data;
+	struct bt_scpp *scan = user_data;
 	struct gatt_char *chr;
 
 	if (status) {
@@ -175,98 +218,39 @@ static void iwin_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 	write_scan_params(scan->attrib, scan->iwhandle);
 }
 
-static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+bool bt_scpp_attach(struct bt_scpp *scan, void *attrib)
 {
-	struct scan *scan = user_data;
 	bt_uuid_t iwin_uuid, refresh_uuid;
 
+	if (!scan || scan->attrib || !scan->primary)
+		return false;
+
 	scan->attrib = g_attrib_ref(attrib);
 
 	if (scan->iwhandle) {
 		write_scan_params(scan->attrib, scan->iwhandle);
-		return;
+		return true;
 	}
 
 	bt_uuid16_create(&iwin_uuid, SCAN_INTERVAL_WIN_UUID);
 	bt_uuid16_create(&refresh_uuid, SCAN_REFRESH_UUID);
 
-	gatt_discover_char(scan->attrib, scan->range.start, scan->range.end,
-					&iwin_uuid, iwin_discovered_cb, scan);
+	gatt_discover_char(scan->attrib, scan->primary->range.start,
+				scan->primary->range.end, &iwin_uuid,
+				iwin_discovered_cb, scan);
 
-	gatt_discover_char(scan->attrib, scan->range.start, scan->range.end,
-				&refresh_uuid, refresh_discovered_cb, scan);
-}
-
-static void attio_disconnected_cb(gpointer user_data)
-{
-	struct scan *scan = user_data;
+	gatt_discover_char(scan->attrib, scan->primary->range.start,
+				scan->primary->range.end, &refresh_uuid,
+				refresh_discovered_cb, scan);
 
-	g_attrib_unref(scan->attrib);
-	scan->attrib = NULL;
+	return true;
 }
 
-static int scan_register(struct btd_service *service, struct gatt_primary *prim)
+void bt_scpp_detach(struct bt_scpp *scan)
 {
-	struct btd_device *device = btd_service_get_device(service);
-	struct scan *scan;
-
-	scan = g_new0(struct scan, 1);
-	scan->device = btd_device_ref(device);
-	scan->range = prim->range;
-	scan->attioid = btd_device_add_attio_callback(device,
-							attio_connected_cb,
-							attio_disconnected_cb,
-							scan);
-
-	btd_service_set_user_data(service, scan);
-
-	return 0;
-}
-
-static void scan_param_remove(struct btd_service *service)
-{
-	struct scan *scan = btd_service_get_user_data(service);
-
-	if (scan->attrib != NULL && scan->refresh_cb_id > 0)
-		g_attrib_unregister(scan->attrib, scan->refresh_cb_id);
+	if (!scan || !scan->attrib)
+		return;
 
-	btd_device_remove_attio_callback(scan->device, scan->attioid);
-	btd_device_unref(scan->device);
 	g_attrib_unref(scan->attrib);
-	g_free(scan);
-}
-
-static int scan_param_probe(struct btd_service *service)
-{
-	struct btd_device *device = btd_service_get_device(service);
-	struct gatt_primary *prim;
-
-	DBG("Probing Scan Parameters");
-
-	prim = btd_device_get_primary(device, SCAN_PARAMETERS_UUID);
-	if (!prim)
-		return -EINVAL;
-
-	return scan_register(service, prim);
-}
-
-static struct btd_profile scan_profile = {
-	.name = "Scan Parameters Client Driver",
-	.remote_uuid = SCAN_PARAMETERS_UUID,
-	.device_probe = scan_param_probe,
-	.device_remove = scan_param_remove,
-};
-
-static int scan_param_init(void)
-{
-	return btd_profile_register(&scan_profile);
-}
-
-static void scan_param_exit(void)
-{
-	btd_profile_unregister(&scan_profile);
+	scan->attrib = NULL;
 }
-
-BLUETOOTH_PLUGIN_DEFINE(scanparam, VERSION,
-			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-			scan_param_init, scan_param_exit)
diff --git a/android/scpp.h b/android/scpp.h
new file mode 100644
index 0000000..f374cee
--- /dev/null
+++ b/android/scpp.h
@@ -0,0 +1,32 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can rescpptribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is scpptributed in the hope that it will be useful,
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
+struct bt_scpp;
+
+struct bt_scpp *bt_scpp_new(void *primary);
+
+struct bt_scpp *bt_scpp_ref(struct bt_scpp *scan);
+void bt_scpp_unref(struct bt_scpp *scan);
+
+bool bt_scpp_attach(struct bt_scpp *scan, void *gatt);
+void bt_scpp_detach(struct bt_scpp *scan);
-- 
1.9.3

