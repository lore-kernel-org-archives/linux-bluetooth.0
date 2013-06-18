Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] client: Display command even with no description
Date: Tue, 18 Jun 2013 17:13:46 -0300
Message-Id: <1371586427-7909-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1371586427-7909-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1371586427-7909-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

Having no description doesn't mean it's not an available command. So add
command to the output of "help" command, even if it has no description.
---
 client/main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/client/main.c b/client/main.c
index b0a66d8..54af807 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1182,10 +1182,9 @@ static void rl_handler(char *input)
 	printf("Available commands:\n");
 
 	for (i = 0; cmd_table[i].cmd; i++) {
-		if (cmd_table[i].desc)
-			printf("\t%s %s\t%s\n", cmd_table[i].cmd,
+		printf("\t%s %s\t%s\n", cmd_table[i].cmd,
 						cmd_table[i].arg ? : "    ",
-						cmd_table[i].desc);
+						cmd_table[i].desc ? : "");
 	}
 
 done:
-- 
1.8.3.1

