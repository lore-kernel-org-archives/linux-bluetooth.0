Return-Path: <cyrus@holtmann.org>
From: Alvaro Silva <alvaro.silva@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ v2 01/13] gatttool: Fix memory leak after parsing input line
Date: Tue,  2 Apr 2013 19:31:18 -0400
Message-Id: <1364945490-17059-2-git-send-email-alvaro.silva@openbossa.org>
In-Reply-To: <1364945490-17059-1-git-send-email-alvaro.silva@openbossa.org>
References: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
 <1364945490-17059-1-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

The callback is responsible for freeing input line buffer that comes
from rl_callback_handler_install().
---
 attrib/interactive.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index a99ad0a..9f72453 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -850,7 +850,7 @@ static void parse_line(char *line_read)
 	line_read = g_strstrip(line_read);
 
 	if (*line_read == '\0')
-		return;
+		goto done;
 
 	add_history(line_read);
 
@@ -866,6 +866,9 @@ static void parse_line(char *line_read)
 		printf("%s: command not found\n", argvp[0]);
 
 	g_strfreev(argvp);
+
+done:
+	free(line_read);
 }
 
 static gboolean prompt_read(GIOChannel *chan, GIOCondition cond,
-- 
1.7.9.5

