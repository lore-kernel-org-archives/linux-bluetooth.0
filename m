Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 1/3] client: Compare a input string and each command
 only once
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <fa395eee-ee8e-4878-7736-d2d281e06689@jp.fujitsu.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <1e5de043-cacc-7601-43db-8401429e4515@jp.fujitsu.com>
Date: Mon, 19 Jun 2017 20:24:46 +0900
MIME-Version: 1.0
In-Reply-To: <fa395eee-ee8e-4878-7736-d2d281e06689@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This compares a input string and each command only once in rl_handler().

---
 client/main.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/client/main.c b/client/main.c
index 2f269af..784bc69 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1854,6 +1854,8 @@ static void cmd_quit(const char *arg)
 	g_main_loop_quit(main_loop);
 }
 
+static void cmd_help(const char *arg);
+
 static char *generic_generator(const char *text, int state,
 					GList *source, const char *property)
 {
@@ -2145,7 +2147,7 @@ static const struct {
 	{ "version",      NULL,       cmd_version, "Display version" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit },
-	{ "help" },
+	{ "help",         NULL,       cmd_help },
 	{ }
 };
 
@@ -2245,10 +2247,14 @@ static void rl_handler(char *input)
 		}
 	}
 
-	if (strcmp(cmd, "help")) {
-		printf("Invalid command\n");
-		goto done;
-	}
+	printf("Invalid command\n");
+done:
+	free(input);
+}
+
+static void cmd_help(const char *arg)
+{
+	int i;
 
 	printf("Available commands:\n");
 
@@ -2259,9 +2265,6 @@ static void rl_handler(char *input)
 					cmd_table[i].arg ? : "",
 					cmd_table[i].desc ? : "");
 	}
-
-done:
-	free(input);
 }
 
 static gboolean signal_handler(GIOChannel *channel, GIOCondition condition,
-- 
2.7.4
