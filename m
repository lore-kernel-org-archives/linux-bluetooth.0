Return-Path: <cyrus@holtmann.org>
Message-ID: <41533.172.16.2.1.1374065624.squirrel@gesmail.globaledgesoft.com>
Date: Wed, 17 Jul 2013 18:23:44 +0530 (IST)
Subject: gatttool Segmentation fault
From: "Sathish N" <sathish.n@globaledgesoft.com>
To: linux-bluetooth@vger.kernel.org
Cc: ajay.kv@globaledgesoft.com
Reply-To: sathish.n@globaledgesoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

passing the special character single quote

#gatttool -I
[   ][                 ][LE]> '
Segmentation fault (core dumped)


Checking g_shell_parse_argv fail status, works fine.

---

--- a/attrib/interactive.c	2013-05-14 06:34:08.000000000 +0530
+++ b/attrib/interactive.c	2013-07-17 18:07:24.563861308 +0530
@@ -867,7 +867,8 @@

 	add_history(line_read);

-	g_shell_parse_argv(line_read, &argcp, &argvp, NULL);
+	if(g_shell_parse_argv(line_read, &argcp, &argvp, NULL) == FALSE)
+		goto done;

 	for (i = 0; commands[i].cmd; i++)
 		if (strcasecmp(commands[i].cmd, argvp[0]) == 0)


---

Thanks,
Ajay K V & Sathish N

