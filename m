Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 06/10] unit/avrcp: Add /TP/PAS/BV-10-C test
Date: Tue,  4 Mar 2014 16:02:11 +0200
Message-Id: <1393941735-12187-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393941735-12187-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393941735-12187-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the get current player application setting value
response issued from the Target.
---
 unit/test-avrcp.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index a849be3..e7d37e0 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -365,6 +365,31 @@ static ssize_t avrcp_handle_get_player_value_text(struct avrcp *session,
 	return 1;
 }
 
+static ssize_t avrcp_handle_get_current_player_value(struct avrcp *session,
+						uint8_t transaction,
+						uint16_t params_len,
+						uint8_t *params,
+						void *user_data)
+{
+	uint8_t *attributes;
+	int i;
+
+	DBG("params[0] %d params_len %d", params[0], params_len);
+
+	attributes = g_memdup(&params[1], params[0]);
+
+	for (i = 0; i < params[0]; i++) {
+		params[i * 2 + 1] = attributes[i];
+		params[i * 2 + 2] = 0; /* value */
+	}
+
+	g_free(attributes);
+
+	params[0] = i;
+
+	return params[0] * 2 + 1;
+}
+
 static const struct avrcp_control_handler control_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
@@ -381,6 +406,9 @@ static const struct avrcp_control_handler control_handlers[] = {
 		{ AVRCP_GET_PLAYER_VALUE_TEXT,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
 					avrcp_handle_get_player_value_text },
+		{ AVRCP_GET_CURRENT_PLAYER_VALUE,
+					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
+					avrcp_handle_get_current_player_value },
 		{ },
 };
 
@@ -573,5 +601,19 @@ int main(int argc, char *argv[])
 				AVRCP_ATTRIBUTE_EQUALIZER,
 				AVRCP_ATTRIBUTE_REPEAT_MODE));
 
+	define_test("/TP/PAS/BV-10-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58,
+				AVRCP_GET_CURRENT_PLAYER_VALUE,
+				0x00, 0x00, 0x03, 0x02,
+				AVRCP_ATTRIBUTE_EQUALIZER,
+				AVRCP_ATTRIBUTE_REPEAT_MODE),
+			raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
+				0x00, 0x19, 0x58,
+				AVRCP_GET_CURRENT_PLAYER_VALUE,
+				0x00, 0x00, 0x05, 0x02,
+				AVRCP_ATTRIBUTE_EQUALIZER, 0x00,
+				AVRCP_ATTRIBUTE_REPEAT_MODE, 0x00));
+
 	return g_test_run();
 }
-- 
1.8.3.2

