Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 1/3] client: Compare a input string and each command
 only once
To: <linux-bluetooth@vger.kernel.org>
References: <3520047b-7832-35e2-d1fa-fb7f5c0d058d@jp.fujitsu.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <07dfe372-da22-35ae-e028-dbf7587c2875@jp.fujitsu.com>
Date: Thu, 15 Jun 2017 20:48:31 +0900
MIME-Version: 1.0
In-Reply-To: <3520047b-7832-35e2-d1fa-fb7f5c0d058d@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This compares a input string and each command only once in rl_handler().

---
  client/main.c | 19 +++++++++++--------
  1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/client/main.c b/client/main.c
index 255cbd5..4826642 100644
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

