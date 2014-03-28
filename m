Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 6/9] android/gatt: Search for descriptors and notify
Date: Fri, 28 Mar 2014 19:54:42 +0100
Message-Id: <1396032885-32077-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1396032885-32077-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1396032885-32077-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds searching for descriptors and sending them in
notifications. Descriptors are cached. In case of initialial descriptor
provided, next after the given is sent.
---
 android/gatt.c | 160 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 151 insertions(+), 9 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index fec55d4..1fe7035 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -237,6 +237,16 @@ static bool match_char_by_higher_inst_id(const void *data,
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
@@ -1396,6 +1406,12 @@ done:
 				HAL_OP_GATT_CLIENT_GET_CHARACTERISTIC, status);
 }
 
+struct discover_desc_data {
+	int32_t conn_id;
+	struct service *service;
+	struct characteristic *characteristic;
+};
+
 static void send_client_descr_notify(int32_t status, int32_t conn_id,
 						const struct descriptor *descr,
 						const struct service *srvc,
@@ -1426,8 +1442,78 @@ static void send_client_descr_notify(int32_t status, int32_t conn_id,
 	}
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-					HAL_EV_GATT_CLIENT_GET_DESCRIPTOR,
-					sizeof(ev), &ev);
+			HAL_EV_GATT_CLIENT_GET_DESCRIPTOR, sizeof(ev), &ev);
+}
+
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
+	struct descriptor *descr = NULL;
+
+	if (status != 0) {
+		error("gatt: Discover all char descriptors failed: %s\n",
+							att_ecode2str(status));
+	} else if (data->characteristic) {
+		cache_all_descr(pdu, len, data->characteristic->descriptors);
+		descr = queue_peek_head(data->characteristic->descriptors);
+	}
+
+	send_client_descr_notify(status, data->conn_id, descr, data->service,
+							data->characteristic);
+	free(data);
 }
 
 static void handle_client_get_descriptor(const void *buf, uint16_t len)
@@ -1435,9 +1521,11 @@ static void handle_client_get_descriptor(const void *buf, uint16_t len)
 	const struct hal_cmd_gatt_client_get_descriptor *cmd = buf;
 	struct characteristic *ch = NULL;
 	struct descriptor *descr = NULL;
+	struct characteristic *next_ch = NULL;
 	struct service *srvc = NULL;
 	struct element_id match_id;
 	struct gatt_device *dev;
+	uint16_t start, end;
 	int32_t conn_id = 0;
 	uint8_t status;
 
@@ -1453,8 +1541,8 @@ static void handle_client_get_descriptor(const void *buf, uint16_t len)
 
 	hal_srvc_id_to_element_id(&cmd->srvc_id, &match_id);
 	if (!find_service(cmd->conn_id, &match_id, &dev, &srvc)) {
-		status = HAL_STATUS_FAILED;
-		goto done;
+		error("gatt: cound not find service");
+		goto failed;
 	}
 
 	conn_id = dev->conn_id;
@@ -1462,18 +1550,72 @@ static void handle_client_get_descriptor(const void *buf, uint16_t len)
 	hal_gatt_id_to_element_id(&cmd->gatt_id[0], &match_id);
 	ch = queue_find(srvc->chars, match_char_by_element_id, &match_id);
 	if (!ch) {
-		status = HAL_STATUS_FAILED;
-		goto done;
+		error("gatt: cound not find characteristic");
+		goto failed;
 	}
 
+	/* Clip range to given characteristic */
+	start = ch->ch.value_handle + 1;
+	end = srvc->primary.range.end;
+
 	if (queue_isempty(ch->descriptors)) {
-		/* TODO: Cache descriptors */
+		/* Use next characteristic start as end. If there is none -
+		 * service end is valid end.
+		 * TODO: we should cache char end handle to avoid this search */
+		next_ch = queue_find(srvc->chars, match_char_by_higher_inst_id,
+						INT_TO_PTR(match_id.instance));
+		if (next_ch)
+			end = next_ch->ch.handle - 1;
+
+		/* If characteristic is not empty create descriptor cache, else
+		 * notify with bad status. */
+		if (start <= end) {
+			struct discover_desc_data *cb_data;
+
+			cb_data = new0(struct discover_desc_data, 1);
+			if (!cb_data) {
+				error("gatt: cb_data allocation error");
+
+				status = HAL_STATUS_FAILED;
+				goto done;
+			}
+
+			cb_data->service = srvc;
+			cb_data->conn_id = conn_id;
+			cb_data->characteristic = ch;
+
+			if (gatt_discover_char_desc(dev->attrib, start, end,
+							gatt_discover_desc_cb,
+							cb_data)) {
+				status = HAL_STATUS_SUCCESS;
+				goto done;
+			}
+
+			free(cb_data);
+		}
+
+		goto failed;
 	}
 
-	/* TODO: Send from cache */
-	send_client_descr_notify(GATT_FAILURE, conn_id, descr, srvc, ch);
+	/* Send from cache */
+	if (cmd->number > 1)
+		descr = queue_find(ch->descriptors,
+					match_descr_by_higher_inst_id,
+					INT_TO_PTR(cmd->gatt_id[1].inst_id));
+	else
+		descr = queue_peek_head(ch->descriptors);
 
+	if (descr) {
+		send_client_descr_notify(GATT_SUCCESS, conn_id, descr, srvc,
+									ch);
+		status = HAL_STATUS_SUCCESS;
+		goto done;
+	}
+
+failed:
+	send_client_descr_notify(GATT_FAILURE, conn_id, descr, srvc, ch);
 	status = HAL_STATUS_SUCCESS;
+
 done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_CLIENT_GET_DESCRIPTOR, status);
-- 
1.9.0

