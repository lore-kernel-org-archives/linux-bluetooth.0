Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] android/gatt: Handle write characteristic client command
Date: Mon, 31 Mar 2014 15:59:48 +0200
Message-Id: <1396274388-24698-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1396274388-24698-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1396274388-24698-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds write characteristic client command handling.
---
 android/gatt.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 105 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index a42c14a..e31e8c4 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1500,13 +1500,116 @@ done:
 				HAL_OP_GATT_CLIENT_READ_CHARACTERISTIC, status);
 }
 
+struct write_char_data {
+	int32_t conn_id;
+	struct element_id srvc_id;
+	struct element_id char_id;
+	uint8_t is_primary;
+};
+
+static void send_client_write_char_notify(int32_t status, int32_t conn_id,
+					struct element_id srvc_id,
+					struct element_id char_id,
+					uint8_t is_primary)
+{
+	struct hal_ev_gatt_client_write_characteristic ev;
+
+	memset(&ev, 0, sizeof(ev));
+
+	ev.conn_id = conn_id;
+	ev.status = status;
+
+	ev.data.srvc_id.inst_id = srvc_id.instance;
+	uuid2android(&srvc_id.uuid, ev.data.srvc_id.uuid);
+	ev.data.srvc_id.is_primary = is_primary;
+
+	ev.data.char_id.inst_id = char_id.instance;
+	uuid2android(&char_id.uuid, ev.data.srvc_id.uuid);
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
+	send_client_write_char_notify(status, data->conn_id, data->srvc_id,
+					data->char_id, data->is_primary);
+
+	free(data);
+}
+
 static void handle_client_write_characteristic(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_write_characteristic *cmd = buf;
+	struct write_char_data *cb_data;
+	struct characteristic *ch;
+	struct gatt_device *dev;
+	struct service *srvc;
+	struct element_id srvc_id;
+	struct element_id char_id;
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
+	hal_srvc_id_to_element_id(&cmd->srvc_id, &srvc_id);
+	hal_gatt_id_to_element_id(&cmd->gatt_id, &char_id);
+
+	if (!find_service(cmd->conn_id, &srvc_id, &dev, &srvc))
+		goto failed;
+
+	/* search characteristics by instance id */
+	ch = queue_find(srvc->chars, match_char_by_element_id, &char_id);
+	if (!ch) {
+		error("gatt: Characteristic with inst_id: %d not found",
+							cmd->gatt_id.inst_id);
+		goto failed;
+	}
+
+	cb_data = new0(struct write_char_data, 1);
+	if (!cb_data) {
+		error("gatt: Cannot allocate call data");
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	cb_data->srvc_id = srvc_id;
+	cb_data->char_id = char_id;
+	cb_data->conn_id = cmd->conn_id;
+	cb_data->is_primary = cmd->srvc_id.is_primary;
+
+	if (!gatt_write_char(dev->attrib, ch->ch.value_handle, value,
+					sizeof(value), write_char_cb, cb_data))
+	{
+		error("gatt: Cannot read characteristic with inst_id: %d",
+							cmd->gatt_id.inst_id);
+		free(cb_data);
+	}
+
+	status = HAL_STATUS_SUCCESS;
+	goto done;
+
+failed:
+	status = HAL_STATUS_SUCCESS;
+	send_client_write_char_notify(GATT_FAILURE, cmd->conn_id, srvc_id,
+					char_id, cmd->srvc_id.is_primary);
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-					HAL_OP_GATT_CLIENT_WRITE_CHARACTERISTIC,
-					HAL_STATUS_FAILED);
+			HAL_OP_GATT_CLIENT_WRITE_CHARACTERISTIC, status);
 }
 
 static void handle_client_read_descriptor(const void *buf, uint16_t len)
-- 
1.8.5.2

