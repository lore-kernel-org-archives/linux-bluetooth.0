Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] client: Force redisplay on rl_printf
Date: Fri,  5 Sep 2014 15:49:11 +0300
Message-Id: <1409921352-28485-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1409921352-28485-1-git-send-email-luiz.dentz@gmail.com>
References: <1409921352-28485-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

It seems some in some version of readline rl_redisplay does not update
when rl_printf is called, so this uses rl_forced_update_display which
should force the new lines to be displayed.
---
 client/display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/display.c b/client/display.c
index bc891af..0f212b6 100644
--- a/client/display.c
+++ b/client/display.c
@@ -58,7 +58,7 @@ void rl_printf(const char *fmt, ...)
 		rl_restore_prompt();
 		rl_replace_line(saved_line, 0);
 		rl_point = saved_point;
-		rl_redisplay();
+		rl_forced_update_display();
 		free(saved_line);
 	}
 }
-- 
1.9.3

