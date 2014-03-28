Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Subject: [PATCHv2 2/9] android/gatt: Handle read characteristic client command
Date: Fri, 28 Mar 2014 19:54:38 +0100
Message-Id: <1396032885-32077-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1396032885-32077-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1396032885-32077-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>

This adds read characteristic client command handling.
---
 android/gatt.c | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 8dacd86..15a61d4 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -243,6 +243,26 @@ static bool match_notification(const void *a, const void *b)
 	return true;
 }

+static bool match_char_by_element_id(const void *data, const void *user_data)
+{
+	const struct element_id *exp_id = user_data;
+	const struct characteristic *chars = data;
+	bt_uuid_t uuid;
+
+	bt_string_to_uuid(&uuid, chars->ch.uuid);
+	if (exp_id->instance == chars->id.instance)
+		return !bt_uuid_cmp(&uuid, &exp_id->uuid);
+
+	return false;
+}
+
+static void hal_gatt_id_to_element_id(const struct hal_gatt_gatt_id *from,
+							struct element_id *to)
+{
+	to->instance = from->inst_id;
+	android2uuid(from->uuid, &to->uuid);
+}
+
 static void destroy_notification(void *data)
 {
 	struct notification_data *notification = data;
@@ -1359,13 +1379,129 @@ static void handle_client_get_descriptor(const void *buf, uint16_t len)
 			HAL_OP_GATT_CLIENT_GET_DESCRIPTOR, HAL_STATUS_FAILED);
 }

+struct read_char_data {
+	int32_t conn_id;
+	struct service *service;
+	struct characteristic *characteristic;
+	uint8_t is_primary;
+};
+
+static void send_client_read_char_notify(int32_t status, const uint8_t *pdu,
+						uint16_t len, int32_t conn_id,
+						struct service *service,
+						struct characteristic *ch,
+						uint8_t is_primary)
+{
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_gatt_client_read_characteristic *ev = (void *) buf;
+	bt_uuid_t uuid;
+	ssize_t vlen;
+
+	memset(buf, 0, sizeof(buf));
+
+	ev->conn_id = conn_id;
+	ev->status = status;
+
+	ev->data.srvc_id.inst_id = service->id.instance;
+	bt_string_to_uuid(&uuid, service->primary.uuid);
+	uuid2android(&uuid, ev->data.srvc_id.uuid);
+	ev->data.srvc_id.is_primary = is_primary;
+
+	ev->data.char_id.inst_id = ch->id.instance;
+	bt_string_to_uuid(&uuid, ch->ch.uuid);
+	uuid2android(&uuid, ev->data.char_id.uuid);
+
+	ev->data.status = status;
+
+	if (pdu) {
+		vlen = dec_read_resp(pdu, len, ev->data.value, sizeof(buf));
+		if (vlen < 0) {
+			error("gatt: Protocol error");
+			ev->status = GATT_FAILURE;
+		} else {
+			ev->data.len = vlen;
+		}
+	}
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_EV_GATT_CLIENT_READ_CHARACTERISTIC,
+					sizeof(*ev) + ev->data.len, ev);
+}
+
+static void read_char_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct read_char_data *data = user_data;
+
+	send_client_read_char_notify(status, pdu, len, data->conn_id,
+					data->service, data->characteristic,
+						data->is_primary);
+
+	free(data);
+}
+
 static void handle_client_read_characteristic(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_read_characteristic *cmd = buf;
+	struct read_char_data *cb_data;
+	struct characteristic *ch;
+	struct element_id match_id;
+	struct gatt_device *dev;
+	struct service *srvc;
+	uint8_t status;
+
 	DBG("");

+	/* TODO authorization needs to be handled */
+
+	hal_srvc_id_to_element_id(&cmd->srvc_id, &match_id);
+	if (!find_service(cmd->conn_id, &match_id, &dev, &srvc)) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	/* search characteristics by element id */
+	hal_gatt_id_to_element_id(&cmd->gatt_id, &match_id);
+	ch = queue_find(srvc->chars, match_char_by_element_id, &match_id);
+	if (!ch) {
+		error("gatt: Characteristic with inst_id: %d not found",
+							cmd->gatt_id.inst_id);
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	cb_data = new0(struct read_char_data, 1);
+	if (!cb_data) {
+		error("gatt: Cannot allocate cb data");
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	cb_data->service = srvc;
+	cb_data->conn_id = dev->conn_id;
+	cb_data->characteristic = ch;
+	cb_data->is_primary = cmd->srvc_id.is_primary;
+
+	if (!gatt_read_char(dev->attrib, ch->ch.value_handle,
+						read_char_cb, cb_data)) {
+		/* Read characteristic failed so we need to send
+		 * notification with failed status as Android waits
+		 * for it. Even though we reply success as a reply for
+		 * this command.
+		 */
+		error("gatt: Cannot read characteristic with inst_id: %d",
+							cmd->gatt_id.inst_id);
+		send_client_read_char_notify(GATT_FAILURE, NULL, 0,
+						dev->conn_id, srvc, ch,
+						cmd->srvc_id.is_primary);
+		free(cb_data);
+	}
+
+	status = HAL_STATUS_SUCCESS;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-					HAL_OP_GATT_CLIENT_READ_CHARACTERISTIC,
-					HAL_STATUS_FAILED);
+				HAL_OP_GATT_CLIENT_READ_CHARACTERISTIC, status);
 }

 static void handle_client_write_characteristic(const void *buf, uint16_t len)
--
1.9.0

