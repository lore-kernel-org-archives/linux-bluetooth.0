Return-Path: <cyrus@holtmann.org>
From: Sathish N <sathish.n@globaledgesoft.com>
To: linux-bluetooth@vger.kernel.org
Cc: girish.br@globaledgesoft.com, sathish.n@globaledgesoft.com,
	ajay.kv@globaledgesoft.com, anderson.lizardo@openbossa.org
Subject: [PATCH bluez] attrib: gatttool segfault interactive
Date: Thu, 18 Jul 2013 16:05:45 +0530
Message-Id: <1374143745-16224-1-git-send-email-sathish.n@globaledgesoft.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: sathish N <sathish.n@globaledgesoft.com>

---
 bluez/attrib/interactive.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bluez/attrib/interactive.c b/bluez/attrib/interactive.c
index f28dc22..4fd7276 100644
--- a/bluez/attrib/interactive.c
+++ b/bluez/attrib/interactive.c
@@ -867,7 +867,8 @@ static void parse_line(char *line_read)
 
 	add_history(line_read);
 
-	g_shell_parse_argv(line_read, &argcp, &argvp, NULL);
+	if (g_shell_parse_argv(line_read, &argcp, &argvp, NULL) == FALSE)
+		goto done;
 
 	for (i = 0; commands[i].cmd; i++)
 		if (strcasecmp(commands[i].cmd, argvp[0]) == 0)
-- 
1.7.9.5
