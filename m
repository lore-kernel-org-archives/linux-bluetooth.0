Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 7/9] android/gatt: Add client read descriptor handler
Date: Fri, 28 Mar 2014 19:54:43 +0100
Message-Id: <1396032885-32077-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1396032885-32077-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1396032885-32077-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 135 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 1fe7035..0a4159e 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -49,6 +49,8 @@
 #include "attrib/gatt.h"
 #include "btio/btio.h"
 
+#define GATT_MAX_ATTR_LEN 600
+
 #define GATT_SUCCESS	0x00000000
 #define GATT_FAILURE	0x00000101
 
@@ -237,6 +239,17 @@ static bool match_char_by_higher_inst_id(const void *data,
 	return inst_id < ch->id.instance;
 }
 
+static bool match_descr_by_element_id(const void *data, const void *user_data)
+{
+	const struct element_id *exp_id = user_data;
+	const struct descriptor *descr = data;
+
+	if (exp_id->instance == descr->id.instance)
+		return !bt_uuid_cmp(&descr->id.uuid, &exp_id->uuid);
+
+	return false;
+}
+
 static bool match_descr_by_higher_inst_id(const void *data,
 							const void *user_data)
 {
@@ -1861,12 +1874,133 @@ done:
 			HAL_OP_GATT_CLIENT_WRITE_CHARACTERISTIC, status);
 }
 
+static void send_client_descr_read_notify(int32_t status, const uint8_t *pdu,
+						guint16 len, int32_t conn_id,
+						const struct descriptor *descr,
+						const struct service *srvc,
+						const struct characteristic *ch)
+{
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_gatt_client_read_descriptor *ev = (void *) buf;
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
+	if (pdu)
+		ev->data.len = dec_read_resp(pdu, len, ev->data.value,
+							GATT_MAX_ATTR_LEN);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_EV_GATT_CLIENT_READ_DESCRIPTOR,
+					sizeof(*ev) + ev->data.len, ev);
+}
+
+struct read_desc_data {
+	int32_t conn_id;
+	struct service *service;
+	struct characteristic *characteristic;
+	struct descriptor *descriptor;
+};
+
+static void read_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct read_desc_data *cb_data = user_data;
+
+	if (status != 0)
+		error("gatt: Discover all char descriptors failed: %s\n",
+							att_ecode2str(status));
+
+	send_client_descr_read_notify(status, pdu, len, cb_data->conn_id,
+					cb_data->descriptor, cb_data->service,
+					cb_data->characteristic);
+
+	free(cb_data);
+}
+
 static void handle_client_read_descriptor(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_read_descriptor *cmd = buf;
+	struct characteristic *ch = NULL;
+	struct descriptor *descr = NULL;
+	struct read_desc_data *cb_data;
+	struct service *srvc = NULL;
+	struct element_id match_id;
+	struct gatt_device *dev;
+	int32_t conn_id = 0;
+	uint8_t status;
+
 	DBG("");
 
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
+	cb_data = new0(struct read_desc_data, 1);
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
+
+	/* TODO: handle cmd->auth_req flag */
+	if (gatt_read_char(dev->attrib, descr->handle, read_desc_cb, cb_data)) {
+		status = HAL_STATUS_SUCCESS;
+		goto done;
+	}
+
+	free(cb_data);
+
+failed:
+	send_client_descr_read_notify(GATT_FAILURE, NULL, 0, conn_id, descr,
+								srvc, ch);
+	status = HAL_STATUS_SUCCESS;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_CLIENT_READ_DESCRIPTOR, HAL_STATUS_FAILED);
+			HAL_OP_GATT_CLIENT_READ_DESCRIPTOR, status);
 }
 
 static void handle_client_write_descriptor(const void *buf, uint16_t len)
-- 
1.9.0

