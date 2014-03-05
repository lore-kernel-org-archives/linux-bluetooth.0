Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/10] unit/avrcp: Add attributes and value check
Date: Wed,  5 Mar 2014 16:32:26 +0200
Message-Id: <1394029952-3319-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394029952-3319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394029952-3319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds check to get_player_value_text() and update test case.
---
 unit/test-avrcp.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 089ec21..f7550f7 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -376,11 +376,28 @@ static ssize_t avrcp_handle_get_player_value_text(struct avrcp *session,
 						uint8_t *params,
 						void *user_data)
 {
-	DBG("");
+	int i;
 
-	if (params_len != 1)
+	DBG("attr_id %d num_vals %d len %d", params[0], params[1], params_len);
+
+	if (params_len != 2 + params[1])
 		return -EINVAL;
 
+	if (params[0] > AVRCP_ATTRIBUTE_LAST ||
+		    params[0] == AVRCP_ATTRIBUTE_ILEGAL)
+		return -EINVAL;
+
+	for (i = 2; i < 2 + params[1]; i++) {
+		DBG("Value 0x%02x", params[i]);
+
+		/* Check for invalid value */
+		switch (params[0]) {
+		case AVRCP_ATTRIBUTE_EQUALIZER:
+			if (params[i] < 0x01 || params[i] > 0x02)
+				return -EINVAL;
+		}
+	}
+
 	params[0] = 0;
 
 	return 1;
@@ -618,7 +635,8 @@ int main(int argc, char *argv[])
 			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
 				0x00, 0x19, 0x58,
 				AVRCP_GET_PLAYER_VALUE_TEXT,
-				0x00, 0x00, 0x01, 0x00),
+				0x00, 0x00, 0x03, AVRCP_ATTRIBUTE_EQUALIZER,
+				0x01, 0x01),
 			raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
 				0x00, 0x19, 0x58,
 				AVRCP_GET_PLAYER_VALUE_TEXT,
-- 
1.8.3.2

