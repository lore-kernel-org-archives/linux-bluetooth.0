Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] unit/avrcp: Add /TP/MDI/BV-04-C test
Date: Thu,  6 Mar 2014 16:43:02 +0200
Message-Id: <1394116985-28247-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394116985-28247-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394116985-28247-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies Get element attributes responded by Target.
---
 unit/test-avrcp.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index d50b1ad..45ac798 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -476,6 +476,22 @@ static ssize_t avrcp_handle_get_play_status(struct avrcp *session,
 	return -EAGAIN;
 }
 
+static ssize_t avrcp_handle_get_element_attrs(struct avrcp *session,
+						uint8_t transaction,
+						uint16_t params_len,
+						uint8_t *params,
+						void *user_data)
+{
+	DBG("");
+
+	if (params_len < 9)
+		return -EINVAL;
+
+	avrcp_get_element_attrs_rsp(session, transaction, NULL, 0);
+
+	return -EAGAIN;
+}
+
 static const struct avrcp_control_handler control_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
@@ -501,6 +517,9 @@ static const struct avrcp_control_handler control_handlers[] = {
 		{ AVRCP_GET_PLAY_STATUS,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
 					avrcp_handle_get_play_status },
+		{  AVRCP_GET_ELEMENT_ATTRIBUTES,
+					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
+					avrcp_handle_get_element_attrs },
 		{ },
 };
 
@@ -822,5 +841,14 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x09, 0x00, 0x00, 0x00,
 				0x00, 0x00, 0x00, 0x00, 0x00, 0x00));
 
+	/* Get element attributes - TG */
+	define_test("/TP/MDI/BV-04-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRIBUTES,
+				0x00, 0x00, 0x09, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x00, 0x00, 0x00, 0x00),
+			raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRIBUTES,
+				0x00, 0x00, 0x00));
 	return g_test_run();
 }
-- 
1.8.3.2

