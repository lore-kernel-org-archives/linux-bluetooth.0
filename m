Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/9] unit/avrcp: Add /TP/PAS/BV-08-C test
Date: Fri, 28 Feb 2014 16:18:39 +0200
Message-Id: <1393597125-18176-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393597125-18176-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393597125-18176-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that verify the get player application setting values
response issued from the Target.
---
 unit/test-avrcp.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 51fe064..b469dfd 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -375,6 +375,18 @@ fail:
 	return AVC_CTYPE_REJECTED;
 }
 
+static uint8_t avrcp_handle_get_player_value_text(struct avrcp *session,
+				uint8_t transaction, uint16_t *params_len,
+				uint8_t *params, void *user_data)
+{
+	DBG("");
+
+	*params_len = 1;
+	params[0] = 0;
+
+	return AVC_CTYPE_STABLE;
+}
+
 static const struct avrcp_control_handler control_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES, AVC_CTYPE_STATUS,
 					avrcp_handle_get_capabilities },
@@ -384,6 +396,8 @@ static const struct avrcp_control_handler control_handlers[] = {
 					avrcp_handle_get_player_attr_text },
 		{ AVRCP_LIST_PLAYER_VALUES, AVC_CTYPE_STATUS,
 					avrcp_handle_list_player_values },
+		{ AVRCP_GET_PLAYER_VALUE_TEXT, AVC_CTYPE_STATUS,
+					avrcp_handle_get_player_value_text },
 		{ },
 };
 
@@ -550,5 +564,15 @@ int main(int argc, char *argv[])
 				AVRCP_LIST_PLAYER_VALUES,
 				0x00, 0x00, 0x01, 0x00));
 
+	define_test("/TP/PAS/BV-08-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58,
+				AVRCP_GET_PLAYER_VALUE_TEXT,
+				0x00, 0x00, 0x01, 0x00),
+			raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
+				0x00, 0x19, 0x58,
+				AVRCP_GET_PLAYER_VALUE_TEXT,
+				0x00, 0x00, 0x01, 0x00));
+
 	return g_test_run();
 }
-- 
1.8.3.2

