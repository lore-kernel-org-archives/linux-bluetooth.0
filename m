Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 1/5] android/avrcp: Add vendor unique passthrough request
Date: Wed, 12 Mar 2014 12:54:29 +0200
Message-Id: <1394621673-13718-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <CABBYNZK6yEDvVwda3GBubgh2+J=SwE_Vmr5oEJ_hhqhOLd2CsA@mail.gmail.com>
References: <CABBYNZK6yEDvVwda3GBubgh2+J=SwE_Vmr5oEJ_hhqhOLd2CsA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avctp.c     | 74 +++++++++++++++++++++++++++++++++++++++++------------
 android/avctp.h     |  8 +++++-
 android/avrcp-lib.c | 12 +++++++++
 android/avrcp-lib.h |  2 ++
 4 files changed, 79 insertions(+), 17 deletions(-)

diff --git a/android/avctp.c b/android/avctp.c
index d970250..e9ba6db 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -159,6 +159,8 @@ struct avctp_channel {
 
 struct key_pressed {
 	uint8_t op;
+	uint8_t *params;
+	size_t params_len;
 	guint timer;
 };
 
@@ -1172,25 +1174,38 @@ static const char *op2str(uint8_t op)
 	return "UNKNOWN";
 }
 
-static int avctp_passthrough_press(struct avctp *session, uint8_t op)
+static int avctp_passthrough_press(struct avctp *session, uint8_t op,
+					uint8_t *params, size_t params_len)
 {
-	uint8_t operands[2];
+	uint8_t operands[7];
+	size_t len;
 
-	DBG("%s", op2str(op));
+	DBG("op 0x%02x %s params_len %zd", op, op2str(op), params_len);
 
 	/* Button pressed */
 	operands[0] = op & 0x7f;
-	operands[1] = 0;
+
+	if (op == AVC_VENDOR_UNIQUE && params &&
+				params_len == 5) {
+		memcpy(&operands[2], params, params_len);
+		len = params_len + 2;
+		operands[1] = params_len;
+	} else {
+		len = 2;
+		operands[1] = 0;
+	}
 
 	return avctp_send_req(session, AVC_CTYPE_CONTROL,
 				AVC_SUBUNIT_PANEL, AVC_OP_PASSTHROUGH,
-				operands, sizeof(operands),
+				operands, len,
 				avctp_passthrough_rsp, NULL);
 }
 
-static int avctp_passthrough_release(struct avctp *session, uint8_t op)
+static int avctp_passthrough_release(struct avctp *session, uint8_t op,
+					uint8_t *params, size_t params_len)
 {
-	uint8_t operands[2];
+	uint8_t operands[7];
+	size_t len;
 
 	DBG("%s", op2str(op));
 
@@ -1198,9 +1213,16 @@ static int avctp_passthrough_release(struct avctp *session, uint8_t op)
 	operands[0] = op | 0x80;
 	operands[1] = 0;
 
+	if (op == AVC_VENDOR_UNIQUE && params &&
+				params_len > sizeof(operands) - 2) {
+		memcpy(&operands[2], params, params_len);
+		len = params_len;
+	} else
+		len = 2;
+
 	return avctp_send_req(session, AVC_CTYPE_CONTROL,
 				AVC_SUBUNIT_PANEL, AVC_OP_PASSTHROUGH,
-				operands, sizeof(operands),
+				operands, len,
 				NULL, NULL);
 }
 
@@ -1208,15 +1230,18 @@ static gboolean repeat_timeout(gpointer user_data)
 {
 	struct avctp *session = user_data;
 
-	avctp_passthrough_release(session, session->key.op);
-	avctp_passthrough_press(session, session->key.op);
+	avctp_passthrough_release(session, session->key.op, session->key.params,
+						session->key.params_len);
+	avctp_passthrough_press(session, session->key.op, session->key.params,
+						session->key.params_len);
 
 	return TRUE;
 }
 
 static void release_pressed(struct avctp *session)
 {
-	avctp_passthrough_release(session, session->key.op);
+	avctp_passthrough_release(session, session->key.op, session->key.params,
+						session->key.params_len);
 
 	if (session->key.timer > 0)
 		g_source_remove(session->key.timer);
@@ -1224,7 +1249,8 @@ static void release_pressed(struct avctp *session)
 	session->key.timer = 0;
 }
 
-static bool set_pressed(struct avctp *session, uint8_t op)
+static bool set_pressed(struct avctp *session, uint8_t op, uint8_t *params,
+							size_t params_len)
 {
 	if (session->key.timer > 0) {
 		if (session->key.op == op)
@@ -1236,6 +1262,8 @@ static bool set_pressed(struct avctp *session, uint8_t op)
 		return FALSE;
 
 	session->key.op = op;
+	session->key.params = params;
+	session->key.params_len = params_len;
 	session->key.timer = g_timeout_add_seconds(AVC_PRESS_TIMEOUT,
 							repeat_timeout,
 							session);
@@ -1247,24 +1275,38 @@ static gboolean avctp_passthrough_rsp(struct avctp *session, uint8_t code,
 					uint8_t subunit, uint8_t *operands,
 					size_t operand_count, void *user_data)
 {
+	uint8_t *params;
+	size_t params_len;
+
+	DBG("code 0x%02x operand_count %zd", code, operand_count);
+
 	if (code != AVC_CTYPE_ACCEPTED)
 		return FALSE;
 
-	if (set_pressed(session, operands[0]))
+	if (operands[0] == AVC_VENDOR_UNIQUE) {
+		params = &operands[2];
+		params_len = operand_count - 2;
+	} else {
+		params = NULL;
+		params_len = 0;
+	}
+
+	if (set_pressed(session, operands[0], params, params_len))
 		return FALSE;
 
-	avctp_passthrough_release(session, operands[0]);
+	avctp_passthrough_release(session, operands[0], params, params_len);
 
 	return FALSE;
 }
 
-int avctp_send_passthrough(struct avctp *session, uint8_t op)
+int avctp_send_passthrough(struct avctp *session, uint8_t op, uint8_t *params,
+							size_t params_len)
 {
 	/* Auto release if key pressed */
 	if (session->key.timer > 0)
 		release_pressed(session);
 
-	return avctp_passthrough_press(session, op);
+	return avctp_passthrough_press(session, op, params, params_len);
 }
 
 int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
diff --git a/android/avctp.h b/android/avctp.h
index 2f419a2..98c1142 100644
--- a/android/avctp.h
+++ b/android/avctp.h
@@ -108,6 +108,11 @@
 #define AVC_BLUE			0x7c
 #define AVC_YELLOW			0x7c
 
+#define AVC_VENDOR_UNIQUE		0x7e
+
+#define AVC_VENDOR_NEXT_GROUP		0x00
+#define AVC_VENDOR_PREV_GROUP		0x01
+
 struct avctp;
 
 typedef bool (*avctp_passthrough_cb) (struct avctp *session,
@@ -159,7 +164,8 @@ unsigned int avctp_register_browsing_pdu_handler(struct avctp *session,
 bool avctp_unregister_browsing_pdu_handler(struct avctp *session,
 							unsigned int id);
 
-int avctp_send_passthrough(struct avctp *session, uint8_t op);
+int avctp_send_passthrough(struct avctp *session, uint8_t op, uint8_t *params,
+							size_t params_len);
 int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
 				uint8_t code, uint8_t subunit,
 				uint8_t *operands, size_t operand_count);
diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 5400f80..2cdd1e0 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -471,3 +471,15 @@ int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
 				AVC_SUBUNIT_PANEL, AVRCP_REGISTER_NOTIFICATION,
 				params, params_len);
 }
+
+int avrcp_send_passthrough_vendor(struct avrcp *session, uint8_t vendor_op,
+							uint16_t vendor_id)
+{
+	uint8_t params[5];
+
+	hton24(params, vendor_id);
+	bt_put_be16(vendor_op, &params[3]);
+
+	return avctp_send_passthrough(session->conn, AVC_VENDOR_UNIQUE, params,
+								sizeof(params));
+}
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 91a7d47..3a2012a 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -164,3 +164,5 @@ int avrcp_get_element_attrs_rsp(struct avrcp *session, uint8_t transaction,
 int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t code, uint8_t *params,
 					size_t params_len);
+int avrcp_send_passthrough_vendor(struct avrcp *session, uint8_t vendor_op,
+							uint16_t vendor_id);
-- 
1.8.3.2

