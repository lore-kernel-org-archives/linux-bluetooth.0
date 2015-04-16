Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 02/13] shared/ad: Add bt_ad_foreach_manufacturer_data
Date: Thu, 16 Apr 2015 17:41:04 +0300
Message-Id: <1429195275-19635-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1429195275-19635-1-git-send-email-luiz.dentz@gmail.com>
References: <1429195275-19635-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_ad_foreach_manufacturer_data function that can be used
list entries added to manufacturer data.
---
 src/shared/ad.c | 29 ++++++++++++++++-------------
 src/shared/ad.h | 11 +++++++++++
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index d2c3f9b..d8b124d 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -39,12 +39,6 @@ struct uuid_data {
 	size_t len;
 };
 
-struct manufacturer_data {
-	uint16_t manufacturer_id;
-	uint8_t *data;
-	size_t len;
-};
-
 struct bt_ad *bt_ad_new(void)
 {
 	struct bt_ad *ad;
@@ -109,7 +103,7 @@ static bool uuid_data_match(const void *data, const void *elem)
 
 static void manuf_destroy(void *data)
 {
-	struct manufacturer_data *manuf = data;
+	struct bt_ad_manufacturer_data *manuf = data;
 
 	free(manuf->data);
 	free(manuf);
@@ -117,7 +111,7 @@ static void manuf_destroy(void *data)
 
 static bool manuf_match(const void *data, const void *elem)
 {
-	const struct manufacturer_data *manuf = elem;
+	const struct bt_ad_manufacturer_data *manuf = elem;
 	uint16_t manuf_id = PTR_TO_UINT(elem);
 
 	return manuf->manufacturer_id == manuf_id;
@@ -187,7 +181,7 @@ static size_t mfg_data_length(struct queue *manuf_data)
 	entry = queue_get_entries(manuf_data);
 
 	while (entry) {
-		struct manufacturer_data *data = entry->data;
+		struct bt_ad_manufacturer_data *data = entry->data;
 
 		length += 2 + sizeof(uint16_t) + data->len;
 
@@ -289,7 +283,7 @@ static void serialize_manuf_data(struct queue *manuf_data, uint8_t *buf,
 	const struct queue_entry *entry = queue_get_entries(manuf_data);
 
 	while (entry) {
-		struct manufacturer_data *data = entry->data;
+		struct bt_ad_manufacturer_data *data = entry->data;
 
 		buf[(*pos)++] = data->len + 2 + 1;
 
@@ -446,7 +440,7 @@ void bt_ad_clear_service_uuid(struct bt_ad *ad)
 bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id,
 							void *data, size_t len)
 {
-	struct manufacturer_data *new_data;
+	struct bt_ad_manufacturer_data *new_data;
 
 	if (!ad)
 		return false;
@@ -454,7 +448,7 @@ bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id,
 	if (len > (MAX_ADV_DATA_LEN - 2 - sizeof(uint16_t)))
 		return false;
 
-	new_data = new0(struct manufacturer_data, 1);
+	new_data = new0(struct bt_ad_manufacturer_data, 1);
 	if (!new_data)
 		return false;
 
@@ -478,9 +472,18 @@ bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id,
 	return false;
 }
 
+void bt_ad_foreach_manufacturer_data(struct bt_ad *ad, bt_ad_func_t func,
+							void *user_data)
+{
+	if (!ad)
+		return;
+
+	queue_foreach(ad->manufacturer_data, func, user_data);
+}
+
 bool bt_ad_remove_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id)
 {
-	struct manufacturer_data *data;
+	struct bt_ad_manufacturer_data *data;
 
 	if (!ad)
 		return false;
diff --git a/src/shared/ad.h b/src/shared/ad.h
index f1060a1..6e916a3 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -23,8 +23,16 @@
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
 
+typedef void (*bt_ad_func_t)(void *data, void *user_data);
+
 struct bt_ad;
 
+struct bt_ad_manufacturer_data {
+	uint16_t manufacturer_id;
+	uint8_t *data;
+	size_t len;
+};
+
 struct bt_ad *bt_ad_new(void);
 
 struct bt_ad *bt_ad_ref(struct bt_ad *ad);
@@ -42,6 +50,9 @@ void bt_ad_clear_service_uuid(struct bt_ad *ad);
 bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_data,
 						void *data, size_t len);
 
+void bt_ad_foreach_manufacturer_data(struct bt_ad *ad, bt_ad_func_t func,
+							void *user_data);
+
 bool bt_ad_remove_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id);
 
 void bt_ad_clear_manufacturer_data(struct bt_ad *ad);
-- 
2.1.0

