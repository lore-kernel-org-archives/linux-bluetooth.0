Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 25/38] android/gatt: Add support for ATT read by group type
Date: Wed, 30 Apr 2014 11:13:56 +0200
Message-Id: <1398849249-5868-26-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index d588a56..d4d6a38 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3597,17 +3597,98 @@ static const struct ipc_handler cmd_handlers[] = {
 		sizeof(struct hal_cmd_gatt_server_send_response) },
 };
 
+struct copy_att_list_data {
+	int iterator;
+	struct att_data_list *adl;
+};
+
+static void copy_to_att_list(void *data, void *user_data)
+{
+	struct copy_att_list_data *l = user_data;
+	struct gatt_db_group *group = data;
+	uint8_t *value;
+
+	value = l->adl->data[l->iterator++];
+
+	put_le16(group->handle, value);
+	put_le16(group->end_group, &value[2]);
+
+	memcpy(&value[4], group->value, group->len);
+}
+
+static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
+						uint8_t *rsp, size_t rsp_size,
+						uint16_t *length)
+{
+	uint16_t start, end;
+	uint16_t len;
+	bt_uuid_t uuid;
+	struct queue *q;
+	struct att_data_list *adl;
+	struct copy_att_list_data l;
+	struct gatt_db_group *d;
+
+	len = dec_read_by_grp_req(cmd, cmd_len, &start, &end, &uuid);
+	if (!len)
+		return ATT_ECODE_INVALID_PDU;
+
+	q = queue_new();
+	if (!q)
+		return ATT_ECODE_INSUFF_RESOURCES;
+
+	gatt_db_read_by_group_type(gatt_db, start, end, uuid, q);
+
+	if (queue_isempty(q)) {
+		queue_destroy(q, NULL);
+		return ATT_ECODE_ATTR_NOT_FOUND;
+	}
+
+	len = queue_length(q);
+	d = queue_peek_head(q);
+
+	/* Element contains start/end handle + size of uuid */
+	adl = att_data_list_alloc(len, 2 * sizeof(uint16_t) + d->len);
+	if (adl == NULL) {
+		queue_destroy(q, NULL);
+		return ATT_ECODE_INSUFF_RESOURCES;
+	}
+
+	l.iterator = 0;
+	l.adl = adl;
+
+	queue_foreach(q, copy_to_att_list, &l);
+
+	len = enc_read_by_grp_resp(adl, rsp, rsp_size);
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
 	uint8_t opdu[ATT_DEFAULT_LE_MTU];
 	uint8_t status;
 	uint16_t length = 0;
+	size_t vlen;
+	uint8_t *value = g_attrib_get_buffer(dev->attrib, &vlen);
 
 	DBG("op 0x%02x", ipdu[0]);
 
+	if (len > vlen) {
+		error("Too much data on ATT socket %p", value);
+		status = ATT_ECODE_INVALID_PDU;
+		goto done;
+	}
+
 	switch (ipdu[0]) {
 	case ATT_OP_READ_BY_GROUP_REQ:
+		status = read_by_group_type(ipdu, len, opdu, sizeof(opdu),
+								&length);
+		break;
 	case ATT_OP_READ_BY_TYPE_REQ:
 	case ATT_OP_READ_REQ:
 	case ATT_OP_READ_BLOB_REQ:
-- 
1.8.4

