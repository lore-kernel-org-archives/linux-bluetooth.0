Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] unit/avrcp: Fix possible buffer overflow
Date: Tue, 18 Mar 2014 15:31:19 +0200
Message-Id: <1395149479-14180-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

values[] should be the same size as attr[].
---
 unit/test-avrcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index ec70da4..02f9949 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -439,10 +439,12 @@ static int get_value_text(struct avrcp *session, uint8_t transaction,
 static int get_value(struct avrcp *session, uint8_t transaction,
 			uint8_t number, uint8_t *attrs, void *user_data)
 {
-	uint8_t values[2] = { 0x00, 0x00 };
+	uint8_t values[number];
 
 	DBG("");
 
+	memset(values, 0, number);
+
 	avrcp_get_current_player_value_rsp(session, transaction, number, attrs,
 									values);
 
-- 
1.8.3.2

