Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/12] android/avrcp-lib: Add support for parsing GetPlayerValueText response
Date: Wed, 26 Mar 2014 16:13:47 +0200
Message-Id: <1395843232-26750-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395843232-26750-1-git-send-email-luiz.dentz@gmail.com>
References: <1395843232-26750-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 40 +++++++++++++++++++++++++++++++++++++++-
 android/avrcp-lib.h |  3 +++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index c901656..5f36738 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -1018,12 +1018,50 @@ int avrcp_list_player_values(struct avrcp *session, uint8_t attr)
 				list_values_rsp, session);
 }
 
+static gboolean get_value_text_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct avrcp_header *pdu;
+	uint8_t number = 0;
+	uint8_t values[AVRCP_ATTRIBUTE_LAST];
+	char *text[AVRCP_ATTRIBUTE_LAST];
+	int err;
+
+	DBG("");
+
+	if (!player || !player->cfm || !player->cfm->get_value_text)
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
+	err = parse_text_rsp(pdu, &number, values, text);
+
+done:
+	player->cfm->get_value_text(session, err, number, values, text,
+							player->user_data);
+
+	return FALSE;
+}
+
 int avrcp_get_player_value_text(struct avrcp *session, uint8_t attr,
 					uint8_t number, uint8_t *values)
 {
 	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
 				AVRCP_GET_PLAYER_VALUE_TEXT, &attr,
-				sizeof(attr), NULL, NULL);
+				sizeof(attr), get_value_text_rsp, session);
 }
 
 int avrcp_get_current_player_value(struct avrcp *session, uint8_t *attrs,
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index fea4f95..0929155 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -176,6 +176,9 @@ struct avrcp_control_cfm {
 	void (*list_values) (struct avrcp *session, int err,
 					uint8_t number, uint8_t *values,
 					void *user_data);
+	void (*get_value_text) (struct avrcp *session, int err,
+					uint8_t number, uint8_t *values,
+					char **text, void *user_data);
 };
 
 struct avrcp_passthrough_handler {
-- 
1.8.5.3

