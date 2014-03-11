Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 06/10] android/avrcp: Add vendor unique passthrough request
Date: Tue, 11 Mar 2014 15:05:50 +0200
Message-Id: <1394543154-25355-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394543154-25355-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394458798-13822-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1394543154-25355-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avctp.c     | 22 ++++++++++++++++++++++
 android/avctp.h     |  7 +++++++
 android/avrcp-lib.c |  5 +++++
 android/avrcp-lib.h |  2 ++
 4 files changed, 36 insertions(+)

diff --git a/android/avctp.c b/android/avctp.c
index d970250..33729f0 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -48,6 +48,7 @@
 #include "src/uinput.h"
 
 #include "avctp.h"
+#include "avrcp-lib.h"
 
 /* AV/C Panel 1.23, page 76:
  * command with the pressed value is valid for two seconds
@@ -1214,6 +1215,27 @@ static gboolean repeat_timeout(gpointer user_data)
 	return TRUE;
 }
 
+int avctp_passthrough_vendor_req(struct avctp *session, uint8_t op, bool press)
+{
+	uint8_t operands[7];
+
+	DBG("op %d press %d", op, press);
+
+	if (press)
+		operands[0] = AVC_VENDOR_UNIQUE;
+	else
+		operands[0] = AVC_VENDOR_UNIQUE | 0x80;
+
+	operands[1] = 5;
+	hton24(&operands[2], IEEEID_BTSIG);
+	bt_put_be16(op, &operands[5]);
+
+	return avctp_send_req(session, AVC_CTYPE_CONTROL,
+				AVC_SUBUNIT_PANEL, AVC_OP_PASSTHROUGH,
+				operands, sizeof(operands),
+				avctp_passthrough_rsp, NULL);
+}
+
 static void release_pressed(struct avctp *session)
 {
 	avctp_passthrough_release(session, session->key.op);
diff --git a/android/avctp.h b/android/avctp.h
index 2f419a2..4f65869 100644
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
@@ -170,3 +175,5 @@ int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
 int avctp_send_browsing_req(struct avctp *session,
 				uint8_t *operands, size_t operand_count,
 				avctp_browsing_rsp_cb func, void *user_data);
+int avctp_passthrough_vendor_req(struct avctp *session, uint8_t op,
+								bool press);
diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 5400f80..a9bd438 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -471,3 +471,8 @@ int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
 				AVC_SUBUNIT_PANEL, AVRCP_REGISTER_NOTIFICATION,
 				params, params_len);
 }
+
+int avrcp_passthrough_vendor_req(struct avrcp *session, uint8_t op, bool press)
+{
+	return avctp_passthrough_vendor_req(session->conn, op, press);
+}
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 91a7d47..2acf0fb 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -164,3 +164,5 @@ int avrcp_get_element_attrs_rsp(struct avrcp *session, uint8_t transaction,
 int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t code, uint8_t *params,
 					size_t params_len);
+int avrcp_passthrough_vendor_req(struct avrcp *session, uint8_t op,
+								bool press);
-- 
1.8.3.2

