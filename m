Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/35] android/avrcp-lib: Add initial code for handling browsing PDUs
Date: Fri, 25 Apr 2014 11:38:39 +0300
Message-Id: <1398415152-22950-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 147 +++++++++++++++++++++++++++++++++++++++++++++++-----
 android/avrcp-lib.h |   3 ++
 2 files changed, 136 insertions(+), 14 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 73f827b..8f7f187 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -90,6 +90,12 @@ struct avrcp_control_handler {
 			uint16_t params_len, uint8_t *params, void *user_data);
 };
 
+struct avrcp_browsing_handler {
+	uint8_t id;
+	ssize_t (*func) (struct avrcp *session, uint8_t transaction,
+			uint16_t params_len, uint8_t *params, void *user_data);
+};
+
 struct avrcp {
 	struct avctp *conn;
 	struct avrcp_player *player;
@@ -105,6 +111,10 @@ struct avrcp {
 	void *passthrough_data;
 	unsigned int passthrough_id;
 
+	const struct avrcp_browsing_handler *browsing_handlers;
+	void *browsing_data;
+	unsigned int browsing_id;
+
 	avrcp_destroy_cb_t destroy;
 	void *destroy_data;
 };
@@ -194,6 +204,28 @@ static struct avrcp_browsing_header *parse_browsing_pdu(uint8_t *operands,
 	return pdu;
 }
 
+static uint8_t errno2status(int err)
+{
+	switch (err) {
+	case -ENOSYS:
+		return AVRCP_STATUS_INVALID_COMMAND;
+	case -EINVAL:
+		return AVRCP_STATUS_INVALID_PARAM;
+	case 0:
+		return AVRCP_STATUS_SUCCESS;
+	case -ENOTDIR:
+		return AVRCP_STATUS_NOT_DIRECTORY;
+	case -EBADRQC:
+		return AVRCP_STATUS_INVALID_SCOPE;
+	case -ERANGE:
+		return AVRCP_STATUS_OUT_OF_BOUNDS;
+	case -ENOENT:
+		return AVRCP_STATUS_DOES_NOT_EXIST;
+	default:
+		return AVRCP_STATUS_INTERNAL_ERROR;
+	}
+}
+
 static ssize_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 					uint8_t *code, uint8_t *subunit,
 					uint8_t *operands, size_t operand_count,
@@ -244,19 +276,10 @@ static ssize_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 	ret = handler->func(session, transaction, pdu->params_len, pdu->params,
 							session->control_data);
 	if (ret < 0) {
-		switch (ret) {
-		case -EAGAIN:
+		if (ret == -EAGAIN)
 			return ret;
-		case -ENOSYS:
-			pdu->params[0] = AVRCP_STATUS_INVALID_COMMAND;
-			goto reject;
-		case -EINVAL:
-			pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
-			goto reject;
-		default:
-			pdu->params[0] = AVRCP_STATUS_INTERNAL_ERROR;
-			goto reject;
-		}
+		pdu->params[0] = errno2status(ret);
+		goto reject;
 	}
 
 	*code = handler->rsp;
@@ -330,10 +353,89 @@ struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 	return session;
 }
 
+static ssize_t handle_browsing_pdu(struct avctp *conn,
+					uint8_t transaction, uint8_t *operands,
+					size_t operand_count, void *user_data)
+{
+	struct avrcp *session = user_data;
+	const struct avrcp_browsing_handler *handler;
+	struct avrcp_browsing_header *pdu;
+	int ret;
+
+	pdu = parse_browsing_pdu(operands, operand_count);
+	if (!pdu) {
+		pdu = (void *) operands;
+		pdu->params[0] = AVRCP_STATUS_INVALID_COMMAND;
+		goto reject;
+	}
+
+	DBG("AVRCP Browsing PDU 0x%02X, len 0x%04X", pdu->pdu_id,
+							pdu->params_len);
+
+	if (!session->browsing_handlers) {
+		pdu->pdu_id = AVRCP_GENERAL_REJECT;
+		pdu->params[0] = AVRCP_STATUS_INTERNAL_ERROR;
+		goto reject;
+	}
+
+	for (handler = session->browsing_handlers; handler->id; handler++) {
+		if (handler->id == pdu->pdu_id)
+			break;
+	}
+
+	if (handler->id != pdu->pdu_id) {
+		pdu->pdu_id = AVRCP_GENERAL_REJECT;
+		pdu->params[0] = AVRCP_STATUS_INVALID_COMMAND;
+		goto reject;
+	}
+
+	if (!handler->func) {
+		pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
+		goto reject;
+	}
+
+	ret = handler->func(session, transaction, pdu->params_len, pdu->params,
+							session->control_data);
+	if (ret < 0) {
+		if (ret == -EAGAIN)
+			return ret;
+		pdu->params[0] = errno2status(ret);
+		goto reject;
+	}
+
+	pdu->params_len = htons(ret);
+
+	return AVRCP_BROWSING_HEADER_LENGTH + ret;
+
+reject:
+	pdu->params_len = htons(1);
+
+	return AVRCP_BROWSING_HEADER_LENGTH + 1;
+}
+
+static void browsing_disconnect_cb(void *data)
+{
+	struct avrcp *session = data;
+
+	session->browsing_id = 0;
+}
+
 int avrcp_connect_browsing(struct avrcp *session, int fd, size_t imtu,
 								size_t omtu)
 {
-	return avctp_connect_browsing(session->conn, fd, imtu, omtu);
+	int err;
+
+	err = avctp_connect_browsing(session->conn, fd, imtu, omtu);
+	if (err < 0)
+		return err;
+
+	session->browsing_id = avctp_register_browsing_pdu_handler(
+							session->conn,
+							handle_browsing_pdu,
+							session,
+							browsing_disconnect_cb);
+
+	return 0;
 }
 
 void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
@@ -680,6 +782,18 @@ static void avrcp_set_control_handlers(struct avrcp *session,
 	session->control_data = user_data;
 }
 
+static const struct avrcp_browsing_handler browsing_handlers[] = {
+		{ },
+};
+
+static void avrcp_set_browsing_handlers(struct avrcp *session,
+				const struct avrcp_browsing_handler *handlers,
+				void *user_data)
+{
+	session->browsing_handlers = handlers;
+	session->browsing_data = user_data;
+}
+
 void avrcp_register_player(struct avrcp *session,
 				const struct avrcp_control_ind *ind,
 				const struct avrcp_control_cfm *cfm,
@@ -693,6 +807,7 @@ void avrcp_register_player(struct avrcp *session,
 	player->user_data = user_data;
 
 	avrcp_set_control_handlers(session, player_handlers, player);
+	avrcp_set_browsing_handlers(session, browsing_handlers, player);
 	session->player = player;
 }
 
@@ -747,8 +862,12 @@ static int status2errno(uint8_t status)
 		return -EINVAL;
 	case AVRCP_STATUS_SUCCESS:
 		return 0;
+	case AVRCP_STATUS_NOT_DIRECTORY:
+		return -ENOTDIR;
+	case AVRCP_STATUS_INVALID_SCOPE:
+		return -EBADRQC;
 	case AVRCP_STATUS_OUT_OF_BOUNDS:
-		return -EOVERFLOW;
+		return -ERANGE;
 	case AVRCP_STATUS_INTERNAL_ERROR:
 	case AVRCP_STATUS_INVALID_PLAYER_ID:
 	case AVRCP_STATUS_PLAYER_NOT_BROWSABLE:
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 4d1bbcc..a2cff01 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -66,6 +66,9 @@
 #define AVRCP_STATUS_PARAM_NOT_FOUND		0x02
 #define AVRCP_STATUS_INTERNAL_ERROR		0x03
 #define AVRCP_STATUS_SUCCESS			0x04
+#define AVRCP_STATUS_NOT_DIRECTORY		0x08
+#define AVRCP_STATUS_DOES_NOT_EXIST		0x09
+#define AVRCP_STATUS_INVALID_SCOPE		0x0a
 #define AVRCP_STATUS_OUT_OF_BOUNDS		0x0b
 #define AVRCP_STATUS_INVALID_PLAYER_ID		0x11
 #define AVRCP_STATUS_PLAYER_NOT_BROWSABLE	0x12
-- 
1.9.0

