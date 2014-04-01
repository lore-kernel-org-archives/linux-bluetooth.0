Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 3/5] android/gatt: Add descriptors sending and caching for client
Date: Tue,  1 Apr 2014 17:19:25 +0200
Message-Id: <1396365567-17339-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1396365567-17339-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1396365567-17339-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds descriptors caching at first get descriptor call. After that
descriptors are send from the cache.
---
 android/gatt.c | 160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 152 insertions(+), 8 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index b496d8a..2039920 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -287,6 +287,16 @@ static bool match_char_by_higher_inst_id(const void *data,
 	return inst_id < ch->id.instance;
 }
 
+static bool match_descr_by_higher_inst_id(const void *data,
+							const void *user_data)
+{
+	const struct descriptor *descr = data;
+	uint8_t instance = PTR_TO_INT(user_data);
+
+	/* For now we match instance as it is unique */
+	return instance < descr->id.instance;
+}
+
 static bool match_char_by_instance(const void *data, const void *user_data)
 {
 	const struct characteristic *ch = data;
@@ -1420,6 +1430,15 @@ done:
 				HAL_OP_GATT_CLIENT_GET_CHARACTERISTIC, status);
 }
 
+struct discover_desc_data {
+	int32_t conn_id;
+	const struct element_id *srvc_id;
+	const struct element_id *char_id;
+	uint8_t primary;
+
+	struct queue *descriptors;
+};
+
 static void send_client_descr_notify(int32_t status, int32_t conn_id,
 					bool primary,
 					const struct element_id *srvc,
@@ -1443,6 +1462,126 @@ static void send_client_descr_notify(int32_t status, int32_t conn_id,
 			HAL_EV_GATT_CLIENT_GET_DESCRIPTOR, sizeof(ev), &ev);
 }
 
+
+static void cache_all_descr(const uint8_t *pdu, guint16 len,
+							struct queue *queue)
+{
+	struct att_data_list *list;
+	guint8 format;
+	int i;
+
+	list = dec_find_info_resp(pdu, len, &format);
+	if (!list || !queue)
+		return;
+
+	for (i = 0; i < list->num; i++) {
+		char uuidstr[MAX_LEN_UUID_STR];
+		struct descriptor *descr;
+		bt_uuid_t uuid128;
+		uint16_t handle;
+		uint8_t *value;
+		bt_uuid_t uuid;
+
+		value = list->data[i];
+		handle = get_le16(value);
+
+		if (format == ATT_FIND_INFO_RESP_FMT_16BIT) {
+			bt_uuid16_create(&uuid, get_le16(&value[2]));
+			bt_uuid_to_uuid128(&uuid, &uuid128);
+		} else {
+			uint128_t u128;
+
+			bswap_128(&value[2], &u128);
+			bt_uuid128_create(&uuid128, u128);
+		}
+
+		bt_uuid_to_string(&uuid128, uuidstr, MAX_LEN_UUID_STR);
+		DBG("gatt: Cached descriptor handle = 0x%04x, uuid = %s\n",
+							handle, uuidstr);
+
+		descr = new0(struct descriptor, 1);
+		if (!descr)
+			break;
+
+		descr->id.instance = i;
+		descr->handle = handle;
+		descr->id.uuid = uuid128;
+
+		if (!queue_push_tail(queue, descr))
+			free(descr);
+	}
+
+	att_data_list_free(list);
+}
+
+static void gatt_discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct discover_desc_data *data = user_data;
+	struct descriptor *descr;
+
+	if (!data) {
+		error("No user data");
+		return;
+	}
+
+	if (status != 0)
+		error("gatt: Discover all char descriptors failed: %s\n",
+							att_ecode2str(status));
+	else
+		cache_all_descr(pdu, len, data->descriptors);
+
+	descr = queue_peek_head(data->descriptors);
+	send_client_descr_notify(status, data->conn_id, data->primary,
+						data->srvc_id, data->char_id,
+						&descr->id);
+
+	free(data);
+}
+
+static bool build_descr_cache(int32_t conn_id, struct gatt_device *dev,
+					struct service *srvc, uint8_t primary,
+					struct characteristic *ch)
+{
+	struct discover_desc_data *cb_data;
+	struct characteristic *next_ch;
+	uint16_t start, end;
+
+	/* Clip range to given characteristic */
+	start = ch->ch.value_handle + 1;
+	end = srvc->primary.range.end;
+
+	/* Use next characteristic start as end. If there is none -
+	 * service end is valid end.
+	 * TODO: we should cache char end handle to avoid this search */
+	next_ch = queue_find(srvc->chars, match_char_by_higher_inst_id,
+					INT_TO_PTR(ch->id.instance));
+	if (next_ch)
+		end = next_ch->ch.handle - 1;
+
+	/* If there are no descriptors, notify with fail status. */
+	if (start > end)
+		return false;
+
+	cb_data = new0(struct discover_desc_data, 1);
+	if (!cb_data)
+		return false;
+
+	cb_data->conn_id = conn_id;
+	cb_data->srvc_id = &srvc->id;
+	cb_data->char_id = &ch->id;
+	cb_data->primary = primary;
+	cb_data->descriptors = ch->descriptors;
+
+	if (!gatt_discover_char_desc(dev->attrib, start, end,
+					gatt_discover_desc_cb,	cb_data)) {
+		free(cb_data);
+		return false;
+	}
+
+	return true;
+}
+
 static void handle_client_get_descriptor(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_get_descriptor *cmd = buf;
@@ -1488,19 +1627,24 @@ static void handle_client_get_descriptor(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-
 	if (queue_isempty(ch->descriptors)) {
-		/* TODO: Build the cache */
-
-		ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
+		if (build_descr_cache(conn_id, dev, srvc, primary, ch)) {
+			ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_GET_DESCRIPTOR,
-					HAL_STATUS_FAILED);
-		return;
+					HAL_STATUS_SUCCESS);
+			return;
+		}
 	}
 
-	status = HAL_STATUS_FAILED;
+	status = HAL_STATUS_SUCCESS;
 
-	/* TODO: Send from cache */
+	/* Send from cache */
+	if (cmd->number > 1)
+		descr = queue_find(ch->descriptors,
+					match_descr_by_higher_inst_id,
+					INT_TO_PTR(cmd->gatt_id[1].inst_id));
+	else
+		descr = queue_peek_head(ch->descriptors);
 
 failed:
 	send_client_descr_notify(descr ? GATT_SUCCESS : GATT_FAILURE, conn_id,
-- 
1.9.0

