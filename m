Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 2/2] android/gatt: Fix find_info_handle function
Date: Thu, 11 Dec 2014 17:53:54 +0100
Message-Id: <1418316834-26886-2-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1418316834-26886-1-git-send-email-mariusz.skamra@tieto.com>
References: <1418316834-26886-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Server can contain attributes with 128-bit attribute types
---
 android/gatt.c | 50 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index c4e3497..4237813 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6104,11 +6104,12 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
 						uint8_t *rsp, size_t rsp_size,
 						uint16_t *length)
 {
-	struct queue *q;
+	struct gatt_db_attribute *attrib;
+	struct queue *q, *temp;
 	struct att_data_list *adl;
 	int iterator = 0;
 	uint16_t start, end;
-	uint16_t len;
+	uint16_t len, queue_len;
 
 	DBG("");
 
@@ -6130,17 +6131,45 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
 		return ATT_ECODE_ATTR_NOT_FOUND;
 	}
 
-	len = queue_length(q);
-	adl = att_data_list_alloc(len, 2 * sizeof(uint16_t));
-	if (!adl) {
+	temp = queue_new();
+	if (!temp) {
+		queue_destroy(q, NULL);
+		return ATT_ECODE_UNLIKELY;
+	}
+
+	attrib = queue_peek_head(q);
+	/* UUIDS can be only 128 bit and 16 bit */
+	len = bt_uuid_len(gatt_db_attribute_get_type(attrib));
+	if (len != 2 && len != 16) {
 		queue_destroy(q, NULL);
+		queue_destroy(temp, NULL);
+		return ATT_ECODE_UNLIKELY;
+	}
+
+	while (attrib) {
+		const bt_uuid_t *type;
+		type = gatt_db_attribute_get_type(attrib);
+
+		if (bt_uuid_len(type) != len)
+			break;
+
+		queue_push_tail(temp, queue_pop_head(q));
+		attrib = queue_peek_head(q);
+	}
+
+	queue_destroy(q, NULL);
+
+	queue_len = queue_length(temp);
+	adl = att_data_list_alloc(queue_len, len + sizeof(uint16_t));
+	if (!adl) {
+		queue_destroy(temp, NULL);
 		return ATT_ECODE_INSUFF_RESOURCES;
 	}
 
-	while (queue_peek_head(q)) {
+	while (queue_peek_head(temp)) {
 		uint8_t *value;
 		const bt_uuid_t *type;
-		struct gatt_db_attribute *attrib = queue_pop_head(q);
+		struct gatt_db_attribute *attrib = queue_pop_head(temp);
 		uint16_t handle;
 
 		type = gatt_db_attribute_get_type(attrib);
@@ -6151,17 +6180,18 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
 
 		handle = gatt_db_attribute_get_handle(attrib);
 		put_le16(handle, value);
-		memcpy(&value[2], &type->value.u16, bt_uuid_len(type));
+		memcpy(&value[2], &type->value, len);
 	}
 
-	len = enc_find_info_resp(ATT_FIND_INFO_RESP_FMT_16BIT, adl, rsp,
+	len = enc_find_info_resp(len == 2 ? ATT_FIND_INFO_RESP_FMT_16BIT :
+					ATT_FIND_INFO_RESP_FMT_128BIT, adl, rsp,
 								rsp_size);
 	if (!len)
 		return ATT_ECODE_UNLIKELY;
 
 	*length = len;
 	att_data_list_free(adl);
-	queue_destroy(q, free);
+	queue_destroy(temp, NULL);
 
 	return 0;
 }
-- 
1.9.1

