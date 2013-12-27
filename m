Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] tools/bluetooth-player: Formatting commands
Date: Fri, 27 Dec 2013 15:10:34 +0100
Message-Id: <1388153434-8459-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Formatting commands passed to bluetooth player.
Whitespace character trimmed.
---
 tools/bluetooth-player.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index 622d391..1dadc70 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -1065,9 +1065,10 @@ static char **cmd_completion(const char *text, int start, int end)
 
 static void rl_handler(char *input)
 {
+
 	int argc;
 	char **argv = NULL;
-	int i;
+	int i, len;
 
 	if (!input) {
 		rl_insert_text("quit");
@@ -1080,6 +1081,12 @@ static void rl_handler(char *input)
 	if (!strlen(input))
 		goto done;
 
+	if (input) {
+		len = strlen(input);
+		if (len > 0 && input[len - 1] == ' ')
+			input[len - 1] = '\0';
+	}
+
 	add_history(input);
 
 	argv = g_strsplit(input, " ", -1);
-- 
1.7.9.5

