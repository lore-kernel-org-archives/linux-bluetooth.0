Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 8/9]  android/gatt: Add client write descriptor handler
Date: Fri, 28 Mar 2014 19:54:44 +0100
Message-Id: <1396032885-32077-9-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1396032885-32077-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1396032885-32077-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 129 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 128 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 0a4159e..f5e44be 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2003,12 +2003,139 @@ done:
 			HAL_OP_GATT_CLIENT_READ_DESCRIPTOR, status);
 }
 
+struct write_descr_data {
+	int32_t conn_id;
+	struct service *service;
+	struct characteristic *characteristic;
+	struct descriptor *descriptor;
+
+	int32_t write_type;
+};
+
+static void send_client_descr_write_notify(int32_t status, int32_t conn_id,
+						const struct descriptor *descr,
+						const struct service *srvc,
+						const struct characteristic *ch) {
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_gatt_client_write_descriptor *ev = (void *) buf;
+
+	memset(buf, 0, sizeof(buf));
+
+	ev->status = status;
+	ev->conn_id = conn_id;
+
+	if (srvc) {
+		ev->data.srvc_id.inst_id = srvc->id.instance;
+		uuid2android(&srvc->id.uuid, ev->data.srvc_id.uuid);
+	}
+
+	if (ch) {
+		ev->data.char_id.inst_id = ch->id.instance;
+		uuid2android(&ch->id.uuid, ev->data.char_id.uuid);
+	}
+
+	if (descr) {
+		ev->data.descr_id.inst_id = descr->id.instance;
+		uuid2android(&descr->id.uuid, ev->data.descr_id.uuid);
+	}
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_EV_GATT_CLIENT_WRITE_DESCRIPTOR,
+					sizeof(*ev), ev);
+}
+
+
+static void write_descr_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct read_desc_data *cb_data = user_data;
+
+	if (status != 0)
+		error("gatt: Write descriptors failed: %s\n",
+							att_ecode2str(status));
+
+	send_client_descr_write_notify(status, cb_data->conn_id,
+					cb_data->descriptor, cb_data->service,
+					cb_data->characteristic);
+
+	free(cb_data);
+
+}
+
 static void handle_client_write_descriptor(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_write_descriptor *cmd = buf;
+	struct write_descr_data *cb_data;
+	struct characteristic *ch = NULL;
+	struct descriptor *descr = NULL;
+	struct service *srvc = NULL;
+	struct element_id match_id;
+	struct gatt_device *dev;
+	int32_t conn_id = 0;
+	uint8_t status;
+
 	DBG("");
 
+	if (len != sizeof(*cmd) + cmd->len * sizeof(cmd->value[0])) {
+		error("gatt: Write descr. msg size invalid (%d bytes)", len);
+
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	hal_srvc_id_to_element_id(&cmd->srvc_id, &match_id);
+	if (!find_service(cmd->conn_id, &match_id, &dev, &srvc)) {
+		error("gatt: Read descr. could not find service");
+		goto failed;
+	}
+
+	conn_id = dev->conn_id;
+
+	hal_gatt_id_to_element_id(&cmd->char_id, &match_id);
+	ch = queue_find(srvc->chars, match_char_by_element_id, &match_id);
+	if (!ch) {
+		error("gatt: Read descr. could not find characteristic");
+		goto failed;
+	}
+
+	hal_gatt_id_to_element_id(&cmd->descr_id, &match_id);
+	descr = queue_find(ch->descriptors, match_descr_by_element_id,
+								&match_id);
+	if (!descr) {
+		error("gatt: Read descr. could not find descriptor");
+		goto failed;
+	}
+
+	cb_data = new0(struct write_descr_data, 1);
+	if (!cb_data) {
+		error("gatt: Read descr. could not allocate callback data");
+
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	cb_data->service = srvc;
+	cb_data->conn_id = conn_id;
+	cb_data->descriptor = descr;
+	cb_data->characteristic = ch;
+	cb_data->write_type = cmd->write_type;
+
+	if (gatt_write_char(dev->attrib, descr->handle, cmd->value,
+					cmd->len * sizeof(cmd->value[0]),
+					write_descr_cb, cb_data)) {
+		status = HAL_STATUS_SUCCESS;
+		goto done;
+	}
+
+	free(cb_data);
+
+failed:
+	send_client_descr_write_notify(GATT_FAILURE, conn_id, descr, srvc, ch);
+	status = HAL_STATUS_SUCCESS;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_CLIENT_WRITE_DESCRIPTOR, HAL_STATUS_FAILED);
+				HAL_OP_GATT_CLIENT_WRITE_DESCRIPTOR, status);
 }
 
 static void handle_client_execute_write(const void *buf, uint16_t len)
-- 
1.9.0

