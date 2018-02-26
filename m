Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/14] shared/shell: Fix timeout parameter
Date: Mon, 26 Feb 2018 17:53:25 +0200
Message-Id: <20180226155336.25875-4-luiz.dentz@gmail.com>
In-Reply-To: <20180226155336.25875-1-luiz.dentz@gmail.com>
References: <20180226155336.25875-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fix help message and add proper optstr modifier so both -t/--timeout
work properly.
---
 src/shared/shell.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 0653c0ea1..e82307d6f 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -768,7 +768,7 @@ static void usage(int argc, char **argv, const struct bt_shell_opt *opt)
 	for (i = 0; opt && opt->options[i].name; i++)
 		printf("\t--%s \t%s\n", opt->options[i].name, opt->help[i]);
 
-	printf("\t--timeout \t\tTimeout in seconds for non-interactive mode\n"
+	printf("\t--timeout \tTimeout in seconds for non-interactive mode\n"
 		"\t--version \tDisplay version\n"
 		"\t--help \t\tDisplay help\n");
 }
@@ -787,9 +787,9 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 	if (opt) {
 		memcpy(options + offset, opt->options,
 				sizeof(struct option) * opt->optno);
-		snprintf(optstr, sizeof(optstr), "+hv%s", opt->optstr);
+		snprintf(optstr, sizeof(optstr), "+hvt:%s", opt->optstr);
 	} else
-		snprintf(optstr, sizeof(optstr), "+hv");
+		snprintf(optstr, sizeof(optstr), "+hvt:");
 
 	while ((c = getopt_long(argc, argv, optstr, options, &index)) != -1) {
 		switch (c) {
-- 
2.14.3

