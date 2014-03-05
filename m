Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/10] unit/avrcp: Add attributes check in list_player_vals()
Date: Wed,  5 Mar 2014 16:32:24 +0200
Message-Id: <1394029952-3319-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394029952-3319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394029952-3319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add check and fix test case since it was testing that response is
received but attribute 0 is illegal one.
---
 unit/test-avrcp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 7ce2801..c3064da 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -356,11 +356,15 @@ static ssize_t avrcp_handle_list_player_values(struct avrcp *session,
 						uint8_t *params,
 						void *user_data)
 {
-	DBG("params[0] %d params_len %d", params[0], params_len);
+	DBG("params[0] 0x%02x params_len %d", params[0], params_len);
 
 	if (params_len != 1)
 		return -EINVAL;
 
+	if (params[0] > AVRCP_ATTRIBUTE_LAST ||
+		    params[0] == AVRCP_ATTRIBUTE_ILEGAL)
+		return -EINVAL;
+
 	params[0] = 0;
 
 	return 1;
@@ -604,7 +608,7 @@ int main(int argc, char *argv[])
 			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
 				0x00, 0x19, 0x58,
 				AVRCP_LIST_PLAYER_VALUES,
-				0x00, 0x00, 0x01, 0x00),
+				0x00, 0x00, 0x01, AVRCP_ATTRIBUTE_EQUALIZER),
 			raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
 				0x00, 0x19, 0x58,
 				AVRCP_LIST_PLAYER_VALUES,
-- 
1.8.3.2

