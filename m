Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 3/3] client: Output a long message by two lines
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <fa395eee-ee8e-4878-7736-d2d281e06689@jp.fujitsu.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <951937f9-8eb6-0b89-c5e5-9ebe8981b53e@jp.fujitsu.com>
Date: Mon, 19 Jun 2017 20:26:36 +0900
MIME-Version: 1.0
In-Reply-To: <fa395eee-ee8e-4878-7736-d2d281e06689@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
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
index 3cb4ad5..578dde9 100644
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

