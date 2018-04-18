Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/7] shared/ad: Add support for arbritary type
Date: Wed, 18 Apr 2018 14:04:56 +0300
Message-Id: <20180418110502.13099-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds APIs to include data of any type.
---
 src/shared/ad.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/ad.h |  16 ++++++
 2 files changed, 172 insertions(+)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 255794dc4..c80caf869 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -37,6 +37,7 @@ struct bt_ad {
 	struct queue *manufacturer_data;
 	struct queue *solicit_uuids;
 	struct queue *service_data;
+	struct queue *data;
 };
 
 struct bt_ad *bt_ad_new(void)
@@ -48,6 +49,7 @@ struct bt_ad *bt_ad_new(void)
 	ad->manufacturer_data = queue_new();
 	ad->solicit_uuids = queue_new();
 	ad->service_data = queue_new();
+	ad->data = queue_new();
 	ad->appearance = UINT16_MAX;
 
 	return bt_ad_ref(ad);
@@ -94,6 +96,14 @@ static bool manuf_match(const void *data, const void *elem)
 	return manuf->manufacturer_id == manuf_id;
 }
 
+static void data_destroy(void *data)
+{
+	struct bt_ad_data *ad = data;
+
+	free(ad->data);
+	free(ad);
+}
+
 void bt_ad_unref(struct bt_ad *ad)
 {
 	if (!ad)
@@ -110,6 +120,8 @@ void bt_ad_unref(struct bt_ad *ad)
 
 	queue_destroy(ad->service_data, uuid_destroy);
 
+	queue_destroy(ad->data, data_destroy);
+
 	free(ad->name);
 
 	free(ad);
@@ -203,6 +215,24 @@ static size_t name_length(const char *name, size_t *pos)
 	return len;
 }
 
+static size_t data_length(struct queue *queue)
+{
+	size_t length = 0;
+	const struct queue_entry *entry;
+
+	entry = queue_get_entries(queue);
+
+	while (entry) {
+		struct bt_ad_data *data = entry->data;
+
+		length += 1 + 1 + data->len;
+
+		entry = entry->next;
+	}
+
+	return length;
+}
+
 static size_t calculate_length(struct bt_ad *ad)
 {
 	size_t length = 0;
@@ -219,6 +249,8 @@ static size_t calculate_length(struct bt_ad *ad)
 
 	length += ad->appearance != UINT16_MAX ? 4 : 0;
 
+	length += data_length(ad->data);
+
 	return length;
 }
 
@@ -370,6 +402,24 @@ static void serialize_appearance(uint16_t value, uint8_t *buf, uint8_t *pos)
 	*pos += 2;
 }
 
+static void serialize_data(struct queue *queue, uint8_t *buf, uint8_t *pos)
+{
+	const struct queue_entry *entry = queue_get_entries(queue);
+
+	while (entry) {
+		struct bt_ad_data *data = entry->data;
+
+		buf[(*pos)++] = data->len + 1;
+		buf[(*pos)++] = data->type;
+
+		memcpy(buf + *pos, data->data, data->len);
+
+		*pos += data->len;
+
+		entry = entry->next;
+	}
+}
+
 uint8_t *bt_ad_generate(struct bt_ad *ad, size_t *length)
 {
 	uint8_t *adv_data;
@@ -399,6 +449,8 @@ uint8_t *bt_ad_generate(struct bt_ad *ad, size_t *length)
 
 	serialize_appearance(ad->appearance, adv_data, &pos);
 
+	serialize_data(ad->data, adv_data, &pos);
+
 	return adv_data;
 }
 
@@ -756,3 +808,107 @@ void bt_ad_clear_appearance(struct bt_ad *ad)
 
 	ad->appearance = UINT16_MAX;
 }
+
+static bool data_type_match(const void *data, const void *user_data)
+{
+	const struct bt_ad_data *a = data;
+	const uint8_t type = PTR_TO_UINT(user_data);
+
+	return a->type == type;
+}
+
+bool bt_ad_add_data(struct bt_ad *ad, uint8_t type, void *data, size_t len)
+{
+	struct bt_ad_data *new_data;
+
+	if (!ad)
+		return false;
+
+	if (len > (MAX_ADV_DATA_LEN - 2))
+		return false;
+
+	new_data = queue_find(ad->data, data_type_match, UINT_TO_PTR(type));
+	if (new_data) {
+		if (new_data->len == len && !memcmp(new_data->data, data, len))
+			return false;
+		new_data->data = realloc(new_data->data, len);
+		memcpy(new_data->data, data, len);
+		new_data->len = len;
+		return true;
+	}
+
+	new_data = new0(struct bt_ad_data, 1);
+	new_data->type = type;
+	new_data->data = malloc(len);
+	if (!new_data->data) {
+		free(new_data);
+		return false;
+	}
+
+	memcpy(new_data->data, data, len);
+	new_data->len = len;
+
+	if (queue_push_tail(ad->data, new_data))
+		return true;
+
+	data_destroy(new_data);
+
+	return false;
+}
+
+static bool data_match(const void *data, const void *user_data)
+{
+	const struct bt_ad_data *d1 = data;
+	const struct bt_ad_data *d2 = user_data;
+
+	if (d1->type != d2->type)
+		return false;
+
+	if (d1->len != d2->len)
+		return false;
+
+	return !memcmp(d1->data, d2->data, d1->len);
+}
+
+bool bt_ad_has_data(struct bt_ad *ad, const struct bt_ad_data *data)
+{
+	if (!ad)
+		return false;
+
+	if (!data)
+		return !queue_isempty(ad->data);
+
+	return queue_find(ad->data, data_match, data);
+}
+
+void bt_ad_foreach_data(struct bt_ad *ad, bt_ad_func_t func, void *user_data)
+{
+	if (!ad)
+		return;
+
+	queue_foreach(ad->data, func, user_data);
+}
+
+bool bt_ad_remove_data(struct bt_ad *ad, uint8_t type)
+{
+	struct bt_ad_data *data;
+
+	if (!ad)
+		return false;
+
+	data = queue_remove_if(ad->data, data_type_match, UINT_TO_PTR(type));
+	if (!data)
+		return false;
+
+	data_destroy(data);
+
+	return true;
+}
+
+void bt_ad_clear_data(struct bt_ad *ad)
+{
+	if (!ad)
+		return;
+
+	queue_remove_all(ad->data, NULL, NULL, data_destroy);
+}
diff --git a/src/shared/ad.h b/src/shared/ad.h
index f0e3b8127..2ce7e3fb2 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -39,6 +39,12 @@ struct bt_ad_manufacturer_data {
 
 struct bt_ad_service_data {
 	bt_uuid_t uuid;
+	size_t len;
+	void *data;
+};
+
+struct bt_ad_data {
+	uint8_t type;
 	uint8_t *data;
 	size_t len;
 };
@@ -96,3 +102,13 @@ void bt_ad_clear_name(struct bt_ad *ad);
 bool bt_ad_add_appearance(struct bt_ad *ad, uint16_t appearance);
 
 void bt_ad_clear_appearance(struct bt_ad *ad);
+
+bool bt_ad_add_data(struct bt_ad *ad, uint8_t type, void *data, size_t len);
+
+bool bt_ad_has_data(struct bt_ad *ad, const struct bt_ad_data *data);
+
+void bt_ad_foreach_data(struct bt_ad *ad, bt_ad_func_t func, void *user_data);
+
+bool bt_ad_remove_data(struct bt_ad *ad, uint8_t type);
+
+void bt_ad_clear_data(struct bt_ad *ad);
-- 
2.14.3

