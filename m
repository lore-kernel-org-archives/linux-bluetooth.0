Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 6/6] android/avctp: Make avctp_send_vendor to take struct iovec
Date: Fri, 11 Apr 2014 16:58:37 +0300
Message-Id: <1397224717-28446-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1397224717-28446-1-git-send-email-luiz.dentz@gmail.com>
References: <1397224717-28446-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes it possible to pass data without copying.
---
 android/avctp.c     |   8 +--
 android/avctp.h     |   2 +-
 android/avrcp-lib.c | 182 +++++++++++++++++++++++++++++++---------------------
 android/avrcp-lib.h |   2 +-
 4 files changed, 113 insertions(+), 81 deletions(-)

diff --git a/android/avctp.c b/android/avctp.c
index 62c41fd..2271d2c 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -1352,19 +1352,15 @@ int avctp_send_passthrough(struct avctp *session, uint8_t op, uint8_t *params,
 
 int avctp_send_vendor(struct avctp *session, uint8_t transaction,
 				uint8_t code, uint8_t subunit,
-				uint8_t *operands, size_t operand_count)
+				const struct iovec *iov, int iov_cnt)
 {
 	struct avctp_channel *control = session->control;
-	struct iovec iov;
 
 	if (control == NULL)
 		return -ENOTCONN;
 
-	iov.iov_base = operands;
-	iov.iov_len = operand_count;
-
 	return avctp_send(control, transaction, AVCTP_RESPONSE, code, subunit,
-						AVC_OP_VENDORDEP, &iov, 1);
+						AVC_OP_VENDORDEP, iov, iov_cnt);
 }
 
 int avctp_send_vendor_req(struct avctp *session, uint8_t code, uint8_t subunit,
diff --git a/android/avctp.h b/android/avctp.h
index 1b15398..6bfc4cb 100644
--- a/android/avctp.h
+++ b/android/avctp.h
@@ -168,7 +168,7 @@ int avctp_send_passthrough(struct avctp *session, uint8_t op, uint8_t *params,
 							size_t params_len);
 int avctp_send_vendor(struct avctp *session, uint8_t transaction,
 				uint8_t code, uint8_t subunit,
-				uint8_t *operands, size_t operand_count);
+				const struct iovec *iov, int iov_cnt);
 int avctp_send_vendor_req(struct avctp *session, uint8_t code, uint8_t subunit,
 					const struct iovec *iov, int iov_cnt,
 					avctp_rsp_cb func, void *user_data);
diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index e2bba11..6957422 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -703,29 +703,30 @@ int avrcp_init_uinput(struct avrcp *session, const char *name,
 
 int avrcp_send(struct avrcp *session, uint8_t transaction, uint8_t code,
 					uint8_t subunit, uint8_t pdu_id,
-					uint8_t *params, size_t params_len)
+					const struct iovec *iov, int iov_cnt)
 {
-	struct avrcp_header *pdu = (void *) session->tx_buf;
-	size_t len = sizeof(*pdu);
-
-	memset(pdu, 0, len);
-
-	hton24(pdu->company_id, IEEEID_BTSIG);
-	pdu->pdu_id = pdu_id;
-	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+	struct iovec pdu[iov_cnt + 1];
+	struct avrcp_header hdr;
+	int i;
 
-	if (params_len > 0) {
-		len += params_len;
+	memset(&hdr, 0, sizeof(hdr));
 
-		if (len > session->tx_mtu)
-			return -ENOBUFS;
+	pdu[0].iov_base = &hdr;
+	pdu[0].iov_len = sizeof(hdr);
 
-		memcpy(pdu->params, params, params_len);
-		pdu->params_len = htons(params_len);
+	for (i = 0; i < iov_cnt; i++) {
+		pdu[i + 1].iov_base = iov[i].iov_base;
+		pdu[i + 1].iov_len = iov[i].iov_len;
+		hdr.params_len += iov[i].iov_len;
 	}
 
+	hton24(hdr.company_id, IEEEID_BTSIG);
+	hdr.pdu_id = pdu_id;
+	hdr.packet_type = AVRCP_PACKET_TYPE_SINGLE;
+	hdr.params_len = htons(hdr.params_len);
+
 	return avctp_send_vendor(session->conn, transaction, code, subunit,
-							session->tx_buf, len);
+							pdu, iov_cnt + 1);
 }
 
 static int status2errno(uint8_t status)
@@ -2034,52 +2035,61 @@ int avrcp_search(struct avrcp *session, const char *string)
 int avrcp_get_capabilities_rsp(struct avrcp *session, uint8_t transaction,
 						uint8_t number, uint8_t *events)
 {
-	uint8_t pdu[AVRCP_EVENT_LAST + 1];
+	struct iovec iov[2];
 
 	if (number > AVRCP_EVENT_LAST)
 		return -EINVAL;
 
-	pdu[0] = number;
-	memcpy(&pdu[1], events, number);
+	iov[0].iov_base = &number;
+	iov[0].iov_len = sizeof(number);
+
+	iov[1].iov_base = events;
+	iov[1].iov_len = number;
 
 	return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
 				AVC_SUBUNIT_PANEL, AVRCP_GET_CAPABILITIES,
-				pdu, number + 1);
+				iov, 2);
 }
 
 int avrcp_list_player_attributes_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t number, uint8_t *attrs)
 {
-	uint8_t pdu[AVRCP_ATTRIBUTE_LAST + 1];
+	struct iovec iov[2];
 
 	if (number > AVRCP_ATTRIBUTE_LAST)
 		return -EINVAL;
 
-	pdu[0] = number;
+	iov[0].iov_base = &number;
+	iov[0].iov_len = sizeof(number);
 
-	if (number > 0)
-		memcpy(&pdu[1], attrs, number);
+	if (!number)
+		return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
+				AVC_SUBUNIT_PANEL, AVRCP_LIST_PLAYER_ATTRIBUTES,
+				iov, 1);
+
+	iov[1].iov_base = attrs;
+	iov[1].iov_len = number;
 
 	return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
 				AVC_SUBUNIT_PANEL, AVRCP_LIST_PLAYER_ATTRIBUTES,
-				pdu, number + 1);
+				iov, 2);
 }
 
 int avrcp_get_player_attribute_text_rsp(struct avrcp *session,
 					uint8_t transaction, uint8_t number,
 					uint8_t *attrs, const char **text)
 {
-	uint8_t pdu[AVRCP_ATTRIBUTE_LAST * (4 + 255)];
-	uint8_t *ptr;
-	uint16_t length;
+	struct iovec iov[1 + AVRCP_ATTRIBUTE_LAST * 2];
+	uint8_t val[AVRCP_ATTRIBUTE_LAST][4];
 	int i;
 
 	if (number > AVRCP_ATTRIBUTE_LAST)
 		return -EINVAL;
 
-	pdu[0] = number;
-	length = 1;
-	for (i = 0, ptr = &pdu[1]; i < number; i++) {
+	iov[0].iov_base = &number;
+	iov[0].iov_len = sizeof(number);
+
+	for (i = 0; i < number; i++) {
 		uint8_t len = 0;
 
 		if (attrs[i] > AVRCP_ATTRIBUTE_LAST ||
@@ -2089,135 +2099,161 @@ int avrcp_get_player_attribute_text_rsp(struct avrcp *session,
 		if (text[i])
 			len = strlen(text[i]);
 
-		ptr[0] = attrs[i];
-		put_be16(AVRCP_CHARSET_UTF8, &ptr[1]);
-		ptr[3] = len;
+		val[i][0] = attrs[i];
+		put_be16(AVRCP_CHARSET_UTF8, &val[i][1]);
+		val[i][3] = len;
 
-		if (len)
-			memcpy(&ptr[4], text[i], len);
+		iov[i + 1].iov_base = val[i];
+		iov[i + 1].iov_len = sizeof(val[i]);
 
-		ptr += 4 + len;
-		length += 4 + len;
+		iov[i + 2].iov_base = (void *) text[i];
+		iov[i + 2].iov_len = len;
 	}
 
 	return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
 			AVC_SUBUNIT_PANEL, AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
-			pdu, length);
+			iov, 1 + i * 2);
 }
 
 int avrcp_list_player_values_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t number, uint8_t *values)
 {
-	uint8_t pdu[AVRCP_ATTRIBUTE_LAST + 1];
+	struct iovec iov[2];
 
 	if (number > AVRCP_ATTRIBUTE_LAST)
 		return -EINVAL;
 
-	pdu[0] = number;
-	memcpy(&pdu[1], values, number);
+	iov[0].iov_base = &number;
+	iov[0].iov_len = sizeof(number);
+
+	iov[1].iov_base = values;
+	iov[1].iov_len = number;
 
 	return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
-			AVC_SUBUNIT_PANEL, AVRCP_LIST_PLAYER_VALUES,
-			pdu, number + 1);
+				AVC_SUBUNIT_PANEL, AVRCP_LIST_PLAYER_VALUES,
+				iov, 2);
 }
 
 int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint32_t position, uint32_t duration,
 				uint8_t status)
 {
+	struct iovec iov;
 	uint8_t pdu[9];
 
 	put_be32(position, &pdu[0]);
 	put_be32(duration, &pdu[4]);
 	pdu[8] = status;
 
+	iov.iov_base = &pdu;
+	iov.iov_len = sizeof(pdu);
+
 	return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
 				AVC_SUBUNIT_PANEL, AVRCP_GET_PLAY_STATUS,
-				pdu, sizeof(pdu));
+				&iov, 1);
 }
 
 int avrcp_get_player_values_text_rsp(struct avrcp *session,
 					uint8_t transaction, uint8_t number,
 					uint8_t *values, const char **text)
 {
-	uint8_t pdu[AVRCP_ATTRIBUTE_LAST * (4 + 255)];
-	uint8_t *ptr;
-	uint16_t length;
+	struct iovec iov[1 + AVRCP_ATTRIBUTE_LAST * 2];
+	uint8_t val[AVRCP_ATTRIBUTE_LAST][4];
 	int i;
 
 	if (number > AVRCP_ATTRIBUTE_LAST)
 		return -EINVAL;
 
-	pdu[0] = number;
-	length = 1;
-	for (i = 0, ptr = &pdu[1]; i < number; i++) {
+	iov[0].iov_base = &number;
+	iov[0].iov_len = sizeof(number);
+
+	for (i = 0; i < number; i++) {
 		uint8_t len = 0;
 
 		if (text[i])
 			len = strlen(text[i]);
 
-		ptr[0] = values[i];
-		put_be16(AVRCP_CHARSET_UTF8, &ptr[1]);
-		ptr[3] = len;
-		memcpy(&ptr[4], text[i], len);
-		ptr += 4 + len;
-		length += 4 + len;
+		val[i][0] = values[i];
+		put_be16(AVRCP_CHARSET_UTF8, &val[i][1]);
+		val[i][3] = len;
+
+		iov[i + 1].iov_base = val[i];
+		iov[i + 1].iov_len = sizeof(val[i]);
+
+		iov[i + 2].iov_base = (void *) text[i];
+		iov[i + 2].iov_len = len;
 	}
 
 	return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
-			AVC_SUBUNIT_PANEL, AVRCP_GET_PLAYER_VALUE_TEXT,
-			pdu, length);
+				AVC_SUBUNIT_PANEL, AVRCP_GET_PLAYER_VALUE_TEXT,
+				iov, 1 + i * 2);
 }
 
 int avrcp_get_current_player_value_rsp(struct avrcp *session,
 					uint8_t transaction, uint8_t number,
 					uint8_t *attrs, uint8_t *values)
 {
-	uint8_t pdu[AVRCP_ATTRIBUTE_LAST * 2  + 1];
-	uint8_t *ptr;
-	uint16_t length;
+	struct iovec iov[1 + AVRCP_ATTRIBUTE_LAST];
+	uint8_t val[AVRCP_ATTRIBUTE_LAST][2];
 	int i;
 
 	if (number > AVRCP_ATTRIBUTE_LAST)
 		return -EINVAL;
 
-	pdu[0] = number;
-	length = 1;
-	for (i = 0, ptr = &pdu[1]; i < number; i++) {
-		ptr[0] = attrs[i];
-		ptr[1] = values[i];
-		ptr += 2;
-		length += 2;
+	iov[0].iov_base = &number;
+	iov[0].iov_len = sizeof(number);
+
+	for (i = 0; i < number; i++) {
+		val[i][0] = attrs[i];
+		val[i][1] = values[i];
+
+		iov[i + 1].iov_base = val[i];
+		iov[i + 1].iov_len = sizeof(val[i]);
 	}
 
 	return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
 			AVC_SUBUNIT_PANEL, AVRCP_GET_CURRENT_PLAYER_VALUE,
-			pdu, length);
+			iov, 1 + i);
 }
 
 int avrcp_get_element_attrs_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t *params, size_t params_len)
 {
+	struct iovec iov;
+
+	iov.iov_base = params;
+	iov.iov_len = params_len;
+
 	return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
 				AVC_SUBUNIT_PANEL, AVRCP_GET_ELEMENT_ATTRIBUTES,
-				params, params_len);
+				&iov, 1);
 }
 
 int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t code, uint8_t *params,
 					size_t params_len)
 {
+	struct iovec iov;
+
+	iov.iov_base = params;
+	iov.iov_len = params_len;
+
 	return avrcp_send(session, transaction, code,
 				AVC_SUBUNIT_PANEL, AVRCP_REGISTER_NOTIFICATION,
-				params, params_len);
+				&iov, 1);
 }
 
 int avrcp_set_addressed_player_rsp(struct avrcp *session, uint8_t transaction,
 							uint8_t status)
 {
+	struct iovec iov;
+
+	iov.iov_base = &status;
+	iov.iov_len = sizeof(status);
+
 	return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
 				AVC_SUBUNIT_PANEL, AVRCP_SET_ADDRESSED_PLAYER,
-				&status, sizeof(status));
+				&iov, 1);
 }
 
 int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op)
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 3364e01..8b2424c 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -241,7 +241,7 @@ int avrcp_init_uinput(struct avrcp *session, const char *name,
 							const char *address);
 int avrcp_send(struct avrcp *session, uint8_t transaction, uint8_t code,
 					uint8_t subunit, uint8_t pdu_id,
-					uint8_t *params, size_t params_len);
+					const struct iovec *iov, int iov_cnt);
 int avrcp_get_capabilities(struct avrcp *session, uint8_t param);
 int avrcp_register_notification(struct avrcp *session, uint8_t event,
 							uint32_t interval);
-- 
1.9.0

