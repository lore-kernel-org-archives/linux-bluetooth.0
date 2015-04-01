Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@gmail.com>
Subject: [PATCH 18/28] android/scpp: Introduce bt_gatt_client
Date: Wed,  1 Apr 2015 18:40:34 +0200
Message-Id: <1427906444-11769-19-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mariusz Skamra <mariusz.skamra@gmail.com>

This patch replaces gattrib with bt_gatt_client and strips glib dependencies.
---
 android/hog.c  |  18 ++----
 android/scpp.c | 196 +++++++++++++++++++++------------------------------------
 android/scpp.h |   4 +-
 3 files changed, 80 insertions(+), 138 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 71f8c50..78c1b26 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -954,16 +954,16 @@ static void find_included_cb(struct gatt_db_attribute *attrib, void *user_data)
 	DBG("included: handle %x", start_handle);
 }
 
-static void hog_attach_scpp(struct bt_hog *hog, struct gatt_primary *primary)
+static void hog_attach_scpp(struct bt_hog *hog, uint16_t service_handle)
 {
 	if (hog->scpp) {
-		bt_scpp_attach(hog->scpp, hog->attrib);
+		bt_scpp_attach(hog->scpp, hog->client);
 		return;
 	}
 
-	hog->scpp = bt_scpp_new(primary);
+	hog->scpp = bt_scpp_new(service_handle);
 	if (hog->scpp)
-		bt_scpp_attach(hog->scpp, hog->attrib);
+		bt_scpp_attach(hog->scpp, hog->client);
 }
 
 static void dis_notify(uint8_t source, uint16_t vendor, uint16_t product,
@@ -1047,11 +1047,6 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 	for (l = services; l; l = l->next) {
 		primary = l->data;
 
-		if (strcmp(primary->uuid, SCAN_PARAMETERS_UUID) == 0) {
-			hog_attach_scpp(hog, primary);
-			continue;
-		}
-
 		if (strcmp(primary->uuid, BATTERY_UUID) == 0) {
 			hog_attach_bas(hog, primary);
 		}
@@ -1074,8 +1069,7 @@ static void service_cb(struct gatt_db_attribute *attrib, void *user_data)
 	if (!bt_uuid_strcmp(uuid, HOG_UUID))
 		hog_attach_hog(hog, service_handle);
 	else if (!bt_uuid_strcmp(uuid, SCAN_PARAMETERS_UUID))
-		/* TODO */
-		return;
+		hog_attach_scpp(hog, service_handle);
 	else if (!bt_uuid_strcmp(uuid, DEVICE_INFORMATION_UUID))
 		hog_attach_dis(hog, service_handle);
 	else if (!bt_uuid_strcmp(uuid, BATTERY_UUID))
@@ -1101,7 +1095,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
 	}
 
 	if (hog->scpp)
-		bt_scpp_attach(hog->scpp, gatt);
+		bt_scpp_attach(hog->scpp, hog->client);
 
 	if (hog->dis)
 		bt_dis_attach(hog->dis, hog->client);
diff --git a/android/scpp.c b/android/scpp.c
index a28fbb6..37bd82e 100644
--- a/android/scpp.c
+++ b/android/scpp.c
@@ -26,23 +26,16 @@
 #include <config.h>
 #endif
 
-#include <stdbool.h>
-#include <errno.h>
-
-#include <glib.h>
-
 #include "src/log.h"
 
 #include "lib/bluetooth.h"
-#include "lib/sdp.h"
 #include "lib/uuid.h"
 
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
-
-#include "attrib/att.h"
-#include "attrib/gattrib.h"
-#include "attrib/gatt.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
 
 #include "android/scpp.h"
 
@@ -55,36 +48,37 @@
 
 struct bt_scpp {
 	int ref_count;
-	GAttrib *attrib;
-	struct gatt_primary *primary;
+	uint16_t service_handle;
 	uint16_t interval;
 	uint16_t window;
 	uint16_t iwhandle;
 	uint16_t refresh_handle;
-	guint refresh_cb_id;
+	uint32_t refresh_cb_id;
+	struct bt_gatt_client *client;
+	struct gatt_db *db;
 };
 
 static void scpp_free(struct bt_scpp *scan)
 {
 	bt_scpp_detach(scan);
 
-	g_free(scan->primary);
-	g_free(scan);
+	free(scan);
 }
 
-struct bt_scpp *bt_scpp_new(void *primary)
+struct bt_scpp *bt_scpp_new(uint16_t service_handle)
 {
 	struct bt_scpp *scan;
 
-	scan = g_try_new0(struct bt_scpp, 1);
+	if (!service_handle)
+		return NULL;
+
+	scan = new0(struct bt_scpp, 1);
 	if (!scan)
 		return NULL;
 
 	scan->interval = SCAN_INTERVAL;
 	scan->window = SCAN_WINDOW;
-
-	if (primary)
-		scan->primary = g_memdup(primary, sizeof(*scan->primary));
+	scan->service_handle = service_handle;
 
 	return bt_scpp_ref(scan);
 }
@@ -110,7 +104,7 @@ void bt_scpp_unref(struct bt_scpp *scan)
 	scpp_free(scan);
 }
 
-static void write_scan_params(GAttrib *attrib, uint16_t handle,
+static void write_scan_params(struct bt_gatt_client *client, uint16_t handle,
 					uint16_t interval, uint16_t window)
 {
 	uint8_t value[4];
@@ -118,168 +112,122 @@ static void write_scan_params(GAttrib *attrib, uint16_t handle,
 	put_le16(interval, &value[0]);
 	put_le16(window, &value[2]);
 
-	gatt_write_cmd(attrib, handle, value, sizeof(value), NULL, NULL);
+	bt_gatt_client_write_without_response(client, handle, NULL, value,
+								sizeof(value));
 }
 
-static void refresh_value_cb(const uint8_t *pdu, uint16_t len,
-						gpointer user_data)
+static void refresh_value_cb(uint16_t value_handle, const uint8_t *value,
+					uint16_t length, void *user_data)
 {
 	struct bt_scpp *scan = user_data;
 
-	DBG("Server requires refresh: %d", pdu[3]);
+	DBG("Server requires refresh: %d", value[0]);
 
-	if (pdu[3] == SERVER_REQUIRES_REFRESH)
-		write_scan_params(scan->attrib, scan->iwhandle, scan->interval,
+	if (value[0] == SERVER_REQUIRES_REFRESH)
+		write_scan_params(scan->client, scan->iwhandle, scan->interval,
 								scan->window);
 }
 
-static void ccc_written_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void ccc_written_cb(uint16_t att_ecode, void *user_data)
 {
-	struct bt_scpp *scan = user_data;
-
-	if (status != 0) {
-		error("Write Scan Refresh CCC failed: %s",
-						att_ecode2str(status));
+	if (att_ecode != 0) {
+		error("Write Scan Refresh CCC failed: att_ecode %d", att_ecode);
 		return;
 	}
 
 	DBG("Scan Refresh: notification enabled");
-
-	scan->refresh_cb_id = g_attrib_register(scan->attrib,
-				ATT_OP_HANDLE_NOTIFY, scan->refresh_handle,
-				refresh_value_cb, scan, NULL);
 }
 
-static void write_ccc(struct bt_scpp *scan, GAttrib *attrib, uint16_t handle,
+static void refresh_discovered_cb(struct gatt_db_attribute *attrib,
 								void *user_data)
 {
-	uint8_t value[2];
-
-	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
+	struct bt_scpp *scan = user_data;
+	bt_uuid_t uuid, refresh_uuid;
+	uint16_t value_handle;
 
-	gatt_write_char(attrib, handle, value, sizeof(value), ccc_written_cb,
-								user_data);
-}
+	gatt_db_attribute_get_char_data(attrib, NULL, &value_handle, NULL,
+									&uuid);
 
-static void discover_descriptor_cb(uint8_t status, GSList *descs,
-								void *user_data)
-{
-	struct bt_scpp *scan = user_data;
-	struct gatt_desc *desc;
+	bt_uuid16_create(&refresh_uuid, SCAN_REFRESH_UUID);
 
-	if (status != 0) {
-		error("Discover descriptors failed: %s", att_ecode2str(status));
+	if (bt_uuid_cmp(&uuid, &refresh_uuid))
 		return;
-	}
 
-	/* There will be only one descriptor on list and it will be CCC */
-	desc = descs->data;
+	scan->refresh_handle = value_handle;
+
+	DBG("Scan Refresh handle: 0x%04x", scan->refresh_handle);
 
-	write_ccc(scan, scan->attrib, desc->handle, scan);
+	scan->refresh_cb_id = bt_gatt_client_register_notify(scan->client,
+					scan->refresh_handle, ccc_written_cb,
+					refresh_value_cb, scan, NULL);
 }
 
-static void refresh_discovered_cb(uint8_t status, GSList *chars,
+static void iwin_discovered_cb(struct gatt_db_attribute *attrib,
 								void *user_data)
 {
 	struct bt_scpp *scan = user_data;
-	struct gatt_char *chr;
-	uint16_t start, end;
-	bt_uuid_t uuid;
+	bt_uuid_t uuid, iwin_uuid;
+	uint16_t value_handle;
 
-	if (status) {
-		error("Scan Refresh %s", att_ecode2str(status));
-		return;
-	}
+	gatt_db_attribute_get_char_data(attrib, NULL, &value_handle, NULL,
+									&uuid);
 
-	if (!chars) {
-		DBG("Scan Refresh not supported");
-		return;
-	}
-
-	chr = chars->data;
-
-	DBG("Scan Refresh handle: 0x%04x", chr->value_handle);
-
-	start = chr->value_handle + 1;
-	end = scan->primary->range.end;
-
-	if (start > end)
-		return;
-
-	scan->refresh_handle = chr->value_handle;
-
-	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	bt_uuid16_create(&iwin_uuid, SCAN_INTERVAL_WIN_UUID);
 
-	gatt_discover_desc(scan->attrib, start, end, &uuid,
-					discover_descriptor_cb, user_data);
-}
-
-static void iwin_discovered_cb(uint8_t status, GSList *chars, void *user_data)
-{
-	struct bt_scpp *scan = user_data;
-	struct gatt_char *chr;
-
-	if (status) {
-		error("Discover Scan Interval Window: %s",
-						att_ecode2str(status));
+	if (bt_uuid_cmp(&uuid, &iwin_uuid))
 		return;
-	}
 
-	chr = chars->data;
-	scan->iwhandle = chr->value_handle;
+	scan->iwhandle = value_handle;
 
 	DBG("Scan Interval Window handle: 0x%04x", scan->iwhandle);
 
-	write_scan_params(scan->attrib, scan->iwhandle, scan->interval,
+	write_scan_params(scan->client, scan->iwhandle, scan->interval,
 								scan->window);
 }
 
-bool bt_scpp_attach(struct bt_scpp *scan, void *attrib)
+bool bt_scpp_attach(struct bt_scpp *scan, struct bt_gatt_client *client)
 {
-	bt_uuid_t iwin_uuid, refresh_uuid;
+	struct gatt_db_attribute *attrib;
 
-	if (!scan || scan->attrib || !scan->primary)
+	if (!scan || scan->client || !scan->service_handle)
 		return false;
 
-	scan->attrib = g_attrib_ref(attrib);
+	scan->client = bt_gatt_client_ref(client);
+	scan->db = bt_gatt_client_get_db(client);
+	attrib = gatt_db_get_attribute(scan->db, scan->service_handle);
 
 	if (scan->iwhandle)
-		write_scan_params(scan->attrib, scan->iwhandle, scan->interval,
+		write_scan_params(scan->client, scan->iwhandle, scan->interval,
 								scan->window);
-	else {
-		bt_uuid16_create(&iwin_uuid, SCAN_INTERVAL_WIN_UUID);
-		gatt_discover_char(scan->attrib, scan->primary->range.start,
-					scan->primary->range.end, &iwin_uuid,
-					iwin_discovered_cb, scan);
-	}
-
-	if (scan->refresh_handle)
-		scan->refresh_cb_id = g_attrib_register(scan->attrib,
-				ATT_OP_HANDLE_NOTIFY, scan->refresh_handle,
-				refresh_value_cb, scan, NULL);
-	else {
-		bt_uuid16_create(&refresh_uuid, SCAN_REFRESH_UUID);
-		gatt_discover_char(scan->attrib, scan->primary->range.start,
-					scan->primary->range.end, &refresh_uuid,
-					refresh_discovered_cb, scan);
-	}
+	else
+		gatt_db_service_foreach_char(attrib, iwin_discovered_cb, scan);
+
+	if (scan->refresh_handle) {
+		uint32_t id = bt_gatt_client_register_notify(scan->client,
+					scan->refresh_handle, ccc_written_cb,
+					refresh_value_cb, scan, NULL);
+		scan->refresh_cb_id = id;
+	} else
+		gatt_db_service_foreach_char(attrib, refresh_discovered_cb,
+									scan);
 
 	return true;
 }
 
 void bt_scpp_detach(struct bt_scpp *scan)
 {
-	if (!scan || !scan->attrib)
+	if (!scan || !scan->client)
 		return;
 
 	if (scan->refresh_cb_id > 0) {
-		g_attrib_unregister(scan->attrib, scan->refresh_cb_id);
+		bt_gatt_client_unregister_notify(scan->client,
+							scan->refresh_cb_id);
 		scan->refresh_cb_id = 0;
 	}
 
-	g_attrib_unref(scan->attrib);
-	scan->attrib = NULL;
+	gatt_db_unref(scan->db);
+	bt_gatt_client_unref(scan->client);
+	scan->client = NULL;
 }
 
 bool bt_scpp_set_interval(struct bt_scpp *scan, uint16_t value)
diff --git a/android/scpp.h b/android/scpp.h
index 048fb9f..65e54c1 100644
--- a/android/scpp.h
+++ b/android/scpp.h
@@ -23,12 +23,12 @@
 
 struct bt_scpp;
 
-struct bt_scpp *bt_scpp_new(void *primary);
+struct bt_scpp *bt_scpp_new(uint16_t service_handle);
 
 struct bt_scpp *bt_scpp_ref(struct bt_scpp *scan);
 void bt_scpp_unref(struct bt_scpp *scan);
 
-bool bt_scpp_attach(struct bt_scpp *scan, void *gatt);
+bool bt_scpp_attach(struct bt_scpp *scan, struct bt_gatt_client *client);
 void bt_scpp_detach(struct bt_scpp *scan);
 
 bool bt_scpp_set_interval(struct bt_scpp *scan, uint16_t value);
-- 
1.9.1

