Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/10] unit/avrcp: Add /TP/PAS/BI-05-C test
Date: Wed,  5 Mar 2014 16:32:29 +0200
Message-Id: <1394029952-3319-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394029952-3319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394029952-3319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that Set player application setting value returns error on
invalid attribute value.
---
 unit/test-avrcp.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 447f3af..b67b89c 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -431,6 +431,34 @@ static ssize_t avrcp_handle_get_current_player_value(struct avrcp *session,
 	return params[0] * 2 + 1;
 }
 
+static ssize_t avrcp_handle_set_player_value(struct avrcp *session,
+						uint8_t transaction,
+						uint16_t params_len,
+						uint8_t *params,
+						void *user_data)
+{
+	int i;
+
+	DBG("params[0] %d params_len %d", params[0], params_len);
+
+	if (params_len != params[0] * 2 + 1)
+		return -EINVAL;
+
+	for (i = 0; i < params[0]; i++) {
+		uint8_t attr = params[i * 2 + 1];
+		uint8_t val = params[i * 2 + 2];
+
+		DBG("attr 0x%02x val 0x%02x", attr, val);
+		switch (attr) {
+		case AVRCP_ATTRIBUTE_REPEAT_MODE:
+			if (val < 0x01 || val > 0x05)
+				return -EINVAL;
+		}
+	}
+
+	return 1;
+}
+
 static const struct avrcp_control_handler control_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
@@ -450,6 +478,9 @@ static const struct avrcp_control_handler control_handlers[] = {
 		{ AVRCP_GET_CURRENT_PLAYER_VALUE,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
 					avrcp_handle_get_current_player_value },
+		{ AVRCP_SET_PLAYER_VALUE,
+					AVC_CTYPE_CONTROL, AVC_CTYPE_STABLE,
+					avrcp_handle_set_player_value },
 		{ },
 };
 
@@ -728,5 +759,17 @@ int main(int argc, char *argv[])
 				AVRCP_GET_CURRENT_PLAYER_VALUE,
 				0x00, 0x00, 0x01, AVRCP_STATUS_INVALID_PARAM));
 
+	/* Set player application setting value invalid behavior - TG */
+	define_test("/TP/PAS/BI-05-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
+				0x00, 0x19, 0x58,
+				AVRCP_SET_PLAYER_VALUE,
+				0x00, 0x00, 0x03, 0x01,
+				AVRCP_ATTRIBUTE_REPEAT_MODE, 0x7f),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_REJECTED,
+				0x48, 0x00, 0x00, 0x19, 0x58,
+				AVRCP_SET_PLAYER_VALUE,
+				0x00, 0x00, 0x01, AVRCP_STATUS_INVALID_PARAM));
+
 	return g_test_run();
 }
-- 
1.8.3.2

