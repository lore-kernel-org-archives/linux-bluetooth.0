Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 5/7] Add transport option to interactive gatttool
Date: Fri, 21 Jan 2011 10:46:24 -0300
Message-Id: <1295617586-3398-5-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1295617586-3398-1-git-send-email-sheldon.demario@openbossa.org>
References: <1295617586-3398-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/igatttool.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/attrib/igatttool.c b/attrib/igatttool.c
index 29290ed..e0d8b44 100644
--- a/attrib/igatttool.c
+++ b/attrib/igatttool.c
@@ -137,6 +137,23 @@ static void cmd_exit(char **cmd)
 	g_main_loop_quit(main_loop);
 }
 
+static void cmd_transport(char **cmd)
+{
+	if (cmd[1] == NULL)
+		return;
+
+	if (conn_state != STATE_DISCONNECTED)
+		return;
+
+	if (strcasecmp(cmd[1], "le") == 0)
+		opt_le = TRUE;
+	else if (strcasecmp(cmd[1], "br") == 0)
+		opt_le = FALSE;
+
+	rl_set_prompt(get_prompt());
+	rl_redisplay();
+}
+
 static void cmd_psm(char **opt)
 {
 	if (opt[1] == NULL)
@@ -158,6 +175,7 @@ static struct {
 	{ "connect",	cmd_connect,	"<bdaddr>",	"Connect"},
 	{ "disconnect",	cmd_disconnect,	NULL,		"Disconnect"},
 	{ "exit",	cmd_exit,	NULL,		"Exit"},
+	{ "transport",	cmd_transport,	"<LE | BR>",	"Set transport"},
 	{ "psm",	cmd_psm,	"<psm>",	"Set psm"},
 	{ NULL, NULL, NULL, NULL}
 };
-- 
1.7.1

