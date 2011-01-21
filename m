Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 4/7] Add psm option to interactive gatttool
Date: Fri, 21 Jan 2011 10:46:23 -0300
Message-Id: <1295617586-3398-4-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1295617586-3398-1-git-send-email-sheldon.demario@openbossa.org>
References: <1295617586-3398-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/igatttool.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/attrib/igatttool.c b/attrib/igatttool.c
index 9cd2a1e..29290ed 100644
--- a/attrib/igatttool.c
+++ b/attrib/igatttool.c
@@ -137,6 +137,18 @@ static void cmd_exit(char **cmd)
 	g_main_loop_quit(main_loop);
 }
 
+static void cmd_psm(char **opt)
+{
+	if (opt[1] == NULL)
+		return;
+
+	if (conn_state == STATE_DISCONNECTED || opt[1] != NULL)
+		opt_psm = atoi(opt[1]);
+
+	rl_set_prompt(get_prompt());
+	rl_redisplay();
+}
+
 static struct {
 	char *cmd;
 	void (*func)(char **cmd);
@@ -146,6 +158,7 @@ static struct {
 	{ "connect",	cmd_connect,	"<bdaddr>",	"Connect"},
 	{ "disconnect",	cmd_disconnect,	NULL,		"Disconnect"},
 	{ "exit",	cmd_exit,	NULL,		"Exit"},
+	{ "psm",	cmd_psm,	"<psm>",	"Set psm"},
 	{ NULL, NULL, NULL, NULL}
 };
 
-- 
1.7.1

