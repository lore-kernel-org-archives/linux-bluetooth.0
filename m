Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/12] android/avrcp-lib: Add support for parsing GetElementAttributes response
Date: Wed, 26 Mar 2014 16:13:51 +0200
Message-Id: <1395843232-26750-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395843232-26750-1-git-send-email-luiz.dentz@gmail.com>
References: <1395843232-26750-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++----
 android/avrcp-lib.h |   6 ++--
 unit/test-avrcp.c   |   2 +-
 3 files changed, 101 insertions(+), 9 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 3412354..33717e0 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -1265,17 +1265,107 @@ int avrcp_set_volume(struct avrcp *session, uint8_t volume, avctp_rsp_cb func,
 						func, user_data);
 }
 
-int avrcp_get_element_attributes(struct avrcp *session, avctp_rsp_cb func,
-								void *user_data)
+static int parse_attribute_list(struct avrcp_header *pdu, uint8_t *number,
+						uint32_t *attrs, char **text)
 {
-	uint8_t buf[9];
+	uint8_t *ptr;
+	uint16_t params_len;
+	int i;
+
+	if (pdu->params_len < 1)
+		return -EPROTO;
+
+	*number = pdu->params[0];
+	if (*number > AVRCP_MEDIA_ATTRIBUTE_LAST) {
+		*number = 0;
+		return -EPROTO;
+	}
+
+	params_len = pdu->params_len - 1;
+	for (i = 0, ptr = &pdu->params[1]; i < *number && params_len > 0; i++) {
+		uint16_t len;
+
+		if (params_len < 8)
+			goto fail;
+
+		attrs[i] = bt_get_be32(&ptr[0]);
+		len = bt_get_be16(&ptr[6]);
+
+		params_len -= 8;
+		ptr += 8;
+
+		if (len > params_len)
+			goto fail;
+
+		if (len > 0) {
+			text[i] = g_strndup((const char *) &ptr[8], len);
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
+static gboolean get_element_attributes_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct avrcp_header *pdu;
+	uint8_t number = 0;
+	uint32_t attrs[AVRCP_MEDIA_ATTRIBUTE_LAST];
+	char *text[AVRCP_MEDIA_ATTRIBUTE_LAST];
+	int err;
+
+	DBG("");
+
+	if (!player || !player->cfm || !player->cfm->get_element_attributes)
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
+	err = parse_attribute_list(pdu, &number, attrs, text);
+
+done:
+	player->cfm->get_element_attributes(session, err, number, attrs, text,
+							player->user_data);
+
+	return FALSE;
+}
+
+int avrcp_get_element_attributes(struct avrcp *session)
+{
+	uint8_t pdu[9];
 
 	/* This returns all attributes */
-	memset(buf, 0, sizeof(buf));
+	memset(pdu, 0, sizeof(pdu));
 
 	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
-				AVRCP_GET_ELEMENT_ATTRIBUTES, buf, sizeof(buf),
-				func, user_data);
+				AVRCP_GET_ELEMENT_ATTRIBUTES, pdu, sizeof(pdu),
+				get_element_attributes_rsp, session);
 }
 
 int avrcp_set_addressed_player(struct avrcp *session, uint16_t player_id,
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index f5666eb..2f35e90 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -188,6 +188,9 @@ struct avrcp_control_cfm {
 	void (*get_play_status) (struct avrcp *session, int err,
 					uint8_t status, uint32_t position,
 					uint32_t duration, void *user_data);
+	void (*get_element_attributes) (struct avrcp *session, int err,
+					uint8_t number, uint32_t *attrs,
+					char **text, void *user_data);
 };
 
 struct avrcp_passthrough_handler {
@@ -231,8 +234,7 @@ int avrcp_get_current_player_value(struct avrcp *session, uint8_t number,
 int avrcp_get_play_status(struct avrcp *session);
 int avrcp_set_volume(struct avrcp *session, uint8_t volume, avctp_rsp_cb func,
 							void *user_data);
-int avrcp_get_element_attributes(struct avrcp *session, avctp_rsp_cb func,
-							void *user_data);
+int avrcp_get_element_attributes(struct avrcp *session);
 int avrcp_set_addressed_player(struct avrcp *session, uint16_t player_id,
 					avctp_rsp_cb func, void *user_data);
 
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index ad15bb9..a0b009a 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -520,7 +520,7 @@ static void test_client(gconstpointer data)
 		avrcp_get_play_status(context->session);
 
 	if (g_str_equal(context->data->test_name, "/TP/MDI/BV-03-C"))
-		avrcp_get_element_attributes(context->session, NULL, NULL);
+		avrcp_get_element_attributes(context->session);
 
 	if (g_str_equal(context->data->test_name, "/TP/NFY/BV-01-C"))
 		avrcp_register_notification(context->session,
-- 
1.8.5.3

