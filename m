Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 09/15] android/gatt: Prepare to cache included services
Date: Tue, 8 Apr 2014 11:22:26 +0200
Message-ID: <1396948952-2035-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch struct service is enhanced to handle caching include
services
---
 android/gatt.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index b95962d..f88c72a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -85,6 +85,8 @@ struct characteristic {
 struct service {
 	struct element_id id;
 	struct gatt_primary prim;
+	struct gatt_included incl;
+
 	bool primary;
 
 	struct queue *chars;
@@ -1194,8 +1196,13 @@ static bool match_service_by_uuid(const void *data, const void *user_data)
 	const struct service *service = data;
 	const bt_uuid_t *uuid = user_data;
 	bt_uuid_t service_uuid;
+	int res;
 
-	if (bt_string_to_uuid(&service_uuid, service->prim.uuid) < 0)
+	if (service->primary)
+		res = bt_string_to_uuid(&service_uuid, service->prim.uuid);
+	else
+		res = bt_string_to_uuid(&service_uuid, service->incl.uuid);
+	if (res < 0)
 		return false;
 
 	return !bt_uuid_cmp(uuid, &service_uuid);
@@ -1461,6 +1468,8 @@ static void handle_client_get_characteristic(const void *buf, uint16_t len)
 
 	/* Discover all characteristics for services if not cached yet */
 	if (queue_isempty(srvc->chars)) {
+		struct att_range range;
+
 		struct discover_char_data *cb_data =
 					new0(struct discover_char_data, 1);
 
@@ -1473,9 +1482,11 @@ static void handle_client_get_characteristic(const void *buf, uint16_t len)
 		cb_data->service = srvc;
 		cb_data->conn_id = dev->conn_id;
 
-		if (!gatt_discover_char(dev->attrib, srvc->prim.range.start,
-					srvc->prim.range.end, NULL,
-					discover_char_cb, cb_data)) {
+		range = srvc->primary ? srvc->prim.range: srvc->incl.range;
+
+		if (!gatt_discover_char(dev->attrib, range.start, range.end,
+							NULL, discover_char_cb,
+							cb_data)) {
 			free(cb_data);
 
 			status = HAL_STATUS_FAILED;
-- 
1.8.4

