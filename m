Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Subject: [PATCH v4 30/38] android/gatt: Add Find info gatt server cmd handling
Date: Wed, 30 Apr 2014 11:14:01 +0200
Message-Id: <1398849249-5868-31-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>

The Find Information Request is used to obtain the mapping of
attribute handles with their associated types. This allows a
client to discover the list of attributes and their types on
a server.
---
 android/gatt.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 962c71c..dfe7dec 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3631,6 +3631,31 @@ static void copy_to_att_list_type(void *data, void *user_data)
 	memcpy(&value[2], hdl_val->value, hdl_val->length);
 }
 
+static void copy_to_att_list_info(void *data, void *user_data)
+{
+	struct copy_att_list_data *l = user_data;
+	struct gatt_db_find_information *info = data;
+	uint8_t *value;
+
+	value = l->adl->data[l->iterator++];
+
+	put_le16(info->handle, value);
+
+	switch (info->uuid.type) {
+	case BT_UUID16:
+		memcpy(&value[2], &info->uuid.value.u16,
+						bt_uuid_len(&info->uuid));
+		break;
+	case BT_UUID128:
+		memcpy(&value[2], &info->uuid.value.u128,
+						bt_uuid_len(&info->uuid));
+		break;
+	default:
+		error("gatt: Unexpected UUID type");
+		break;
+	}
+}
+
 static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
 						uint8_t *rsp, size_t rsp_size,
 						uint16_t *length)
@@ -3807,6 +3832,66 @@ static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
 	return 0;
 }
 
+static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
+						uint8_t *rsp, size_t rsp_size,
+						uint16_t *length)
+{
+	struct queue *q;
+	struct gatt_db_find_information *last_element;
+	struct copy_att_list_data l;
+	struct att_data_list *adl;
+	uint16_t start, end;
+	uint16_t num;
+	uint8_t format;
+	uint16_t len;
+
+	DBG("");
+
+	len = dec_find_info_req(cmd, cmd_len, &start, &end);
+	if (!len)
+		return ATT_ECODE_INVALID_PDU;
+
+	q = queue_new();
+	if (!q)
+		return ATT_ECODE_UNLIKELY;
+
+	gatt_db_find_information(gatt_db, start, end, q);
+
+	if (queue_isempty(q)) {
+		queue_destroy(q, NULL);
+		return ATT_ECODE_ATTR_NOT_FOUND;
+	}
+
+	len = queue_length(q);
+
+	last_element = queue_peek_head(q);
+
+	if (last_element->uuid.type == BT_UUID16) {
+		num = sizeof(uint16_t);
+		format = ATT_FIND_INFO_RESP_FMT_16BIT;
+	} else {
+		num = sizeof(uint128_t);
+		format = ATT_FIND_INFO_RESP_FMT_128BIT;
+	}
+
+	adl = att_data_list_alloc(len, num + sizeof(uint16_t));
+
+	l.iterator = 0;
+	l.adl = adl;
+
+	queue_foreach(q, copy_to_att_list_info, &l);
+
+	len = enc_find_info_resp(format, adl, rsp, rsp_size);
+	if (!len)
+		return ATT_ECODE_UNLIKELY;
+
+	*length = len;
+	att_data_list_free(adl);
+	queue_destroy(q, free);
+
+	return 0;
+}
+
 static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -3844,6 +3929,9 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 								&length);
 		break;
 	case ATT_OP_FIND_INFO_REQ:
+		status = find_info_handle(ipdu, len, opdu, sizeof(opdu),
+								&length);
+		break;
 	case ATT_OP_WRITE_REQ:
 	case ATT_OP_WRITE_CMD:
 	case ATT_OP_FIND_BY_TYPE_REQ:
-- 
1.8.4

