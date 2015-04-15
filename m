Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/11] shared/ad: Add bt_ad_foreach_service_data
Date: Wed, 15 Apr 2015 14:44:25 +0300
Message-Id: <1429098268-9695-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1429098268-9695-1-git-send-email-luiz.dentz@gmail.com>
References: <1429098268-9695-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_ad_foreach_service_data function that can be used
list entries added as service data.
---
 src/shared/ad.c | 29 ++++++++++++++++-------------
 src/shared/ad.h |  9 +++++++++
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 90d27e3..7eb74ab 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -33,12 +33,6 @@ struct bt_ad {
 	struct queue *service_data;
 };
 
-struct uuid_data {
-	bt_uuid_t uuid;
-	uint8_t *data;
-	size_t len;
-};
-
 struct bt_ad *bt_ad_new(void)
 {
 	struct bt_ad *ad;
@@ -87,7 +81,7 @@ struct bt_ad *bt_ad_ref(struct bt_ad *ad)
 
 static void uuid_destroy(void *data)
 {
-	struct uuid_data *uuid_data = data;
+	struct bt_ad_service_data *uuid_data = data;
 
 	free(uuid_data->data);
 	free(uuid_data);
@@ -95,7 +89,7 @@ static void uuid_destroy(void *data)
 
 static bool uuid_data_match(const void *data, const void *elem)
 {
-	const struct uuid_data *uuid_data = elem;
+	const struct bt_ad_service_data *uuid_data = elem;
 	const bt_uuid_t *uuid = data;
 
 	return !bt_uuid_cmp(&uuid_data->uuid, uuid);
@@ -199,7 +193,7 @@ static size_t uuid_data_length(struct queue *uuid_data)
 	entry = queue_get_entries(uuid_data);
 
 	while (entry) {
-		struct uuid_data *data = entry->data;
+		struct bt_ad_service_data *data = entry->data;
 
 		length += 2 + bt_uuid_len(&data->uuid) + data->len;
 
@@ -307,7 +301,7 @@ static void serialize_service_data(struct queue *service_data, uint8_t *buf,
 	const struct queue_entry *entry = queue_get_entries(service_data);
 
 	while (entry) {
-		struct uuid_data *data = entry->data;
+		struct bt_ad_service_data *data = entry->data;
 		int uuid_len = bt_uuid_len(&data->uuid);
 
 		buf[(*pos)++] =  uuid_len + data->len + 1;
@@ -565,7 +559,7 @@ void bt_ad_clear_solicit_uuid(struct bt_ad *ad)
 bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
 								size_t len)
 {
-	struct uuid_data *new_data;
+	struct bt_ad_service_data *new_data;
 
 	if (!ad)
 		return false;
@@ -573,7 +567,7 @@ bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
 	if (len > (MAX_ADV_DATA_LEN - 2 - (size_t)bt_uuid_len(uuid)))
 		return false;
 
-	new_data = new0(struct uuid_data, 1);
+	new_data = new0(struct bt_ad_service_data, 1);
 	if (!new_data)
 		return false;
 
@@ -597,9 +591,18 @@ bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
 	return false;
 }
 
+void bt_ad_foreach_service_data(struct bt_ad *ad, bt_ad_func_t func,
+							void *user_data)
+{
+	if (!ad)
+		return;
+
+	queue_foreach(ad->service_data, func, user_data);
+}
+
 bool bt_ad_remove_service_data(struct bt_ad *ad, bt_uuid_t *uuid)
 {
-	struct uuid_data *data;
+	struct bt_ad_service_data *data;
 
 	if (!ad)
 		return false;
diff --git a/src/shared/ad.h b/src/shared/ad.h
index b7d9ade..c31a040 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -33,6 +33,12 @@ struct bt_ad_manufacturer_data {
 	size_t len;
 };
 
+struct bt_ad_service_data {
+	bt_uuid_t uuid;
+	uint8_t *data;
+	size_t len;
+};
+
 struct bt_ad *bt_ad_new(void);
 
 struct bt_ad *bt_ad_ref(struct bt_ad *ad);
@@ -69,6 +75,9 @@ void bt_ad_clear_solicit_uuid(struct bt_ad *ad);
 bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
 								size_t len);
 
+void bt_ad_foreach_service_data(struct bt_ad *ad, bt_ad_func_t func,
+							void *user_data);
+
 bool bt_ad_remove_service_data(struct bt_ad *ad, bt_uuid_t *uuid);
 
 void bt_ad_clear_service_data(struct bt_ad *ad);
-- 
2.1.0

