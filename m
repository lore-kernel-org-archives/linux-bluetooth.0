Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 2/3] client: Add a description to all commands
To: <linux-bluetooth@vger.kernel.org>
References: <3520047b-7832-35e2-d1fa-fb7f5c0d058d@jp.fujitsu.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <81731523-87ce-af6b-7aeb-319b36b8790e@jp.fujitsu.com>
Date: Thu, 15 Jun 2017 20:49:25 +0900
MIME-Version: 1.0
In-Reply-To: <3520047b-7832-35e2-d1fa-fb7f5c0d058d@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


---
  client/main.c | 14 ++++++++------
  1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/client/main.c b/client/main.c
index 4826642..7110a67 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2073,8 +2073,10 @@ static const struct {
  	{ "devices",      NULL,       cmd_devices, "List available devices" },
  	{ "paired-devices", NULL,     cmd_paired_devices,
  					"List paired devices"},
-	{ "system-alias", "<name>",   cmd_system_alias },
-	{ "reset-alias",  NULL,       cmd_reset_alias },
+	{ "system-alias", "<name>",   cmd_system_alias,
+					"Set controller alias" },
+	{ "reset-alias",  NULL,       cmd_reset_alias,
+					"Reset controller alias" },
  	{ "power",        "<on/off>", cmd_power, "Set controller power" },
  	{ "pairable",     "<on/off>", cmd_pairable,
  					"Set controller pairable mode" },
@@ -2146,8 +2148,9 @@ static const struct {
  						"Unregister profile" },
  	{ "version",      NULL,       cmd_version, "Display version" },
  	{ "quit",         NULL,       cmd_quit, "Quit program" },
-	{ "exit",         NULL,       cmd_quit },
-	{ "help",         NULL,       cmd_help },
+	{ "exit",         NULL,       cmd_quit, "Quit program" },
+	{ "help",         NULL,       cmd_help,
+					"Display help about this program" },
  	{ }
  };
  
@@ -2259,8 +2262,7 @@ static void cmd_help(const char *arg)
  	printf("Available commands:\n");
  
  	for (i = 0; cmd_table[i].cmd; i++) {
-		if (cmd_table[i].desc)
-			printf("  %s %-*s %s\n", cmd_table[i].cmd,
+		printf("  %s %-*s %s\n", cmd_table[i].cmd,
  					(int)(25 - strlen(cmd_table[i].cmd)),
  					cmd_table[i].arg ? : "",
  					cmd_table[i].desc ? : "");
-- 
2.7.4

