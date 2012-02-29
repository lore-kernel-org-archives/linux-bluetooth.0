Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ] gatttool: Add command completion for interactive mode
Date: Wed, 29 Feb 2012 16:17:31 -0400
Message-Id: <1330546651-6695-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/interactive.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index a772362..be81424 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -800,6 +800,33 @@ static gboolean prompt_read(GIOChannel *chan, GIOCondition cond,
 	return TRUE;
 }
 
+static char *completion_generator(const char *text, int state)
+{
+	static int index = 0, len = 0;
+	const char *cmd = NULL;
+
+	if (state == 0) {
+		index = 0;
+		len = strlen(text);
+	}
+
+	while ((cmd = commands[index].cmd) != NULL) {
+		index++;
+		if (strncmp(cmd, text, len) == 0)
+			return strdup(cmd);
+	}
+
+	return NULL;
+}
+
+static char **commands_completion(const char *text, int start, int end)
+{
+	if (start == 0)
+		return rl_completion_matches(text, &completion_generator);
+	else
+		return NULL;
+}
+
 int interactive(const gchar *src, const gchar *dst, int psm)
 {
 	GIOChannel *pchan;
@@ -820,6 +847,7 @@ int interactive(const gchar *src, const gchar *dst, int psm)
 	events = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 	g_io_add_watch(pchan, events, prompt_read, NULL);
 
+	rl_attempted_completion_function = commands_completion;
 	rl_callback_handler_install(get_prompt(), parse_line);
 
 	g_main_loop_run(event_loop);
-- 
1.7.9.2

