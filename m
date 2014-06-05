Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 BlueZ 4/4] android/avrcp-lib: Add fragmentation support
Date: Thu,  5 Jun 2014 14:45:47 +0300
Message-Id: <1401968747-11848-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1401968747-11848-1-git-send-email-luiz.dentz@gmail.com>
References: <1401968747-11848-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds handling for fragmentation if the PDU cannot fit into a AV/C
frame which can be up to 512 bytes or less depending on the L2CAP MTU
negotiated.
---
 android/avrcp-lib.c | 207 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 185 insertions(+), 22 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 036867e..d4e3f44 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -96,6 +96,11 @@ struct avrcp_browsing_handler {
 			uint16_t params_len, uint8_t *params, void *user_data);
 };
 
+struct avrcp_continuing {
+	uint8_t pdu_id;
+	struct iovec pdu;
+};
+
 struct avrcp {
 	struct avctp *conn;
 	struct avrcp_player *player;
@@ -103,6 +108,9 @@ struct avrcp {
 	const struct avrcp_control_handler *control_handlers;
 	void *control_data;
 	unsigned int control_id;
+	uint16_t control_mtu;
+
+	struct avrcp_continuing *continuing;
 
 	const struct avrcp_passthrough_handler *passthrough_handlers;
 	void *passthrough_data;
@@ -135,6 +143,12 @@ static inline void hton24(uint8_t dst[3], uint32_t src)
 	dst[2] = (src & 0x0000ff);
 }
 
+static void continuing_free(struct avrcp_continuing *continuing)
+{
+	g_free(continuing->pdu.iov_base);
+	g_free(continuing);
+}
+
 void avrcp_shutdown(struct avrcp *session)
 {
 	if (session->conn) {
@@ -153,6 +167,9 @@ void avrcp_shutdown(struct avrcp *session)
 	if (session->destroy)
 		session->destroy(session->destroy_data);
 
+	if (session->continuing)
+		continuing_free(session->continuing);
+
 	g_free(session->player);
 	g_free(session);
 }
@@ -340,6 +357,14 @@ struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 							AVC_OP_VENDORDEP,
 							handle_vendordep_pdu,
 							session);
+	session->control_mtu = omtu - AVC_DATA_OFFSET;
+
+	/*
+	 * 27.1.2 AV/C Command Frame
+	 * An AV/C command frame contains up to 512 octets of data
+	 */
+	if (session->control_mtu > AVC_DATA_MTU)
+		session->control_mtu = AVC_DATA_MTU;
 
 	avctp_set_destroy_cb(session->conn, disconnect_cb, session);
 
@@ -751,6 +776,158 @@ static ssize_t set_addressed(struct avrcp *session, uint8_t transaction,
 							player->user_data);
 }
 
+static void continuing_new(struct avrcp *session, uint8_t pdu_id,
+					const struct iovec *iov, int iov_cnt,
+					size_t offset)
+{
+	struct avrcp_continuing *continuing;
+	int i;
+	size_t len = 0;
+
+	continuing = g_new0(struct avrcp_continuing, 1);
+	continuing->pdu_id = pdu_id;
+
+	for (i = 0; i < iov_cnt; i++) {
+		if (i == 0 && offset) {
+			len += iov[i].iov_len - offset;
+			continue;
+		}
+
+		len += iov[i].iov_len;
+	}
+
+	continuing->pdu.iov_base = g_malloc0(len);
+
+	DBG("len %zu", len);
+
+	for (i = 0; i < iov_cnt; i++) {
+		if (i == 0 && offset) {
+			memcpy(continuing->pdu.iov_base,
+						iov[i].iov_base + offset,
+						iov[i].iov_len - offset);
+			continuing->pdu.iov_len += iov[i].iov_len - offset;
+			continue;
+		}
+
+		memcpy(continuing->pdu.iov_base + continuing->pdu.iov_len,
+					iov[i].iov_base, iov[i].iov_len);
+		continuing->pdu.iov_len += iov[i].iov_len;
+	}
+
+	session->continuing = continuing;
+}
+
+static int avrcp_send_internal(struct avrcp *session, uint8_t transaction,
+					uint8_t code, uint8_t subunit,
+					uint8_t pdu_id, uint8_t type,
+					const struct iovec *iov, int iov_cnt)
+{
+	struct iovec pdu[iov_cnt + 1];
+	struct avrcp_header hdr;
+	int i;
+
+	/*
+	 * If a receiver receives a start fragment or non-fragmented AVRCP
+	 * Specific AV/C message when it already has an incomplete fragment
+	 * from that sender then the receiver shall consider the first PDU
+	 * aborted.
+	 */
+	if (session->continuing) {
+		continuing_free(session->continuing);
+		session->continuing = NULL;
+	}
+
+	memset(&hdr, 0, sizeof(hdr));
+
+	pdu[0].iov_base = &hdr;
+	pdu[0].iov_len = sizeof(hdr);
+
+	hdr.packet_type = type;
+
+	for (i = 0; i < iov_cnt; i++) {
+		pdu[i + 1].iov_base = iov[i].iov_base;
+
+		if (pdu[0].iov_len + hdr.params_len + iov[i].iov_len <=
+							session->control_mtu) {
+			pdu[i + 1].iov_len = iov[i].iov_len;
+			hdr.params_len += iov[i].iov_len;
+			if (hdr.packet_type != AVRCP_PACKET_TYPE_SINGLE)
+				hdr.packet_type = AVRCP_PACKET_TYPE_END;
+			continue;
+		}
+
+		/*
+		 * Only send what can fit and store the remaining in the
+		 * continuing iovec
+		 */
+		pdu[i + 1].iov_len = session->control_mtu -
+					(pdu[0].iov_len + hdr.params_len);
+		hdr.params_len += pdu[i + 1].iov_len;
+
+		continuing_new(session, pdu_id, &iov[i], iov_cnt - i,
+							pdu[i + 1].iov_len);
+
+		hdr.packet_type = hdr.packet_type != AVRCP_PACKET_TYPE_SINGLE ?
+						AVRCP_PACKET_TYPE_CONTINUING :
+						AVRCP_PACKET_TYPE_START;
+		break;
+	}
+
+	hton24(hdr.company_id, IEEEID_BTSIG);
+	hdr.pdu_id = pdu_id;
+	hdr.params_len = htons(hdr.params_len);
+
+	return avctp_send_vendor(session->conn, transaction, code, subunit,
+							pdu, iov_cnt + 1);
+}
+
+static ssize_t request_continuing(struct avrcp *session, uint8_t transaction,
+					uint16_t params_len, uint8_t *params,
+					void *user_data)
+{
+	struct iovec iov;
+	int err;
+
+	DBG("");
+
+	if (!params || params_len != 1 || !session->continuing ||
+				session->continuing->pdu_id != params[0])
+		return -EINVAL;
+
+	iov.iov_base = session->continuing->pdu.iov_base;
+	iov.iov_len = session->continuing->pdu.iov_len;
+
+	DBG("len %zu", iov.iov_len);
+
+	session->continuing->pdu.iov_base = NULL;
+
+	err = avrcp_send_internal(session, transaction, AVC_CTYPE_STABLE,
+					AVC_SUBUNIT_PANEL, params[0],
+					AVRCP_PACKET_TYPE_CONTINUING, &iov, 1);
+
+	g_free(iov.iov_base);
+
+	if (err < 0)
+		return -EINVAL;
+
+	return -EAGAIN;
+}
+
+static ssize_t abort_continuing(struct avrcp *session, uint8_t transaction,
+					uint16_t params_len, uint8_t *params,
+					void *user_data)
+{
+	DBG("");
+
+	if (!params || params_len != 1 || !session->continuing)
+		return -EINVAL;
+
+	continuing_free(session->continuing);
+	session->continuing = NULL;
+
+	return 0;
+}
+
 static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
@@ -788,6 +965,12 @@ static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_SET_ADDRESSED_PLAYER,
 					AVC_CTYPE_CONTROL, AVC_CTYPE_STABLE,
 					set_addressed },
+		{ AVRCP_REQUEST_CONTINUING,
+					AVC_CTYPE_CONTROL, AVC_CTYPE_STABLE,
+					request_continuing },
+		{ AVRCP_ABORT_CONTINUING,
+					AVC_CTYPE_CONTROL, AVC_CTYPE_ACCEPTED,
+					abort_continuing },
 		{ },
 };
 
@@ -1049,28 +1232,8 @@ int avrcp_send(struct avrcp *session, uint8_t transaction, uint8_t code,
 					uint8_t subunit, uint8_t pdu_id,
 					const struct iovec *iov, int iov_cnt)
 {
-	struct iovec pdu[iov_cnt + 1];
-	struct avrcp_header hdr;
-	int i;
-
-	memset(&hdr, 0, sizeof(hdr));
-
-	pdu[0].iov_base = &hdr;
-	pdu[0].iov_len = sizeof(hdr);
-
-	for (i = 0; i < iov_cnt; i++) {
-		pdu[i + 1].iov_base = iov[i].iov_base;
-		pdu[i + 1].iov_len = iov[i].iov_len;
-		hdr.params_len += iov[i].iov_len;
-	}
-
-	hton24(hdr.company_id, IEEEID_BTSIG);
-	hdr.pdu_id = pdu_id;
-	hdr.packet_type = AVRCP_PACKET_TYPE_SINGLE;
-	hdr.params_len = htons(hdr.params_len);
-
-	return avctp_send_vendor(session->conn, transaction, code, subunit,
-							pdu, iov_cnt + 1);
+	return avrcp_send_internal(session, transaction, code, subunit, pdu_id,
+					AVRCP_PACKET_TYPE_SINGLE, iov, iov_cnt);
 }
 
 static int status2errno(uint8_t status)
-- 
1.9.3

