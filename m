Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 10/12] android/avrcp-lib: Add support for parsing GetPlayStatus response
Date: Sun, 30 Mar 2014 22:33:36 +0300
Message-Id: <1396208018-23453-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1396208018-23453-1-git-send-email-luiz.dentz@gmail.com>
References: <1396208018-23453-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++----
 android/avrcp-lib.h |  6 ++++--
 unit/test-avrcp.c   |  2 +-
 3 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 3c224a5..c5b54d5 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -1210,12 +1210,57 @@ int avrcp_set_player_value(struct avrcp *session, uint8_t number,
 				set_value_rsp, session);
 }
 
-int avrcp_get_play_status(struct avrcp *session, avctp_rsp_cb func,
-								void *user_data)
+static gboolean get_play_status_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct avrcp_header *pdu;
+	uint8_t status = 0;
+	uint32_t position = 0;
+	uint32_t duration = 0;
+	int err;
+
+	DBG("");
+
+	if (!player || !player->cfm || !player->cfm->get_play_status)
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
+	if (pdu->params_len < 5) {
+		err = -EPROTO;
+		goto done;
+	}
+
+	duration = bt_get_be32(&pdu->params[0]);
+	position = bt_get_be32(&pdu->params[4]);
+	status = pdu->params[8];
+	err = 0;
+
+done:
+	player->cfm->get_play_status(session, err, status, position, duration,
+							player->user_data);
+
+	return FALSE;
+}
+
+int avrcp_get_play_status(struct avrcp *session)
 {
 	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
-				AVRCP_GET_PLAY_STATUS, NULL, 0, func,
-				user_data);
+				AVRCP_GET_PLAY_STATUS, NULL, 0,
+				get_play_status_rsp, session);
 }
 
 int avrcp_set_volume(struct avrcp *session, uint8_t volume, avctp_rsp_cb func,
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 2a65f16..f5666eb 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -185,6 +185,9 @@ struct avrcp_control_cfm {
 	void (*set_value) (struct avrcp *session, int err,
 					uint8_t number, uint8_t *attrs,
 					uint8_t *values, void *user_data);
+	void (*get_play_status) (struct avrcp *session, int err,
+					uint8_t status, uint32_t position,
+					uint32_t duration, void *user_data);
 };
 
 struct avrcp_passthrough_handler {
@@ -225,8 +228,7 @@ int avrcp_set_player_value(struct avrcp *session, uint8_t number,
 					uint8_t *attrs, uint8_t *values);
 int avrcp_get_current_player_value(struct avrcp *session, uint8_t number,
 							uint8_t *attrs);
-int avrcp_get_play_status(struct avrcp *session, avctp_rsp_cb func,
-							void *user_data);
+int avrcp_get_play_status(struct avrcp *session);
 int avrcp_set_volume(struct avrcp *session, uint8_t volume, avctp_rsp_cb func,
 							void *user_data);
 int avrcp_get_element_attributes(struct avrcp *session, avctp_rsp_cb func,
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 8f74e9c..ad15bb9 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -517,7 +517,7 @@ static void test_client(gconstpointer data)
 	}
 
 	if (g_str_equal(context->data->test_name, "/TP/MDI/BV-01-C"))
-		avrcp_get_play_status(context->session, NULL, NULL);
+		avrcp_get_play_status(context->session);
 
 	if (g_str_equal(context->data->test_name, "/TP/MDI/BV-03-C"))
 		avrcp_get_element_attributes(context->session, NULL, NULL);
-- 
1.8.5.3

