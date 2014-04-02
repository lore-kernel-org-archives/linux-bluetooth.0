Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] tools/btmgmt: Fix bogus comment in eir_get_flags function
Date: Wed,  2 Apr 2014 12:29:58 +0200
Message-Id: <1396434598-18361-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1396434598-18361-1-git-send-email-szymon.janc@tieto.com>
References: <1396434598-18361-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This was due to copy-and-paste.
---
 tools/btmgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index aee6841..48d42a3 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -360,7 +360,7 @@ static unsigned int eir_get_flags(const uint8_t *eir, uint16_t eir_len)
 		if (parsed > eir_len)
 			break;
 
-		/* Check for short of complete name */
+		/* Check for flags */
 		if (eir[1] == 0x01)
 			return eir[2];
 
-- 
1.9.1

