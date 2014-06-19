Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/gatt: Remove dead code
Date: Thu, 19 Jun 2014 13:28:21 +0300
Message-Id: <1403173701-23206-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The code apparently left after wrong rebase as it duplicates code
several lines above.
---
 android/gatt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 24884e9..5007817 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5310,11 +5310,6 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
 
 	}
 
-	if (!adl) {
-		queue_destroy(q, NULL);
-		return ATT_ECODE_INSUFF_RESOURCES;
-	}
-
 	len = enc_find_info_resp(ATT_FIND_INFO_RESP_FMT_16BIT, adl, rsp,
 								rsp_size);
 	if (!len)
-- 
1.8.3.2

