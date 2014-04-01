Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 4/5] android/gatt: Add client read descriptor handler
Date: Tue,  1 Apr 2014 17:19:26 +0200
Message-Id: <1396365567-17339-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1396365567-17339-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1396365567-17339-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds descriptor reading. In case of providing wrong
descriptor, error status is being sent with notification.
---
 android/gatt.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 2039920..6c3ecf0 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -49,6 +49,9 @@
 #include "attrib/gatt.h"
 #include "btio/btio.h"
 
+/* set according to android's bt_gatt_client.h */
+#define GATT_MAX_ATTR_LEN 600
+
 #define GATT_SUCCESS	0x00000000
 #define GATT_FAILURE	0x00000101
 
@@ -287,6 +290,17 @@ static bool match_char_by_higher_inst_id(const void *data,
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
@@ -1885,12 +1899,138 @@ failed:
 						cmd->srvc_id.is_primary);
 }
 
+static void send_client_descr_read_notify(int32_t status, const uint8_t *pdu,
+						guint16 len, int32_t conn_id,
+						const struct element_id *srvc,
+						const struct element_id *ch,
+						const struct element_id *descr,
+						uint8_t primary)
+{
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_gatt_client_read_descriptor *ev = (void *) buf;
+
+	memset(buf, 0, sizeof(buf));
+
+	ev->status = status;
+	ev->conn_id = conn_id;
+
+	element_id_to_hal_srvc_id(srvc, primary, &ev->data.srvc_id);
+	element_id_to_hal_gatt_id(ch, &ev->data.char_id);
+	element_id_to_hal_gatt_id(descr, &ev->data.descr_id);
+
+	if (len && pdu)
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
+	const struct element_id *srvc_id;
+	const struct element_id *char_id;
+	const struct element_id *descr_id;
+	uint8_t primary;
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
+					cb_data->srvc_id, cb_data->char_id,
+					cb_data->descr_id, cb_data->primary);
+
+	free(cb_data);
+}
+
 static void handle_client_read_descriptor(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_read_descriptor *cmd = buf;
+	struct read_desc_data *cb_data;
+	struct characteristic *ch;
+	struct descriptor *descr;
+	struct service *srvc;
+	struct element_id char_id;
+	struct element_id descr_id;
+	struct element_id srvc_id;
+	struct gatt_device *dev;
+	int32_t conn_id = 0;
+	uint8_t primary;
+	uint8_t status;
+
 	DBG("");
 
+	conn_id = cmd->conn_id;
+	primary = cmd->srvc_id.is_primary;
+
+	hal_srvc_id_to_element_id(&cmd->srvc_id, &srvc_id);
+	hal_gatt_id_to_element_id(&cmd->char_id, &char_id);
+	hal_gatt_id_to_element_id(&cmd->descr_id, &descr_id);
+
+	if (!find_service(conn_id, &srvc_id, &dev, &srvc)) {
+		error("gatt: Read descr. could not find service");
+
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	ch = queue_find(srvc->chars, match_char_by_element_id, &char_id);
+	if (!ch) {
+		error("gatt: Read descr. could not find characteristic");
+
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	descr = queue_find(ch->descriptors, match_descr_by_element_id,
+								&descr_id);
+	if (!descr) {
+		error("gatt: Read descr. could not find descriptor");
+
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	cb_data = new0(struct read_desc_data, 1);
+	if (!cb_data) {
+		error("gatt: Read descr. could not allocate callback data");
+
+		status = HAL_STATUS_NOMEM;
+		goto failed;
+	}
+
+	cb_data->conn_id = conn_id;
+	cb_data->srvc_id = &srvc->id;
+	cb_data->char_id = &ch->id;
+	cb_data->descr_id = &descr->id;
+	cb_data->primary = primary;
+
+	if (!gatt_read_char(dev->attrib, descr->handle, read_desc_cb,
+								cb_data)) {
+		free(cb_data);
+
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
+	if (status != HAL_STATUS_SUCCESS)
+		send_client_descr_read_notify(GATT_FAILURE, NULL, 0, conn_id,
+						&srvc_id, &char_id, &descr_id,
+						primary);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_CLIENT_READ_DESCRIPTOR, HAL_STATUS_FAILED);
+			HAL_OP_GATT_CLIENT_READ_DESCRIPTOR, status);
 }
 
 static void handle_client_write_descriptor(const void *buf, uint16_t len)
-- 
1.9.0

