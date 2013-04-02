Return-Path: <cyrus@holtmann.org>
From: Alvaro Silva <alvaro.silva@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH BlueZ v2 10/13] gatttool: Use bluetoothctl strategy to handle standard input
Date: Tue,  2 Apr 2013 19:31:27 -0400
Message-Id: <1364945490-17059-11-git-send-email-alvaro.silva@openbossa.org>
In-Reply-To: <1364945490-17059-1-git-send-email-alvaro.silva@openbossa.org>
References: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
 <1364945490-17059-1-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

Use GSource id returned by g_io_add_watch() instead of raw GIOChannel to
handle stdin and glib main loop.
---
 attrib/interactive.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 7520324..fa3f82a 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -906,11 +906,26 @@ static char **commands_completion(const char *text, int start, int end)
 		return NULL;
 }
 
+static guint setup_standard_input(void)
+{
+	GIOChannel *channel;
+	guint source;
+
+	channel = g_io_channel_unix_new(fileno(stdin));
+
+	source = g_io_add_watch(channel,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				prompt_read, NULL);
+
+	g_io_channel_unref(channel);
+
+	return source;
+}
+
 int interactive(const gchar *src, const gchar *dst,
 		const gchar *dst_type, int psm)
 {
-	GIOChannel *pchan;
-	gint events;
+	guint input;
 
 	opt_sec_level = g_strdup("low");
 
@@ -923,10 +938,7 @@ int interactive(const gchar *src, const gchar *dst,
 
 	event_loop = g_main_loop_new(NULL, FALSE);
 
-	pchan = g_io_channel_unix_new(fileno(stdin));
-	g_io_channel_set_close_on_unref(pchan, TRUE);
-	events = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
-	g_io_add_watch(pchan, events, prompt_read, NULL);
+	input = setup_standard_input();
 
 	rl_attempted_completion_function = commands_completion;
 	rl_erase_empty_line = 1;
@@ -936,7 +948,7 @@ int interactive(const gchar *src, const gchar *dst,
 
 	rl_callback_handler_remove();
 	cmd_disconnect(0, NULL);
-	g_io_channel_unref(pchan);
+	g_source_remove(input);
 	g_main_loop_unref(event_loop);
 	g_string_free(prompt, TRUE);
 
-- 
1.7.9.5

