Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/5] client: prettify help table
Date: Fri, 21 Jun 2013 11:17:35 -0300
Message-Id: <1371824255-3071-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1371824255-3071-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1371824255-3071-1-git-send-email-lucas.demarchi@profusion.mobi>
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
index ff2afc6..0dd1510 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1184,9 +1184,10 @@ static void rl_handler(char *input)
 
 	for (i = 0; cmd_table[i].cmd; i++) {
 		if (cmd_table[i].desc)
-			printf("\t%s %s\t%s\n", cmd_table[i].cmd,
-						cmd_table[i].arg ? : "    ",
-						cmd_table[i].desc);
+			printf("  %s %-*s %s\n", cmd_table[i].cmd,
+					(int)(25 - strlen(cmd_table[i].cmd)),
+					cmd_table[i].arg ? : "",
+					cmd_table[i].desc ? : "");
 	}
 
 done:
-- 
1.8.3.1

