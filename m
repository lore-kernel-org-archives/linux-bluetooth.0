Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] android/avrcp-lib: Add support for parsing SetAbsoluteVolume response
Date: Thu,  3 Apr 2014 18:16:39 +0300
Message-Id: <1396538201-14283-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 46 ++++++++++++++++++++++++++++++++++++++++++---
 android/avrcp-lib.h |  5 +++--
 android/avrcp.c     | 54 ++++++++++++++++++++++-------------------------------
 3 files changed, 68 insertions(+), 37 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index ef46953..d6459ce 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -1426,13 +1426,53 @@ int avrcp_get_play_status(struct avrcp *session)
 				get_play_status_rsp, session);
 }
 
-int avrcp_set_volume(struct avrcp *session, uint8_t volume, avctp_rsp_cb func,
-							void *user_data)
+static gboolean set_volume_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct avrcp_header *pdu;
+	uint8_t value = 0;
+	int err;
+
+	DBG("");
+
+	if (!player || !player->cfm || !player->cfm->set_volume)
+		return FALSE;
+
+	pdu = parse_pdu(operands, operand_count);
+	if (!pdu) {
+		err = -EPROTO;
+		goto done;
+	}
+
+	if (code == AVC_CTYPE_REJECTED) {
+		err = parse_status(pdu);
+		goto done;
+	}
+
+	if (pdu->params_len < 1) {
+		err = -EPROTO;
+		goto done;
+	}
+
+	value = pdu->params[0] & 0x7f;
+	err = 0;
+
+done:
+	player->cfm->set_volume(session, err, value, player->user_data);
+
+	return FALSE;
+}
+
+int avrcp_set_volume(struct avrcp *session, uint8_t volume)
 {
 	return avrcp_send_req(session, AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
 						AVRCP_SET_ABSOLUTE_VOLUME,
 						&volume, sizeof(volume),
-						func, user_data);
+						set_volume_rsp, session);
 }
 
 static int parse_attribute_list(uint8_t *params, uint16_t params_len,
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 1e1be63..3364e01 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -197,6 +197,8 @@ struct avrcp_control_cfm {
 	bool (*register_notification) (struct avrcp *session, int err,
 					uint8_t code, uint8_t event,
 					uint8_t *params, void *user_data);
+	void (*set_volume) (struct avrcp *session, int err, uint8_t volume,
+					void *user_data);
 	void (*set_addressed) (struct avrcp *session, int err,
 					void *user_data);
 	void (*set_browsed) (struct avrcp *session, int err,
@@ -254,8 +256,7 @@ int avrcp_set_player_value(struct avrcp *session, uint8_t number,
 int avrcp_get_current_player_value(struct avrcp *session, uint8_t number,
 							uint8_t *attrs);
 int avrcp_get_play_status(struct avrcp *session);
-int avrcp_set_volume(struct avrcp *session, uint8_t volume, avctp_rsp_cb func,
-							void *user_data);
+int avrcp_set_volume(struct avrcp *session, uint8_t volume);
 int avrcp_get_element_attributes(struct avrcp *session);
 int avrcp_set_addressed_player(struct avrcp *session, uint16_t player_id);
 int avrcp_set_browsed_player(struct avrcp *session, uint16_t player_id);
diff --git a/android/avrcp.c b/android/avrcp.c
index add069b..89340f7 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -331,36 +331,6 @@ done:
 			HAL_OP_AVRCP_REGISTER_NOTIFICATION, status);
 }
 
-static gboolean set_volume_rsp(struct avctp *conn,
-					uint8_t code, uint8_t subunit,
-					uint8_t *operands, size_t operand_count,
-					void *user_data)
-{
-	struct hal_ev_avrcp_volume_changed ev;
-	uint8_t *params;
-
-	if (code != AVC_CTYPE_ACCEPTED) {
-		ev.volume = 0;
-		ev.type = code;
-		goto done;
-	}
-
-	if (operands == NULL || operand_count < 7)
-		return FALSE;
-
-	params = &operands[7];
-
-	ev.volume = params[0] & 0x7F;
-	ev.type = code;
-
-done:
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
-					HAL_EV_AVRCP_VOLUME_CHANGED,
-					sizeof(ev), &ev);
-
-	return FALSE;
-}
-
 static void handle_set_volume(const void *buf, uint16_t len)
 {
 	struct hal_cmd_avrcp_set_volume *cmd = (void *) buf;
@@ -381,8 +351,7 @@ static void handle_set_volume(const void *buf, uint16_t len)
 	 */
 	dev = devices->data;
 
-	ret = avrcp_set_volume(dev->session, cmd->value & 0x7f, set_volume_rsp,
-									dev);
+	ret = avrcp_set_volume(dev->session, cmd->value & 0x7f);
 	if (ret < 0) {
 		status = HAL_STATUS_FAILED;
 		goto done;
@@ -780,9 +749,30 @@ static void handle_get_capabilities_rsp(struct avrcp *session, int err,
 	return;
 }
 
+static void handle_set_volume_rsp(struct avrcp *session, int err,
+						uint8_t value, void *user_data)
+{
+	struct hal_ev_avrcp_volume_changed ev;
+
+	if (err < 0) {
+		ev.volume = 0;
+		ev.type = AVC_CTYPE_REJECTED;
+		goto done;
+	}
+
+	ev.volume = value;
+	ev.type = AVC_CTYPE_ACCEPTED;
+
+done:
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
+					HAL_EV_AVRCP_VOLUME_CHANGED,
+					sizeof(ev), &ev);
+}
+
 static const struct avrcp_control_cfm control_cfm = {
 	.get_capabilities = handle_get_capabilities_rsp,
 	.register_notification = handle_register_notification_rsp,
+	.set_volume = handle_set_volume_rsp,
 };
 
 static int avrcp_device_add_session(struct avrcp_device *dev, int fd,
-- 
1.9.0

