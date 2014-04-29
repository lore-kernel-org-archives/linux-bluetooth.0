Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Subject: [PATCH 22/36] android/gatt: Add support for ATT read by type
Date: Tue, 29 Apr 2014 03:14:53 +0200
Message-Id: <1398734107-4793-24-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>

---
 android/gatt.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index eb1a910..d442a49 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3629,6 +3629,19 @@ static void copy_to_att_list(void *data, void *user_data)
 	memcpy(&value[4], group->value, group->len);
 }
 
+static void copy_to_att_list_type(void *data, void *user_data)
+{
+	struct copy_att_list_data *l = user_data;
+	struct gatt_db_handle_value *hdl_val = data;
+	uint8_t *value;
+
+	value = (void *)l->adl->data[l->iterator++];
+
+	put_le16(hdl_val->handle, value);
+
+	memcpy(&value[2], hdl_val->value, hdl_val->length);
+}
+
 static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
 						uint8_t *rsp, size_t rsp_size,
 						uint16_t *length)
@@ -3680,6 +3693,59 @@ static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
 	return 0;
 }
 
+static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
+						uint8_t *rsp, size_t rsp_size,
+						uint16_t *length)
+{
+	uint16_t start, end;
+	uint16_t len;
+	bt_uuid_t uuid;
+	struct queue *q;
+	struct att_data_list *adl;
+	struct copy_att_list_data l;
+	struct gatt_db_handle_value *h;
+
+	DBG("");
+
+	len = dec_read_by_type_req(cmd, cmd_len, &start, &end, &uuid);
+	if (!len)
+		return ATT_ECODE_INVALID_PDU;
+
+	q = queue_new();
+	if (!q)
+		return ATT_ECODE_UNLIKELY;
+
+	gatt_db_read_by_type(gatt_db, start, end, uuid, q);
+
+	if (queue_isempty(q)) {
+		queue_destroy(q, NULL);
+		return ATT_ECODE_ATTR_NOT_FOUND;
+	}
+
+	len = queue_length(q);
+	h = queue_peek_tail(q);
+
+	/* Element here is handle + value*/
+	adl = att_data_list_alloc(len, sizeof(uint16_t) + h->length);
+	if (adl == NULL) {
+		queue_destroy(q, NULL);
+		return ATT_ECODE_UNLIKELY;
+	}
+
+	l.iterator = 0;
+	l.adl = adl;
+
+	queue_foreach(q, copy_to_att_list_type, &l);
+
+	len = enc_read_by_type_resp(adl, rsp, rsp_size);
+	*length = len;
+
+	att_data_list_free(adl);
+	queue_destroy(q, free);
+
+	return 0;
+}
+
 static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -3703,6 +3769,8 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 								&length);
 		break;
 	case ATT_OP_READ_BY_TYPE_REQ:
+		status = read_by_type(ipdu, len, opdu, sizeof(opdu), &length);
+		break;
 	case ATT_OP_READ_REQ:
 	case ATT_OP_READ_BLOB_REQ:
 	case ATT_OP_MTU_REQ:
-- 
1.8.4

