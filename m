Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v3] profiles/deviceinfo: rewrite deviceinfo profile
Date: Thu, 22 Oct 2015 11:10:39 -0700
Message-Id: <1445537439-4845-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch include new version of deviceinfo profile. It is now
not triggering autoconnect. It's also using accept callback instead
of btd_device_add_attio_callback.
---
 profiles/deviceinfo/deviceinfo.c | 162 ++++++++++++++-------------------------
 1 file changed, 57 insertions(+), 105 deletions(-)

diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index 6ee018c..d1f51a0 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -3,6 +3,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2012 Texas Instruments, Inc.
+ *  Copyright (C) 2015 Google Inc.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -38,154 +39,104 @@
 #include "src/device.h"
 #include "src/profile.h"
 #include "src/service.h"
-#include "src/shared/util.h"
 #include "attrib/gattrib.h"
-#include "src/attio.h"
+#include "src/shared/util.h"
+#include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
 #include "attrib/att.h"
-#include "attrib/gatt.h"
 #include "src/log.h"
 
 #define PNP_ID_SIZE	7
 
-struct deviceinfo {
-	struct btd_device	*dev;		/* Device reference */
-	GAttrib			*attrib;	/* GATT connection */
-	guint			attioid;	/* Att watcher id */
-	struct att_range	*svc_range;	/* DeviceInfo range */
-	GSList			*chars;		/* Characteristics */
-};
-
-struct characteristic {
-	struct gatt_char	attr;	/* Characteristic */
-	struct deviceinfo	*d;	/* deviceinfo where the char belongs */
-};
-
-static void deviceinfo_driver_remove(struct btd_service *service)
+static void read_pnpid_cb(bool success, uint8_t att_ecode, const uint8_t *value,
+					uint16_t length, void *user_data)
 {
-	struct deviceinfo *d = btd_service_get_user_data(service);
-
-	if (d->attioid > 0)
-		btd_device_remove_attio_callback(d->dev, d->attioid);
-
-	if (d->attrib != NULL)
-		g_attrib_unref(d->attrib);
-
-	g_slist_free_full(d->chars, g_free);
+	struct btd_device *device = user_data;
 
-	btd_device_unref(d->dev);
-	g_free(d->svc_range);
-	g_free(d);
-}
-
-static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
-{
-	struct characteristic *ch = user_data;
-	uint8_t value[PNP_ID_SIZE];
-	ssize_t vlen;
-
-	if (status != 0) {
-		error("Error reading PNP_ID value: %s", att_ecode2str(status));
+	if (!success) {
+		error("Error reading PNP_ID value: %s",
+						att_ecode2str(att_ecode));
 		return;
 	}
 
-	vlen = dec_read_resp(pdu, len, value, sizeof(value));
-	if (vlen < 0) {
-		error("Error reading PNP_ID: Protocol error");
-		return;
-	}
-
-	if (vlen < 7) {
+	if (length < PNP_ID_SIZE) {
 		error("Error reading PNP_ID: Invalid pdu length received");
 		return;
 	}
 
-	btd_device_set_pnpid(ch->d->dev, value[0], get_le16(&value[1]),
+	btd_device_set_pnpid(device, value[0], get_le16(&value[1]),
 				get_le16(&value[3]), get_le16(&value[5]));
 }
 
-static void process_deviceinfo_char(struct characteristic *ch)
+static void handle_pnpid(struct btd_device *device, uint16_t value_handle)
 {
-	if (g_strcmp0(ch->attr.uuid, PNPID_UUID) == 0)
-		gatt_read_char(ch->d->attrib, ch->attr.value_handle,
-							read_pnpid_cb, ch);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
+
+	if (!bt_gatt_client_read_value(client, value_handle,
+						read_pnpid_cb, device, NULL))
+		DBG("Failed to send request to read pnpid");
 }
 
-static void configure_deviceinfo_cb(uint8_t status, GSList *characteristics,
+static void handle_characteristic(struct gatt_db_attribute *attr,
 								void *user_data)
 {
-	struct deviceinfo *d = user_data;
-	GSList *l;
+	struct btd_device *device = user_data;
+	uint16_t value_handle;
+	bt_uuid_t uuid, pnpid_uuid;
+
+	bt_string_to_uuid(&pnpid_uuid, PNPID_UUID);
 
-	if (status != 0) {
-		error("Discover deviceinfo characteristics: %s",
-							att_ecode2str(status));
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle, NULL,
+								&uuid)) {
+		error("Failed to obtain characteristic data");
 		return;
 	}
 
-	for (l = characteristics; l; l = l->next) {
-		struct gatt_char *c = l->data;
-		struct characteristic *ch;
+	if (bt_uuid_cmp(&pnpid_uuid, &uuid) == 0)
+		handle_pnpid(device, value_handle);
+	else {
+		char uuid_str[MAX_LEN_UUID_STR];
 
-		ch = g_new0(struct characteristic, 1);
-		ch->attr.handle = c->handle;
-		ch->attr.properties = c->properties;
-		ch->attr.value_handle = c->value_handle;
-		memcpy(ch->attr.uuid, c->uuid, MAX_LEN_UUID_STR + 1);
-		ch->d = d;
-
-		d->chars = g_slist_append(d->chars, ch);
-
-		process_deviceinfo_char(ch);
+		bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
+		DBG("Unsupported characteristic: %s", uuid_str);
 	}
 }
-static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
-{
-	struct deviceinfo *d = user_data;
 
-	d->attrib = g_attrib_ref(attrib);
+static void foreach_deviceinfo_service(struct gatt_db_attribute *attr,
+								void *user_data)
+{
+	struct btd_device *device = user_data;
 
-	gatt_discover_char(d->attrib, d->svc_range->start, d->svc_range->end,
-					NULL, configure_deviceinfo_cb, d);
+	gatt_db_service_foreach_char(attr, handle_characteristic, device);
 }
 
-static void attio_disconnected_cb(gpointer user_data)
+static int deviceinfo_driver_probe(struct btd_service *service)
 {
-	struct deviceinfo *d = user_data;
-
-	g_attrib_unref(d->attrib);
-	d->attrib = NULL;
+	return 0;
 }
 
-static int deviceinfo_register(struct btd_service *service,
-						struct gatt_primary *prim)
+static void deviceinfo_driver_remove(struct btd_service *service)
 {
-	struct btd_device *device = btd_service_get_device(service);
-	struct deviceinfo *d;
-
-	d = g_new0(struct deviceinfo, 1);
-	d->dev = btd_device_ref(device);
-	d->svc_range = g_new0(struct att_range, 1);
-	d->svc_range->start = prim->range.start;
-	d->svc_range->end = prim->range.end;
-
-	btd_service_set_user_data(service, d);
-
-	d->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
-						attio_disconnected_cb, d);
-	return 0;
 }
 
-static int deviceinfo_driver_probe(struct btd_service *service)
+
+static int deviceinfo_driver_accept(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
-	struct gatt_primary *prim;
+	struct gatt_db *db = btd_device_get_gatt_db(device);
+	char addr[18];
+	bt_uuid_t deviceinfo_uuid;
 
-	prim = btd_device_get_primary(device, DEVICE_INFORMATION_UUID);
-	if (prim == NULL)
-		return -EINVAL;
+	ba2str(device_get_address(device), addr);
+	DBG("deviceinfo profile accept (%s)", addr);
 
-	return deviceinfo_register(service, prim);
+	/* Handle the device info service */
+	bt_string_to_uuid(&deviceinfo_uuid, DEVICE_INFORMATION_UUID);
+	gatt_db_foreach_service(db, &deviceinfo_uuid,
+					foreach_deviceinfo_service, device);
+
+	return 0;
 }
 
 static struct btd_profile deviceinfo_profile = {
@@ -193,7 +144,8 @@ static struct btd_profile deviceinfo_profile = {
 	.remote_uuid	= DEVICE_INFORMATION_UUID,
 	.external	= true,
 	.device_probe	= deviceinfo_driver_probe,
-	.device_remove	= deviceinfo_driver_remove
+	.device_remove	= deviceinfo_driver_remove,
+	.accept		= deviceinfo_driver_accept,
 };
 
 static int deviceinfo_init(void)
-- 
2.5.0

