Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/16] android/avrcp-lib: Rework handler callback parameters
Date: Sun,  2 Mar 2014 20:48:18 +0200
Message-Id: <1393786109-6554-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
References: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This rework handler callback parameters to make it able to return
proper error such as -EAGAIN to implement asynchronous responses.
---
 android/avrcp-lib.c | 12 +++++++++---
 android/avrcp-lib.h |  5 +++--
 unit/test-avrcp.c   | 42 +++++++++++++++++++++---------------------
 3 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index cdad6ac..339be16 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -125,6 +125,7 @@ static ssize_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 	struct avrcp_header *pdu = (void *) operands;
 	uint32_t company_id = ntoh24(pdu->company_id);
 	uint16_t params_len = ntohs(pdu->params_len);
+	ssize_t ret;
 
 	if (company_id != IEEEID_BTSIG) {
 		*code = AVC_CTYPE_NOT_IMPLEMENTED;
@@ -159,12 +160,17 @@ static ssize_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 		goto reject;
 	}
 
-	*code = handler->func(session, transaction, &params_len,
+	ret = handler->func(session, transaction, code, params_len,
 					pdu->params, session->control_data);
+	if (ret < 0) {
+		if (ret == -EAGAIN)
+			return ret;
+		goto reject;
+	}
 
-	pdu->params_len = htons(params_len);
+	pdu->params_len = htons(ret);
 
-	return AVRCP_HEADER_LENGTH + params_len;
+	return AVRCP_HEADER_LENGTH + ret;
 
 reject:
 	pdu->params_len = htons(1);
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index a33bdfe..d7a805b 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -79,8 +79,9 @@ struct avrcp;
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
-	uint8_t (*func) (struct avrcp *session, uint8_t transaction,
-			uint16_t *params_len, uint8_t *params, void *user_data);
+	ssize_t (*func) (struct avrcp *session, uint8_t transaction,
+			uint8_t *code, uint16_t params_len, uint8_t *params,
+			void *user_data);
 };
 
 struct avrcp_passthrough_handler {
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 302c331..2d5711b 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -292,54 +292,54 @@ static const struct avrcp_passthrough_handler passthrough_handlers[] = {
 		{ },
 };
 
-static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
-				uint8_t transaction, uint16_t *params_len,
-				uint8_t *params, void *user_data)
+static ssize_t avrcp_handle_get_capabilities(struct avrcp *session,
+					uint8_t transaction, uint8_t *code,
+					uint16_t params_len, uint8_t *params,
+					void *user_data)
 {
 	uint32_t id = 0x001958;
 
-	DBG("params[0] %d params_len %d", params[0], *params_len);
-
-	if (*params_len != 1)
+	if (params_len != 1)
 		goto fail;
 
 	switch (params[0]) {
 	case CAP_COMPANY_ID:
-		*params_len = 5;
 		params[1] = 1;
 		hton24(&params[2], id);
-		return AVC_CTYPE_STABLE;
+		*code = AVC_CTYPE_STABLE;
+		return 5;
 	}
 
 fail:
-	*params_len = 1;
 	params[0] = AVRCP_STATUS_INVALID_PARAM;
-
-	return AVC_CTYPE_REJECTED;
+	*code = AVC_CTYPE_REJECTED;
+	return 1;
 }
 
-static uint8_t avrcp_handle_list_attributes(struct avrcp *session,
-				uint8_t transaction, uint16_t *params_len,
-				uint8_t *params, void *user_data)
+static ssize_t avrcp_handle_list_attributes(struct avrcp *session,
+					uint8_t transaction, uint8_t *code,
+					uint16_t params_len, uint8_t *params,
+					void *user_data)
 {
 	DBG("");
 
-	*params_len = 1;
 	params[0] = 0;
+	*code = AVC_CTYPE_STABLE;
 
-	return AVC_CTYPE_STABLE;
+	return 1;
 }
 
-static uint8_t avrcp_handle_get_player_attr_text(struct avrcp *session,
-				uint8_t transaction, uint16_t *params_len,
-				uint8_t *params, void *user_data)
+static ssize_t avrcp_handle_get_player_attr_text(struct avrcp *session,
+					uint8_t transaction, uint8_t *code,
+					uint16_t params_len, uint8_t *params,
+					void *user_data)
 {
 	DBG("");
 
-	*params_len = 1;
 	params[0] = 0;
+	*code = AVC_CTYPE_STABLE;
 
-	return AVC_CTYPE_STABLE;
+	return 1;
 }
 
 static const struct avrcp_control_handler control_handlers[] = {
-- 
1.8.5.3

