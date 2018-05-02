Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/9] shared/ad: Add support for arbritary type
Date: Wed,  2 May 2018 12:24:34 +0300
Message-Id: <20180502092442.10567-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds APIs to include data of arbritary type as long as it is not
of a type which blacklisted due to being handled already or it is
considered to safe to be set by an application.
---
 src/shared/ad.c | 231 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 src/shared/ad.h |  60 +++++++++++++++
 2 files changed, 278 insertions(+), 13 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 255794dc4..f0e62cef1 100644
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
 
@@ -258,21 +290,21 @@ static void serialize_uuids(struct queue *uuids, uint8_t uuid_type,
 static void serialize_service_uuids(struct queue *uuids, uint8_t *buf,
 								uint8_t *pos)
 {
-	serialize_uuids(uuids, BT_UUID16, EIR_UUID16_ALL, buf, pos);
+	serialize_uuids(uuids, BT_UUID16, BT_AD_UUID16_ALL, buf, pos);
 
-	serialize_uuids(uuids, BT_UUID32, EIR_UUID32_ALL, buf, pos);
+	serialize_uuids(uuids, BT_UUID32, BT_AD_UUID32_ALL, buf, pos);
 
-	serialize_uuids(uuids, BT_UUID128, EIR_UUID128_ALL, buf, pos);
+	serialize_uuids(uuids, BT_UUID128, BT_AD_UUID128_ALL, buf, pos);
 }
 
 static void serialize_solicit_uuids(struct queue *uuids, uint8_t *buf,
 								uint8_t *pos)
 {
-	serialize_uuids(uuids, BT_UUID16, EIR_SOLICIT16, buf, pos);
+	serialize_uuids(uuids, BT_UUID16, BT_AD_SOLICIT16, buf, pos);
 
-	serialize_uuids(uuids, BT_UUID32, EIR_SOLICIT32, buf, pos);
+	serialize_uuids(uuids, BT_UUID32, BT_AD_SOLICIT32, buf, pos);
 
-	serialize_uuids(uuids, BT_UUID128, EIR_SOLICIT128, buf, pos);
+	serialize_uuids(uuids, BT_UUID128, BT_AD_SOLICIT128, buf, pos);
 }
 
 static void serialize_manuf_data(struct queue *manuf_data, uint8_t *buf,
@@ -285,7 +317,7 @@ static void serialize_manuf_data(struct queue *manuf_data, uint8_t *buf,
 
 		buf[(*pos)++] = data->len + 2 + 1;
 
-		buf[(*pos)++] = EIR_MANUFACTURER_DATA;
+		buf[(*pos)++] = BT_AD_MANUFACTURER_DATA;
 
 		bt_put_le16(data->manufacturer_id, buf + (*pos));
 
@@ -312,13 +344,13 @@ static void serialize_service_data(struct queue *service_data, uint8_t *buf,
 
 		switch (uuid_len) {
 		case 2:
-			buf[(*pos)++] = EIR_SVC_DATA16;
+			buf[(*pos)++] = BT_AD_SERVICE_DATA16;
 			break;
 		case 4:
-			buf[(*pos)++] = EIR_SVC_DATA32;
+			buf[(*pos)++] = BT_AD_SERVICE_DATA32;
 			break;
 		case 16:
-			buf[(*pos)++] = EIR_SVC_DATA128;
+			buf[(*pos)++] = BT_AD_SERVICE_DATA128;
 			break;
 		}
 
@@ -340,14 +372,14 @@ static void serialize_service_data(struct queue *service_data, uint8_t *buf,
 static void serialize_name(const char *name, uint8_t *buf, uint8_t *pos)
 {
 	int len;
-	uint8_t type = EIR_NAME_COMPLETE;
+	uint8_t type = BT_AD_NAME_COMPLETE;
 
 	if (!name)
 		return;
 
 	len = strlen(name);
 	if (len > MAX_ADV_DATA_LEN - (*pos + 2)) {
-		type = EIR_NAME_SHORT;
+		type = BT_AD_NAME_SHORT;
 		len = MAX_ADV_DATA_LEN - (*pos + 2);
 	}
 
@@ -364,12 +396,30 @@ static void serialize_appearance(uint16_t value, uint8_t *buf, uint8_t *pos)
 		return;
 
 	buf[(*pos)++] = sizeof(value) + 1;
-	buf[(*pos)++] = EIR_GAP_APPEARANCE;
+	buf[(*pos)++] = BT_AD_GAP_APPEARANCE;
 
 	bt_put_le16(value, buf + (*pos));
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
 
@@ -756,3 +808,156 @@ void bt_ad_clear_appearance(struct bt_ad *ad)
 
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
+static uint8_t type_blacklist[] = {
+	BT_AD_FLAGS,
+	BT_AD_UUID16_SOME,
+	BT_AD_UUID16_ALL,
+	BT_AD_UUID32_SOME,
+	BT_AD_UUID32_ALL,
+	BT_AD_UUID128_SOME,
+	BT_AD_UUID128_ALL,
+	BT_AD_NAME_SHORT,
+	BT_AD_NAME_COMPLETE,
+	BT_AD_TX_POWER,
+	BT_AD_CLASS_OF_DEV,
+	BT_AD_SSP_HASH,
+	BT_AD_SSP_RANDOMIZER,
+	BT_AD_DEVICE_ID,
+	BT_AD_SMP_TK,
+	BT_AD_SMP_OOB_FLAGS,
+	BT_AD_SLAVE_CONN_INTERVAL,
+	BT_AD_SOLICIT16,
+	BT_AD_SOLICIT128,
+	BT_AD_SERVICE_DATA16,
+	BT_AD_PUBLIC_ADDRESS,
+	BT_AD_RANDOM_ADDRESS,
+	BT_AD_GAP_APPEARANCE,
+	BT_AD_ADVERTISING_INTERVAL,
+	BT_AD_LE_DEVICE_ADDRESS,
+	BT_AD_LE_ROLE,
+	BT_AD_SSP_HASH_P256,
+	BT_AD_SSP_RANDOMIZER_P256,
+	BT_AD_SOLICIT32,
+	BT_AD_SERVICE_DATA32,
+	BT_AD_SERVICE_DATA128,
+	BT_AD_LE_SC_CONFIRM_VALUE,
+	BT_AD_LE_SC_RANDOM_VALUE,
+	BT_AD_LE_SUPPORTED_FEATURES,
+	BT_AD_CHANNEL_MAP_UPDATE_IND,
+	BT_AD_MESH_PROV,
+	BT_AD_MESH_DATA,
+	BT_AD_MESH_BEACON,
+	BT_AD_3D_INFO_DATA,
+	BT_AD_MANUFACTURER_DATA,
+};
+
+bool bt_ad_add_data(struct bt_ad *ad, uint8_t type, void *data, size_t len)
+{
+	struct bt_ad_data *new_data;
+	size_t i;
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
+	for (i = 0; i < sizeof(type_blacklist); i++) {
+		if (type == type_blacklist[i])
+			return false;
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
index f0e3b8127..8d705323b 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -27,6 +27,50 @@
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
 
+#define BT_AD_FLAGS			0x01
+#define BT_AD_UUID16_SOME		0x02
+#define BT_AD_UUID16_ALL		0x03
+#define BT_AD_UUID32_SOME		0x04
+#define BT_AD_UUID32_ALL		0x05
+#define BT_AD_UUID128_SOME		0x06
+#define BT_AD_UUID128_ALL		0x07
+#define BT_AD_NAME_SHORT		0x08
+#define BT_AD_NAME_COMPLETE		0x09
+#define BT_AD_TX_POWER			0x0a
+#define BT_AD_CLASS_OF_DEV		0x0d
+#define BT_AD_SSP_HASH			0x0e
+#define BT_AD_SSP_RANDOMIZER		0x0f
+#define BT_AD_DEVICE_ID			0x10
+#define BT_AD_SMP_TK			0x10
+#define BT_AD_SMP_OOB_FLAGS		0x11
+#define BT_AD_SLAVE_CONN_INTERVAL	0x12
+#define BT_AD_SOLICIT16			0x14
+#define BT_AD_SOLICIT128		0x15
+#define BT_AD_SERVICE_DATA16		0x16
+#define BT_AD_PUBLIC_ADDRESS		0x17
+#define BT_AD_RANDOM_ADDRESS		0x18
+#define BT_AD_GAP_APPEARANCE		0x19
+#define BT_AD_ADVERTISING_INTERVAL	0x1a
+#define BT_AD_LE_DEVICE_ADDRESS		0x1b
+#define BT_AD_LE_ROLE			0x1c
+#define BT_AD_SSP_HASH_P256		0x1d
+#define BT_AD_SSP_RANDOMIZER_P256	0x1e
+#define BT_AD_SOLICIT32			0x1f
+#define BT_AD_SERVICE_DATA32		0x20
+#define BT_AD_SERVICE_DATA128		0x21
+#define BT_AD_LE_SC_CONFIRM_VALUE	0x22
+#define BT_AD_LE_SC_RANDOM_VALUE	0x23
+#define BT_AD_URI			0x24
+#define BT_AD_INDOOR_POSITIONING	0x25
+#define BT_AD_TRANSPORT_DISCOVERY	0x26
+#define BT_AD_LE_SUPPORTED_FEATURES	0x27
+#define BT_AD_CHANNEL_MAP_UPDATE_IND	0x28
+#define BT_AD_MESH_PROV			0x29
+#define BT_AD_MESH_DATA			0x2a
+#define BT_AD_MESH_BEACON		0x2b
+#define BT_AD_3D_INFO_DATA		0x3d
+#define BT_AD_MANUFACTURER_DATA		0xff
+
 typedef void (*bt_ad_func_t)(void *data, void *user_data);
 
 struct bt_ad;
@@ -39,6 +83,12 @@ struct bt_ad_manufacturer_data {
 
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
@@ -96,3 +146,13 @@ void bt_ad_clear_name(struct bt_ad *ad);
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

