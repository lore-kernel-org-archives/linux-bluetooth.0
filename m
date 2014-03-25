Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/gatt: Handle get descriptor client command
Date: Tue, 25 Mar 2014 19:19:12 +0100
Message-Id: <1395771552-21540-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds get characteristic descriptor command handling. If initial
descriptor is given, next descriptor after given is returned. In case of
no initial descriptor, first descriptor in given characteristic is
returned. Descriptors are cached for each characteristic on first get
descriptor command.
---
 android/gatt.c | 274 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 272 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index d5a8bf4..b1b26bb 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -31,6 +31,7 @@
 #include <glib.h>
 #include <errno.h>
 #include <sys/socket.h>
+#include <assert.h>
 
 #include "ipc.h"
 #include "ipc-common.h"
@@ -61,6 +62,8 @@ struct gatt_id {
 struct gatt_srvc_char {
 	struct gatt_id id;
 	struct gatt_char ch;
+
+	struct queue *descriptors;
 };
 
 struct gatt_srvc {
@@ -73,6 +76,7 @@ struct gatt_srvc {
 struct generic_call_data {
 	struct gatt_device *dev;
 	struct gatt_srvc *gatt_srvc;
+	struct gatt_srvc_char *gatt_char;
 };
 
 struct gatt_device {
@@ -102,11 +106,26 @@ static struct queue *conn_wait_queue = NULL;	/* Devs waiting to connect */
 
 static void bt_le_discovery_stop_cb(void);
 
+static void free_gatt_char(void *data)
+{
+	struct gatt_srvc_char *chars = data;
+
+	if (!chars)
+		return;
+
+	queue_destroy(chars->descriptors, free);
+
+	free(chars);
+}
+
 static void free_gatt_service(void *data)
 {
 	struct gatt_srvc *srvc = data;
 
-	queue_destroy(srvc->chars, free);
+	if (!srvc)
+		return;
+
+	queue_destroy(srvc->chars, free_gatt_char);
 	free(srvc);
 }
 
@@ -177,6 +196,29 @@ static bool match_char_by_higher_inst_id(const void *data,
 	return inst_id < chars->id.inst_id;
 }
 
+static bool match_char_by_gatt_id(const void *data, const void *user_data)
+{
+	const struct gatt_id *exp_id = user_data;
+	const struct gatt_srvc_char *chars = data;
+	bt_uuid_t uuid;
+
+	bt_string_to_uuid(&uuid, chars->ch.uuid);
+	if (exp_id->inst_id == chars->id.inst_id)
+		return !bt_uuid_cmp(&uuid, &exp_id->uuid);
+
+	return false;
+}
+
+static bool match_descr_by_higher_inst_id(const void *data,
+							const void *user_data)
+{
+	const struct gatt_id *descr_id = data;
+	uint8_t inst_id = PTR_TO_INT(user_data);
+
+	/* For now we match inst_id as it is unique */
+	return inst_id < descr_id->inst_id;
+}
+
 static void destroy_device(void *data)
 {
 	struct gatt_device *dev = data;
@@ -972,6 +1014,12 @@ static void cache_all_srvc_chars(GSList *characteristics, struct queue *q)
 			continue;
 		}
 
+		chars->descriptors = queue_new();
+		if (!chars->descriptors) {
+			free(chars);
+			continue;
+		}
+
 		memcpy(&chars->ch, characteristics->data, sizeof(chars->ch));
 
 		bt_string_to_uuid(&uuid, chars->ch.uuid);
@@ -1020,6 +1068,17 @@ static void hal_srvc_id_to_gatt_id(const struct hal_gatt_srvc_id *from,
 	bt_uuid128_create(&to->uuid, uuid128);
 }
 
+static void hal_gatt_id_to_gatt_id(const struct hal_gatt_gatt_id *from,
+							struct gatt_id *to)
+{
+	uint128_t uuid128;
+
+	to->inst_id = from->inst_id;
+
+	memcpy(&uuid128.data, &from->uuid, sizeof(uuid128));
+	bt_uuid128_create(&to->uuid, uuid128);
+}
+
 static void handle_client_get_characteristic(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_get_characteristic *cmd = buf;
@@ -1095,12 +1154,223 @@ done:
 				HAL_OP_GATT_CLIENT_GET_CHARACTERISTIC, status);
 }
 
+static void send_client_descr_notify(const struct gatt_id *descr_id,
+						struct generic_call_data *data)
+{
+	struct hal_ev_gatt_client_get_descriptor ev;
+	bt_uuid_t uuid;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.status = HAL_STATUS_FAILED;
+
+	if (descr_id) {
+		ev.status = HAL_STATUS_SUCCESS;
+
+		ev.descr_id.inst_id = descr_id->inst_id;
+		bt_uuid_to_uuid128(&descr_id->uuid, &uuid);
+		memcpy(&ev.descr_id.uuid, &uuid.value.u128.data,
+						sizeof(ev.descr_id.uuid));
+	}
+
+	ev.conn_id = data->dev->conn_id;
+
+	/* TODO: handle included services */
+	ev.srvc_id.is_primary = 1;
+	ev.srvc_id.inst_id = data->gatt_srvc->id.inst_id;
+	bt_string_to_uuid(&uuid, data->gatt_srvc->service.uuid);
+	memcpy(&ev.srvc_id.uuid, &uuid.value.u128.data,
+						sizeof(ev.srvc_id.uuid));
+
+	ev.char_id.inst_id = data->gatt_char->id.inst_id;
+	bt_string_to_uuid(&uuid, data->gatt_char->ch.uuid);
+	memcpy(&ev.char_id.uuid, &uuid.value.u128.data,
+						sizeof(ev.srvc_id.uuid));
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_EV_GATT_CLIENT_GET_DESCRIPTOR,
+					sizeof(ev), &ev);
+}
+
+
+static void cache_all_descr(const guint8 *pdu, guint16 len, struct queue *queue)
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
+		struct gatt_id *descr_id;
+		bt_uuid_t uuid128;
+		uint16_t handle;
+		uint8_t *value;
+		bt_uuid_t uuid;
+
+		value = list->data[i];
+		handle = get_le16(value);
+
+		if (format == 0x01) {
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
+		DBG("gatt: descriptor handle = 0x%04x, uuid = %s\n", handle,
+								uuidstr);
+
+		descr_id = new0(struct gatt_id, 1);
+		if (!descr_id)
+			continue;
+
+		descr_id->inst_id = i;
+		descr_id->uuid = uuid128;
+
+		if (!queue_push_tail(queue, descr_id))
+			free(descr_id);
+	}
+
+	att_data_list_free(list);
+}
+
+static void gatt_discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct generic_call_data *call_data = user_data;
+	struct gatt_id *descr_id = NULL;
+
+	if (status != 0) {
+		g_printerr("gatt: Discover all char descriptors failed: "
+						"%s\n", att_ecode2str(status));
+		goto done;
+	}
+
+	if (call_data->gatt_char) {
+		cache_all_descr(pdu, len, call_data->gatt_char->descriptors);
+		descr_id = queue_peek_head(call_data->gatt_char->descriptors);
+	}
+
+done:
+	send_client_descr_notify(descr_id, call_data);
+	free(call_data);
+}
+
 static void handle_client_get_descriptor(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_get_descriptor *cmd = buf;
+	struct generic_call_data *call_data = NULL;
+	struct gatt_id *descr_id = NULL;
+	struct gatt_srvc_char *chars;
+	struct gatt_id match_id;
+	struct gatt_device *dev;
+	struct gatt_srvc *srvc;
+	uint16_t start, end;
+	uint8_t status;
+
 	DBG("");
 
+	if (len != sizeof(*cmd) + cmd->number * sizeof(cmd->gatt_id[0])) {
+		error("gatt: Wrong get descriptor cmd size (%u bytes), \
+							terminating", len);
+		raise(SIGTERM);
+		return;
+	}
+
+	/* search on list by connection id */
+	dev = queue_find(conn_list, match_dev_by_conn_id,
+						INT_TO_PTR(cmd->conn_id));
+	if (!dev) {
+		error("gatt: Get descriptor conn_id=%d not found",
+								cmd->conn_id);
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	hal_srvc_id_to_gatt_id(&cmd->srvc_id, &match_id);
+	srvc = queue_find(dev->services, match_srvc_by_gatt_id, &match_id);
+	if (!srvc) {
+		error("gatt: Get descriptor service with inst_id: %d not found",
+							match_id.inst_id);
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	assert(cmd->number);
+	hal_gatt_id_to_gatt_id(&cmd->gatt_id[0], &match_id);
+
+	chars = queue_find(srvc->chars, match_char_by_gatt_id, &match_id);
+	if (!chars) {
+		error("gatt: Get descriptor could not find appropriate \
+							characteristic");
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	call_data = new0(struct generic_call_data, 1);
+	if (!call_data) {
+		error("gatt: Get descriptor cannot allocate call data");
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	call_data->gatt_srvc = srvc;
+	call_data->dev = dev;
+
+	/* Clip range to given characteristic */
+	start = chars->ch.value_handle + 1;
+	end = srvc->service.range.end;
+
+	call_data->gatt_char = chars;
+	if (queue_isempty(chars->descriptors)) {
+		/* Use next characteristic start as end. If there is none -
+		 * service end is valid end. */
+		chars = queue_find(srvc->chars, match_char_by_higher_inst_id,
+						INT_TO_PTR(match_id.inst_id));
+		if (chars)
+			end = chars->ch.handle - 1;
+
+		/* If characteristic is not empty create descriptor cache, else
+		 * notify with bad status. */
+		if (start <= end) {
+			status = HAL_STATUS_SUCCESS;
+			if (!gatt_discover_char_desc(dev->attrib, start, end,
+							gatt_discover_desc_cb,
+							call_data)) {
+				free(call_data);
+			}
+
+			status = HAL_STATUS_SUCCESS;
+			goto done;
+		}
+
+		goto notify;
+	}
+
+	/* Send from cache */
+	if (cmd->number > 1)
+		descr_id = queue_find(chars->descriptors,
+					match_descr_by_higher_inst_id,
+					INT_TO_PTR(cmd->gatt_id[1].inst_id));
+	else
+		descr_id = queue_peek_head(chars->descriptors);
+
+notify:
+	send_client_descr_notify(descr_id, call_data);
+	free(call_data);
+
+	status = HAL_STATUS_SUCCESS;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_CLIENT_GET_DESCRIPTOR, HAL_STATUS_FAILED);
+				HAL_OP_GATT_CLIENT_GET_DESCRIPTOR, status);
 }
 
 static void handle_client_read_characteristic(const void *buf, uint16_t len)
-- 
1.9.0

