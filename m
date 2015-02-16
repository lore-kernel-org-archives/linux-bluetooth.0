Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] tools/btmgmt: Fix illegal memory access
Date: Mon, 16 Feb 2015 11:03:26 +0200
Message-Id: <1424077406-22281-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 tools/btmgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 7cf82e2..3ff0724 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3392,7 +3392,7 @@ static char *cmd_generator(const char *text, int state)
 			return strdup(cmd);
 	}
 
-	while (j++ < NELEM(interactive_cmd)) {
+	while (j < NELEM(interactive_cmd)) {
 		cmd = interactive_cmd[j++].cmd;
 
 		if (!strncmp(cmd, text, len))
-- 
2.1.0

