Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 2/3] client: Add a description to all commands
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <fa395eee-ee8e-4878-7736-d2d281e06689@jp.fujitsu.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <60cfed17-0dd7-44d5-d622-eeee1b26bcaf@jp.fujitsu.com>
Date: Mon, 19 Jun 2017 20:25:42 +0900
MIME-Version: 1.0
In-Reply-To: <fa395eee-ee8e-4878-7736-d2d281e06689@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


---
 client/main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/client/main.c b/client/main.c
index 784bc69..3cb4ad5 100644
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
