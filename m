Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Maxime Chevallier <maxime.chevallier@smile.fr>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
        Maxime Chevallier <maxime.chevallier@smile.fr>
Subject: [PATCH 1/2] tools/btgatt-client: Fix set-security interactive command
Date: Thu, 22 Dec 2016 11:36:04 +0100
Message-Id: <1482402965-9462-1-git-send-email-maxime.chevallier@smile.fr>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix the interactive "set-security" command in btgatt-client, that would
always fail due to bad initialization of argv buffer :

[GATT client]# set-security 2
Usage: set_security <level>
level: 1-3
e.g.:
        set-sec-level 2
---
 tools/btgatt-client.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 40a03b1..afe00aa 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1198,8 +1198,7 @@ static void set_security_usage(void)
 
 static void cmd_set_security(struct client *cli, char *cmd_str)
 {
-	char *argvbuf[1];
-	char **argv = argvbuf;
+	char *argv[2];
 	int argc = 0;
 	char *endptr = NULL;
 	int level;
-- 
2.1.4

