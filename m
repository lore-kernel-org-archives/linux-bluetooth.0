Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] android/avrcp-lib: Embed response code into handler table
Date: Fri, 28 Feb 2014 15:42:33 +0200
Message-Id: <1393594953-4970-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1393594953-4970-1-git-send-email-luiz.dentz@gmail.com>
References: <1393594953-4970-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes the handlers code simpler as they don't need to care about
the response or reject opcode.
---
 android/avrcp-lib.c | 16 ++++++++++++----
 android/avrcp-lib.h |  4 ++--
 unit/test-avrcp.c   | 41 +++++++++++++++++++++--------------------
 3 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index ea36063..34498d3 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -174,14 +174,22 @@ static ssize_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 		goto reject;
 	}
 
-	ret = handler->func(session, transaction, code, params_len,
-					pdu->params, session->control_data);
+	ret = handler->func(session, transaction, params_len, pdu->params,
+							session->control_data);
 	if (ret < 0) {
-		if (ret == -EAGAIN)
+		switch (ret) {
+		case -EAGAIN:
 			return ret;
-		goto reject;
+		case -EINVAL:
+			pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
+			goto reject;
+		default:
+			pdu->params[0] = AVRCP_STATUS_INTERNAL_ERROR;
+			goto reject;
+		}
 	}
 
+	*code = handler->rsp;
 	pdu->params_len = htons(ret);
 
 	return AVRCP_HEADER_LENGTH + ret;
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 5cb0065..6738703 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -82,9 +82,9 @@ struct avrcp;
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
+	uint8_t rsp;
 	ssize_t (*func) (struct avrcp *session, uint8_t transaction,
-			uint8_t *code, uint16_t params_len, uint8_t *params,
-			void *user_data);
+			uint16_t params_len, uint8_t *params, void *user_data);
 };
 
 struct avrcp_passthrough_handler {
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 160f1ce..c3b4f39 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -31,6 +31,7 @@
 #include <inttypes.h>
 #include <string.h>
 #include <fcntl.h>
+#include <errno.h>
 #include <sys/socket.h>
 
 #include <glib.h>
@@ -306,61 +307,61 @@ static const struct avrcp_passthrough_handler passthrough_handlers[] = {
 };
 
 static ssize_t avrcp_handle_get_capabilities(struct avrcp *session,
-					uint8_t transaction, uint8_t *code,
-					uint16_t params_len, uint8_t *params,
-					void *user_data)
+						uint8_t transaction,
+						uint16_t params_len,
+						uint8_t *params,
+						void *user_data)
 {
 	uint32_t id = 0x001958;
 
 	if (params_len != 1)
-		goto fail;
+		return -EINVAL;
 
 	switch (params[0]) {
 	case CAP_COMPANY_ID:
 		params[1] = 1;
 		hton24(&params[2], id);
-		*code = AVC_CTYPE_STABLE;
 		return 5;
 	}
 
-fail:
-	params[0] = AVRCP_STATUS_INVALID_PARAM;
-	*code = AVC_CTYPE_REJECTED;
-	return 1;
+	return -EINVAL;
 }
 
 static ssize_t avrcp_handle_list_attributes(struct avrcp *session,
-					uint8_t transaction, uint8_t *code,
-					uint16_t params_len, uint8_t *params,
-					void *user_data)
+						uint8_t transaction,
+						uint16_t params_len,
+						uint8_t *params,
+						void *user_data)
 {
 	DBG("");
 
 	params[0] = 0;
-	*code = AVC_CTYPE_STABLE;
 
 	return 1;
 }
 
 static ssize_t avrcp_handle_get_player_attr_text(struct avrcp *session,
-					uint8_t transaction, uint8_t *code,
-					uint16_t params_len, uint8_t *params,
-					void *user_data)
+						uint8_t transaction,
+						uint16_t params_len,
+						uint8_t *params,
+						void *user_data)
 {
 	DBG("");
 
 	params[0] = 0;
-	*code = AVC_CTYPE_STABLE;
 
 	return 1;
 }
 
 static const struct avrcp_control_handler control_handlers[] = {
-		{ AVRCP_GET_CAPABILITIES, AVC_CTYPE_STATUS,
+		{ AVRCP_GET_CAPABILITIES,
+					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
 					avrcp_handle_get_capabilities },
-		{ AVRCP_LIST_PLAYER_ATTRIBUTES, AVC_CTYPE_STATUS,
+		{ AVRCP_LIST_PLAYER_ATTRIBUTES,
+					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
 					avrcp_handle_list_attributes },
-		{ AVRCP_GET_PLAYER_ATTRIBUTE_TEXT, AVC_CTYPE_STATUS,
+		{ AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
+					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
 					avrcp_handle_get_player_attr_text },
 		{ },
 };
-- 
1.8.5.3

