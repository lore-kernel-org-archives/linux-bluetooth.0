Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] tools/btmgmt: Handle commands tables in consistent way
Date: Thu, 12 Feb 2015 17:30:44 +0100
Message-Id: <1423758644-3122-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1423758644-3122-1-git-send-email-szymon.janc@tieto.com>
References: <1423758644-3122-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In some places commands tables were accessed by fixed element count
and in some places it was assumed that last element is zeroed.

This could lead to accessing invalid memory since tables were
not terminated with zeroed element (I couldn't crash the tool but
this is most likely only due to static memory being zeroed).

Be consistent and terminate arrays with zeroed element and use this
for iterating.
---
 tools/btmgmt.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 0686ed6..c8fc9f6 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3289,6 +3289,7 @@ static struct cmd_info all_cmd[] = {
 	{ "add-device", cmd_add_device, "Add Device"			},
 	{ "del-device", cmd_del_device, "Remove Device"			},
 	{ "clr-devices",cmd_clr_devices,"Clear Devices"			},
+	{ }
 };
 
 static void cmd_quit(struct mgmt *mgmt, uint16_t index,
@@ -3371,6 +3372,7 @@ static struct cmd_info interactive_cmd[] = {
 	{ "quit",	cmd_quit,	"Exit program"			},
 	{ "exit",	cmd_quit,	"Exit program"			},
 	{ "help",	NULL,		"List supported commands"	},
+	{ }
 };
 
 static char *cmd_generator(const char *text, int state)
@@ -3432,12 +3434,11 @@ static char **cmd_completion(const char *text, int start, int end)
 	return matches;
 }
 
-static struct cmd_info *find_cmd(const char *cmd, struct cmd_info table[],
-							size_t cmd_count)
+static struct cmd_info *find_cmd(const char *cmd, struct cmd_info table[])
 {
-	size_t i;
+	int i;
 
-	for (i = 0; i < cmd_count; i++) {
+	for (i = 0; table[i].cmd; i++) {
 		if (!strcmp(table[i].cmd, cmd))
 			return &table[i];
 	}
@@ -3478,9 +3479,9 @@ static void rl_handler(char *input)
 	argv = w.we_wordv;
 	argc = w.we_wordc;
 
-	c = find_cmd(cmd, all_cmd, NELEM(all_cmd));
+	c = find_cmd(cmd, all_cmd);
 	if (!c && interactive)
-		c = find_cmd(cmd, interactive_cmd, NELEM(interactive_cmd));
+		c = find_cmd(cmd, interactive_cmd);
 
 	if (c && c->func) {
 		c->func(mgmt, mgmt_index, argc, argv);
@@ -3494,7 +3495,7 @@ static void rl_handler(char *input)
 
 	print("Available commands:");
 
-	for (i = 0; i < NELEM(all_cmd); i++) {
+	for (i = 0; all_cmd[i].cmd; i++) {
 		c = &all_cmd[i];
 		if (c->doc)
 			print("  %s %-*s %s", c->cmd,
@@ -3504,7 +3505,7 @@ static void rl_handler(char *input)
 	if (!interactive)
 		goto free_we;
 
-	for (i = 0; i < NELEM(interactive_cmd); i++) {
+	for (i = 0; interactive_cmd[i].cmd; i++) {
 		c = &interactive_cmd[i];
 		if (c->doc)
 			print("  %s %-*s %s", c->cmd,
@@ -3603,7 +3604,7 @@ int main(int argc, char *argv[])
 	if (argc > 0) {
 		struct cmd_info *c;
 
-		c = find_cmd(argv[0], all_cmd, NELEM(all_cmd));
+		c = find_cmd(argv[0], all_cmd);
 		if (!c) {
 			fprintf(stderr, "Unknown command: %s\n", argv[0]);
 			mgmt_unref(mgmt);
-- 
1.9.3

