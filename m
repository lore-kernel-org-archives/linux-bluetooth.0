Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 08/12] android/avrcp-lib: Add support for parsing GetCurrentPlayerValue response
Date: Sun, 30 Mar 2014 22:33:34 +0300
Message-Id: <1396208018-23453-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1396208018-23453-1-git-send-email-luiz.dentz@gmail.com>
References: <1396208018-23453-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++------
 android/avrcp-lib.h |  8 +++--
 unit/test-avrcp.c   |  6 ++--
 3 files changed, 84 insertions(+), 15 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 66310ac..c2b376a 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -1064,24 +1064,91 @@ int avrcp_get_player_value_text(struct avrcp *session, uint8_t attr,
 				sizeof(attr), get_value_text_rsp, session);
 }
 
-int avrcp_get_current_player_value(struct avrcp *session, uint8_t *attrs,
-					uint8_t attr_count, avctp_rsp_cb func,
+static int parse_value(struct avrcp_header *pdu, uint8_t *number,
+					uint8_t *attrs, uint8_t *values)
+{
+	int i;
+
+	if (pdu->params_len < 1)
+		return -EPROTO;
+
+	*number = pdu->params[0];
+
+	/* Check if PDU is big enough to hold the number of (attribute, value)
+	 * tuples.
+	 */
+	if (*number > AVRCP_ATTRIBUTE_LAST ||
+					1 + *number * 2 != pdu->params_len) {
+		number = 0;
+		return -EPROTO;
+	}
+
+	for (i = 0; i < *number; i++) {
+		attrs[i] = pdu->params[i * 2 + 1];
+		values[i] = pdu->params[i * 2 + 2];
+	}
+
+	return 0;
+}
+
+static gboolean get_value_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
 					void *user_data)
+{
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct avrcp_header *pdu = (void *) operands;
+	uint8_t number = 0;
+	uint8_t attrs[AVRCP_ATTRIBUTE_LAST];
+	uint8_t values[AVRCP_ATTRIBUTE_LAST];
+	int err;
+
+	DBG("");
+
+	if (!player || !player->cfm || !player->cfm->get_value)
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
+	player->cfm->get_value(session, err, number, attrs, values,
+							player->user_data);
+
+	return FALSE;
+}
+
+int avrcp_get_current_player_value(struct avrcp *session, uint8_t number,
+							uint8_t *attrs)
 
 {
-	uint8_t buf[AVRCP_ATTRIBUTE_LAST + 1];
+	uint8_t pdu[AVRCP_ATTRIBUTE_LAST + 1];
 
-	if (attr_count > AVRCP_ATTRIBUTE_LAST)
+	if (number > AVRCP_ATTRIBUTE_LAST)
 		return -EINVAL;
 
-	if (attrs && attr_count) {
-		buf[0] = attr_count;
-		memcpy(buf + 1, attrs, attr_count);
+	if (number > 0) {
+		if (!attrs)
+			return -EINVAL;
+
+		pdu[0] = number;
+		memcpy(&pdu[1], attrs, number);
 	}
 
 	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
-				AVRCP_GET_CURRENT_PLAYER_VALUE, buf,
-				attr_count + 1, func, user_data);
+				AVRCP_GET_CURRENT_PLAYER_VALUE, pdu,
+				number + 1, get_value_rsp, session);
 }
 
 int avrcp_set_player_value(struct avrcp *session, uint8_t *attributes,
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 0929155..30ceda0 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -179,6 +179,9 @@ struct avrcp_control_cfm {
 	void (*get_value_text) (struct avrcp *session, int err,
 					uint8_t number, uint8_t *values,
 					char **text, void *user_data);
+	void (*get_value) (struct avrcp *session, int err,
+					uint8_t number, uint8_t *attrs,
+					uint8_t *values, void *user_data);
 };
 
 struct avrcp_passthrough_handler {
@@ -218,9 +221,8 @@ int avrcp_get_player_value_text(struct avrcp *session, uint8_t attr,
 int avrcp_set_player_value(struct avrcp *session, uint8_t *attributes,
 					uint8_t attr_count, uint8_t *values,
 					avctp_rsp_cb func, void *user_data);
-int avrcp_get_current_player_value(struct avrcp *session, uint8_t *attrs,
-					uint8_t attr_count, avctp_rsp_cb func,
-					void *user_data);
+int avrcp_get_current_player_value(struct avrcp *session, uint8_t number,
+							uint8_t *attrs);
 int avrcp_get_play_status(struct avrcp *session, avctp_rsp_cb func,
 							void *user_data);
 int avrcp_set_volume(struct avrcp *session, uint8_t volume, avctp_rsp_cb func,
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index fe1d51f..016c80c 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -500,11 +500,11 @@ static void test_client(gconstpointer data)
 		avrcp_get_player_attribute_text(context->session, 0, NULL);
 
 	if (g_str_equal(context->data->test_name, "/TP/PAS/BV-09-C")) {
-		uint8_t attributes[2] = { AVRCP_ATTRIBUTE_EQUALIZER,
+		uint8_t attrs[2] = { AVRCP_ATTRIBUTE_EQUALIZER,
 						AVRCP_ATTRIBUTE_REPEAT_MODE };
 
-		avrcp_get_current_player_value(context->session, attributes,
-						sizeof(attributes), NULL, NULL);
+		avrcp_get_current_player_value(context->session, sizeof(attrs),
+									attrs);
 	}
 
 	if (g_str_equal(context->data->test_name, "/TP/PAS/BV-11-C")) {
-- 
1.8.5.3

