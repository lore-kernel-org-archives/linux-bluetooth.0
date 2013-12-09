Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] btmgmt: Remove unneeded code
Date: Mon,  9 Dec 2013 16:13:01 +0200
Message-Id: <1386598381-31374-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 tools/btmgmt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 1d71d74..f31d8b1 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -555,7 +555,6 @@ static void user_confirm(uint16_t index, uint16_t len, const void *param,
 	rsp_len = strlen(rsp);
 	if (rsp[rsp_len - 1] == '\n') {
 		rsp[rsp_len - 1] = '\0';
-		rsp_len--;
 	}
 
 	if (rsp[0] == 'y' || rsp[0] == 'Y')
-- 
1.8.3.2

