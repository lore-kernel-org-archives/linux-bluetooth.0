Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Subject: [PATCHv2 3/9] android/gatt: Handle write characteristic client command
Date: Fri, 28 Mar 2014 19:54:39 +0100
Message-Id: <1396032885-32077-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1396032885-32077-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1396032885-32077-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>

This adds write characteristic client command handling.
---
 android/gatt.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 15a61d4..4dd16e7 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1504,13 +1504,119 @@ done:
 				HAL_OP_GATT_CLIENT_READ_CHARACTERISTIC, status);
 }

+struct write_char_data {
+	int32_t conn_id;
+	struct service *service;
+	struct characteristic *characteristic;
+	uint8_t is_primary;
+};
+
+static void send_client_write_char_notify(int32_t status, int32_t conn_id,
+					struct service *service,
+					struct characteristic *characteristic,
+					uint8_t is_primary)
+{
+	struct hal_ev_gatt_client_write_characteristic ev;
+	bt_uuid_t uuid;
+
+	memset(&ev, 0, sizeof(ev));
+
+	ev.conn_id = conn_id;
+	ev.status = status;
+
+	ev.data.srvc_id.inst_id = service->id.instance;
+	bt_string_to_uuid(&uuid, service->primary.uuid);
+	memcpy(&ev.data.srvc_id.uuid, &uuid.value.u128.data,
+						sizeof(ev.data.srvc_id.uuid));
+	ev.data.srvc_id.is_primary = is_primary;
+
+	ev.data.char_id.inst_id = characteristic->id.instance;
+	bt_string_to_uuid(&uuid, characteristic->ch.uuid);
+	memcpy(&ev.data.char_id.uuid, &uuid.value.u128.data,
+						sizeof(ev.data.char_id.uuid));
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_EV_GATT_CLIENT_WRITE_CHARACTERISTIC,
+					sizeof(ev), &ev);
+}
+
+static void write_char_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct write_char_data *data = user_data;
+
+	send_client_write_char_notify(status, data->conn_id, data->service,
+					data->characteristic, data->is_primary);
+
+	free(data);
+}
+
 static void handle_client_write_characteristic(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_write_characteristic *cmd = buf;
+	struct write_char_data *cb_data;
+	struct characteristic *ch;
+	struct element_id match_id;
+	struct gatt_device *dev;
+	struct service *srvc;
+	uint8_t status;
+	uint8_t value[cmd->len];
+
 	DBG("");

+	if (len != sizeof(*cmd) + cmd->len) {
+		error("Invalid write characteristic size (%u bytes), "
+							"terminating", len);
+		raise(SIGTERM);
+		return;
+	}
+
+	memcpy(value, cmd->value, cmd->len);
+
+	hal_srvc_id_to_element_id(&cmd->srvc_id, &match_id);
+	if (!find_service(cmd->conn_id, &match_id, &dev, &srvc)) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	/* search characteristics by instance id */
+	hal_gatt_id_to_element_id(&cmd->gatt_id, &match_id);
+
+	ch = queue_find(srvc->chars, match_char_by_element_id, &match_id);
+	if (!ch) {
+		error("gatt: Characteristic with inst_id: %d not found",
+							cmd->gatt_id.inst_id);
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	cb_data = new0(struct write_char_data, 1);
+	if (!cb_data) {
+		error("gatt: Cannot allocate call data");
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	cb_data->service = srvc;
+	cb_data->characteristic = ch;
+	cb_data->conn_id = dev->conn_id;
+	cb_data->is_primary = cmd->srvc_id.is_primary;
+
+	if (!gatt_write_char(dev->attrib, ch->ch.value_handle, value,
+					sizeof(value), write_char_cb, cb_data))
+	{
+		error("gatt: Cannot read characteristic with inst_id: %d",
+							cmd->gatt_id.inst_id);
+		send_client_write_char_notify(GATT_FAILURE, dev->conn_id, srvc,
+						ch, cmd->srvc_id.is_primary);
+		free(cb_data);
+	}
+
+	status = HAL_STATUS_SUCCESS;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-					HAL_OP_GATT_CLIENT_WRITE_CHARACTERISTIC,
-					HAL_STATUS_FAILED);
+			HAL_OP_GATT_CLIENT_WRITE_CHARACTERISTIC, status);
 }

 static void handle_client_read_descriptor(const void *buf, uint16_t len)
--
1.9.0

