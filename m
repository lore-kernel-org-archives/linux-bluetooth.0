Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 09/10] unit/avrcp: Add /TP/PAS/BI-01-C test
Date: Tue,  4 Mar 2014 16:02:14 +0200
Message-Id: <1393941735-12187-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393941735-12187-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393941735-12187-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that Get player app setting attribute text returns error
given invalid attribute id.
---
 unit/test-avrcp.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 6999d22..803dd6b 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -326,7 +326,16 @@ static ssize_t avrcp_handle_get_player_attr_text(struct avrcp *session,
 						uint8_t *params,
 						void *user_data)
 {
-	DBG("");
+	int i;
+
+	DBG("params[0] %d params_len %d", params[0], params_len);
+
+	for (i = 1; i <= params[0]; i++) {
+		DBG("params[%d] = 0x%02x", i, params[i]);
+		if (params[i] > AVRCP_ATTRIBUTE_LAST ||
+			params[i] == AVRCP_ATTRIBUTE_ILEGAL)
+			return -EINVAL;
+	}
 
 	params[0] = 0;
 
@@ -633,5 +642,18 @@ int main(int argc, char *argv[])
 				AVRCP_ATTRIBUTE_EQUALIZER, 0xaa,
 				AVRCP_ATTRIBUTE_REPEAT_MODE, 0xff));
 
+	/* Get player app setting attribute text invalid behavior - TG */
+	define_test("/TP/PAS/BI-01-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58,
+				AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
+				0x00, 0x00, 0x02, 0x01,
+				/* Invalid attribute id */
+				0x7f),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_REJECTED,
+				0x48, 0x00, 0x00, 0x19, 0x58,
+				AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
+				0x00, 0x00, 0x01, AVRCP_STATUS_INVALID_PARAM));
+
 	return g_test_run();
 }
-- 
1.8.3.2

