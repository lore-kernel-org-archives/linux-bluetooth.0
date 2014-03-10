Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 07/10] unit/avrcp: Add /TP/NFY/BV-02-C test
Date: Mon, 10 Mar 2014 11:09:50 +0200
Message-Id: <1394442593-4233-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394442593-4233-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394442593-4233-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that Target responds to Register notification command.
---
 android/avrcp-lib.h |  3 +++
 unit/test-avrcp.c   | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 4c845d3..91a7d47 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -86,6 +86,9 @@
 /* Company IDs for vendor dependent commands */
 #define IEEEID_BTSIG		0x001958
 
+/* Parameters legths */
+#define AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH       5
+
 struct avrcp;
 
 struct avrcp_control_handler {
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index fa4870d..0e3bb51 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -162,6 +162,8 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 	ssize_t len;
 	int fd;
 
+	DBG("");
+
 	pdu = &context->data->pdu_list[context->pdu_offset++];
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
@@ -495,6 +497,43 @@ static ssize_t avrcp_handle_get_element_attrs(struct avrcp *session,
 	return -EAGAIN;
 }
 
+static ssize_t avrcp_handle_register_notification(struct avrcp *session,
+							uint8_t transaction,
+							uint16_t params_len,
+							uint8_t *params,
+							void *user_data)
+{
+	uint8_t event;
+	uint8_t pdu[1024];
+	size_t pdu_len;
+
+	DBG("");
+
+	if (params_len != AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH)
+		return -EINVAL;
+
+	event = params[0];
+	pdu[0] = event;
+	pdu_len = 1;
+
+	switch (event) {
+	case AVRCP_EVENT_TRACK_CHANGED:
+		memset(&pdu[1], 0xff, 8);
+		pdu_len += 8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_INTERIM,
+						pdu, pdu_len);
+
+	avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_CHANGED,
+						pdu, pdu_len);
+
+	return -EAGAIN;
+}
+
 static const struct avrcp_control_handler control_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
@@ -523,6 +562,9 @@ static const struct avrcp_control_handler control_handlers[] = {
 		{ AVRCP_GET_ELEMENT_ATTRIBUTES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
 					avrcp_handle_get_element_attrs },
+		{ AVRCP_REGISTER_NOTIFICATION,
+					AVC_CTYPE_NOTIFY, AVC_CTYPE_INTERIM,
+					avrcp_handle_register_notification },
 		{ },
 };
 
@@ -879,5 +921,22 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x05, AVRCP_EVENT_STATUS_CHANGED,
 				0x00, 0x00, 0x00, 0x00));
 
+	/* Register notification - TG */
+	define_test("/TP/NFY/BV-02-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x05, AVRCP_EVENT_TRACK_CHANGED,
+				0x00, 0x00, 0x00, 0x00),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x09, AVRCP_EVENT_TRACK_CHANGED,
+				0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+				0xff, 0xff),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_CHANGED, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x09, AVRCP_EVENT_TRACK_CHANGED,
+				0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+				0xff, 0xff));
+
 	return g_test_run();
 }
-- 
1.8.3.2

