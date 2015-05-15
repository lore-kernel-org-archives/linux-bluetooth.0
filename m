Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/ad: Replace data if already exists
Date: Fri, 15 May 2015 16:30:20 +0300
Message-Id: <1431696620-4762-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If either manufacturer or service data already exist but the content
is different replace with the new data.
---
 src/shared/ad.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 00d138d..dfc6b9a 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -431,6 +431,14 @@ void bt_ad_clear_service_uuid(struct bt_ad *ad)
 	queue_remove_all(ad->service_uuids, NULL, NULL, free);
 }
 
+static bool manufacturer_id_data_match(const void *data, const void *user_data)
+{
+	const struct bt_ad_manufacturer_data *m = data;
+	uint16_t id = PTR_TO_UINT(user_data);
+
+	return m->manufacturer_id == id;
+}
+
 bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id,
 							void *data, size_t len)
 {
@@ -442,6 +450,17 @@ bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id,
 	if (len > (MAX_ADV_DATA_LEN - 2 - sizeof(uint16_t)))
 		return false;
 
+	new_data = queue_find(ad->manufacturer_data, manufacturer_id_data_match,
+						UINT_TO_PTR(manufacturer_id));
+	if (new_data) {
+		if (new_data->len == len && !memcmp(new_data->data, data, len))
+			return false;
+		new_data->data = realloc(new_data->data, len);
+		memcpy(new_data->data, data, len);
+		new_data->len = len;
+		return true;
+	}
+
 	new_data = new0(struct bt_ad_manufacturer_data, 1);
 	if (!new_data)
 		return false;
@@ -458,11 +477,6 @@ bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id,
 
 	new_data->len = len;
 
-	if (bt_ad_has_manufacturer_data(ad, new_data)) {
-		manuf_destroy(new_data);
-		return false;
-	}
-
 	if (queue_push_tail(ad->manufacturer_data, new_data))
 		return true;
 
@@ -556,6 +570,15 @@ void bt_ad_clear_solicit_uuid(struct bt_ad *ad)
 	queue_remove_all(ad->solicit_uuids, NULL, NULL, free);
 }
 
+
+static bool service_uuid_match(const void *data, const void *user_data)
+{
+	const struct bt_ad_service_data *s = data;
+	const bt_uuid_t *uuid = user_data;
+
+	return bt_uuid_cmp(&s->uuid, uuid);
+}
+
 bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
 								size_t len)
 {
@@ -567,6 +590,16 @@ bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
 	if (len > (MAX_ADV_DATA_LEN - 2 - (size_t)bt_uuid_len(uuid)))
 		return false;
 
+	new_data = queue_find(ad->service_uuids, service_uuid_match, uuid);
+	if (new_data) {
+		if (new_data->len == len && !memcmp(new_data->data, data, len))
+			return false;
+		new_data->data = realloc(new_data->data, len);
+		memcpy(new_data->data, data, len);
+		new_data->len = len;
+		return true;
+	}
+
 	new_data = new0(struct bt_ad_service_data, 1);
 	if (!new_data)
 		return false;
-- 
2.1.0

