Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 09/12] android/avrcp-lib: Add support for parsing SetPlayerValue response
Date: Sun, 30 Mar 2014 22:33:35 +0300
Message-Id: <1396208018-23453-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1396208018-23453-1-git-send-email-luiz.dentz@gmail.com>
References: <1396208018-23453-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 59 +++++++++++++++++++++++++++++++++++++++++++----------
 android/avrcp-lib.h |  8 +++++---
 unit/test-avrcp.c   |  9 ++++----
 3 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index c2b376a..3c224a5 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -1151,26 +1151,63 @@ int avrcp_get_current_player_value(struct avrcp *session, uint8_t number,
 				number + 1, get_value_rsp, session);
 }
 
-int avrcp_set_player_value(struct avrcp *session, uint8_t *attributes,
-					uint8_t attr_count, uint8_t *values,
-					avctp_rsp_cb func, void *user_data)
+static gboolean set_value_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
 {
-	uint8_t buf[2 * AVRCP_ATTRIBUTE_LAST + 1];
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct avrcp_header *pdu;
+	uint8_t number = 0;
+	uint8_t attrs[AVRCP_ATTRIBUTE_LAST];
+	uint8_t values[AVRCP_ATTRIBUTE_LAST];
+	int err;
+
+	DBG("");
+
+	if (!player || !player->cfm || !player->cfm->set_value)
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
+	err = parse_value(pdu, &number, attrs, values);
+
+done:
+	player->cfm->set_value(session, err, number, attrs, values,
+							player->user_data);
+
+	return FALSE;
+}
+
+int avrcp_set_player_value(struct avrcp *session, uint8_t number,
+					uint8_t *attrs, uint8_t *values)
+{
+	uint8_t pdu[2 * AVRCP_ATTRIBUTE_LAST + 1];
 	int i;
 
-	if (attr_count > AVRCP_ATTRIBUTE_LAST)
+	if (number > AVRCP_ATTRIBUTE_LAST)
 		return -EINVAL;
 
-	buf[0] = attr_count;
+	pdu[0] = number;
 
-	for (i = 0; i < attr_count; i++) {
-		buf[i * 2 + 1] = attributes[i];
-		buf[i * 2 + 2] = values[i];
+	for (i = 0; i < number; i++) {
+		pdu[i * 2 + 1] = attrs[i];
+		pdu[i * 2 + 2] = values[i];
 	}
 
 	return avrcp_send_req(session, AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
-				AVRCP_SET_PLAYER_VALUE, buf, 2 * attr_count + 1,
-				func, user_data);
+				AVRCP_SET_PLAYER_VALUE, pdu, 2 * number + 1,
+				set_value_rsp, session);
 }
 
 int avrcp_get_play_status(struct avrcp *session, avctp_rsp_cb func,
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 30ceda0..2a65f16 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -182,6 +182,9 @@ struct avrcp_control_cfm {
 	void (*get_value) (struct avrcp *session, int err,
 					uint8_t number, uint8_t *attrs,
 					uint8_t *values, void *user_data);
+	void (*set_value) (struct avrcp *session, int err,
+					uint8_t number, uint8_t *attrs,
+					uint8_t *values, void *user_data);
 };
 
 struct avrcp_passthrough_handler {
@@ -218,9 +221,8 @@ int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t number,
 int avrcp_list_player_values(struct avrcp *session, uint8_t attr);
 int avrcp_get_player_value_text(struct avrcp *session, uint8_t attr,
 					uint8_t number, uint8_t *values);
-int avrcp_set_player_value(struct avrcp *session, uint8_t *attributes,
-					uint8_t attr_count, uint8_t *values,
-					avctp_rsp_cb func, void *user_data);
+int avrcp_set_player_value(struct avrcp *session, uint8_t number,
+					uint8_t *attrs, uint8_t *values);
 int avrcp_get_current_player_value(struct avrcp *session, uint8_t number,
 							uint8_t *attrs);
 int avrcp_get_play_status(struct avrcp *session, avctp_rsp_cb func,
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 016c80c..8f74e9c 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -508,13 +508,12 @@ static void test_client(gconstpointer data)
 	}
 
 	if (g_str_equal(context->data->test_name, "/TP/PAS/BV-11-C")) {
-		uint8_t attributes[2] = { AVRCP_ATTRIBUTE_EQUALIZER,
+		uint8_t attrs[2] = { AVRCP_ATTRIBUTE_EQUALIZER,
 						AVRCP_ATTRIBUTE_REPEAT_MODE };
-		uint8_t values[] = { 0xaa, 0xff };
+		uint8_t values[2] = { 0xaa, 0xff };
 
-		avrcp_set_player_value(context->session, attributes,
-						sizeof(attributes), values,
-						NULL, NULL);
+		avrcp_set_player_value(context->session, sizeof(attrs), attrs,
+								values);
 	}
 
 	if (g_str_equal(context->data->test_name, "/TP/MDI/BV-01-C"))
-- 
1.8.5.3

