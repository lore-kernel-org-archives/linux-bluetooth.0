Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 08/15] android/gatt: Change handling of find_information requests
Date: Wed, 14 May 2014 12:18:12 +0200
Message-Id: <1400062699-2372-9-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400062699-2372-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400062699-2372-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This uses new version of gatt_db_find_information function which
returns list of handles.
---
 android/gatt.c | 66 ++++++++++++++++++++--------------------------------------
 1 file changed, 22 insertions(+), 44 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 5cfe2ba..66e75b7 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3963,31 +3963,6 @@ static void copy_to_att_list(void *data, void *user_data)
 	memcpy(&value[4], group->value, group->len);
 }
 
-static void copy_to_att_list_info(void *data, void *user_data)
-{
-	struct copy_att_list_data *l = user_data;
-	struct gatt_db_find_information *info = data;
-	uint8_t *value;
-
-	value = l->adl->data[l->iterator++];
-
-	put_le16(info->handle, value);
-
-	switch (info->uuid.type) {
-	case BT_UUID16:
-		memcpy(&value[2], &info->uuid.value.u16,
-						bt_uuid_len(&info->uuid));
-		break;
-	case BT_UUID128:
-		memcpy(&value[2], &info->uuid.value.u128,
-						bt_uuid_len(&info->uuid));
-		break;
-	default:
-		error("gatt: Unexpected UUID type");
-		break;
-	}
-}
-
 static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
 						uint8_t *rsp, size_t rsp_size,
 						uint16_t *length)
@@ -4319,12 +4294,9 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
 						uint16_t *length)
 {
 	struct queue *q;
-	struct gatt_db_find_information *last_element;
-	struct copy_att_list_data l;
 	struct att_data_list *adl;
+	int iterator = 0;
 	uint16_t start, end;
-	uint16_t num;
-	uint8_t format;
 	uint16_t len;
 
 	DBG("");
@@ -4345,29 +4317,35 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
 	}
 
 	len = queue_length(q);
+	adl = att_data_list_alloc(len, 2 * sizeof(uint16_t));
+	if (!adl) {
+		queue_destroy(q, NULL);
+		return ATT_ECODE_INSUFF_RESOURCES;
+	}
+
+	while (queue_peek_head(q)) {
+		uint8_t *value;
+		const bt_uuid_t *type;
+		uint16_t handle = PTR_TO_UINT(queue_pop_head(q));
 
-	last_element = queue_peek_head(q);
+		type = gatt_db_get_attribute_type(gatt_db, handle);
+		if (!type)
+			break;
+
+		value = adl->data[iterator++];
+
+		put_le16(handle, value);
+		memcpy(&value[2], &type->value.u16, bt_uuid_len(type));
 
-	if (last_element->uuid.type == BT_UUID16) {
-		num = sizeof(uint16_t);
-		format = ATT_FIND_INFO_RESP_FMT_16BIT;
-	} else {
-		num = sizeof(uint128_t);
-		format = ATT_FIND_INFO_RESP_FMT_128BIT;
 	}
 
-	adl = att_data_list_alloc(len, num + sizeof(uint16_t));
 	if (!adl) {
-		queue_destroy(q, free);
+		queue_destroy(q, NULL);
 		return ATT_ECODE_INSUFF_RESOURCES;
 	}
 
-	l.iterator = 0;
-	l.adl = adl;
-
-	queue_foreach(q, copy_to_att_list_info, &l);
-
-	len = enc_find_info_resp(format, adl, rsp, rsp_size);
+	len = enc_find_info_resp(ATT_FIND_INFO_RESP_FMT_16BIT, adl, rsp,
+								rsp_size);
 	if (!len)
 		return ATT_ECODE_UNLIKELY;
 
-- 
1.9.0

