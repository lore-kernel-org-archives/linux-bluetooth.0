Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 3/6] android/avrcp-lib: Make avrcp_send_req to take struct iovec
Date: Fri, 11 Apr 2014 16:58:34 +0300
Message-Id: <1397224717-28446-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1397224717-28446-1-git-send-email-luiz.dentz@gmail.com>
References: <1397224717-28446-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes it possible to pass data without copying.
---
 android/avrcp-lib.c | 126 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 88 insertions(+), 38 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 3d27856..75186bd 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -767,12 +767,13 @@ static int parse_browsing_status(struct avrcp_browsing_header *pdu)
 }
 
 static int avrcp_send_req(struct avrcp *session, uint8_t code, uint8_t subunit,
-					uint8_t pdu_id, uint8_t *params,
-					size_t params_len, avctp_rsp_cb func,
+					uint8_t pdu_id, const struct iovec *iov,
+					int iov_cnt, avctp_rsp_cb func,
 					void *user_data)
 {
 	struct avrcp_header *pdu = (void *) session->tx_buf;
 	size_t len = sizeof(*pdu);
+	int i;
 
 	memset(pdu, 0, len);
 
@@ -780,16 +781,23 @@ static int avrcp_send_req(struct avrcp *session, uint8_t code, uint8_t subunit,
 	pdu->pdu_id = pdu_id;
 	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
 
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
 	return avctp_send_vendordep_req(session->conn, code, subunit,
 					session->tx_buf, len, func, user_data);
 }
@@ -887,9 +895,14 @@ done:
 
 int avrcp_get_capabilities(struct avrcp *session, uint8_t param)
 {
+	struct iovec iov;
+
+	iov.iov_base = &param;
+	iov.iov_len = sizeof(param);
+
 	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
-				AVRCP_GET_CAPABILITIES, &param, sizeof(param),
-				get_capabilities_rsp, session);
+					AVRCP_GET_CAPABILITIES, &iov, 1,
+					get_capabilities_rsp, session);
 }
 
 static gboolean register_notification_rsp(struct avctp *conn,
@@ -983,15 +996,18 @@ done:
 int avrcp_register_notification(struct avrcp *session, uint8_t event,
 							uint32_t interval)
 {
-	uint8_t params[5];
+	struct iovec iov;
+	uint8_t pdu[5];
 
-	params[0] = event;
-	put_be32(interval, &params[1]);
+	pdu[0] = event;
+	put_be32(interval, &pdu[1]);
+
+	iov.iov_base = pdu;
+	iov.iov_len = sizeof(pdu);
 
 	return avrcp_send_req(session, AVC_CTYPE_NOTIFY, AVC_SUBUNIT_PANEL,
-					AVRCP_REGISTER_NOTIFICATION,
-					params, sizeof(params),
-					register_notification_rsp, session);
+				AVRCP_REGISTER_NOTIFICATION, &iov, 1,
+				register_notification_rsp, session);
 }
 
 static gboolean list_attributes_rsp(struct avctp *conn,
@@ -1136,8 +1152,13 @@ done:
 int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t number,
 								uint8_t *attrs)
 {
+	struct iovec iov;
+
+	iov.iov_base = attrs;
+	iov.iov_len = number;
+
 	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
-				AVRCP_GET_PLAYER_ATTRIBUTE_TEXT, attrs, number,
+				AVRCP_GET_PLAYER_ATTRIBUTE_TEXT, &iov, 1,
 				get_attribute_text_rsp, session);
 }
 
@@ -1184,9 +1205,14 @@ done:
 
 int avrcp_list_player_values(struct avrcp *session, uint8_t attr)
 {
+	struct iovec iov;
+
+	iov.iov_base = &attr;
+	iov.iov_len = sizeof(attr);
+
 	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
-				AVRCP_LIST_PLAYER_VALUES, &attr, sizeof(attr),
-				list_values_rsp, session);
+					AVRCP_LIST_PLAYER_VALUES, &iov, 1,
+					list_values_rsp, session);
 }
 
 static gboolean get_value_text_rsp(struct avctp *conn,
@@ -1230,9 +1256,20 @@ done:
 int avrcp_get_player_value_text(struct avrcp *session, uint8_t attr,
 					uint8_t number, uint8_t *values)
 {
+	struct iovec iov[2];
+
+	if (!number)
+		return -EINVAL;
+
+	iov[0].iov_base = &attr;
+	iov[0].iov_len = sizeof(attr);
+
+	iov[1].iov_base = values;
+	iov[0].iov_len = number;
+
 	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
-				AVRCP_GET_PLAYER_VALUE_TEXT, &attr,
-				sizeof(attr), get_value_text_rsp, session);
+					AVRCP_GET_PLAYER_VALUE_TEXT, iov, 2,
+					get_value_text_rsp, session);
 }
 
 static int parse_value(struct avrcp_header *pdu, uint8_t *number,
@@ -1304,22 +1341,20 @@ int avrcp_get_current_player_value(struct avrcp *session, uint8_t number,
 							uint8_t *attrs)
 
 {
-	uint8_t pdu[AVRCP_ATTRIBUTE_LAST + 1];
+	struct iovec iov[2];
 
 	if (number > AVRCP_ATTRIBUTE_LAST)
 		return -EINVAL;
 
-	if (number > 0) {
-		if (!attrs)
-			return -EINVAL;
+	iov[0].iov_base = &number;
+	iov[0].iov_len = sizeof(number);
 
-		pdu[0] = number;
-		memcpy(&pdu[1], attrs, number);
-	}
+	iov[1].iov_base = attrs;
+	iov[1].iov_len = number;
 
 	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
-				AVRCP_GET_CURRENT_PLAYER_VALUE, pdu,
-				number + 1, get_value_rsp, session);
+				AVRCP_GET_CURRENT_PLAYER_VALUE, iov, 2,
+				get_value_rsp, session);
 }
 
 static gboolean set_value_rsp(struct avctp *conn,
@@ -1363,6 +1398,7 @@ done:
 int avrcp_set_player_value(struct avrcp *session, uint8_t number,
 					uint8_t *attrs, uint8_t *values)
 {
+	struct iovec iov;
 	uint8_t pdu[2 * AVRCP_ATTRIBUTE_LAST + 1];
 	int i;
 
@@ -1376,8 +1412,11 @@ int avrcp_set_player_value(struct avrcp *session, uint8_t number,
 		pdu[i * 2 + 2] = values[i];
 	}
 
+	iov.iov_base = pdu;
+	iov.iov_len = 1 + number * 2;
+
 	return avrcp_send_req(session, AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
-				AVRCP_SET_PLAYER_VALUE, pdu, 2 * number + 1,
+				AVRCP_SET_PLAYER_VALUE, &iov, 1,
 				set_value_rsp, session);
 }
 
@@ -1477,10 +1516,14 @@ done:
 
 int avrcp_set_volume(struct avrcp *session, uint8_t volume)
 {
+	struct iovec iov;
+
+	iov.iov_base = &volume;
+	iov.iov_len = sizeof(volume);
+
 	return avrcp_send_req(session, AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
-						AVRCP_SET_ABSOLUTE_VOLUME,
-						&volume, sizeof(volume),
-						set_volume_rsp, session);
+				AVRCP_SET_ABSOLUTE_VOLUME, &iov, 1,
+				set_volume_rsp, session);
 }
 
 static int parse_attribute_list(uint8_t *params, uint16_t params_len,
@@ -1596,13 +1639,17 @@ done:
 
 int avrcp_get_element_attributes(struct avrcp *session)
 {
+	struct iovec iov;
 	uint8_t pdu[9];
 
 	/* This returns all attributes */
 	memset(pdu, 0, sizeof(pdu));
 
+	iov.iov_base = pdu;
+	iov.iov_len = sizeof(pdu);
+
 	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
-				AVRCP_GET_ELEMENT_ATTRIBUTES, pdu, sizeof(pdu),
+				AVRCP_GET_ELEMENT_ATTRIBUTES, &iov, 1,
 				get_element_attributes_rsp, session);
 }
 
@@ -1637,14 +1684,17 @@ done:
 
 int avrcp_set_addressed_player(struct avrcp *session, uint16_t player_id)
 {
-	uint8_t params[2];
+	struct iovec iov;
+	uint8_t pdu[2];
 
-	put_be16(player_id, params);
+	put_be16(player_id, pdu);
+
+	iov.iov_base = pdu;
+	iov.iov_len = sizeof(pdu);
 
 	return avrcp_send_req(session, AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
-				AVRCP_SET_ADDRESSED_PLAYER, params,
-				sizeof(params), set_addressed_rsp,
-				session);
+				AVRCP_SET_ADDRESSED_PLAYER, &iov, 1,
+				set_addressed_rsp, session);
 }
 
 static gboolean set_browsed_rsp(struct avctp *conn, uint8_t *operands,
-- 
1.9.0

