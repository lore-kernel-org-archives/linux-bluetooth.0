Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 5/5] Add connect/disconnect options on interactive mode of gatttool
Date: Tue,  8 Feb 2011 12:32:16 -0300
Message-Id: <1297179136-14750-5-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1297179136-14750-1-git-send-email-sheldon.demario@openbossa.org>
References: <1297179136-14750-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatttool.c  |    4 +-
 attrib/gatttool.h  |    1 +
 attrib/igatttool.c |  103 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index e0de05b..ac9bb60 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -86,7 +86,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	}
 }
 
-static GIOChannel *do_connect(gboolean le)
+GIOChannel *do_connect(gboolean le, BtIOConnect connect_cb)
 {
 	GIOChannel *chan;
 	bdaddr_t sba, dba;
@@ -630,7 +630,7 @@ int main(int argc, char *argv[])
 		goto done;
 	}
 
-	chan = do_connect(main_opts.le);
+	chan = do_connect(main_opts.le, connect_cb);
 	if (chan == NULL) {
 		got_error = TRUE;
 		goto done;
diff --git a/attrib/gatttool.h b/attrib/gatttool.h
index 0f78aa8..6fec2b0 100644
--- a/attrib/gatttool.h
+++ b/attrib/gatttool.h
@@ -43,3 +43,4 @@ struct main_opts {
 } main_opts;
 
 int do_interactive(void);
+GIOChannel *do_connect(gboolean le, BtIOConnect connect_cb);
diff --git a/attrib/igatttool.c b/attrib/igatttool.c
index cac97f0..fa014c3 100644
--- a/attrib/igatttool.c
+++ b/attrib/igatttool.c
@@ -25,15 +25,24 @@
 #include <stdio.h>
 #include <glib.h>
 
+#include <bluetooth/sdp.h>
+
 #include <readline/readline.h>
 #include <readline/history.h>
 
+#include "btio.h"
+#include "gattrib.h"
 #include "gatttool.h"
 
+static GIOChannel *iochannel = NULL;
+static GAttrib *attrib = NULL;
 static GMainLoop *event_loop;
+static GString *prompt;
 
 static void cmd_help(int argcp, char **argvp);
 static void cmd_exit(int argcp, char **argvp);
+static void cmd_connect(int argcp, char **argvp);
+static void cmd_disconnect(int argcp, char **argvp);
 
 static struct {
 	const char *cmd;
@@ -42,9 +51,62 @@ static struct {
 } commands[] = {
 	{ "help",	cmd_help,	"Show this help"},
 	{ "exit",	cmd_exit,	"Exit interactive mode"},
+	{ "connect",	cmd_connect,	"Connect to a remote device"},
+	{ "disconnect",	cmd_disconnect,	"Disconnect from a remote device"},
 	{ NULL, NULL, NULL}
 };
 
+enum state {
+	STATE_DISCONNECTED,
+	STATE_CONNECTING,
+	STATE_CONNECTED
+} conn_state;
+
+static char *get_prompt(void)
+{
+	if (conn_state == STATE_CONNECTING) {
+		g_string_assign(prompt, "Connecting... ");
+		return prompt->str;
+	}
+
+	if (conn_state == STATE_CONNECTED)
+		g_string_assign(prompt, "[CON]");
+	else
+		g_string_assign(prompt, "[   ]");
+
+	if (main_opts.dst)
+		g_string_append_printf(prompt, "[%17s]", main_opts.dst);
+	else
+		g_string_append_printf(prompt, "[%17s]", "");
+
+	if (main_opts.le)
+		g_string_append(prompt, "[LE]");
+	else
+		g_string_append(prompt, "[BR]");
+
+	g_string_append(prompt, "> ");
+
+	return prompt->str;
+}
+
+static void set_state(enum state st)
+{
+	conn_state = st;
+	rl_set_prompt(get_prompt());
+	rl_redisplay();
+}
+
+static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
+{
+	if (err) {
+		printf("connect error: %s\n", err->message);
+		return;
+	}
+
+	attrib = g_attrib_new(iochannel);
+	set_state(STATE_CONNECTED);
+}
+
 static void cmd_help(int argcp, char **argvp)
 {
 	int i;
@@ -59,6 +121,41 @@ static void cmd_exit(int argcp, char **argvp)
 	g_main_loop_quit(event_loop);
 }
 
+static void cmd_connect(int argcp, char **argvp)
+{
+	if (conn_state != STATE_DISCONNECTED)
+		return;
+
+	if (main_opts.dst == NULL) {
+		printf("Remote Bluetooth address required\n");
+		return;
+	}
+
+	set_state(STATE_CONNECTING);
+	iochannel = do_connect(main_opts.le, connect_cb);
+	if (iochannel == NULL)
+		set_state(STATE_DISCONNECTED);
+
+	return;
+}
+
+static void cmd_disconnect(int argcp, char **argvp)
+{
+	if (conn_state == STATE_DISCONNECTED)
+		return;
+
+	g_attrib_unref(attrib);
+	attrib = NULL;
+
+	g_io_channel_shutdown(iochannel, FALSE, NULL);
+	g_io_channel_unref(iochannel);
+	iochannel = NULL;
+
+	set_state(STATE_DISCONNECTED);
+
+	return;
+}
+
 static void parse_line(char *line_read)
 {
 	gchar **argvp;
@@ -110,6 +207,8 @@ int do_interactive(void)
 	GIOChannel *pchan;
 	gint events;
 
+	prompt = g_string_new(NULL);
+
 	event_loop = g_main_loop_new(NULL, FALSE);
 
 	pchan = g_io_channel_unix_new(fileno(stdin));
@@ -117,13 +216,15 @@ int do_interactive(void)
 	events = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 	g_io_add_watch(pchan, events, prompt_read, NULL);
 
-	rl_callback_handler_install("> ", parse_line);
+	rl_callback_handler_install(get_prompt(), parse_line);
 
 	g_main_loop_run(event_loop);
 
 	rl_callback_handler_remove();
+	cmd_disconnect(0, NULL);
 	g_io_channel_unref(pchan);
 	g_main_loop_unref(event_loop);
+	g_string_free(prompt, TRUE);
 
 	return 0;
 }
-- 
1.7.1

