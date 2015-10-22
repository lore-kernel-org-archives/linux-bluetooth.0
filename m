Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH BlueZ] profiles/scanparam: rewrite scanparam profile
Date: Thu, 22 Oct 2015 16:07:56 -0700
Message-Id: <1445555276-9693-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch rewrites scanparam profile. It will no longer trigger
autoconnect.
---
 profiles/scanparam/scan.c | 255 ++++++++++++++++++++++++----------------------
 1 file changed, 131 insertions(+), 124 deletions(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index fbda8a8..e967cab 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -40,10 +40,11 @@
 #include "src/profile.h"
 #include "src/service.h"
 #include "src/shared/util.h"
+#include "src/shared/att.h"
+#include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
 #include "attrib/att.h"
-#include "attrib/gattrib.h"
-#include "attrib/gatt.h"
-#include "src/attio.h"
 
 #define SCAN_INTERVAL_WIN_UUID		0x2A4F
 #define SCAN_REFRESH_UUID		0x2A31
@@ -54,203 +55,208 @@
 
 struct scan {
 	struct btd_device *device;
-	GAttrib *attrib;
-	struct att_range range;
-	guint attioid;
-	uint16_t interval;
-	uint16_t window;
+	struct gatt_db *db;
+	struct bt_gatt_client *client;
+	struct gatt_db_attribute *attr;
 	uint16_t iwhandle;
-	uint16_t refresh_handle;
 	guint refresh_cb_id;
 };
 
-static void write_scan_params(GAttrib *attrib, uint16_t handle)
+static GSList *devices;
+
+static void scan_free(struct scan *scan)
+{
+	bt_gatt_client_unregister_notify(scan->client, scan->refresh_cb_id);
+	gatt_db_unref(scan->db);
+	bt_gatt_client_unref(scan->client);
+	btd_device_unref(scan->device);
+	g_free(scan);
+}
+
+static int cmp_device(gconstpointer a, gconstpointer b)
+{
+	const struct scan *scan = a;
+	const struct btd_device *device = b;
+
+	return scan->device == device ? 0 : -1;
+}
+
+static void write_scan_params(struct scan *scan)
 {
 	uint8_t value[4];
 
 	put_le16(SCAN_INTERVAL, &value[0]);
 	put_le16(SCAN_WINDOW, &value[2]);
 
-	gatt_write_cmd(attrib, handle, value, sizeof(value), NULL, NULL);
+	bt_gatt_client_write_without_response(scan->client, scan->iwhandle,
+						false, value, sizeof(value));
 }
 
-static void refresh_value_cb(const uint8_t *pdu, uint16_t len,
-						gpointer user_data)
+static void refresh_value_cb(uint16_t value_handle, const uint8_t *value,
+					uint16_t length, void *user_data)
 {
 	struct scan *scan = user_data;
 
-	DBG("Server requires refresh: %d", pdu[3]);
+	DBG("Server requires refresh: %d", value[3]);
 
-	if (pdu[3] == SERVER_REQUIRES_REFRESH)
-		write_scan_params(scan->attrib, scan->iwhandle);
+	if (value[3] == SERVER_REQUIRES_REFRESH)
+		write_scan_params(scan);
 }
 
-static void ccc_written_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void refresh_ccc_written_cb(uint16_t att_ecode, void *user_data)
 {
-	struct scan *scan = user_data;
-
-	if (status != 0) {
-		error("Write Scan Refresh CCC failed: %s",
-						att_ecode2str(status));
+	if (att_ecode != 0) {
+		error("Scan Refresh: notifications not enabled %s",
+						att_ecode2str(att_ecode));
 		return;
 	}
 
 	DBG("Scan Refresh: notification enabled");
-
-	scan->refresh_cb_id = g_attrib_register(scan->attrib,
-				ATT_OP_HANDLE_NOTIFY, scan->refresh_handle,
-				refresh_value_cb, scan, NULL);
 }
 
-static void discover_descriptor_cb(uint8_t status, GSList *descs,
-								void *user_data)
+static void handle_refresh(struct scan *scan, uint16_t value_handle)
 {
-	struct scan *scan = user_data;
-	struct gatt_desc *desc;
-	uint8_t value[2];
+	DBG("Scan Refresh handle: 0x%04x", value_handle);
 
-	if (status != 0) {
-		error("Discover descriptors failed: %s", att_ecode2str(status));
-		return;
-	}
+	scan->refresh_cb_id = bt_gatt_client_register_notify(scan->client,
+					value_handle, refresh_ccc_written_cb,
+						refresh_value_cb, scan,	NULL);
+}
+
+static void handle_iwin(struct scan *scan, uint16_t value_handle)
+{
+	scan->iwhandle = value_handle;
 
-	/* There will be only one descriptor on list and it will be CCC */
-	desc = descs->data;
+	DBG("Scan Interval Window handle: 0x%04x", scan->iwhandle);
 
-	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
-	gatt_write_char(scan->attrib, desc->handle, value, sizeof(value),
-						ccc_written_cb, user_data);
+	write_scan_params(scan);
 }
 
-static void refresh_discovered_cb(uint8_t status, GSList *chars,
+static void handle_characteristic(struct gatt_db_attribute *attr,
 								void *user_data)
 {
 	struct scan *scan = user_data;
-	struct gatt_char *chr;
-	uint16_t start, end;
-	bt_uuid_t uuid;
-
-	if (status) {
-		error("Scan Refresh %s", att_ecode2str(status));
-		return;
-	}
+	uint16_t value_handle;
+	bt_uuid_t uuid, scan_interval_wind_uuid, scan_refresh_uuid;
 
-	if (!chars) {
-		DBG("Scan Refresh not supported");
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle, NULL,
+								&uuid)) {
+		error("Failed to obtain characteristic data");
 		return;
 	}
 
-	chr = chars->data;
+	bt_uuid16_create(&scan_interval_wind_uuid, SCAN_INTERVAL_WIN_UUID);
+	bt_uuid16_create(&scan_refresh_uuid, SCAN_REFRESH_UUID);
 
-	DBG("Scan Refresh handle: 0x%04x", chr->value_handle);
+	if (bt_uuid_cmp(&scan_interval_wind_uuid, &uuid) == 0)
+		handle_iwin(scan, value_handle);
+	else if (bt_uuid_cmp(&scan_refresh_uuid, &uuid) == 0)
+		handle_refresh(scan, value_handle);
+	else {
+		char uuid_str[MAX_LEN_UUID_STR];
 
-	start = chr->value_handle + 1;
-	end = scan->range.end;
-
-	if (start > end)
-		return;
-
-	scan->refresh_handle = chr->value_handle;
-
-	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
-
-	gatt_discover_desc(scan->attrib, start, end, &uuid,
-					discover_descriptor_cb, user_data);
+		bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
+		DBG("Unsupported characteristic: %s", uuid_str);
+	}
 }
 
-static void iwin_discovered_cb(uint8_t status, GSList *chars, void *user_data)
+static void foreach_scan_param_service(struct gatt_db_attribute *attr,
+								void *user_data)
 {
 	struct scan *scan = user_data;
-	struct gatt_char *chr;
 
-	if (status) {
-		error("Discover Scan Interval Window: %s",
-						att_ecode2str(status));
+	if (scan->attr) {
+		error("More than one scan params service exists for this device");
 		return;
 	}
 
-	chr = chars->data;
-	scan->iwhandle = chr->value_handle;
-
-	DBG("Scan Interval Window handle: 0x%04x", scan->iwhandle);
-
-	write_scan_params(scan->attrib, scan->iwhandle);
+	scan->attr = attr;
+	gatt_db_service_foreach_char(scan->attr, handle_characteristic, scan);
 }
 
-static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+static int scan_param_accept(struct btd_service *service)
 {
-	struct scan *scan = user_data;
-	bt_uuid_t iwin_uuid, refresh_uuid;
+	struct btd_device *device = btd_service_get_device(service);
+	struct gatt_db *db = btd_device_get_gatt_db(device);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
+	bt_uuid_t scan_parameters_uuid;
+	struct scan *scan;
+	GSList *l;
+	char addr[18];
 
-	scan->attrib = g_attrib_ref(attrib);
+	ba2str(device_get_address(device), addr);
+	DBG("Scan Parameters Client Driver profile accept (%s)", addr);
 
-	if (scan->iwhandle) {
-		write_scan_params(scan->attrib, scan->iwhandle);
-		return;
+	l = g_slist_find_custom(devices, device, cmp_device);
+	if (!l) {
+		error("Scan Parameters service not handled by profile");
+		return -1;
 	}
 
-	bt_uuid16_create(&iwin_uuid, SCAN_INTERVAL_WIN_UUID);
-	bt_uuid16_create(&refresh_uuid, SCAN_REFRESH_UUID);
+	scan = l->data;
 
-	gatt_discover_char(scan->attrib, scan->range.start, scan->range.end,
-					&iwin_uuid, iwin_discovered_cb, scan);
+	/* Clean-up any old client/db and acquire the new ones */
+	scan->attr = NULL;
+	gatt_db_unref(scan->db);
+	bt_gatt_client_unref(scan->client);
 
-	gatt_discover_char(scan->attrib, scan->range.start, scan->range.end,
-				&refresh_uuid, refresh_discovered_cb, scan);
-}
 
-static void attio_disconnected_cb(gpointer user_data)
-{
-	struct scan *scan = user_data;
+	scan->db = gatt_db_ref(db);
+	scan->client = bt_gatt_client_ref(client);
 
-	g_attrib_unref(scan->attrib);
-	scan->attrib = NULL;
+	bt_string_to_uuid(&scan_parameters_uuid, SCAN_PARAMETERS_UUID);
+	gatt_db_foreach_service(db, &scan_parameters_uuid,
+					foreach_scan_param_service, scan);
+
+	return 0;
 }
 
-static int scan_register(struct btd_service *service, struct gatt_primary *prim)
+static void scan_param_remove(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct scan *scan;
+	GSList *l;
+	char addr[18];
 
-	scan = g_new0(struct scan, 1);
-	scan->device = btd_device_ref(device);
-	scan->range = prim->range;
-	scan->attioid = btd_device_add_attio_callback(device,
-							attio_connected_cb,
-							attio_disconnected_cb,
-							scan);
-
-	btd_service_set_user_data(service, scan);
+	ba2str(device_get_address(device), addr);
+	DBG("GAP profile remove (%s)", addr);
 
-	return 0;
-}
-
-static void scan_param_remove(struct btd_service *service)
-{
-	struct scan *scan = btd_service_get_user_data(service);
+	l = g_slist_find_custom(devices, device, cmp_device);
+	if (!l) {
+		error("GAP service not handled by profile");
+		return;
+	}
 
-	if (scan->attrib != NULL && scan->refresh_cb_id > 0)
-		g_attrib_unregister(scan->attrib, scan->refresh_cb_id);
+	scan = l->data;
 
-	btd_device_remove_attio_callback(scan->device, scan->attioid);
-	btd_device_unref(scan->device);
-	g_attrib_unref(scan->attrib);
-	g_free(scan);
+	devices = g_slist_remove(devices, scan);
+	scan_free(scan);
 }
 
 static int scan_param_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
-	struct gatt_primary *prim;
+	struct scan *scan;
+	GSList *l;
+	char addr[18];
 
-	DBG("Probing Scan Parameters");
+	ba2str(device_get_address(device), addr);
+	DBG("Scan Parameters Client Driver profile probe (%s)", addr);
 
-	prim = btd_device_get_primary(device, SCAN_PARAMETERS_UUID);
-	if (!prim)
-		return -EINVAL;
+	/* Ignore, if we were probed for this device already */
+	l = g_slist_find_custom(devices, device, cmp_device);
+	if (l) {
+		error("Profile probed twice for the same device!");
+		return -1;
+	}
 
-	return scan_register(service, prim);
+	scan = g_new0(struct scan, 1);
+	if (!scan)
+		return -1;
+
+	scan->device = btd_device_ref(device);
+	devices = g_slist_append(devices, scan);
+	return 0;
 }
 
 static struct btd_profile scan_profile = {
@@ -258,6 +264,7 @@ static struct btd_profile scan_profile = {
 	.remote_uuid = SCAN_PARAMETERS_UUID,
 	.device_probe = scan_param_probe,
 	.device_remove = scan_param_remove,
+	.accept = scan_param_accept,
 };
 
 static int scan_param_init(void)
-- 
2.5.0

