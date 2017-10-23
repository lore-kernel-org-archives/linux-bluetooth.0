Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v2 3/3] profiles/battery: Remove unused bas.[ch]
Date: Mon, 23 Oct 2017 17:48:14 +0200
Message-Id: <20171023154814.20607-3-hadess@hadess.net>
In-Reply-To: <20171023154814.20607-1-hadess@hadess.net>
References: <20171023154814.20607-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Battery Service characteristics are not children of the HoG
characteristics, so there's nothing to consume in the input profile.
Remove that code which duplicated most of the battery profile plugin.
---
 Makefile.am              |   1 -
 Makefile.plugins         |   1 -
 android/Android.mk       |   1 -
 android/Makefile.am      |   1 -
 profiles/battery/bas.c   | 340 -----------------------------------------------
 profiles/battery/bas.h   |  32 -----
 profiles/input/hog-lib.c |  25 +---
 7 files changed, 1 insertion(+), 400 deletions(-)
 delete mode 100644 profiles/battery/bas.c
 delete mode 100644 profiles/battery/bas.h

diff --git a/Makefile.am b/Makefile.am
index 8faabf44b..46358c7e9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -404,7 +404,6 @@ unit_test_hog_SOURCES = unit/test-hog.c \
 			$(btio_sources) \
 			profiles/input/hog-lib.h profiles/input/hog-lib.c \
 			profiles/scanparam/scpp.h profiles/scanparam/scpp.c \
-			profiles/battery/bas.h profiles/battery/bas.c \
 			profiles/deviceinfo/dis.h profiles/deviceinfo/dis.c \
 			src/log.h src/log.c \
 			attrib/att.h attrib/att.c \
diff --git a/Makefile.plugins b/Makefile.plugins
index 1f3b5b552..7416ad6bf 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -66,7 +66,6 @@ builtin_modules += hog
 builtin_sources += profiles/input/hog.c profiles/input/uhid_copy.h \
 			profiles/input/hog-lib.c profiles/input/hog-lib.h \
 			profiles/deviceinfo/dis.c profiles/deviceinfo/dis.h \
-			profiles/battery/bas.c profiles/battery/bas.h \
 			profiles/scanparam/scpp.c profiles/scanparam/scpp.h \
 			profiles/input/suspend.h profiles/input/suspend-none.c
 
diff --git a/android/Android.mk b/android/Android.mk
index 38ef4aa97..7b70d0129 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -41,7 +41,6 @@ LOCAL_SRC_FILES := \
 	bluez/android/bluetooth.c \
 	bluez/profiles/scanparam/scpp.c \
 	bluez/profiles/deviceinfo/dis.c \
-	bluez/profiles/battery/bas.c \
 	bluez/profiles/input/hog-lib.c \
 	bluez/android/hidhost.c \
 	bluez/android/socket.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 154f8db56..35d6e1e9d 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -32,7 +32,6 @@ android_bluetoothd_SOURCES = android/main.c \
 				profiles/scanparam/scpp.c \
 				profiles/deviceinfo/dis.h \
 				profiles/deviceinfo/dis.c \
-				profiles/battery/bas.h profiles/battery/bas.c \
 				profiles/input/hog-lib.h \
 				profiles/input/hog-lib.c \
 				android/ipc-common.h \
diff --git a/profiles/battery/bas.c b/profiles/battery/bas.c
deleted file mode 100644
index de369fd3c..000000000
--- a/profiles/battery/bas.c
+++ /dev/null
@@ -1,340 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2014  Intel Corporation. All rights reserved.
- *
- *
- *  This library is free software; you can rebastribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is bastributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdbool.h>
-#include <errno.h>
-
-#include <glib.h>
-
-#include "src/log.h"
-
-#include "lib/bluetooth.h"
-#include "lib/sdp.h"
-#include "lib/uuid.h"
-
-#include "src/shared/util.h"
-#include "src/shared/queue.h"
-
-#include "attrib/gattrib.h"
-#include "attrib/att.h"
-#include "attrib/gatt.h"
-
-#include "profiles/battery/bas.h"
-
-#define ATT_NOTIFICATION_HEADER_SIZE 3
-#define ATT_READ_RESPONSE_HEADER_SIZE 1
-
-struct bt_bas {
-	int ref_count;
-	GAttrib *attrib;
-	struct gatt_primary *primary;
-	uint16_t handle;
-	uint16_t ccc_handle;
-	guint id;
-	struct queue *gatt_op;
-};
-
-struct gatt_request {
-	unsigned int id;
-	struct bt_bas *bas;
-	void *user_data;
-};
-
-static void destroy_gatt_req(struct gatt_request *req)
-{
-	queue_remove(req->bas->gatt_op, req);
-	bt_bas_unref(req->bas);
-	free(req);
-}
-
-static void bas_free(struct bt_bas *bas)
-{
-	bt_bas_detach(bas);
-
-	g_free(bas->primary);
-	queue_destroy(bas->gatt_op, (void *) destroy_gatt_req);
-	free(bas);
-}
-
-struct bt_bas *bt_bas_new(void *primary)
-{
-	struct bt_bas *bas;
-
-	bas = new0(struct bt_bas, 1);
-	bas->gatt_op = queue_new();
-
-	if (primary)
-		bas->primary = g_memdup(primary, sizeof(*bas->primary));
-
-	return bt_bas_ref(bas);
-}
-
-struct bt_bas *bt_bas_ref(struct bt_bas *bas)
-{
-	if (!bas)
-		return NULL;
-
-	__sync_fetch_and_add(&bas->ref_count, 1);
-
-	return bas;
-}
-
-void bt_bas_unref(struct bt_bas *bas)
-{
-	if (!bas)
-		return;
-
-	if (__sync_sub_and_fetch(&bas->ref_count, 1))
-		return;
-
-	bas_free(bas);
-}
-
-static struct gatt_request *create_request(struct bt_bas *bas,
-							void *user_data)
-{
-	struct gatt_request *req;
-
-	req = new0(struct gatt_request, 1);
-	req->user_data = user_data;
-	req->bas = bt_bas_ref(bas);
-
-	return req;
-}
-
-static void set_and_store_gatt_req(struct bt_bas *bas,
-						struct gatt_request *req,
-						unsigned int id)
-{
-	req->id = id;
-	queue_push_head(bas->gatt_op, req);
-}
-
-static void write_char(struct bt_bas *bas, GAttrib *attrib, uint16_t handle,
-					const uint8_t *value, size_t vlen,
-					GAttribResultFunc func,
-					gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(bas, user_data);
-
-	id = gatt_write_char(attrib, handle, value, vlen, func, req);
-
-	set_and_store_gatt_req(bas, req, id);
-}
-
-static void read_char(struct bt_bas *bas, GAttrib *attrib, uint16_t handle,
-				GAttribResultFunc func, gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(bas, user_data);
-
-	id = gatt_read_char(attrib, handle, func, req);
-
-	set_and_store_gatt_req(bas, req, id);
-}
-
-static void discover_char(struct bt_bas *bas, GAttrib *attrib,
-						uint16_t start, uint16_t end,
-						bt_uuid_t *uuid, gatt_cb_t func,
-						gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(bas, user_data);
-
-	id = gatt_discover_char(attrib, start, end, uuid, func, req);
-
-	set_and_store_gatt_req(bas, req, id);
-}
-
-static void discover_desc(struct bt_bas *bas, GAttrib *attrib,
-				uint16_t start, uint16_t end, bt_uuid_t *uuid,
-				gatt_cb_t func, gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(bas, user_data);
-
-	id = gatt_discover_desc(attrib, start, end, uuid, func, req);
-	set_and_store_gatt_req(bas, req, id);
-}
-
-static void notification_cb(const guint8 *pdu, guint16 len, gpointer user_data)
-{
-	DBG("Battery Level at %u", pdu[ATT_NOTIFICATION_HEADER_SIZE]);
-}
-
-static void read_value_cb(guint8 status, const guint8 *pdu, guint16 len,
-					gpointer user_data)
-{
-	DBG("Battery Level at %u", pdu[ATT_READ_RESPONSE_HEADER_SIZE]);
-}
-
-static void ccc_written_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
-{
-	struct gatt_request *req = user_data;
-	struct bt_bas *bas = req->user_data;
-
-	destroy_gatt_req(req);
-
-	if (status != 0) {
-		error("Write Scan Refresh CCC failed: %s",
-						att_ecode2str(status));
-		return;
-	}
-
-	DBG("Battery Level: notification enabled");
-
-	bas->id = g_attrib_register(bas->attrib, ATT_OP_HANDLE_NOTIFY,
-					bas->handle, notification_cb, bas,
-					NULL);
-}
-
-static void write_ccc(struct bt_bas *bas, GAttrib *attrib, uint16_t handle,
-							void *user_data)
-{
-	uint8_t value[2];
-
-	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
-
-	write_char(bas, attrib, handle, value, sizeof(value), ccc_written_cb,
-								user_data);
-}
-
-static void ccc_read_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
-{
-	struct gatt_request *req = user_data;
-	struct bt_bas *bas = req->user_data;
-
-	destroy_gatt_req(req);
-
-	if (status != 0) {
-		error("Error reading CCC value: %s", att_ecode2str(status));
-		return;
-	}
-
-	write_ccc(bas, bas->attrib, bas->ccc_handle, bas);
-}
-
-static void discover_descriptor_cb(uint8_t status, GSList *descs,
-								void *user_data)
-{
-	struct gatt_request *req = user_data;
-	struct bt_bas *bas = req->user_data;
-	struct gatt_desc *desc;
-
-	destroy_gatt_req(req);
-
-	if (status != 0) {
-		error("Discover descriptors failed: %s", att_ecode2str(status));
-		return;
-	}
-
-	/* There will be only one descriptor on list and it will be CCC */
-	desc = descs->data;
-	bas->ccc_handle = desc->handle;
-
-	read_char(bas, bas->attrib, desc->handle, ccc_read_cb, bas);
-}
-
-static void bas_discovered_cb(uint8_t status, GSList *chars, void *user_data)
-{
-	struct gatt_request *req = user_data;
-	struct bt_bas *bas = req->user_data;
-	struct gatt_char *chr;
-	uint16_t start, end;
-	bt_uuid_t uuid;
-
-	destroy_gatt_req(req);
-
-	if (status) {
-		error("Battery: %s", att_ecode2str(status));
-		return;
-	}
-
-	chr = chars->data;
-	bas->handle = chr->value_handle;
-
-	DBG("Battery handle: 0x%04x", bas->handle);
-
-	read_char(bas, bas->attrib, bas->handle, read_value_cb, bas);
-
-	start = chr->value_handle + 1;
-	end = bas->primary->range.end;
-
-	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
-
-	discover_desc(bas, bas->attrib, start, end, &uuid,
-						discover_descriptor_cb, bas);
-}
-
-bool bt_bas_attach(struct bt_bas *bas, void *attrib)
-{
-	if (!bas || bas->attrib || !bas->primary)
-		return false;
-
-	bas->attrib = g_attrib_ref(attrib);
-
-	if (bas->handle > 0)
-		return true;
-
-	discover_char(bas, bas->attrib, bas->primary->range.start,
-					bas->primary->range.end, NULL,
-					bas_discovered_cb, bas);
-
-	return true;
-}
-
-static void cancel_gatt_req(struct gatt_request *req)
-{
-	if (g_attrib_cancel(req->bas->attrib, req->id))
-		destroy_gatt_req(req);
-}
-
-void bt_bas_detach(struct bt_bas *bas)
-{
-	if (!bas || !bas->attrib)
-		return;
-
-	if (bas->id > 0) {
-		g_attrib_unregister(bas->attrib, bas->id);
-		bas->id = 0;
-	}
-
-	queue_foreach(bas->gatt_op, (void *) cancel_gatt_req, NULL);
-	g_attrib_unref(bas->attrib);
-	bas->attrib = NULL;
-}
diff --git a/profiles/battery/bas.h b/profiles/battery/bas.h
deleted file mode 100644
index 3e175b5b5..000000000
--- a/profiles/battery/bas.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2014  Intel Corporation. All rights reserved.
- *
- *
- *  This library is free software; you can rebastribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is bastributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-struct bt_bas;
-
-struct bt_bas *bt_bas_new(void *primary);
-
-struct bt_bas *bt_bas_ref(struct bt_bas *bas);
-void bt_bas_unref(struct bt_bas *bas);
-
-bool bt_bas_attach(struct bt_bas *bas, void *gatt);
-void bt_bas_detach(struct bt_bas *bas);
diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index dab385fe7..7b0097cb6 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -57,7 +57,6 @@
 
 #include "profiles/scanparam/scpp.h"
 #include "profiles/deviceinfo/dis.h"
-#include "profiles/battery/bas.h"
 #include "profiles/input/hog-lib.h"
 
 #define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
@@ -105,7 +104,6 @@ struct bt_hog {
 	uint16_t		setrep_id;
 	struct bt_scpp		*scpp;
 	struct bt_dis		*dis;
-	struct queue		*bas;
 	GSList			*instances;
 	struct queue		*gatt_op;
 };
@@ -1174,7 +1172,6 @@ static void hog_free(void *data)
 
 	bt_hog_detach(hog);
 
-	queue_destroy(hog->bas, (void *) bt_bas_unref);
 	g_slist_free_full(hog->instances, hog_free);
 
 	bt_scpp_unref(hog->scpp);
@@ -1323,7 +1320,6 @@ static struct bt_hog *hog_new(int fd, const char *name, uint16_t vendor,
 		return NULL;
 
 	hog->gatt_op = queue_new();
-	hog->bas = queue_new();
 
 	if (fd < 0)
 		hog->uhid = bt_uhid_new_default();
@@ -1332,7 +1328,7 @@ static struct bt_hog *hog_new(int fd, const char *name, uint16_t vendor,
 
 	hog->uhid_fd = fd;
 
-	if (!hog->gatt_op || !hog->bas || !hog->uhid) {
+	if (!hog->gatt_op || !hog->uhid) {
 		hog_free(hog);
 		return NULL;
 	}
@@ -1483,16 +1479,6 @@ static void hog_attach_dis(struct bt_hog *hog, struct gatt_primary *primary)
 	}
 }
 
-static void hog_attach_bas(struct bt_hog *hog, struct gatt_primary *primary)
-{
-	struct bt_bas *instance;
-
-	instance = bt_bas_new(primary);
-
-	bt_bas_attach(instance, hog->attrib);
-	queue_push_head(hog->bas, instance);
-}
-
 static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
 {
 	struct bt_hog *instance;
@@ -1555,11 +1541,6 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 			continue;
 		}
 
-		if (strcmp(primary->uuid, BATTERY_UUID) == 0) {
-			hog_attach_bas(hog, primary);
-			continue;
-		}
-
 		if (strcmp(primary->uuid, HOG_UUID) == 0)
 			hog_attach_hog(hog, primary);
 	}
@@ -1585,8 +1566,6 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 	if (hog->dis)
 		bt_dis_attach(hog->dis, gatt);
 
-	queue_foreach(hog->bas, (void *) bt_bas_attach, gatt);
-
 	for (l = hog->instances; l; l = l->next) {
 		struct bt_hog *instance = l->data;
 
@@ -1625,8 +1604,6 @@ void bt_hog_detach(struct bt_hog *hog)
 	if (!hog->attrib)
 		return;
 
-	queue_foreach(hog->bas, (void *) bt_bas_detach, NULL);
-
 	for (l = hog->instances; l; l = l->next) {
 		struct bt_hog *instance = l->data;
 
-- 
2.14.2

