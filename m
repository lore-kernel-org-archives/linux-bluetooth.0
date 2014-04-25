Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/35] android/avrcp-lib: Add support for parsing GetFolderItems PDU
Date: Fri, 25 Apr 2014 11:38:43 +0300
Message-Id: <1398415152-22950-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/avrcp-lib.h |   9 +++++
 2 files changed, 112 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 8f7f187..be3305d 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -782,7 +782,52 @@ static void avrcp_set_control_handlers(struct avrcp *session,
 	session->control_data = user_data;
 }
 
+static ssize_t get_folder_items(struct avrcp *session, uint8_t transaction,
+					uint16_t params_len, uint8_t *params,
+					void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	uint8_t scope;
+	uint32_t start, end;
+	uint16_t number;
+	uint32_t attrs[AVRCP_MEDIA_ATTRIBUTE_LAST];
+	int i;
+
+	DBG("");
+
+	if (!player->ind || !player->ind->get_folder_items)
+		return -ENOSYS;
+
+	if (!params || params_len < 10)
+		return -EINVAL;
+
+	scope = params[0];
+	if (scope > AVRCP_MEDIA_NOW_PLAYING)
+		return -EBADRQC;
+
+	start = get_be32(&params[1]);
+	end = get_be32(&params[5]);
+
+	if (start > end)
+		return -ERANGE;
+
+	number = get_be16(&params[9]);
+
+	for (i = 0; i < number; i++) {
+		attrs[i] = get_be32(&params[11 + i * 4]);
+
+		if (attrs[i] == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
+				attrs[i] > AVRCP_MEDIA_ATTRIBUTE_LAST)
+			return -EINVAL;
+	}
+
+	return player->ind->get_folder_items(session, transaction, scope, start,
+							end, number, attrs,
+							player->user_data);
+}
+
 static const struct avrcp_browsing_handler browsing_handlers[] = {
+		{ AVRCP_GET_FOLDER_ITEMS, get_folder_items },
 		{ },
 };
 
@@ -951,6 +996,32 @@ static int avrcp_send_browsing_req(struct avrcp *session, uint8_t pdu_id,
 							func, user_data);
 }
 
+static int avrcp_send_browsing(struct avrcp *session, uint8_t transaction,
+				uint8_t pdu_id, const struct iovec *iov,
+				int iov_cnt)
+{
+	struct iovec pdu[iov_cnt + 1];
+	struct avrcp_browsing_header hdr;
+	int i;
+
+	memset(&hdr, 0, sizeof(hdr));
+
+	for (i = 0; i < iov_cnt; i++) {
+		pdu[i + 1].iov_base = iov[i].iov_base;
+		pdu[i + 1].iov_len = iov[i].iov_len;
+		hdr.params_len += iov[i].iov_len;
+	}
+
+	hdr.pdu_id = pdu_id;
+	hdr.params_len = htons(hdr.params_len);
+
+	pdu[0].iov_base = &hdr;
+	pdu[0].iov_len = sizeof(hdr);
+
+	return avctp_send_browsing(session->conn, transaction, pdu,
+								iov_cnt + 1);
+}
+
 static gboolean get_capabilities_rsp(struct avctp *conn,
 					uint8_t code, uint8_t subunit,
 					uint8_t *operands, size_t operand_count,
@@ -2384,6 +2455,38 @@ int avrcp_set_addressed_player_rsp(struct avrcp *session, uint8_t transaction,
 				&iov, 1);
 }
 
+int avrcp_get_folder_items_rsp(struct avrcp *session, uint8_t transaction,
+					uint16_t counter, uint8_t number,
+					uint8_t *type, uint16_t *len,
+					uint8_t **params)
+{
+	struct iovec iov[UINT8_MAX * 2 + 1];
+	uint8_t pdu[5];
+	uint8_t item[UINT8_MAX][3];
+	int i;
+
+	pdu[0] = AVRCP_STATUS_SUCCESS;
+	put_be16(counter, &pdu[1]);
+	put_be16(number, &pdu[3]);
+
+	iov[0].iov_base = pdu;
+	iov[0].iov_len = sizeof(pdu);
+
+	for (i = 0; i < number; i++) {
+		item[i][0] = type[i];
+		put_be16(len[i], &item[i][1]);
+
+		iov[i * 2 + 1].iov_base = item[i];
+		iov[i * 2 + 1].iov_len = sizeof(item[i]);
+
+		iov[i * 2 + 2].iov_base = params[i];
+		iov[i * 2 + 2].iov_len = len[i];
+	}
+
+	return avrcp_send_browsing(session, transaction, AVRCP_GET_FOLDER_ITEMS,
+							iov, number * 2 + 1);
+}
+
 int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op)
 {
 	uint8_t params[5];
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index a2cff01..90fb5dd 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -159,6 +159,10 @@ struct avrcp_control_ind {
 					uint32_t interval, void *user_data);
 	int (*set_addressed) (struct avrcp *session, uint8_t transaction,
 					uint16_t id, void *user_data);
+	int (*get_folder_items) (struct avrcp *session, uint8_t transaction,
+					uint8_t scope, uint32_t start,
+					uint32_t end, uint16_t number,
+					uint32_t *attrs, void *user_data);
 };
 
 struct avrcp_control_cfm {
@@ -290,4 +294,9 @@ int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
 					size_t params_len);
 int avrcp_set_addressed_player_rsp(struct avrcp *session, uint8_t transaction,
 							uint8_t status);
+int avrcp_get_folder_items_rsp(struct avrcp *session, uint8_t transaction,
+					uint16_t counter, uint8_t number,
+					uint8_t *type, uint16_t *len,
+					uint8_t **params);
+
 int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op);
-- 
1.9.0

