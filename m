Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] android/gatt: Handle read characteristic client command
Date: Mon, 31 Mar 2014 15:59:47 +0200
Message-Id: <1396274388-24698-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds read characteristic client command handling.
---
 android/gatt.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 8dacd86..a42c14a 100644
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
@@ -1359,13 +1379,125 @@ static void handle_client_get_descriptor(const void *buf, uint16_t len)
 			HAL_OP_GATT_CLIENT_GET_DESCRIPTOR, HAL_STATUS_FAILED);
 }
 
+struct read_char_data {
+	int32_t conn_id;
+	struct element_id srvc_id;
+	struct element_id char_id;
+	uint8_t primary;
+};
+
+static void send_client_read_char_notify(int32_t status, const uint8_t *pdu,
+						uint16_t len, int32_t conn_id,
+						struct element_id srvc_id,
+						struct element_id char_id,
+						uint8_t primary)
+{
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_gatt_client_read_characteristic *ev = (void *) buf;
+	ssize_t vlen;
+
+	memset(buf, 0, sizeof(buf));
+
+	ev->conn_id = conn_id;
+	ev->status = status;
+
+	ev->data.srvc_id.inst_id = srvc_id.instance;
+	uuid2android(&srvc_id.uuid, ev->data.srvc_id.uuid);
+	ev->data.srvc_id.is_primary = primary;
+
+	ev->data.char_id.inst_id = char_id.instance;
+	uuid2android(&char_id.uuid, ev->data.char_id.uuid);
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
+						data->srvc_id, data->char_id,
+						data->primary);
+
+	free(data);
+}
+
 static void handle_client_read_characteristic(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_read_characteristic *cmd = buf;
+	struct read_char_data *cb_data = NULL;
+	struct characteristic *ch;
+	struct gatt_device *dev;
+	struct service *srvc;
+	struct element_id srvc_id;
+	struct element_id char_id;
+	uint8_t status;
+
 	DBG("");
 
+	/* TODO authorization needs to be handled */
+
+	hal_srvc_id_to_element_id(&cmd->srvc_id, &srvc_id);
+	hal_gatt_id_to_element_id(&cmd->gatt_id, &char_id);
+
+	if (!find_service(cmd->conn_id, &srvc_id, &dev, &srvc))
+		goto failed;
+
+	/* search characteristics by element id */
+	ch = queue_find(srvc->chars, match_char_by_element_id, &char_id);
+	if (!ch) {
+		error("gatt: Characteristic with inst_id: %d not found",
+							cmd->gatt_id.inst_id);
+		goto failed;
+	}
+
+	cb_data = new0(struct read_char_data, 1);
+	if (!cb_data) {
+		error("gatt: Cannot allocate cb data");
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	cb_data->conn_id = cmd->conn_id;
+	cb_data->primary = cmd->srvc_id.is_primary;
+	cb_data->srvc_id.instance = cmd->srvc_id.inst_id;
+	cb_data->srvc_id = srvc_id;
+	cb_data->char_id = char_id;
+
+	if (!gatt_read_char(dev->attrib, ch->ch.value_handle,
+						read_char_cb, cb_data)) {
+		error("gatt: Cannot read characteristic with inst_id: %d",
+							cmd->gatt_id.inst_id);
+		free(cb_data);
+	}
+
+	status = HAL_STATUS_SUCCESS;
+	goto done;
+
+failed:
+	send_client_read_char_notify(GATT_FAILURE, NULL, 0, cmd->conn_id,
+					srvc_id, char_id,
+					cmd->srvc_id.is_primary);
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
1.8.5.2

