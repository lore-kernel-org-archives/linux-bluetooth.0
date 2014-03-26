Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/12] android/avrcp-lib: Add support for parsing ListPlayerValues response
Date: Wed, 26 Mar 2014 16:13:45 +0200
Message-Id: <1395843232-26750-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395843232-26750-1-git-send-email-luiz.dentz@gmail.com>
References: <1395843232-26750-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 android/avrcp-lib.h |  3 +++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 5178174..43037dd 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -970,11 +970,52 @@ int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t number,
 				get_attribute_text_rsp, session);
 }
 
+static gboolean list_values_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct avrcp_header *pdu;
+	uint8_t number = 0;
+	uint8_t *values = NULL;
+	int err;
+
+	DBG("");
+
+	if (!player || !player->cfm || !player->cfm->list_values)
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
+		values = &pdu->params[1];
+
+	err = 0;
+
+done:
+	player->cfm->list_values(session, err, number, values,
+							player->user_data);
+
+	return FALSE;
+}
+
 int avrcp_list_player_values(struct avrcp *session, uint8_t attr)
 {
 	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
 				AVRCP_LIST_PLAYER_VALUES, &attr, sizeof(attr),
-				NULL, NULL);
+				list_values_rsp, session);
 }
 
 int avrcp_get_current_player_value(struct avrcp *session, uint8_t *attrs,
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 4a61948..5cbbed5 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -173,6 +173,9 @@ struct avrcp_control_cfm {
 	void (*get_attribute_text) (struct avrcp *session, int err,
 					uint8_t number, uint8_t *attrs,
 					char **text, void *user_data);
+	void (*list_values) (struct avrcp *session, int err,
+					uint8_t number, uint8_t *values,
+					void *user_data);
 };
 
 struct avrcp_passthrough_handler {
-- 
1.8.5.3

