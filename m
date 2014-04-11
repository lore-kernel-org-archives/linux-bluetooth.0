Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 1/6] android/avrcp-lib: Make avrcp_send_browsing_req to take struct iovec
Date: Fri, 11 Apr 2014 16:58:32 +0300
Message-Id: <1397224717-28446-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes it possible to pass data without copying.
---
v2: Remove unnecessary casts when assigning to iov_base and add patch 6/6

 android/avrcp-lib.c | 85 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 27 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 3209023..999e8aa 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -795,27 +795,35 @@ static int avrcp_send_req(struct avrcp *session, uint8_t code, uint8_t subunit,
 }
 
 static int avrcp_send_browsing_req(struct avrcp *session, uint8_t pdu_id,
-					uint8_t *params, size_t params_len,
+					const struct iovec *iov, int iov_cnt,
 					avctp_browsing_rsp_cb func,
 					void *user_data)
 {
 	struct avrcp_browsing_header *pdu = (void *) session->tx_buf;
 	size_t len = sizeof(*pdu);
+	int i;
 
 	memset(pdu, 0, len);
 
 	pdu->pdu_id = pdu_id;
 
-	if (params_len > 0) {
-		len += params_len;
+	if (iov_cnt <= 0)
+		goto done;
+
+	for (i = 0; i < iov_cnt; i++) {
+		len += iov[i].iov_len;
 
 		if (len > session->tx_mtu)
 			return -ENOBUFS;
 
-		memcpy(pdu->params, params, params_len);
-		pdu->params_len = htons(params_len);
+		memcpy(&pdu->params[pdu->params_len], iov[i].iov_base,
+							iov[i].iov_len);
+		pdu->params_len += iov[i].iov_len;
 	}
 
+	pdu->params_len = htons(pdu->params_len);
+
+done:
 	return avctp_send_browsing_req(session->conn, session->tx_buf, len,
 							func, user_data);
 }
@@ -1707,13 +1715,16 @@ done:
 
 int avrcp_set_browsed_player(struct avrcp *session, uint16_t player_id)
 {
+	struct iovec iov;
 	uint8_t pdu[2];
 
 	put_be16(player_id, pdu);
 
+	iov.iov_base = pdu;
+	iov.iov_len = sizeof(pdu);
+
 	return avrcp_send_browsing_req(session, AVRCP_SET_BROWSED_PLAYER,
-					pdu, sizeof(pdu), set_browsed_rsp,
-					session);
+					&iov, 1, set_browsed_rsp, session);
 }
 
 static gboolean get_folder_items_rsp(struct avctp *conn,
@@ -1762,7 +1773,9 @@ int avrcp_get_folder_items(struct avrcp *session, uint8_t scope,
 				uint32_t start, uint32_t end, uint8_t number,
 				uint32_t *attrs)
 {
-	uint8_t pdu[10 + number * sizeof(uint32_t)];
+
+	struct iovec iov[2];
+	uint8_t pdu[10];
 	int i;
 
 	pdu[0] = scope;
@@ -1770,18 +1783,22 @@ int avrcp_get_folder_items(struct avrcp *session, uint8_t scope,
 	put_be32(end, &pdu[5]);
 	pdu[9] = number;
 
+	iov[0].iov_base = pdu;
+	iov[0].iov_len = sizeof(pdu);
+
 	if (!number)
-		goto done;
+		return avrcp_send_browsing_req(session, AVRCP_GET_FOLDER_ITEMS,
+						iov, 1, get_folder_items_rsp,
+						session);
 
 	for (i = 0; i < number; i++)
 		put_be32(attrs[i], &attrs[i]);
 
-	memcpy(&pdu[10], attrs, number * sizeof(*attrs));
+	iov[1].iov_base = attrs;
+	iov[1].iov_len = number * sizeof(*attrs);
 
-done:
 	return avrcp_send_browsing_req(session, AVRCP_GET_FOLDER_ITEMS,
-					pdu, sizeof(pdu),
-					get_folder_items_rsp, session);
+					iov, 2, get_folder_items_rsp, session);
 }
 
 static gboolean change_path_rsp(struct avctp *conn, uint8_t *operands,
@@ -1824,15 +1841,18 @@ done:
 int avrcp_change_path(struct avrcp *session, uint8_t direction, uint64_t uid,
 							uint16_t counter)
 {
+	struct iovec iov;
 	uint8_t pdu[11];
 
 	put_be16(counter, &pdu[0]);
 	pdu[2] = direction;
 	put_be64(uid, &pdu[3]);
 
+	iov.iov_base = pdu;
+	iov.iov_len = sizeof(pdu);
+
 	return avrcp_send_browsing_req(session, AVRCP_CHANGE_PATH,
-					pdu, sizeof(pdu),
-					change_path_rsp, session);
+					&iov, 1, change_path_rsp, session);
 }
 
 static gboolean get_item_attributes_rsp(struct avctp *conn, uint8_t *operands,
@@ -1874,7 +1894,8 @@ int avrcp_get_item_attributes(struct avrcp *session, uint8_t scope,
 				uint64_t uid, uint16_t counter, uint8_t number,
 				uint32_t *attrs)
 {
-	uint8_t pdu[12 + number * sizeof(uint32_t)];
+	struct iovec iov[2];
+	uint8_t pdu[12];
 	int i;
 
 	pdu[0] = scope;
@@ -1882,18 +1903,24 @@ int avrcp_get_item_attributes(struct avrcp *session, uint8_t scope,
 	put_be16(counter, &pdu[9]);
 	pdu[11] = number;
 
+	iov[0].iov_base = pdu;
+	iov[0].iov_len = sizeof(pdu);
+
 	if (!number)
-		goto done;
+		return avrcp_send_browsing_req(session,
+						AVRCP_GET_ITEM_ATTRIBUTES,
+						iov, 1, get_item_attributes_rsp,
+						session);
 
 	for (i = 0; i < number; i++)
 		put_be32(attrs[i], &attrs[i]);
 
-	memcpy(&pdu[12], attrs, number * sizeof(uint32_t));
+	iov[1].iov_base = attrs;
+	iov[1].iov_len = number * sizeof(*attrs);
 
-done:
 	return avrcp_send_browsing_req(session, AVRCP_GET_ITEM_ATTRIBUTES,
-					pdu, sizeof(pdu),
-					get_item_attributes_rsp, session);
+					iov, 2, get_item_attributes_rsp,
+					session);
 }
 
 static gboolean search_rsp(struct avctp *conn, uint8_t *operands,
@@ -1939,22 +1966,26 @@ done:
 
 int avrcp_search(struct avrcp *session, const char *string)
 {
-	uint8_t pdu[255];
+	struct iovec iov[2];
+	uint8_t pdu[4];
 	size_t len;
 
 	if (!string)
 		return -EINVAL;
 
-	len = strnlen(string, 255 - 4);
+	len = strnlen(string, UINT8_MAX);
 
 	put_be16(AVRCP_CHARSET_UTF8, &pdu[0]);
 	put_be16(len, &pdu[2]);
 
-	memcpy(&pdu[4], string, len);
-	len += 4;
+	iov[0].iov_base = pdu;
+	iov[0].iov_len = sizeof(pdu);
+
+	iov[1].iov_base = (void *) string;
+	iov[1].iov_len = len;
 
-	return avrcp_send_browsing_req(session, AVRCP_SEARCH,
-					pdu, len, search_rsp, session);
+	return avrcp_send_browsing_req(session, AVRCP_SEARCH, iov, 2,
+							search_rsp, session);
 }
 
 int avrcp_get_capabilities_rsp(struct avrcp *session, uint8_t transaction,
-- 
1.9.0

