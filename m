Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] unit/avrcp: Add /TP/PAS/BV-02-C test
Date: Thu, 27 Feb 2014 15:35:10 +0200
Message-Id: <1393508113-18628-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the List Player Application Setting Attributes
response issued from the Target.
---
 unit/test-avrcp.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index c65f743..c4faca3 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -331,9 +331,23 @@ fail:
 	return AVC_CTYPE_REJECTED;
 }
 
+static uint8_t avrcp_handle_list_attributes(struct avrcp *session,
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
+		{ AVRCP_LIST_PLAYER_ATTRIBUTES, AVC_CTYPE_STATUS,
+					avrcp_handle_list_attributes },
 		{ },
 };
 
@@ -462,5 +476,13 @@ int main(int argc, char *argv[])
 				0x00, 0x19, 0x58, 0x11, 0x00, 0x00,
 				0x00));
 
+	define_test("/TP/PAS/BV-02-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58, 0x11, 0x00, 0x00,
+				0x00),
+			raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
+				0x00, 0x19, 0x58, 0x11, 0x00, 0x00,
+				0x01, 0x00));
+
 	return g_test_run();
 }
-- 
1.8.3.2

