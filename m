Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH v2 1/7] Improve help messages in interactive gatttool
Date: Tue, 22 Feb 2011 16:11:58 -0300
Message-Id: <1298401924-20094-1-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1298328606-7993-1-git-send-email-sheldon.demario@openbossa.org>
References: <1298328606-7993-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Includes the parameters info on help.
---
 attrib/interactive.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index edc465a..b491314 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -217,13 +217,19 @@ static void cmd_primary(int argcp, char **argvp)
 static struct {
 	const char *cmd;
 	void (*func)(int argcp, char **argvp);
+	const char *params;
 	const char *desc;
 } commands[] = {
-	{ "help",	cmd_help,	"Show this help"},
-	{ "exit",	cmd_exit,	"Exit interactive mode"},
-	{ "connect",	cmd_connect,	"Connect to a remote device"},
-	{ "disconnect",	cmd_disconnect,	"Disconnect from a remote device"},
-	{ "primary",	cmd_primary,	"Primary Service Discovery"},
+	{ "help",		cmd_help,	"",
+		"Show this help"},
+	{ "exit",		cmd_exit,	"",
+		"Exit interactive mode" },
+	{ "connect",		cmd_connect,	"[address]",
+		"Connect to a remote device" },
+	{ "disconnect",		cmd_disconnect,	"",
+		"Disconnect from a remote device" },
+	{ "primary",		cmd_primary,	"[UUID]",
+		"Primary Service Discovery" },
 	{ NULL, NULL, NULL}
 };
 
@@ -232,7 +238,8 @@ static void cmd_help(int argcp, char **argvp)
 	int i;
 
 	for (i = 0; commands[i].cmd; i++)
-		printf("%-12s\t%s\n", commands[i].cmd, commands[i].desc);
+		printf("%-15s %-25s %s\n", commands[i].cmd,
+				commands[i].params, commands[i].desc);
 }
 
 static void parse_line(char *line_read)
-- 
1.7.1

