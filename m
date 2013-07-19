Return-Path: <cyrus@holtmann.org>
From: Sathish Narasimman <sathish.n@globaledgesoft.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, girish.br@globaledgesoft.com,
	anderson.lizardo@openbossa.org, sathish.n@globaledgesoft.com,
	ajay.kv@globaledgesoft.com
Subject: [PATCH BlueZ] attrib: Fix interactive gatttool segfault
Date: Fri, 19 Jul 2013 10:01:52 +0530
Message-Id: <1374208312-18661-1-git-send-email-sathish.n@globaledgesoft.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

passing the special character single quote

$gatttool -I
[   ][                 ][LE]> '
Segmentation fault (core dumped)

Checking g_shell_parse_argv fail status(return FALSE on failure), works fine.

hope the fix to the previous "git am" error is solved

---
 attrib/interactive.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index f28dc22..4fd7276 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -867,7 +867,8 @@ static void parse_line(char *line_read)
 
 	add_history(line_read);
 
-	g_shell_parse_argv(line_read, &argcp, &argvp, NULL);
+	if (g_shell_parse_argv(line_read, &argcp, &argvp, NULL) == FALSE)
+		goto done;
 
 	for (i = 0; commands[i].cmd; i++)
 		if (strcasecmp(commands[i].cmd, argvp[0]) == 0)
-- 
1.7.9.5

