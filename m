Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 02/10] unit/avrcp: Add /TP/PAS/BV-06-C test
Date: Tue,  4 Mar 2014 16:02:07 +0200
Message-Id: <1393941735-12187-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393941735-12187-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393941735-12187-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the list player application setting values response
issued from the Target.
---
 unit/test-avrcp.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 8119b53..d33a459 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -333,6 +333,22 @@ static ssize_t avrcp_handle_get_player_attr_text(struct avrcp *session,
 	return 1;
 }
 
+static ssize_t avrcp_handle_list_player_values(struct avrcp *session,
+						uint8_t transaction,
+						uint16_t params_len,
+						uint8_t *params,
+						void *user_data)
+{
+	DBG("params[0] %d params_len %d", params[0], params_len);
+
+	if (params_len != 1)
+		return -EINVAL;
+
+	params[0] = 0;
+
+	return 1;
+}
+
 static const struct avrcp_control_handler control_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
@@ -343,6 +359,9 @@ static const struct avrcp_control_handler control_handlers[] = {
 		{ AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
 					avrcp_handle_get_player_attr_text },
+		{ AVRCP_LIST_PLAYER_VALUES,
+					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
+					avrcp_handle_list_player_values },
 		{ },
 };
 
@@ -499,5 +518,15 @@ int main(int argc, char *argv[])
 				AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
 				0x00, 0x00, 0x01, 0x00));
 
+	define_test("/TP/PAS/BV-06-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58,
+				AVRCP_LIST_PLAYER_VALUES,
+				0x00, 0x00, 0x01, 0x00),
+			raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
+				0x00, 0x19, 0x58,
+				AVRCP_LIST_PLAYER_VALUES,
+				0x00, 0x00, 0x01, 0x00));
+
 	return g_test_run();
 }
-- 
1.8.3.2

