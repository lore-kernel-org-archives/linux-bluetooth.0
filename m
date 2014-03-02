Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 13/16] android/avrcp: Add handler for RegisterNotification command
Date: Sun,  2 Mar 2014 20:48:28 +0200
Message-Id: <1393786109-6554-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
References: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/android/avrcp.c b/android/avrcp.c
index 6ef8d0a..875c6e2 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -252,10 +252,58 @@ static void handle_set_player_attrs_value(const void *buf, uint16_t len)
 
 static void handle_register_notification(const void *buf, uint16_t len)
 {
+	struct hal_cmd_avrcp_register_notification *cmd = (void *) buf;
+	uint8_t status;
+	struct avrcp_request *req;
+	uint8_t pdu[IPC_MTU];
+	size_t pdu_len = 1;
+	int ret;
+
 	DBG("");
 
+	req = pop_request(AVRCP_REGISTER_NOTIFICATION);
+	if (!req) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	pdu[0] = cmd->event;
+
+	switch (cmd->event) {
+	case AVRCP_EVENT_STATUS_CHANGED:
+	case AVRCP_EVENT_TRACK_CHANGED:
+	case AVRCP_EVENT_TRACK_REACHED_END:
+	case AVRCP_EVENT_TRACK_REACHED_START:
+	case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
+		if (cmd->len > 0) {
+			memcpy(&pdu[1], cmd->data, cmd->len);
+			pdu_len += cmd->len;
+		}
+		break;
+	case AVRCP_EVENT_SETTINGS_CHANGED:
+		pdu[1] = cmd->len / sizeof(struct hal_avrcp_player_attr_value);
+		memcpy(&pdu[2], cmd->data, cmd->len);
+		break;
+	default:
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	ret = avrcp_send(req->dev->session, req->transaction, cmd->type,
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
-			HAL_OP_AVRCP_REGISTER_NOTIFICATION, HAL_STATUS_FAILED);
+			HAL_OP_AVRCP_REGISTER_NOTIFICATION, status);
 }
 
 static void handle_set_volume(const void *buf, uint16_t len)
@@ -568,6 +616,37 @@ static ssize_t handle_get_element_attrs_cmd(struct avrcp *session,
 
 }
 
+static ssize_t handle_register_notification_cmd(struct avrcp *session,
+						uint8_t transaction,
+						uint16_t params_len,
+						uint8_t *params,
+						void *user_data)
+{
+	struct avrcp_device *dev = user_data;
+	struct avrcp_request *req;
+	struct hal_ev_avrcp_register_notification ev;
+
+	if (params_len != 5)
+		return -EINVAL;
+
+	req = g_new0(struct avrcp_request, 1);
+	req->dev = dev;
+	req->pdu_id = AVRCP_REGISTER_NOTIFICATION;
+	req->transaction = transaction;
+
+	g_queue_push_tail(dev->queue, req);
+
+	ev.event = params[0];
+	ev.param = bt_get_be32(&params[1]);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
+					HAL_EV_AVRCP_REGISTER_NOTIFICATION,
+					sizeof(ev), &ev);
+
+	return -EAGAIN;
+
+}
+
 static const struct avrcp_control_handler control_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
@@ -578,6 +657,9 @@ static const struct avrcp_control_handler control_handlers[] = {
 		{ AVRCP_GET_ELEMENT_ATTRIBUTES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
 					handle_get_element_attrs_cmd },
+		{ AVRCP_REGISTER_NOTIFICATION,
+					AVC_CTYPE_NOTIFY, AVC_CTYPE_INTERIM,
+					handle_register_notification_cmd },
 		{ },
 };
 
-- 
1.8.5.3

