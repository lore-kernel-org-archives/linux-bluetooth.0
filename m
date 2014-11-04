Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 3/4] shared/att: Add support for BT_ATT_ALL_REQUESTS
Date: Tue,  4 Nov 2014 13:19:58 -0800
Message-Id: <1415135999-8792-4-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1415135999-8792-1-git-send-email-jamuraa@chromium.org>
References: <1415135999-8792-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/att-types.h |  3 +++
 src/shared/att.c       | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index a6b23e4..a042695 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -55,6 +55,9 @@
 #define BT_ATT_OP_HANDLE_VAL_IND		0x1D
 #define BT_ATT_OP_HANDLE_VAL_CONF		0x1E
 
+/* Special opcode for all requests (legacy servers) */
+#define BT_ATT_ALL_REQUESTS 0xFE
+
 /* Error codes for Error response PDU */
 #define BT_ATT_ERROR_INVALID_HANDLE			0x01
 #define BT_ATT_ERROR_READ_NOT_PERMITTED			0x02
diff --git a/src/shared/att.c b/src/shared/att.c
index 6adde22..aa80cef 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -575,6 +575,15 @@ struct notify_data {
 	bool handler_found;
 };
 
+static bool opcode_match(uint8_t opcode, uint8_t test_opcode)
+{
+	if (opcode == BT_ATT_ALL_REQUESTS &&
+				    get_op_type(test_opcode) == ATT_OP_TYPE_REQ)
+		return true;
+
+	return opcode == test_opcode;
+}
+
 static void notify_handler(void *data, void *user_data)
 {
 	struct att_notify *notify = data;
@@ -583,7 +592,7 @@ static void notify_handler(void *data, void *user_data)
 	if (notify->removed)
 		return;
 
-	if (notify->opcode != not_data->opcode)
+	if (!opcode_match(notify->opcode, not_data->opcode))
 		return;
 
 	not_data->handler_found = true;
-- 
2.1.0.rc2.206.gedb03e5

