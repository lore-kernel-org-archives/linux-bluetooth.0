Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 18/20] unit/avrcp: Fix possible buffer overflow
Date: Mon, 31 Mar 2014 15:25:12 +0300
Message-Id: <1396268714-4056-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1396268714-4056-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1396268714-4056-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

text[] needs to be of size number for get_value_text()
---
 unit/test-avrcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index fdca98f..00fdaff 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -431,10 +431,15 @@ static int get_value_text(struct avrcp *session, uint8_t transaction,
 				uint8_t attr, uint8_t number, uint8_t *values,
 				void *user_data)
 {
-	const char *text[] = { "on" };
+	const char *text[number];
 
 	DBG("");
 
+	if (number) {
+		memset(text, 0, number);
+		text[0] = "on";
+	}
+
 	avrcp_get_player_values_text_rsp(session, transaction, number,
 								values, text);
 
-- 
1.8.3.2

