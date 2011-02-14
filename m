Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH v3 3/3] Add connect/disconnect options on interactive mode of gatttool
Date: Mon, 14 Feb 2011 12:07:20 -0300
Message-Id: <1297696040-16453-3-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1297696040-16453-1-git-send-email-sheldon.demario@openbossa.org>
References: <1297696040-16453-1-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <20110209212642.GA11368@jh-x301>
References: <20110209212642.GA11368@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatttool.c    |   10 ++--
 attrib/gatttool.h    |    3 +-
 attrib/interactive.c |  114 +++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 119 insertions(+), 8 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index d663eb5..cd6b60d 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -83,7 +83,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	}
 }
 
-static GIOChannel *do_connect(gboolean le)
+GIOChannel *do_connect(gchar *dst, gboolean le, BtIOConnect connect_cb)
 {
 	GIOChannel *chan;
 	bdaddr_t sba, dba;
@@ -99,11 +99,11 @@ static GIOChannel *do_connect(gboolean le)
 	}
 
 	/* Remote device */
-	if (opt_dst == NULL) {
+	if (dst == NULL) {
 		g_printerr("Remote Bluetooth address required\n");
 		return NULL;
 	}
-	str2ba(opt_dst, &dba);
+	str2ba(dst, &dba);
 
 	/* Local adapter */
 	if (opt_src != NULL) {
@@ -599,7 +599,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (opt_interactive) {
-		interactive();
+		interactive(opt_dst, opt_le);
 		goto done;
 	}
 
@@ -621,7 +621,7 @@ int main(int argc, char *argv[])
 		goto done;
 	}
 
-	chan = do_connect(opt_le);
+	chan = do_connect(opt_dst, opt_le, connect_cb);
 	if (chan == NULL) {
 		got_error = TRUE;
 		goto done;
diff --git a/attrib/gatttool.h b/attrib/gatttool.h
index ed5d9d6..2237330 100644
--- a/attrib/gatttool.h
+++ b/attrib/gatttool.h
@@ -21,4 +21,5 @@
  *
  */
 
-int interactive(void);
+int interactive(gchar *dst, gboolean le);
+GIOChannel *do_connect(gchar *dst, gboolean le, BtIOConnect connect_cb);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 0653609..83a0778 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -28,18 +28,119 @@
 #include <readline/readline.h>
 #include <readline/history.h>
 
+#include "btio.h"
+#include "gattrib.h"
 #include "gatttool.h"
 
+static GIOChannel *iochannel = NULL;
+static GAttrib *attrib = NULL;
 static GMainLoop *event_loop;
+static GString *prompt;
+
+static gchar *opt_dst = NULL;
+static gboolean opt_le = FALSE;
 
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
+	if (opt_dst)
+		g_string_append_printf(prompt, "[%17s]", opt_dst);
+	else
+		g_string_append_printf(prompt, "[%17s]", "");
+
+	if (opt_le)
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
+		set_state(STATE_DISCONNECTED);
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
+	if (argcp > 1) {
+		g_free(opt_dst);
+		opt_dst = strdup(argvp[1]);
+	}
+
+	if (opt_dst == NULL) {
+		printf("Remote Bluetooth address required\n");
+		return;
+	}
+
+	set_state(STATE_CONNECTING);
+	iochannel = do_connect(opt_dst, opt_le, connect_cb);
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
@@ -47,6 +148,8 @@ static struct {
 } commands[] = {
 	{ "help",	cmd_help,	"Show this help"},
 	{ "exit",	cmd_exit,	"Exit interactive mode"},
+	{ "connect",	cmd_connect,	"Connect to a remote device"},
+	{ "disconnect",	cmd_disconnect,	"Disconnect from a remote device"},
 	{ NULL, NULL, NULL}
 };
 
@@ -104,11 +207,16 @@ static gboolean prompt_read(GIOChannel *chan, GIOCondition cond,
 	return TRUE;
 }
 
-int interactive(void)
+int interactive(gchar *dst, gboolean le)
 {
 	GIOChannel *pchan;
 	gint events;
 
+	opt_dst = dst;
+	opt_le = le;
+
+	prompt = g_string_new(NULL);
+
 	event_loop = g_main_loop_new(NULL, FALSE);
 
 	pchan = g_io_channel_unix_new(fileno(stdin));
@@ -116,13 +224,15 @@ int interactive(void)
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

