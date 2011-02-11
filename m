Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH v2 5/5] Add connect/disconnect options on interactive mode of gatttool
Date: Fri, 11 Feb 2011 11:17:23 -0300
Message-Id: <1297433843-9192-5-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1297433843-9192-1-git-send-email-sheldon.demario@openbossa.org>
References: <1297433843-9192-1-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <20110209212642.GA11368@jh-x301>
References: <20110209212642.GA11368@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatttool.c    |    6 +-
 attrib/gatttool.h    |    3 +-
 attrib/interactive.c |  105 +++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 108 insertions(+), 6 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index badd3b0..1b89d9f 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -87,7 +87,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	}
 }
 
-static GIOChannel *do_connect(gboolean le)
+GIOChannel *do_connect(gboolean le, BtIOConnect connect_cb)
 {
 	GIOChannel *chan;
 	bdaddr_t sba, dba;
@@ -609,7 +609,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (main_opts.interactive) {
-		interactive();
+		interactive(&main_opts);
 		goto done;
 	}
 
@@ -631,7 +631,7 @@ int main(int argc, char *argv[])
 		goto done;
 	}
 
-	chan = do_connect(main_opts.le);
+	chan = do_connect(main_opts.le, connect_cb);
 	if (chan == NULL) {
 		got_error = TRUE;
 		goto done;
diff --git a/attrib/gatttool.h b/attrib/gatttool.h
index 3dbe88b..c80026c 100644
--- a/attrib/gatttool.h
+++ b/attrib/gatttool.h
@@ -42,4 +42,5 @@ struct main_opts {
 	gboolean interactive;
 };
 
-int interactive(void);
+int interactive(struct main_opts *config);
+GIOChannel *do_connect(gboolean le, BtIOConnect connect_cb);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 425a9b2..5fb6f8e 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -30,18 +30,111 @@
 #include <readline/readline.h>
 #include <readline/history.h>
 
+#include "btio.h"
+#include "gattrib.h"
 #include "gatttool.h"
 
+static GIOChannel *iochannel = NULL;
+static GAttrib *attrib = NULL;
 static GMainLoop *event_loop;
+static GString *prompt;
+static struct main_opts *main_opts;
 
 static void cmd_help(int argcp, char **argvp);
 
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
+	if (main_opts->dst)
+		g_string_append_printf(prompt, "[%17s]", main_opts->dst);
+	else
+		g_string_append_printf(prompt, "[%17s]", "");
+
+	if (main_opts->le)
+		g_string_append(prompt, "[LE]");
+	else
+		g_string_append(prompt, "[BR]");
+
+	g_string_append(prompt, "> ");
+
+	return prompt->str;
+}
+
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
 static void cmd_exit(int argcp, char **argvp)
 {
 	rl_callback_handler_remove();
 	g_main_loop_quit(event_loop);
 }
 
+static void cmd_connect(int argcp, char **argvp)
+{
+	if (conn_state != STATE_DISCONNECTED)
+		return;
+
+	if (main_opts->dst == NULL) {
+		printf("Remote Bluetooth address required\n");
+		return;
+	}
+
+	set_state(STATE_CONNECTING);
+	iochannel = do_connect(main_opts->le, connect_cb);
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
 static struct {
 	const char *cmd;
 	void (*func)(int argcp, char **argvp);
@@ -49,6 +142,8 @@ static struct {
 } commands[] = {
 	{ "help",	cmd_help,	"Show this help"},
 	{ "exit",	cmd_exit,	"Exit interactive mode"},
+	{ "connect",	cmd_connect,	"Connect to a remote device"},
+	{ "disconnect",	cmd_disconnect,	"Disconnect from a remote device"},
 	{ NULL, NULL, NULL}
 };
 
@@ -106,11 +201,15 @@ static gboolean prompt_read(GIOChannel *chan, GIOCondition cond,
 	return TRUE;
 }
 
-int interactive(void)
+int interactive(struct main_opts *config)
 {
 	GIOChannel *pchan;
 	gint events;
 
+	main_opts = config;
+
+	prompt = g_string_new(NULL);
+
 	event_loop = g_main_loop_new(NULL, FALSE);
 
 	pchan = g_io_channel_unix_new(fileno(stdin));
@@ -118,13 +217,15 @@ int interactive(void)
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

