Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 14/17] unit/test-avrcp: Use avrcp_get_current_player_value_rsp
Date: Mon, 17 Mar 2014 15:08:00 +0200
Message-Id: <1395061683-17206-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
References: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes get_value callback to use avrcp_get_current_player_value_rsp
---
 unit/test-avrcp.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index a49a0a2..3235e48 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -349,21 +349,14 @@ static int get_value_text(struct avrcp *session, uint8_t transaction,
 static int get_value(struct avrcp *session, uint8_t transaction,
 			uint8_t number, uint8_t *attrs, void *user_data)
 {
-	uint8_t *attributes;
-	int i;
+	uint8_t values[2] = { 0x00, 0x00 };
 
 	DBG("");
 
-	attributes = g_memdup(attrs, number);
+	avrcp_get_current_player_value_rsp(session, transaction, number, attrs,
+									values);
 
-	for (i = 0; i < number; i++) {
-		attrs[i * 2 + 1] = attributes[i];
-		attrs[i * 2 + 2] = 0; /* value */
-	}
-
-	g_free(attributes);
-
-	return number * 2 + 1;
+	return -EAGAIN;
 }
 
 static int set_value(struct avrcp *session, uint8_t transaction,
-- 
1.8.5.3

