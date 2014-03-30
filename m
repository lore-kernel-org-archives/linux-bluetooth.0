Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 03/12] android/avrcp-lib: Add support for parsing GetPlayerAttributeText response
Date: Sun, 30 Mar 2014 22:33:29 +0300
Message-Id: <1396208018-23453-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1396208018-23453-1-git-send-email-luiz.dentz@gmail.com>
References: <1396208018-23453-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 android/avrcp-lib.h |  8 +++--
 unit/test-avrcp.c   |  3 +-
 3 files changed, 100 insertions(+), 9 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 15ef1a2..e73d751 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -871,13 +871,103 @@ int avrcp_list_player_attributes(struct avrcp *session)
 				list_attributes_rsp, session);
 }
 
-int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t *attributes,
-					uint8_t attr_len, avctp_rsp_cb func,
+static int parse_text_rsp(struct avrcp_header *pdu, uint8_t *number,
+					uint8_t *attrs, char **text)
+{
+	uint8_t *ptr;
+	uint16_t params_len;
+	int i;
+
+	if (pdu->params_len < 1)
+		return -EPROTO;
+
+	*number = pdu->params[0];
+	if (*number > AVRCP_ATTRIBUTE_LAST) {
+		*number = 0;
+		return -EPROTO;
+	}
+
+	params_len = pdu->params_len - 1;
+	for (i = 0, ptr = &pdu->params[1]; i < *number && params_len > 0; i++) {
+		uint8_t len;
+
+		if (params_len < 4)
+			goto fail;
+
+		attrs[i] = ptr[0];
+		len = ptr[3];
+
+		params_len -= 4;
+		ptr += 4;
+
+		if (len > params_len)
+			goto fail;
+
+		if (len > 0) {
+			text[i] = g_strndup((const char *) &ptr[4], len);
+			params_len -= len;
+			ptr += len;
+		}
+	}
+
+	if (i != *number)
+		goto fail;
+
+	return 0;
+
+fail:
+	for (i -= 1; i >= 0; i--)
+		g_free(text[i]);
+
+	*number = 0;
+
+	return -EPROTO;
+}
+
+static gboolean get_attribute_text_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
 					void *user_data)
 {
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct avrcp_header *pdu;
+	uint8_t number = 0;
+	uint8_t attrs[AVRCP_ATTRIBUTE_LAST];
+	char *text[AVRCP_ATTRIBUTE_LAST];
+	int err;
+
+	DBG("");
+
+	if (!player || !player->cfm || !player->cfm->get_attribute_text)
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
+	err = parse_text_rsp(pdu, &number, attrs, text);
+
+done:
+	player->cfm->get_attribute_text(session, err, number, attrs, text,
+							player->user_data);
+
+	return FALSE;
+}
+
+int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t number,
+								uint8_t *attrs)
+{
 	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
-				AVRCP_GET_PLAYER_ATTRIBUTE_TEXT, attributes,
-				attr_len, func, user_data);
+				AVRCP_GET_PLAYER_ATTRIBUTE_TEXT, attrs, number,
+				get_attribute_text_rsp, session);
 }
 
 int avrcp_get_current_player_value(struct avrcp *session, uint8_t *attrs,
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 87397a3..9ed172e 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -170,6 +170,9 @@ struct avrcp_control_cfm {
 	void (*list_attributes) (struct avrcp *session, int err,
 					uint8_t number, uint8_t *attrs,
 					void *user_data);
+	void (*get_attribute_text) (struct avrcp *session, int err,
+					uint8_t number, uint8_t *attrs,
+					char **text, void *user_data);
 };
 
 struct avrcp_passthrough_handler {
@@ -201,9 +204,8 @@ int avrcp_register_notification(struct avrcp *session, uint8_t event,
 					uint32_t interval, avctp_rsp_cb func,
 					void *user_data);
 int avrcp_list_player_attributes(struct avrcp *session);
-int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t *attributes,
-					uint8_t attr_len, avctp_rsp_cb func,
-					void *user_data);
+int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t number,
+							uint8_t *attrs);
 int avrcp_set_player_value(struct avrcp *session, uint8_t *attributes,
 					uint8_t attr_count, uint8_t *values,
 					avctp_rsp_cb func, void *user_data);
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 88e457d..fe1d51f 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -497,8 +497,7 @@ static void test_client(gconstpointer data)
 		avrcp_list_player_attributes(context->session);
 
 	if (g_str_equal(context->data->test_name, "/TP/PAS/BV-03-C"))
-		avrcp_get_player_attribute_text(context->session, NULL, 0,
-								NULL, NULL);
+		avrcp_get_player_attribute_text(context->session, 0, NULL);
 
 	if (g_str_equal(context->data->test_name, "/TP/PAS/BV-09-C")) {
 		uint8_t attributes[2] = { AVRCP_ATTRIBUTE_EQUALIZER,
-- 
1.8.5.3

