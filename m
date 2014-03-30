Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 02/12] android/avrcp-lib: Add support for parsing ListPlayerAttributes response
Date: Sun, 30 Mar 2014 22:33:28 +0300
Message-Id: <1396208018-23453-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1396208018-23453-1-git-send-email-luiz.dentz@gmail.com>
References: <1396208018-23453-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
 android/avrcp-lib.h |  6 ++++--
 unit/test-avrcp.c   |  2 +-
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 90ada8a..15ef1a2 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -823,12 +823,52 @@ int avrcp_register_notification(struct avrcp *session, uint8_t event,
 					func, user_data);
 }
 
-int avrcp_list_player_attributes(struct avrcp *session, avctp_rsp_cb func,
-								void *user_data)
+static gboolean list_attributes_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct avrcp_header *pdu = (void *) operands;
+	uint8_t number = 0;
+	uint8_t *attrs = NULL;
+	int err;
+
+	DBG("");
+
+	if (!player || !player->cfm || !player->cfm->list_attributes)
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
+	number = pdu->params[0];
+	if (number > 0)
+		attrs = &pdu->params[1];
+
+	err = 0;
+
+done:
+	player->cfm->list_attributes(session, err, number, attrs,
+							player->user_data);
+
+	return FALSE;
+}
+
+int avrcp_list_player_attributes(struct avrcp *session)
 {
 	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
 				AVRCP_LIST_PLAYER_ATTRIBUTES, NULL, 0,
-				func, user_data);
+				list_attributes_rsp, session);
 }
 
 int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t *attributes,
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index ab110cb..87397a3 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -167,6 +167,9 @@ struct avrcp_control_cfm {
 	void (*get_capabilities) (struct avrcp *session, int err,
 					uint8_t number, uint8_t *params,
 					void *user_data);
+	void (*list_attributes) (struct avrcp *session, int err,
+					uint8_t number, uint8_t *attrs,
+					void *user_data);
 };
 
 struct avrcp_passthrough_handler {
@@ -197,8 +200,7 @@ int avrcp_get_capabilities(struct avrcp *session, uint8_t param);
 int avrcp_register_notification(struct avrcp *session, uint8_t event,
 					uint32_t interval, avctp_rsp_cb func,
 					void *user_data);
-int avrcp_list_player_attributes(struct avrcp *session, avctp_rsp_cb func,
-							void *user_data);
+int avrcp_list_player_attributes(struct avrcp *session);
 int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t *attributes,
 					uint8_t attr_len, avctp_rsp_cb func,
 					void *user_data);
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index d6be6a6..88e457d 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -494,7 +494,7 @@ static void test_client(gconstpointer data)
 		avrcp_get_capabilities(context->session, CAP_EVENTS_SUPPORTED);
 
 	if (g_str_equal(context->data->test_name, "/TP/PAS/BV-01-C"))
-		avrcp_list_player_attributes(context->session, NULL, NULL);
+		avrcp_list_player_attributes(context->session);
 
 	if (g_str_equal(context->data->test_name, "/TP/PAS/BV-03-C"))
 		avrcp_get_player_attribute_text(context->session, NULL, 0,
-- 
1.8.5.3

