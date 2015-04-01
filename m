Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 19/28] android/scpp: Merge refresh_discovered_cb with iwin_discovered_cb
Date: Wed,  1 Apr 2015 18:40:35 +0200
Message-Id: <1427906444-11769-20-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This two callbacks do the same work when used with
gatt_db_service_foreach_char, because search for characteristic with
specificis not performed, so they can be merged.
---
 android/scpp.c | 56 ++++++++++++++++++++------------------------------------
 1 file changed, 20 insertions(+), 36 deletions(-)

diff --git a/android/scpp.c b/android/scpp.c
index 37bd82e..bf0a3db 100644
--- a/android/scpp.c
+++ b/android/scpp.c
@@ -138,51 +138,36 @@ static void ccc_written_cb(uint16_t att_ecode, void *user_data)
 	DBG("Scan Refresh: notification enabled");
 }
 
-static void refresh_discovered_cb(struct gatt_db_attribute *attrib,
-								void *user_data)
+static void characteristic_cb(struct gatt_db_attribute *attrib, void *user_data)
 {
 	struct bt_scpp *scan = user_data;
-	bt_uuid_t uuid, refresh_uuid;
+	bt_uuid_t uuid, iwin_uuid, refresh_uuid;
 	uint16_t value_handle;
 
 	gatt_db_attribute_get_char_data(attrib, NULL, &value_handle, NULL,
 									&uuid);
-
+	bt_uuid16_create(&iwin_uuid, SCAN_INTERVAL_WIN_UUID);
 	bt_uuid16_create(&refresh_uuid, SCAN_REFRESH_UUID);
 
-	if (bt_uuid_cmp(&uuid, &refresh_uuid))
-		return;
+	if (!scan->iwhandle && !bt_uuid_cmp(&uuid, &iwin_uuid)) {
+		scan->iwhandle = value_handle;
 
-	scan->refresh_handle = value_handle;
+		DBG("Scan Interval Window handle: 0x%04x", scan->iwhandle);
 
-	DBG("Scan Refresh handle: 0x%04x", scan->refresh_handle);
+		write_scan_params(scan->client, scan->iwhandle, scan->interval,
+								scan->window);
+	}
 
-	scan->refresh_cb_id = bt_gatt_client_register_notify(scan->client,
-					scan->refresh_handle, ccc_written_cb,
+	if (!scan->refresh_handle && !bt_uuid_cmp(&uuid, &refresh_uuid)) {
+		uint32_t id = bt_gatt_client_register_notify(scan->client,
+					value_handle, ccc_written_cb,
 					refresh_value_cb, scan, NULL);
-}
-
-static void iwin_discovered_cb(struct gatt_db_attribute *attrib,
-								void *user_data)
-{
-	struct bt_scpp *scan = user_data;
-	bt_uuid_t uuid, iwin_uuid;
-	uint16_t value_handle;
 
-	gatt_db_attribute_get_char_data(attrib, NULL, &value_handle, NULL,
-									&uuid);
-
-	bt_uuid16_create(&iwin_uuid, SCAN_INTERVAL_WIN_UUID);
-
-	if (bt_uuid_cmp(&uuid, &iwin_uuid))
-		return;
-
-	scan->iwhandle = value_handle;
+		DBG("Scan Refresh handle: 0x%04x", value_handle);
 
-	DBG("Scan Interval Window handle: 0x%04x", scan->iwhandle);
-
-	write_scan_params(scan->client, scan->iwhandle, scan->interval,
-								scan->window);
+		scan->refresh_handle = value_handle;
+		scan->refresh_cb_id = id;
+	}
 }
 
 bool bt_scpp_attach(struct bt_scpp *scan, struct bt_gatt_client *client)
@@ -199,17 +184,16 @@ bool bt_scpp_attach(struct bt_scpp *scan, struct bt_gatt_client *client)
 	if (scan->iwhandle)
 		write_scan_params(scan->client, scan->iwhandle, scan->interval,
 								scan->window);
-	else
-		gatt_db_service_foreach_char(attrib, iwin_discovered_cb, scan);
 
 	if (scan->refresh_handle) {
 		uint32_t id = bt_gatt_client_register_notify(scan->client,
 					scan->refresh_handle, ccc_written_cb,
 					refresh_value_cb, scan, NULL);
 		scan->refresh_cb_id = id;
-	} else
-		gatt_db_service_foreach_char(attrib, refresh_discovered_cb,
-									scan);
+	}
+
+	if (!scan->iwhandle || !scan->refresh_handle)
+		gatt_db_service_foreach_char(attrib, characteristic_cb, scan);
 
 	return true;
 }
-- 
1.9.1

