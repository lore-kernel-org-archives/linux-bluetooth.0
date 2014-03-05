Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/10] unit/avrcp: Add /TP/PAS/BI-04-C test
Date: Wed,  5 Mar 2014 16:32:28 +0200
Message-Id: <1394029952-3319-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394029952-3319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394029952-3319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that Get current player application setting value return
error when given invalid attribute id.
---
 unit/test-avrcp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 3a26a06..447f3af 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -414,6 +414,9 @@ static ssize_t avrcp_handle_get_current_player_value(struct avrcp *session,
 
 	DBG("params[0] %d params_len %d", params[0], params_len);
 
+	if (!check_attributes(params))
+		return -EINVAL;
+
 	attributes = g_memdup(&params[1], params[0]);
 
 	for (i = 0; i < params[0]; i++) {
@@ -712,5 +715,18 @@ int main(int argc, char *argv[])
 				AVRCP_GET_PLAYER_VALUE_TEXT,
 				0x00, 0x00, 0x01, AVRCP_STATUS_INVALID_PARAM));
 
+	/* Get current player application setting value invalid behavior - TG */
+	define_test("/TP/PAS/BI-04-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58,
+				AVRCP_GET_CURRENT_PLAYER_VALUE,
+				0x00, 0x00, 0x02, 0x01,
+				/* Invalid attribute */
+				0x7f),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_REJECTED,
+				0x48, 0x00, 0x00, 0x19, 0x58,
+				AVRCP_GET_CURRENT_PLAYER_VALUE,
+				0x00, 0x00, 0x01, AVRCP_STATUS_INVALID_PARAM));
+
 	return g_test_run();
 }
-- 
1.8.3.2

