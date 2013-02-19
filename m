Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/2] tools: btmgmt: Add missing return after g_main_loop_quit()
Date: Tue, 19 Feb 2013 17:00:03 -0400
Message-Id: <1361307604-4764-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This change keeps semantic of previous code that used to call exit()
directly.
---
 tools/btmgmt.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 9753724..4650876 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -135,8 +135,10 @@ static void discovering(uint16_t index, uint16_t len, const void *param,
 		return;
 	}
 
-	if (ev->discovering == 0 && discovery)
+	if (ev->discovering == 0 && discovery) {
 		g_main_loop_quit(event_loop);
+		return;
+	}
 
 	if (monitor)
 		printf("hci%u type %u discovering %s\n", index,
-- 
1.7.9.5

