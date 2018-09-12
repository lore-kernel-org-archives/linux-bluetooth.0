Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/shell: Set rl_readline_name
Date: Wed, 12 Sep 2018 14:48:17 +0300
Message-Id: <20180912114817.32369-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Set rl_readline_name so the binary name can be used in inputrc.
---
 src/shared/shell.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 9b0125579..7c3c2daa7 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -972,6 +972,9 @@ static void rl_init(void)
 	if (data.mode)
 		return;
 
+	/* Allow conditional parsing of the ~/.inputrc file. */
+	rl_readline_name = data.name;
+
 	setlinebuf(stdout);
 	rl_attempted_completion_function = shell_completion;
 
@@ -989,18 +992,11 @@ static const struct option main_options[] = {
 
 static void usage(int argc, char **argv, const struct bt_shell_opt *opt)
 {
-	const char *name;
 	unsigned int i;
 
-	name = strrchr(argv[0], '/');
-	if (!name)
-		name = argv[0];
-	else
-		name++;
-
-	printf("%s ver %s\n", name, VERSION);
+	printf("%s ver %s\n", data.name, VERSION);
 	printf("Usage:\n"
-		"\t%s [--options] [commands]\n", name);
+		"\t%s [--options] [commands]\n", data.name);
 
 	printf("Options:\n");
 
@@ -1030,10 +1026,16 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 	} else
 		snprintf(optstr, sizeof(optstr), "+hvt:");
 
+	data.name = strrchr(argv[0], '/');
+	if (!data.name)
+		data.name = strdup(argv[0]);
+	else
+		data.name = strdup(data.name++);
+
 	while ((c = getopt_long(argc, argv, optstr, options, &index)) != -1) {
 		switch (c) {
 		case 'v':
-			printf("%s: %s\n", argv[0], VERSION);
+			printf("%s: %s\n", data.name, VERSION);
 			exit(EXIT_SUCCESS);
 			return;
 		case 'h':
@@ -1065,7 +1067,6 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 		index = -1;
 	}
 
-	data.name = strdup(argv[0]);
 	bt_shell_set_env("SHELL", data.name);
 
 	data.argc = argc - optind;
-- 
2.17.1
