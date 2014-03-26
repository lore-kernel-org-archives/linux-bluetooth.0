Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/12] android/avrcp-lib: Add support for parsing RegisterNotification response
Date: Wed, 26 Mar 2014 16:13:52 +0200
Message-Id: <1395843232-26750-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395843232-26750-1-git-send-email-luiz.dentz@gmail.com>
References: <1395843232-26750-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 android/avrcp-lib.h |  6 ++--
 android/avrcp.c     | 39 ++++++++++------------
 unit/test-avrcp.c   |  3 +-
 4 files changed, 114 insertions(+), 28 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 33717e0..dc3fb34 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -801,6 +801,7 @@ done:
 	return FALSE;
 }
 
+
 int avrcp_get_capabilities(struct avrcp *session, uint8_t param)
 {
 	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
@@ -808,10 +809,97 @@ int avrcp_get_capabilities(struct avrcp *session, uint8_t param)
 				get_capabilities_rsp, session);
 }
 
-int avrcp_register_notification(struct avrcp *session, uint8_t event,
-					uint32_t interval, avctp_rsp_cb func,
+static gboolean register_notification_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
 					void *user_data)
 {
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct avrcp_header *pdu;
+	uint8_t event = 0;
+	uint16_t value16;
+	uint32_t value32;
+	uint64_t value64;
+	uint8_t *params = NULL;
+	int err;
+
+	DBG("");
+
+	if (!player || !player->cfm || !player->cfm->register_notification)
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
+	event = pdu->params[0];
+
+	switch (event) {
+	case AVRCP_EVENT_STATUS_CHANGED:
+	case AVRCP_EVENT_VOLUME_CHANGED:
+		if (pdu->params_len != 2) {
+			err = -EPROTO;
+			goto done;
+		}
+		params = &pdu->params[1];
+		break;
+	case AVRCP_EVENT_TRACK_CHANGED:
+		if (pdu->params_len != 9) {
+			err = -EPROTO;
+			goto done;
+		}
+		value64 = bt_get_be64(&pdu->params[1]);
+		params = (uint8_t *) &value64;
+		break;
+	case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
+		if (pdu->params_len != 5) {
+			err = -EPROTO;
+			goto done;
+		}
+		value32 = bt_get_be32(&pdu->params[1]);
+		params = (uint8_t *) &value32;
+		break;
+	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
+	case AVRCP_EVENT_SETTINGS_CHANGED:
+		if (pdu->params_len < 2) {
+			err = -EPROTO;
+			goto done;
+		}
+		params = &pdu->params[1];
+		break;
+	case AVRCP_EVENT_UIDS_CHANGED:
+		if (pdu->params_len != 3) {
+			err = -EPROTO;
+			goto done;
+		}
+		value16 = bt_get_be16(&pdu->params[1]);
+		params = (uint8_t *) &value16;
+		break;
+	}
+
+	err = 0;
+
+done:
+	return player->cfm->register_notification(session, err, code, event,
+						params, player->user_data);
+}
+
+int avrcp_register_notification(struct avrcp *session, uint8_t event,
+							uint32_t interval)
+{
 	uint8_t params[5];
 
 	params[0] = event;
@@ -820,7 +908,7 @@ int avrcp_register_notification(struct avrcp *session, uint8_t event,
 	return avrcp_send_req(session, AVC_CTYPE_NOTIFY, AVC_SUBUNIT_PANEL,
 					AVRCP_REGISTER_NOTIFICATION,
 					params, sizeof(params),
-					func, user_data);
+					register_notification_rsp, session);
 }
 
 static gboolean list_attributes_rsp(struct avctp *conn,
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 2f35e90..0b867aa 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -191,6 +191,9 @@ struct avrcp_control_cfm {
 	void (*get_element_attributes) (struct avrcp *session, int err,
 					uint8_t number, uint32_t *attrs,
 					char **text, void *user_data);
+	bool (*register_notification) (struct avrcp *session, int err,
+					uint8_t code, uint8_t event,
+					uint8_t *params, void *user_data);
 };
 
 struct avrcp_passthrough_handler {
@@ -219,8 +222,7 @@ int avrcp_send(struct avrcp *session, uint8_t transaction, uint8_t code,
 					uint8_t *params, size_t params_len);
 int avrcp_get_capabilities(struct avrcp *session, uint8_t param);
 int avrcp_register_notification(struct avrcp *session, uint8_t event,
-					uint32_t interval, avctp_rsp_cb func,
-					void *user_data);
+							uint32_t interval);
 int avrcp_list_player_attributes(struct avrcp *session);
 int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t number,
 							uint8_t *attrs);
diff --git a/android/avrcp.c b/android/avrcp.c
index 0995a06..add069b 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -724,39 +724,37 @@ static const struct avrcp_control_ind control_ind = {
 	.register_notification = handle_register_notification_cmd,
 };
 
-static gboolean register_notification_rsp(struct avctp *conn,
-					uint8_t code, uint8_t subunit,
-					uint8_t *operands, size_t operand_count,
-					void *user_data)
+static bool handle_register_notification_rsp(struct avrcp *session, int err,
+						uint8_t code, uint8_t event,
+						uint8_t *params,
+						void *user_data)
 {
 	struct avrcp_device *dev = user_data;
 	struct hal_ev_avrcp_volume_changed ev;
-	uint8_t *params;
 
-	if (code != AVC_CTYPE_INTERIM && code != AVC_CTYPE_CHANGED)
-		return FALSE;
-
-	if (operands == NULL || operand_count < 7)
-		return FALSE;
+	if (err < 0) {
+		error("AVRCP: %s", strerror(-err));
+		return false;
+	}
 
-	params = &operands[7];
+	if (code != AVC_CTYPE_INTERIM && code != AVC_CTYPE_CHANGED)
+		return false;
 
-	if (params == NULL || params[0] != AVRCP_EVENT_VOLUME_CHANGED)
-		return FALSE;
+	if (event != AVRCP_EVENT_VOLUME_CHANGED)
+		return false;
 
 	ev.type = code;
-	ev.volume = params[1] & 0x7F;
+	ev.volume = params[0] & 0x7f;
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
 					HAL_EV_AVRCP_VOLUME_CHANGED,
 					sizeof(ev), &ev);
 
 	if (code == AVC_CTYPE_INTERIM)
-		return TRUE;
+		return true;
 
-	avrcp_register_notification(dev->session, params[0], 0,
-					register_notification_rsp, dev);
-	return FALSE;
+	avrcp_register_notification(dev->session, event, 0);
+	return false;
 }
 
 static void handle_get_capabilities_rsp(struct avrcp *session, int err,
@@ -775,9 +773,7 @@ static void handle_get_capabilities_rsp(struct avrcp *session, int err,
 		if (events[i] != AVRCP_EVENT_VOLUME_CHANGED)
 			continue;
 
-		avrcp_register_notification(dev->session, events[i], 0,
-						register_notification_rsp,
-						dev);
+		avrcp_register_notification(dev->session, events[i], 0);
 		break;
 	}
 
@@ -786,6 +782,7 @@ static void handle_get_capabilities_rsp(struct avrcp *session, int err,
 
 static const struct avrcp_control_cfm control_cfm = {
 	.get_capabilities = handle_get_capabilities_rsp,
+	.register_notification = handle_register_notification_rsp,
 };
 
 static int avrcp_device_add_session(struct avrcp_device *dev, int fd,
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index a0b009a..5b259bd 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -524,8 +524,7 @@ static void test_client(gconstpointer data)
 
 	if (g_str_equal(context->data->test_name, "/TP/NFY/BV-01-C"))
 		avrcp_register_notification(context->session,
-						AVRCP_EVENT_STATUS_CHANGED, 0,
-						NULL, NULL);
+						AVRCP_EVENT_STATUS_CHANGED, 0);
 
 	if (g_str_equal(context->data->test_name, "/TP/BGN/BV-01-I"))
 		avrcp_send_passthrough(context->session, IEEEID_BTSIG,
-- 
1.8.5.3

