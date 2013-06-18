Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] client: prettify help table
Date: Tue, 18 Jun 2013 17:13:47 -0300
Message-Id: <1371586427-7909-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1371586427-7909-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1371586427-7909-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

cmd + options have a maximum length of 25. Align the description
after this value. In order not to reach 80 chars so easily change the
first \t to 2 spaces, like is done in udev, kmod, systemd, etc.
---
 client/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/client/main.c b/client/main.c
index 54af807..db6705f 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1182,9 +1182,10 @@ static void rl_handler(char *input)
 	printf("Available commands:\n");
 
 	for (i = 0; cmd_table[i].cmd; i++) {
-		printf("\t%s %s\t%s\n", cmd_table[i].cmd,
-						cmd_table[i].arg ? : "    ",
-						cmd_table[i].desc ? : "");
+		printf("  %s %-*s %s\n", cmd_table[i].cmd,
+					(int)(25 - strlen(cmd_table[i].cmd)),
+					cmd_table[i].arg ? : "",
+					cmd_table[i].desc ? : "");
 	}
 
 done:
-- 
1.8.3.1

