Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 31/35] android/avrcp: Add avrcp_add_to_now_playing function
Date: Fri, 25 Apr 2014 11:39:08 +0300
Message-Id: <1398415152-22950-32-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/avrcp-lib.h |  4 ++++
 2 files changed, 52 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index a6f69ff..6c2928b 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -2407,6 +2407,54 @@ int avrcp_search(struct avrcp *session, const char *string)
 							search_rsp, session);
 }
 
+static gboolean add_to_now_playing_rsp(struct avctp *conn, uint8_t *operands,
+					size_t operand_count, void *user_data)
+{
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct avrcp_browsing_header *pdu;
+	int err;
+
+	DBG("");
+
+	if (!player || !player->cfm || !player->cfm->add_to_now_playing)
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
+	player->cfm->add_to_now_playing(session, err, player->user_data);
+
+	return FALSE;
+}
+
+int avrcp_add_to_now_playing(struct avrcp *session, uint8_t scope, uint64_t uid,
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
+	return avrcp_send_browsing_req(session, AVRCP_ADD_TO_NOW_PLAYING,
+					&iov, 1, add_to_now_playing_rsp,
+					session);
+}
+
 int avrcp_get_capabilities_rsp(struct avrcp *session, uint8_t transaction,
 						uint8_t number, uint8_t *events)
 {
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index fb097af..83bc72e 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -226,6 +226,8 @@ struct avrcp_control_cfm {
 	void (*play_item) (struct avrcp *session, int err, void *user_data);
 	void (*search) (struct avrcp *session, int err, uint16_t counter,
 					uint32_t items, void *user_data);
+	void (*add_to_now_playing) (struct avrcp *session, int err,
+					void *user_data);
 };
 
 struct avrcp_passthrough_handler {
@@ -283,6 +285,8 @@ int avrcp_get_item_attributes(struct avrcp *session, uint8_t scope,
 int avrcp_play_item(struct avrcp *session, uint8_t scope, uint64_t uid,
 							uint16_t counter);
 int avrcp_search(struct avrcp *session, const char *string);
+int avrcp_add_to_now_playing(struct avrcp *session, uint8_t scope, uint64_t uid,
+							uint16_t counter);
 
 int avrcp_get_capabilities_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t number, uint8_t *events);
-- 
1.9.0

