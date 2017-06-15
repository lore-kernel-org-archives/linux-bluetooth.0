Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 3/3] client: Output a long message by two lines
To: <linux-bluetooth@vger.kernel.org>
References: <3520047b-7832-35e2-d1fa-fb7f5c0d058d@jp.fujitsu.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <c70181b2-d88b-db55-9918-e4d7b57c0d6e@jp.fujitsu.com>
Date: Thu, 15 Jun 2017 20:49:57 +0900
MIME-Version: 1.0
In-Reply-To: <3520047b-7832-35e2-d1fa-fb7f5c0d058d@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


This outputs the help message by two lines as follows if the string of
a command and a argument is long.

   set-alias <alias>          Set device alias
   select-attribute <attribute/UUID>
                              Select attribute
   attribute-info [attribute/UUID]
                              Select attribute
   read                       Read attribute value
---
  client/main.c | 10 +++++++++-
  1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index 7110a67..b3495e7 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2262,10 +2262,18 @@ static void cmd_help(const char *arg)
  	printf("Available commands:\n");
  
  	for (i = 0; cmd_table[i].cmd; i++) {
-		printf("  %s %-*s %s\n", cmd_table[i].cmd,
+		if ((int)strlen(cmd_table[i].arg? : "") <=
+					(int)(25 - strlen(cmd_table[i].cmd)))
+			printf("  %s %-*s %s\n", cmd_table[i].cmd,
  					(int)(25 - strlen(cmd_table[i].cmd)),
  					cmd_table[i].arg ? : "",
  					cmd_table[i].desc ? : "");
+		else
+			printf("  %s %-s\n" "  %s %-25s %s\n",
+					cmd_table[i].cmd,
+					cmd_table[i].arg ? : "",
+					"", "",
+					cmd_table[i].desc ? : "");
  	}
  }
  
-- 
2.7.4

