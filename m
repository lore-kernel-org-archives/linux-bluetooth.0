Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 01/15] android/gatt: Change name of gatt_primary in service structure
Date: Tue, 8 Apr 2014 11:22:18 +0200
Message-ID: <1396948952-2035-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 4f0a656..d7228a3 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -84,7 +84,7 @@ struct characteristic {
 
 struct service {
 	struct element_id id;
-	struct gatt_primary primary;
+	struct gatt_primary prim;
 
 	struct queue *chars;
 };
@@ -525,7 +525,7 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 		}
 
 		/* Put primary service to our local list */
-		memcpy(&p->primary, prim, sizeof(p->primary));
+		memcpy(&p->prim, prim, sizeof(p->prim));
 		if (!queue_push_tail(dev->services, p)) {
 			error("gatt: Cannot push primary service to the list");
 			free(p);
@@ -1137,7 +1137,7 @@ static bool match_service_by_uuid(const void *data, const void *user_data)
 	const bt_uuid_t *uuid = user_data;
 	bt_uuid_t service_uuid;
 
-	if (bt_string_to_uuid(&service_uuid, service->primary.uuid) < 0)
+	if (bt_string_to_uuid(&service_uuid, service->prim.uuid) < 0)
 		return false;
 
 	return !bt_uuid_cmp(uuid, &service_uuid);
@@ -1171,7 +1171,7 @@ static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 		return;
 	}
 
-	bt_string_to_uuid(&uuid, service->primary.uuid);
+	bt_string_to_uuid(&uuid, service->prim.uuid);
 
 	/* TODO store included services in device->services list */
 	for (; included; included = included->next) {
@@ -1249,8 +1249,8 @@ static void handle_client_get_included_service(const void *buf, uint16_t len)
 	data->service = service;
 	data->device = device;
 
-	gatt_find_included(device->attrib, service->primary.range.start,
-				service->primary.range.end, get_included_cb,
+	gatt_find_included(device->attrib, service->prim.range.start,
+				service->prim.range.end, get_included_cb,
 				data);
 
 	status = HAL_STATUS_SUCCESS;
@@ -1408,8 +1408,8 @@ static void handle_client_get_characteristic(const void *buf, uint16_t len)
 		cb_data->service = srvc;
 		cb_data->conn_id = dev->conn_id;
 
-		if (!gatt_discover_char(dev->attrib, srvc->primary.range.start,
-					srvc->primary.range.end, NULL,
+		if (!gatt_discover_char(dev->attrib, srvc->prim.range.start,
+					srvc->prim.range.end, NULL,
 					discover_char_cb, cb_data)) {
 			free(cb_data);
 
@@ -1547,7 +1547,7 @@ static bool build_descr_cache(int32_t conn_id, struct gatt_device *dev,
 
 	/* Clip range to given characteristic */
 	start = ch->ch.value_handle + 1;
-	end = srvc->primary.range.end;
+	end = srvc->prim.range.end;
 
 	/* Use next characteristic start as end. If there is none -
 	 * service end is valid end.
-- 
1.8.4

