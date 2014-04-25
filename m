Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 24/35] android/avrcp: Add avrcp_play_item function
Date: Fri, 25 Apr 2014 11:39:01 +0300
Message-Id: <1398415152-22950-25-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 android/avrcp-lib.h |  3 +++
 2 files changed, 50 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 66581b9..f82c106 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -2234,6 +2234,53 @@ int avrcp_get_item_attributes(struct avrcp *session, uint8_t scope,
 					session);
 }
 
+static gboolean play_item_rsp(struct avctp *conn, uint8_t *operands,
+					size_t operand_count, void *user_data)
+{
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct avrcp_browsing_header *pdu;
+	int err;
+
+	DBG("");
+
+	if (!player || !player->cfm || !player->cfm->play_item)
+		return FALSE;
+
+	pdu = parse_browsing_pdu(operands, operand_count);
+	if (!pdu) {
+		err = -EPROTO;
+		goto done;
+	}
+
+	err = parse_browsing_status(pdu);
+
+done:
+	player->cfm->play_item(session, err, player->user_data);
+
+	return FALSE;
+}
+
+int avrcp_play_item(struct avrcp *session, uint8_t scope, uint64_t uid,
+							uint16_t counter)
+{
+	struct iovec iov;
+	uint8_t pdu[11];
+
+	if (scope > AVRCP_MEDIA_NOW_PLAYING)
+		return -EINVAL;
+
+	pdu[0] = scope;
+	put_be64(uid, &pdu[1]);
+	put_be16(counter, &pdu[9]);
+
+	iov.iov_base = pdu;
+	iov.iov_len = sizeof(pdu);
+
+	return avrcp_send_browsing_req(session, AVRCP_PLAY_ITEM, &iov, 1,
+						play_item_rsp, session);
+}
+
 static gboolean search_rsp(struct avctp *conn, uint8_t *operands,
 					size_t operand_count, void *user_data)
 {
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 0b09b4e..69eec50 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -218,6 +218,7 @@ struct avrcp_control_cfm {
 	void (*get_item_attributes) (struct avrcp *session, int err,
 					uint8_t number, uint32_t *attrs,
 					char **text, void *user_data);
+	void (*play_item) (struct avrcp *session, int err, void *user_data);
 	void (*search) (struct avrcp *session, int err, uint16_t counter,
 					uint32_t items, void *user_data);
 };
@@ -274,6 +275,8 @@ int avrcp_change_path(struct avrcp *session, uint8_t direction, uint64_t uid,
 int avrcp_get_item_attributes(struct avrcp *session, uint8_t scope,
 				uint64_t uid, uint16_t counter, uint8_t number,
 				uint32_t *attrs);
+int avrcp_play_item(struct avrcp *session, uint8_t scope, uint64_t uid,
+							uint16_t counter);
 int avrcp_search(struct avrcp *session, const char *string);
 
 int avrcp_get_capabilities_rsp(struct avrcp *session, uint8_t transaction,
-- 
1.9.0

