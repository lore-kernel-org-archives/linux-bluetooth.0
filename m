Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] unit/avrcp: Fix possible buffer overflow
Date: Wed, 19 Mar 2014 14:26:58 +0200
Message-Id: <1395232018-25101-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Parameter passed needs to be of size number otherwise there is buffer
overflow.
---
 unit/test-avrcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 02f9949..1368933 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -402,10 +402,15 @@ static int get_attribute_text(struct avrcp *session, uint8_t transaction,
 					uint8_t number, uint8_t *attrs,
 					void *user_data)
 {
-	const char *text[] = { "equalizer" };
+	const char *text[number];
 
 	DBG("");
 
+	if (number) {
+		memset(text, 0, number);
+		text[0] = "equalizer";
+	}
+
 	avrcp_get_player_attribute_text_rsp(session, transaction, number, attrs,
 									text);
 
-- 
1.8.3.2

