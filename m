Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH ] GATT: Add support for Gatt multiple char write request
Date: Thu, 21 Aug 2014 16:43:24 +0530
Message-id: <1408619604-26201-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes made to handle gatt char multiple write request
1. Changes made to handle gatt long char write request
2. Cache/prepare and execute long char write request.
3. Updates gatt attribute db using offset value.
4. Proper offset and char length handling to fix below PTS test cases,

TP/GAW/SR/BV-06-C
TP/GAW/SR/BV-10-C
TP/GAW/SR/BV-09-C
TP/GAW/SR/BI-09-C
TP/GAW/SR/BI-14-C
TP/GAW/SR/BI-15-C
TP/GAW/SR/BV-05-C
TP/GAW/SR/BI-07-C
TP/GAW/SR/BV-07-C
TP/GAW/SR/BI-08-C
TP/GAW/SR/BI-25-C
TP/GAW/SR/BI-26-C
TP/GAW/SR/BI-27-C
---
 src/attrib-server.c | 323 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/attrib-server.h |   3 +
 2 files changed, 324 insertions(+), 2 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index e65fff2..10a7923 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -85,6 +85,25 @@ struct group_elem {
 	uint16_t len;
 };
 
+struct local_db {
+	uint16_t handle;
+	uint8_t offset;
+	size_t len;
+	uint8_t *data;
+	struct local_db *next;
+};
+
+struct char_handle_len {
+	uint16_t handle;
+	size_t org_len;
+	struct char_handle_len *next;
+};
+
+struct char_handle_len *local_char_handle_len = NULL;
+struct char_handle_len *local_char_handle_len_head = NULL;
+struct local_db *local_prep_db = NULL;
+struct local_db *local_prep_db_head = NULL;
+
 static bt_uuid_t prim_uuid = {
 			.type = BT_UUID16,
 			.value.u16 = GATT_PRIM_SVC_UUID
@@ -869,6 +888,228 @@ static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
 	return enc_read_blob_resp(a->data, a->len, offset, pdu, len);
 }
 
+static int is_offset_valid(struct btd_adapter *adapter, uint16_t handle,
+								struct attribute **attr, size_t len,
+								uint16_t offset, size_t org_len)
+{
+	struct gatt_server *server;
+	GSList *l;
+	GList *dl;
+	guint h = handle;
+
+	l = g_slist_find_custom(servers, adapter, adapter_cmp);
+
+	if (l == NULL)
+		return -ENOENT;
+
+	server = l->data;
+	DBG("handle=0x%04x", handle);
+
+	dl = g_list_find_custom(server->database, GUINT_TO_POINTER(h), handle_cmp);
+	if (dl == NULL)
+		return -ENOENT;
+
+	if (offset > org_len)
+		return ATT_ECODE_INVALID_OFFSET;
+	else if (org_len < (len + offset))
+		return ATT_ECODE_INVAL_ATTR_VALUE_LEN;
+
+	return 0;
+}
+
+static void free_default_attr_value_len(void)
+{
+	struct char_handle_len *temp_attr_value_len_db = NULL;
+
+	/* Traverse through char_handle_len list and free the list 
+	   after write execute complete */
+	if (local_char_handle_len_head) {
+		local_char_handle_len = local_char_handle_len_head;
+		temp_attr_value_len_db = local_char_handle_len_head;
+		while(temp_attr_value_len_db) {
+			local_char_handle_len = local_char_handle_len->next;
+			g_free(temp_attr_value_len_db);
+			temp_attr_value_len_db = local_char_handle_len;
+		}
+	}
+}
+
+static void store_default_attr_value_len(uint16_t handle, size_t len)
+{
+	bool found = FALSE;
+
+	/* Store handle len for the first prepare write request */
+	if (local_char_handle_len == NULL) {
+		local_char_handle_len = g_new0(struct char_handle_len, 1);
+		local_char_handle_len_head = local_char_handle_len;
+		local_char_handle_len->handle =  handle;
+		local_char_handle_len->org_len = len;
+		local_char_handle_len->next = NULL;
+	}
+
+	local_char_handle_len = local_char_handle_len_head;
+
+	/* Check if handle len is already stored */
+	while (local_char_handle_len) {
+		if (local_char_handle_len->handle == handle) {
+			found = TRUE;
+			break;
+		}
+		if (local_char_handle_len->next)
+			local_char_handle_len = local_char_handle_len->next;
+		else
+			break;
+	}
+
+	if (!found) {
+		if (local_char_handle_len->next == NULL) {
+			local_char_handle_len->next = g_new0(struct char_handle_len, 1);
+			local_char_handle_len = local_char_handle_len->next;
+			local_char_handle_len->handle = handle;
+			local_char_handle_len->org_len = len;
+			local_char_handle_len->next = NULL;
+		}
+	}
+}
+
+static size_t get_org_len(uint16_t handle)
+{
+	local_char_handle_len = local_char_handle_len_head;
+	while (local_char_handle_len) {
+		if (local_char_handle_len->handle == handle) {
+			return local_char_handle_len->org_len;
+		}
+		local_char_handle_len = local_char_handle_len->next;
+	}
+	return local_char_handle_len->org_len;
+}
+
+static uint16_t prepare_write_execute(struct gatt_channel *channel, uint8_t *pdu,
+										size_t len, uint8_t flags)
+{
+	int status;
+	size_t org_len = 0;
+	struct local_db *temp_prepare_db = NULL;
+
+	if (local_prep_db_head != NULL) {
+		local_prep_db = local_prep_db_head;
+		if (flags == 0x01) {
+			do {
+				temp_prepare_db = local_prep_db;
+				org_len = get_org_len(local_prep_db->handle);
+				status = is_offset_valid(channel->server->adapter,
+							local_prep_db->handle, NULL,
+							local_prep_db->len, local_prep_db->offset,
+							org_len);
+
+				if (status) {
+					return enc_error_resp(ATT_OP_EXEC_WRITE_REQ,
+									local_prep_db->handle, status, pdu, len);
+				}
+				attrib_db_update_by_offset(channel->server->adapter,
+										local_prep_db->handle, NULL,
+										local_prep_db->data,
+										local_prep_db->len, NULL,
+										local_prep_db->offset);
+				local_prep_db = local_prep_db->next;
+				g_free(temp_prepare_db);
+			} while(local_prep_db);
+		} else if (flags == 0x00) {
+			temp_prepare_db = local_prep_db;
+			local_prep_db = local_prep_db->next;
+			g_free(temp_prepare_db);
+		}
+
+		free_default_attr_value_len();
+	}
+	return enc_exec_write_resp(pdu);
+}
+
+static uint16_t prepare_write_value(struct gatt_channel *channel, uint16_t handle,
+					const uint8_t *value, size_t vlen,
+					uint8_t *pdu, size_t len, uint16_t offset)
+{
+	struct attribute *a;
+	uint8_t status;
+	GList *l;
+	guint h = handle;
+
+	l = g_list_find_custom(channel->server->database,
+					GUINT_TO_POINTER(h), handle_cmp);
+	if (!l)
+		return enc_error_resp(ATT_OP_PREP_WRITE_REQ, handle,
+				ATT_ECODE_INVALID_HANDLE, pdu, len);
+
+	a = l->data;
+
+	status = att_check_reqs(channel, ATT_OP_PREP_WRITE_REQ, a->write_req);
+	if (status)
+		return enc_error_resp(ATT_OP_PREP_WRITE_REQ, handle, status, pdu,
+									len);
+
+	if (bt_uuid_cmp(&ccc_uuid, &a->uuid) != 0) {
+
+		/* Store the write request data local in a linked list */
+		if (local_prep_db == NULL) {
+			local_prep_db = g_new0(struct local_db, 1);
+			local_prep_db_head =  local_prep_db;
+		} else {
+			if (local_prep_db->next == NULL) {
+				local_prep_db->next = g_new0(struct local_db, 1);
+				local_prep_db = local_prep_db->next;
+			}
+		}
+		local_prep_db->handle = handle;
+		local_prep_db->offset = offset;
+		local_prep_db->len = vlen;
+		local_prep_db->data =  malloc(sizeof(uint8_t) * vlen);
+		memcpy(local_prep_db->data, value, vlen);
+		local_prep_db->next = NULL;
+		store_default_attr_value_len(handle, a->len);
+
+		if (a->write_cb) {
+			status = a->write_cb(a, channel->device,
+							a->cb_user_data);
+			if (status)
+				return enc_error_resp(ATT_OP_PREP_WRITE_REQ, handle,
+							status, pdu, len);
+		}
+	} else {
+		uint16_t cccval = get_le16(value);
+		char *filename;
+		GKeyFile *key_file;
+		char group[6], value[5];
+		char *data;
+		gsize length = 0;
+
+		filename = btd_device_get_storage_path(channel->device, "ccc");
+		if (!filename) {
+			warn("Unable to get ccc storage path for device");
+			return enc_error_resp(ATT_OP_PREP_WRITE_REQ, handle,
+						ATT_ECODE_WRITE_NOT_PERM,
+						pdu, len);
+		}
+
+		key_file = g_key_file_new();
+		g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+		sprintf(group, "%hu", handle);
+		sprintf(value, "%hX", cccval);
+		g_key_file_set_string(key_file, group, "Value", value);
+
+		data = g_key_file_to_data(key_file, &length, NULL);
+		if (length > 0) {
+			create_file(filename, S_IRUSR | S_IWUSR);
+			g_file_set_contents(filename, data, length, NULL);
+		}
+
+		g_free(data);
+		g_free(filename);
+		g_key_file_free(key_file);
+	}
+
+	return enc_prep_write_resp(handle, offset, value, vlen, pdu, len);
+}
 static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 					const uint8_t *value, size_t vlen,
 					uint8_t *pdu, size_t len)
@@ -989,7 +1230,7 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 	uint8_t opdu[channel->mtu];
 	uint16_t length, start, end, mtu, offset;
 	bt_uuid_t uuid;
-	uint8_t status = 0;
+	uint8_t status = 0, flags;
 	size_t vlen;
 	uint8_t *value = g_attrib_get_buffer(channel->attrib, &vlen);
 
@@ -1096,9 +1337,26 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 	case ATT_OP_HANDLE_NOTIFY:
 		/* The attribute client is already handling these */
 		return;
-	case ATT_OP_READ_MULTI_REQ:
 	case ATT_OP_PREP_WRITE_REQ:
+		length = dec_prep_write_req(ipdu, len, &start,
+									&offset, value, &vlen);
+		if (length == 0) {
+			status = ATT_ECODE_INVALID_PDU;
+			goto done;
+		}
+		length = prepare_write_value(channel, start, value, vlen, opdu,
+												channel->mtu, offset);
+		break;
 	case ATT_OP_EXEC_WRITE_REQ:
+		length = dec_exec_write_req(ipdu, len, &flags);
+		if (length == 0) {
+			status = ATT_ECODE_INVALID_PDU;
+			goto done;
+		}
+
+		length = prepare_write_execute(channel, opdu, channel->mtu, flags);
+		break;
+	case ATT_OP_READ_MULTI_REQ:
 	default:
 		DBG("Unsupported request 0x%02x", ipdu[0]);
 		status = ATT_ECODE_REQ_NOT_SUPP;
@@ -1560,6 +1818,67 @@ struct attribute *attrib_db_add(struct btd_adapter *adapter, uint16_t handle,
 								value, len);
 }
 
+int attrib_db_update_by_offset(struct btd_adapter *adapter, uint16_t handle,
+					bt_uuid_t *uuid, const uint8_t *value,
+					size_t len, struct attribute **attr, uint16_t offset)
+{
+	struct gatt_server *server;
+	struct attribute *a;
+	GSList *l;
+	GList *dl;
+	guint h = handle;
+	guint extra_len = 0;
+
+	l = g_slist_find_custom(servers, adapter, adapter_cmp);
+	if (l == NULL)
+		return -ENOENT;
+
+	server = l->data;
+
+	DBG("handle=0x%04x", handle);
+
+	dl = g_list_find_custom(server->database, GUINT_TO_POINTER(h),
+								handle_cmp);
+	if (dl == NULL)
+		return -ENOENT;
+
+	a = dl->data;
+
+	if (offset) {
+		uint8_t *temp_data;
+		temp_data = malloc(sizeof(uint8_t) * a->len);
+		memcpy(temp_data, a->data, a->len);
+
+		if ((a->len - offset) < len)
+			extra_len = len - (a->len - offset);
+		if (extra_len > 0)
+			a->data = g_try_realloc(a->data, a->len + extra_len);
+		memcpy(a->data, temp_data, a->len);
+		free(temp_data);
+	} else {
+		a->data = g_try_realloc(a->data, len);
+	}
+
+	if ((len && a->data == NULL) || (offset > a->len))
+		return -ENOMEM;
+
+	if (offset) {
+		if (extra_len > 0)
+			a->len = a->len + extra_len;
+		memcpy((a->data + offset), value, len);
+	} else {
+		a->len = len;
+		memcpy(a->data, value, len);
+	}
+
+	if (uuid != NULL)
+		a->uuid = *uuid;
+
+	if (attr)
+		*attr = a;
+
+	return 0;
+}
 int attrib_db_update(struct btd_adapter *adapter, uint16_t handle,
 					bt_uuid_t *uuid, const uint8_t *value,
 					size_t len, struct attribute **attr)
diff --git a/src/attrib-server.h b/src/attrib-server.h
index 063cb66..18a320b 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -31,6 +31,9 @@ struct attribute *attrib_db_add(struct btd_adapter *adapter, uint16_t handle,
 int attrib_db_update(struct btd_adapter *adapter, uint16_t handle,
 					bt_uuid_t *uuid, const uint8_t *value,
 					size_t len, struct attribute **attr);
+int attrib_db_update_by_offset(struct btd_adapter *adapter, uint16_t handle,
+					bt_uuid_t *uuid, const uint8_t *value,
+					size_t len, struct attribute **attr, uint16_t offset);
 int attrib_db_del(struct btd_adapter *adapter, uint16_t handle);
 int attrib_gap_set(struct btd_adapter *adapter, uint16_t uuid,
 					const uint8_t *value, size_t len);
-- 
1.9.1

