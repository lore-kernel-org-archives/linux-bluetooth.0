Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/16] android/avrcp: Add handler for GetElementAttributes command
Date: Sun,  2 Mar 2014 20:48:27 +0200
Message-Id: <1393786109-6554-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
References: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/android/avrcp.c b/android/avrcp.c
index 3ac8223..6ef8d0a 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -167,12 +167,79 @@ static void handle_get_player_values_text(const void *buf, uint16_t len)
 			HAL_OP_AVRCP_GET_PLAYER_VALUES_TEXT, HAL_STATUS_FAILED);
 }
 
+static void write_element_text(uint8_t id, uint8_t text_len, uint8_t *text,
+						uint8_t *pdu, size_t *len)
+{
+	uint16_t charset = 106;
+
+	bt_put_be32(id, pdu);
+	pdu += 4;
+	*len += 4;
+
+	bt_put_be16(charset, pdu);
+	pdu += 2;
+	*len += 2;
+
+	bt_put_be16(text_len, pdu);
+	pdu += 2;
+	*len += 2;
+
+	memcpy(pdu, text, text_len);
+	*len += text_len;
+}
+
+static void write_element_attrs(uint8_t *ptr, uint8_t number, uint8_t *pdu,
+								size_t *len)
+{
+	int i;
+
+	for (i = 0; i < number; i++) {
+		struct hal_avrcp_player_setting_text *text = (void *) ptr;
+
+		write_element_text(text->id, text->len, text->text, pdu, len);
+
+		ptr += sizeof(*text) + text->len;
+		pdu += *len;
+	}
+}
+
 static void handle_get_element_attrs_text(const void *buf, uint16_t len)
 {
+	struct hal_cmd_avrcp_get_element_attrs_text *cmd = (void *) buf;
+	uint8_t status;
+	struct avrcp_request *req;
+	uint8_t pdu[IPC_MTU];
+	uint8_t *ptr;
+	size_t pdu_len;
+	int ret;
+
 	DBG("");
 
+	req = pop_request(AVRCP_GET_ELEMENT_ATTRIBUTES);
+	if (!req) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	ptr = (uint8_t *) &cmd->values[0];
+	pdu_len = 0;
+	write_element_attrs(ptr, cmd->number, pdu, &pdu_len);
+
+	ret = avrcp_send(req->dev->session, req->transaction, AVC_CTYPE_STABLE,
+					AVC_SUBUNIT_PANEL, req->pdu_id,
+					pdu, pdu_len);
+	if (ret < 0) {
+		status = HAL_STATUS_FAILED;
+		g_free(req);
+		goto done;
+	}
+
+	status = HAL_STATUS_SUCCESS;
+	g_free(req);
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_AVRCP,
-			HAL_OP_AVRCP_GET_ELEMENT_ATTRS_TEXT, HAL_STATUS_FAILED);
+			HAL_OP_AVRCP_GET_ELEMENT_ATTRS_TEXT, status);
 }
 
 static void handle_set_player_attrs_value(const void *buf, uint16_t len)
@@ -460,6 +527,47 @@ static ssize_t handle_get_play_status_cmd(struct avrcp *session,
 	return -EAGAIN;
 }
 
+static ssize_t handle_get_element_attrs_cmd(struct avrcp *session,
+						uint8_t transaction,
+						uint16_t params_len,
+						uint8_t *params,
+						void *user_data)
+{
+	struct avrcp_device *dev = user_data;
+	struct avrcp_request *req;
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_avrcp_get_element_attrs *ev = (void *) buf;
+	int i;
+
+	if (params_len < 9)
+		return -EINVAL;
+
+	ev->number = params[8];
+
+	if (params_len < ev->number * sizeof(uint32_t) + 1)
+		return -EINVAL;
+
+	params += 9;
+	for (i = 0; i < ev->number; i++) {
+		ev->attrs[i] = bt_get_be32(params);
+		params += 4;
+	}
+
+	req = g_new0(struct avrcp_request, 1);
+	req->dev = dev;
+	req->pdu_id = AVRCP_GET_ELEMENT_ATTRIBUTES;
+	req->transaction = transaction;
+
+	g_queue_push_tail(dev->queue, req);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
+					HAL_EV_AVRCP_GET_ELEMENT_ATTRS,
+					sizeof(*ev) + ev->number, ev);
+
+	return -EAGAIN;
+
+}
+
 static const struct avrcp_control_handler control_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
@@ -467,6 +575,9 @@ static const struct avrcp_control_handler control_handlers[] = {
 		{ AVRCP_GET_PLAY_STATUS,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
 					handle_get_play_status_cmd },
+		{ AVRCP_GET_ELEMENT_ATTRIBUTES,
+					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
+					handle_get_element_attrs_cmd },
 		{ },
 };
 
-- 
1.8.5.3

