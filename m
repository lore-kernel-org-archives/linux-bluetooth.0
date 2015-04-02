Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v9 08/12] shared/ad: implement bt_ad_generate
Date: Thu,  2 Apr 2015 11:59:24 -0700
Message-Id: <1428001168-32822-9-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1428001168-32822-1-git-send-email-jamuraa@chromium.org>
References: <1428001168-32822-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implements the function to provide a raw version of the advertising data
packet for passing to the kernel.
---
 src/eir.h       |  12 +++
 src/shared/ad.c | 237 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 245 insertions(+), 4 deletions(-)

diff --git a/src/eir.h b/src/eir.h
index cf85c1b..279da70 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -22,6 +22,10 @@
  *
  */
 
+#include <glib.h>
+
+#include "lib/sdp.h"
+
 #define EIR_FLAGS                   0x01  /* flags */
 #define EIR_UUID16_SOME             0x02  /* 16-bit UUID, more available */
 #define EIR_UUID16_ALL              0x03  /* 16-bit UUID, all listed */
@@ -36,7 +40,15 @@
 #define EIR_SSP_HASH                0x0E  /* SSP Hash */
 #define EIR_SSP_RANDOMIZER          0x0F  /* SSP Randomizer */
 #define EIR_DEVICE_ID               0x10  /* device ID */
+#define EIR_SOLICIT16               0x14  /* LE: Solicit UUIDs, 16-bit */
+#define EIR_SOLICIT128              0x15  /* LE: Solicit UUIDs, 128-bit */
+#define EIR_SVC_DATA16              0x16  /* LE: Service data, 16-bit UUID */
+#define EIR_PUB_TRGT_ADDR           0x17  /* LE: Public Target Address */
+#define EIR_RND_TRGT_ADDR           0x18  /* LE: Random Target Address */
 #define EIR_GAP_APPEARANCE          0x19  /* GAP appearance */
+#define EIR_SOLICIT32               0x1F  /* LE: Solicit UUIDs, 32-bit */
+#define EIR_SVC_DATA32              0x20  /* LE: Service data, 32-bit UUID */
+#define EIR_SVC_DATA128             0x21  /* LE: Service data, 128-bit UUID */
 #define EIR_MANUFACTURER_DATA       0xFF  /* Manufacturer Specific Data */
 
 /* Flags Descriptions */
diff --git a/src/shared/ad.c b/src/shared/ad.c
index 9307114..cbac460 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -19,9 +19,12 @@
 
 #include "src/shared/ad.h"
 
+#include "src/eir.h"
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
 
+#define MAX_ADV_DATA_LEN 31
+
 struct bt_ad {
 	int ref_count;
 	struct queue *service_uuids;
@@ -139,10 +142,236 @@ void bt_ad_unref(struct bt_ad *ad)
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
+		if (uuid->type == BT_UUID16)
+			uuid16_included = true;
+		else if (uuid->type == BT_UUID32)
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
+		struct manufacturer_data *data = entry->data;
+
+		length += 2 + sizeof(uint16_t) + data->len;
+
+		entry = entry->next;
+	}
+
+	return length;
+}
+
+static uint8_t uuid_data_length(struct queue *uuid_data)
+{
+	uint8_t length = 0;
+	const struct queue_entry *entry;
+
+	entry = queue_get_entries(uuid_data);
+
+	while (entry) {
+		struct uuid_data *data = entry->data;
+
+		length += 2 + bt_uuid_len(&data->uuid) + data->len;
+
+		entry = entry->next;
+	}
+
+	return length;
+}
+
+static uint8_t calculate_length(struct bt_ad *ad)
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
+						uint8_t ad_type, uint8_t *buf,
+						uint8_t *pos)
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
+		buf[length_pos] = *pos - length_pos - 1;
+}
+
+static void serialize_service_uuids(struct queue *uuids, uint8_t *buf,
+								uint8_t *pos)
+{
+	serialize_uuids(uuids, BT_UUID16, EIR_UUID16_ALL, buf, pos);
+
+	serialize_uuids(uuids, BT_UUID32, EIR_UUID32_ALL, buf, pos);
+
+	serialize_uuids(uuids, BT_UUID128, EIR_UUID128_ALL, buf, pos);
+}
+
+static void serialize_solicit_uuids(struct queue *uuids, uint8_t *buf,
+								uint8_t *pos)
+{
+	serialize_uuids(uuids, BT_UUID16, EIR_SOLICIT16, buf, pos);
+
+	serialize_uuids(uuids, BT_UUID32, EIR_SOLICIT32, buf, pos);
+
+	serialize_uuids(uuids, BT_UUID128, EIR_SOLICIT128, buf, pos);
+}
+
+static void serialize_manuf_data(struct queue *manuf_data, uint8_t *buf,
+								uint8_t *pos)
+{
+	const struct queue_entry *entry = queue_get_entries(manuf_data);
+
+	while (entry) {
+		struct manufacturer_data *data = entry->data;
+
+		buf[(*pos)++] = data->len + 2 + 1;
+
+		buf[(*pos)++] = EIR_MANUFACTURER_DATA;
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
+		struct uuid_data *data = entry->data;
+		int uuid_len = bt_uuid_len(&data->uuid);
+
+		buf[(*pos)++] =  uuid_len + data->len + 1;
+
+		switch (uuid_len) {
+		case 2:
+			buf[(*pos)++] = EIR_SVC_DATA16;
+			break;
+		case 4:
+			buf[(*pos)++] = EIR_SVC_DATA32;
+			break;
+		case 16:
+			buf[(*pos)++] = EIR_SVC_DATA128;
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
 uint8_t *bt_ad_generate(struct bt_ad *ad, uint8_t *length)
 {
-	/* TODO: implement */
-	return NULL;
+	uint8_t *adv_data;
+	uint8_t pos = 0;
+
+	if (!ad)
+		return NULL;
+
+	*length = calculate_length(ad);
+
+	if (*length > MAX_ADV_DATA_LEN)
+		return NULL;
+
+	adv_data = malloc0(*length);
+	if (!adv_data)
+		return NULL;
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
@@ -156,7 +385,7 @@ static bool queue_add_uuid(struct queue *queue, const bt_uuid_t *uuid)
 	if (!new_uuid)
 		return false;
 
-	bt_uuid_to_uuid128(uuid, new_uuid);
+	*new_uuid = *uuid;
 
 	if (queue_push_tail(queue, new_uuid))
 		return true;
@@ -309,7 +538,7 @@ bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
 	if (!new_data)
 		return false;
 
-	bt_uuid_to_uuid128(uuid, &new_data->uuid);
+	new_data->uuid = *uuid;
 
 	new_data->data = malloc(len);
 	if (!new_data->data) {
-- 
2.2.0.rc0.207.ga3a616c

