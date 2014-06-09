Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/avrcp: Fix accessing pointer
Date: Mon,  9 Jun 2014 11:18:50 +0300
Message-Id: <1402301930-22304-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 12b6183..1de313b 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -1824,7 +1824,7 @@ static int parse_value(struct avrcp_header *pdu, uint8_t *number,
 	 */
 	if (*number > AVRCP_ATTRIBUTE_LAST ||
 					1 + *number * 2 != pdu->params_len) {
-		number = 0;
+		*number = 0;
 		return -EPROTO;
 	}
 
-- 
1.8.3.2

