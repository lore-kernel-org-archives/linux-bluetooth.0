Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 1/3] android/gatt: Move element_id creation helpers up
Date: Tue,  1 Apr 2014 10:03:22 +0200
Message-Id: <1396339404-14418-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This helpers should be in one place, in file's upper part.
---
 android/gatt.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 61746b1..39195f0 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -135,6 +135,20 @@ static void uuid2android(const bt_uuid_t *src, uint8_t *uuid)
 		uuid[15 - i] = src->value.u128.data[i];
 }
 
+static void hal_srvc_id_to_element_id(const struct hal_gatt_srvc_id *from,
+							struct element_id *to)
+{
+	to->instance = from->inst_id;
+	android2uuid(from->uuid, &to->uuid);
+}
+
+static void hal_gatt_id_to_element_id(const struct hal_gatt_gatt_id *from,
+							struct element_id *to)
+{
+	to->instance = from->inst_id;
+	android2uuid(from->uuid, &to->uuid);
+}
+
 static void destroy_service(void *data)
 {
 	struct service *srvc = data;
@@ -256,13 +270,6 @@ static bool match_char_by_element_id(const void *data, const void *user_data)
 	return false;
 }
 
-static void hal_gatt_id_to_element_id(const struct hal_gatt_gatt_id *from,
-							struct element_id *to)
-{
-	to->instance = from->inst_id;
-	android2uuid(from->uuid, &to->uuid);
-}
-
 static void destroy_notification(void *data)
 {
 	struct notification_data *notification = data;
@@ -1268,13 +1275,6 @@ static void discover_char_cb(uint8_t status, GSList *characteristics,
 	free(data);
 }
 
-static void hal_srvc_id_to_element_id(const struct hal_gatt_srvc_id *from,
-							struct element_id *to)
-{
-	to->instance = from->inst_id;
-	android2uuid(from->uuid, &to->uuid);
-}
-
 static bool find_service(int32_t conn_id, struct element_id *service_id,
 				struct gatt_device **dev, struct service **srvc)
 {
-- 
1.9.0

