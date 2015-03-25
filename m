Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v5 12/13] shared/advertising: implement advertising_data_generate
Date: Wed, 25 Mar 2015 16:01:00 -0700
Message-Id: <1427324461-27651-13-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1427324461-27651-1-git-send-email-jamuraa@chromium.org>
References: <1427324461-27651-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implements the function to provide a raw version of the advertising data
packet for passing to the kernel.
---
 src/shared/advertising-data.c | 240 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 238 insertions(+), 2 deletions(-)

diff --git a/src/shared/advertising-data.c b/src/shared/advertising-data.c
index 800856c..ccef2a4 100644
--- a/src/shared/advertising-data.c
+++ b/src/shared/advertising-data.c
@@ -22,6 +22,21 @@
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
 
+#define MAX_ADV_DATA_LEN 31
+
+#define LE_AD_TYPE_UUID16_ALL		0x03 /* 16-bit service UUIDs, all */
+#define LE_AD_TYPE_UUID32_ALL		0x05 /* 16-bit service UUIDs, all */
+#define LE_AD_TYPE_UUID128_ALL		0x07 /* 16-bit service UUIDs, all */
+#define LE_AD_TYPE_SOLICIT16		0x14 /* 16-bit service solic. UUIDs */
+#define LE_AD_TYPE_SOLICIT32		0x1F /* 32-bit service solic. UUIDs */
+#define LE_AD_TYPE_SOLICIT128		0x15 /* 128-bit service solic. UUIDs */
+#define LE_AD_TYPE_SVC_DATA16		0x16 /* Service Data - 16-bit UUID */
+#define LE_AD_TYPE_SVC_DATA32		0x20 /* Service Data - 32-bit UUID */
+#define LE_AD_TYPE_SVC_DATA128		0x21 /* Service Data - 128-bit UUID */
+#define LE_AD_TYPE_PUB_TRGT_ADDR	0x17 /* Public Target Address */
+#define LE_AD_TYPE_RND_TRGT_ADDR	0x18 /* Random Target Address */
+#define LE_AD_TYPE_MANUF_DATA		0xFF /* Manufacturer Specific Data */
+
 struct advertising_data {
 	int ref_count;
 	struct queue *service_uuids;
@@ -136,10 +151,231 @@ void advertising_data_unref(struct advertising_data *ad)
 	free(ad);
 }
 
+static uint8_t uuid_list_length(struct queue *uuid_queue)
+{
+	bool uuid16_included = false;
+	bool uuid32_included = false;
+	bool uuid128_included = false;
+	uint8_t length = 0;
+	const struct queue_entry *entry;
+
+	entry = queue_get_entries(uuid_queue);
+
+	while (entry) {
+		bt_uuid_t *uuid = entry->data;
+		uint8_t uuid_len = bt_uuid_len(uuid);
+
+		length += uuid_len;
+
+		if (uuid_len == 2)
+			uuid16_included = true;
+		else if (uuid_len == 4)
+			uuid32_included = true;
+		else
+			uuid128_included = true;
+
+		entry = entry->next;
+	}
+
+	if (uuid16_included)
+		length += 2;
+
+	if (uuid32_included)
+		length += 2;
+
+	if (uuid128_included)
+		length += 2;
+
+	return length;
+}
+
+static uint8_t mfg_data_length(struct queue *manuf_data)
+{
+	uint8_t length = 0;
+	const struct queue_entry *entry;
+
+	entry = queue_get_entries(manuf_data);
+
+	while (entry) {
+		struct manufacturer_tagged_data *data = entry->data;
+
+		length += 2 + sizeof(uint16_t) + data->len;
+
+		entry = entry->next;
+	}
+
+	return length;
+}
+
+static uint8_t uuid_data_length(struct queue *tagged_data)
+{
+	uint8_t length = 0;
+	const struct queue_entry *entry;
+
+	entry = queue_get_entries(tagged_data);
+
+	while (entry) {
+		struct uuid_tagged_data *data = entry->data;
+
+		length += 2 + bt_uuid_len(&data->uuid) + data->len;
+
+		entry = entry->next;
+	}
+
+	return length;
+}
+
+static uint8_t calculate_length(struct advertising_data *ad)
+{
+	uint8_t length = 0;
+
+	length += uuid_list_length(ad->service_uuids);
+
+	length += uuid_list_length(ad->solicit_uuids);
+
+	length += mfg_data_length(ad->manufacturer_data);
+
+	length += uuid_data_length(ad->service_data);
+
+	return length;
+}
+
+static void serialize_uuids(struct queue *uuids, uint8_t uuid_type,
+					uint8_t ad_type, uint8_t *buf,
+					uint8_t *pos)
+{
+	const struct queue_entry *entry = queue_get_entries(uuids);
+	bool added = false;
+	uint8_t length_pos = 0;
+
+	while (entry) {
+		bt_uuid_t *uuid = entry->data;
+
+		if (uuid->type == uuid_type) {
+			if (!added) {
+				length_pos = (*pos)++;
+				buf[(*pos)++] = ad_type;
+				added = true;
+			}
+
+			if (uuid_type != BT_UUID32)
+				bt_uuid_to_le(uuid, buf + *pos);
+			else
+				bt_put_le32(uuid->value.u32, buf + *pos);
+
+			*pos += bt_uuid_len(uuid);
+		}
+
+		entry = entry->next;
+	}
+
+	if (added)
+		buf[length_pos] = *pos - length_pos;
+}
+
+static void serialize_service_uuids(struct queue *uuids, uint8_t *buf,
+								uint8_t *pos)
+{
+	serialize_uuids(uuids, BT_UUID16, LE_AD_TYPE_UUID16_ALL, buf, pos);
+
+	serialize_uuids(uuids, BT_UUID32, LE_AD_TYPE_UUID32_ALL, buf, pos);
+
+	serialize_uuids(uuids, BT_UUID128, LE_AD_TYPE_UUID128_ALL, buf, pos);
+}
+
+static void serialize_solicit_uuids(struct queue *uuids, uint8_t *buf,
+								uint8_t *pos)
+{
+	serialize_uuids(uuids, BT_UUID16, LE_AD_TYPE_SOLICIT16, buf, pos);
+
+	serialize_uuids(uuids, BT_UUID32, LE_AD_TYPE_SOLICIT32, buf, pos);
+
+	serialize_uuids(uuids, BT_UUID128, LE_AD_TYPE_SOLICIT128, buf, pos);
+}
+
+static void serialize_manuf_data(struct queue *manuf_data, uint8_t *buf,
+								uint8_t *pos)
+{
+	const struct queue_entry *entry = queue_get_entries(manuf_data);
+
+	while (entry) {
+		struct manufacturer_tagged_data *data = entry->data;
+
+		buf[(*pos)++] = data->len + 2 + 1;
+
+		buf[(*pos)++] = LE_AD_TYPE_MANUF_DATA;
+
+		bt_put_le16(data->manufacturer_id, buf + (*pos));
+
+		*pos += 2;
+
+		memcpy(buf + *pos, data->data, data->len);
+
+		*pos += data->len;
+
+		entry = entry->next;
+	}
+}
+
+static void serialize_service_data(struct queue *service_data, uint8_t *buf,
+								uint8_t *pos)
+{
+	const struct queue_entry *entry = queue_get_entries(service_data);
+
+	while (entry) {
+		struct uuid_tagged_data *data = entry->data;
+		int uuid_len = bt_uuid_len(&data->uuid);
+
+		buf[(*pos)++] =  uuid_len + data->len + 1;
+
+		switch (uuid_len) {
+		case 2:
+			buf[(*pos)++] = LE_AD_TYPE_SVC_DATA16;
+			break;
+		case 4:
+			buf[(*pos)++] = LE_AD_TYPE_SVC_DATA32;
+			break;
+		case 16:
+			buf[(*pos)++] = LE_AD_TYPE_SVC_DATA128;
+			break;
+		}
+
+		if (uuid_len != 4)
+			bt_uuid_to_le(&data->uuid, buf + *pos);
+		else
+			bt_put_le32(data->uuid.value.u32, buf + *pos);
+
+		*pos += uuid_len;
+
+		memcpy(buf + *pos, data->data, data->len);
+
+		*pos += data->len;
+
+		entry = entry->next;
+	}
+}
+
 uint8_t *advertising_data_generate(struct advertising_data *ad, uint8_t *length)
 {
-	/* TODO: implement */
-	return NULL;
+	uint8_t *adv_data;
+	uint8_t pos = 0;
+
+	*length = calculate_length(ad);
+
+	if (*length > MAX_ADV_DATA_LEN)
+		return NULL;
+
+	adv_data = malloc(*length);
+
+	serialize_service_uuids(ad->service_uuids, adv_data, &pos);
+
+	serialize_solicit_uuids(ad->solicit_uuids, adv_data, &pos);
+
+	serialize_manuf_data(ad->manufacturer_data, adv_data, &pos);
+
+	serialize_service_data(ad->service_data, adv_data, &pos);
+
+	return adv_data;
 }
 
 static bool queue_add_uuid(struct queue *queue, const bt_uuid_t *uuid)
-- 
2.2.0.rc0.207.ga3a616c

