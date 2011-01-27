Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 2/6] Add an interactive mode to gatttool
Date: Thu, 27 Jan 2011 16:08:58 -0300
Message-Id: <1296155342-31956-2-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1296155342-31956-1-git-send-email-sheldon.demario@openbossa.org>
References: <1296155342-31956-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need a deeper control over the gatttool steps to make easier the
debug process.
---
 Makefile.am       |    2 +-
 attrib/gatttool.c |  323 +++++++++++++++++++++++++++++++++++++++++++---------
 configure.ac      |    1 +
 3 files changed, 269 insertions(+), 57 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index e6639a7..79abeed 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -180,7 +180,7 @@ bin_PROGRAMS += attrib/gatttool
 attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
 			  attrib/gattrib.c btio/btio.c \
 			  src/glib-helper.h src/glib-helper.c
-attrib_gatttool_LDADD = lib/libbluetooth.la @GLIB_LIBS@
+attrib_gatttool_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @READLINE_LIBS@
 
 builtin_modules += attrib
 builtin_sources += attrib/main.c \
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 8e8ed8e..c347f6b 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -37,6 +37,9 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
+#include <readline/readline.h>
+#include <readline/history.h>
+
 #include "att.h"
 #include "btio.h"
 #include "gattrib.h"
@@ -50,7 +53,7 @@ static gchar *opt_src = NULL;
 static gchar *opt_dst = NULL;
 static gchar *opt_value = NULL;
 static gchar *opt_sec_level = "low";
-static uuid_t *opt_uuid = NULL;
+static uuid_t *opt_uuid;
 static int opt_start = 0x0001;
 static int opt_end = 0xffff;
 static int opt_handle = -1;
@@ -63,8 +66,14 @@ static gboolean opt_listen = FALSE;
 static gboolean opt_char_desc = FALSE;
 static gboolean opt_le = FALSE;
 static gboolean opt_char_write = FALSE;
-static GMainLoop *event_loop;
+static gboolean opt_interactive = FALSE;
+
+static GMainLoop *event_loop = NULL;
+static GIOChannel *iochannel = NULL;
 static gboolean got_error = FALSE;
+static GAttrib *attrib = NULL;
+static GString *prompt = NULL;
+static GOptionContext *context = NULL;
 
 struct characteristic_data {
 	GAttrib *attrib;
@@ -72,16 +81,72 @@ struct characteristic_data {
 	uint16_t end;
 };
 
+enum state {
+	STATE_DISCONNECTED,
+	STATE_CONNECTING,
+	STATE_CONNECTED
+} conn_state;
+
+static void show_message(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+
+	vprintf(format, ap);
+
+	va_end(ap);
+
+	rl_redisplay();
+}
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
+static void set_state(enum state st)
+{
+	conn_state = st;
+	rl_set_prompt(get_prompt());
+	rl_redisplay();
+}
+
 static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
 	if (err) {
-		g_printerr("%s\n", err->message);
-		got_error = TRUE;
-		g_main_loop_quit(event_loop);
+		show_message("connect error: %s\n", err->message);
+		if (!opt_interactive) {
+			got_error = TRUE;
+			g_main_loop_quit(event_loop);
+		}
+	}
+
+	if (opt_interactive) {
+		attrib = g_attrib_new(iochannel);
+		set_state(STATE_CONNECTED);
 	}
 }
 
-static GIOChannel *do_connect(gboolean le)
+static GIOChannel *do_connect(gboolean le, const gchar *dest,
+							BtIOConnect connect_cb)
 {
 	GIOChannel *chan;
 	bdaddr_t sba, dba;
@@ -97,11 +162,11 @@ static GIOChannel *do_connect(gboolean le)
 	}
 
 	/* Remote device */
-	if (opt_dst == NULL) {
+	if (dest == NULL) {
 		g_printerr("Remote Bluetooth address required\n");
 		return NULL;
 	}
-	str2ba(opt_dst, &dba);
+	str2ba(dest, &dba);
 
 	/* Local adapter */
 	if (opt_src != NULL) {
@@ -232,6 +297,23 @@ static gboolean listen_start(gpointer user_data)
 	return FALSE;
 }
 
+static gboolean cmd_disconnect(gpointer cmd)
+{
+	if (conn_state == STATE_DISCONNECTED)
+		return FALSE;
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
+	return FALSE;
+}
+
 static gboolean primary(gpointer user_data)
 {
 	GAttrib *attrib = user_data;
@@ -256,6 +338,24 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 		goto done;
 	}
 
+	if (opt_interactive) {
+		rl_save_prompt();
+		for (l = characteristics; l; l = l->next) {
+			struct att_char *chars = l->data;
+
+			rl_message("handle = 0x%04x, char "
+				"properties = 0x%02x, char value "
+				"handle = 0x%04x, uuid = %s\n", chars->handle,
+				chars->properties, chars->value_handle, chars->uuid);
+			rl_on_new_line();
+		}
+
+		rl_restore_prompt();
+		rl_forced_update_display();
+
+		return;
+	}
+
 	for (l = characteristics; l; l = l->next) {
 		struct att_char *chars = l->data;
 
@@ -265,12 +365,16 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	}
 
 done:
-	g_main_loop_quit(event_loop);
+	if (opt_interactive)
+		g_main_loop_quit(event_loop);
 }
 
 static gboolean characteristics(gpointer user_data)
 {
-	GAttrib *attrib = user_data;
+	if (opt_interactive && conn_state != STATE_CONNECTED) {
+		show_message("Fail: disconnected\n");
+		return FALSE;
+	}
 
 	gatt_discover_char(attrib, opt_start, opt_end, char_discovered_cb, NULL);
 
@@ -487,6 +591,153 @@ static gboolean characteristics_desc(gpointer user_data)
 	return FALSE;
 }
 
+static gboolean cmd_connect(gpointer cmd)
+{
+	const char **c = (const char **) cmd;
+	if (conn_state != STATE_DISCONNECTED)
+		return FALSE;
+
+	if (c[1] != NULL) {
+		g_free(opt_dst);
+		opt_dst = strdup(c[1]);
+	}
+
+	if (opt_dst == NULL) {
+		show_message("Remote Bluetooth address required\n");
+		return FALSE;
+	}
+
+	set_state(STATE_CONNECTING);
+	iochannel = do_connect(opt_le, opt_dst, connect_cb);
+	if (iochannel == NULL)
+		set_state(STATE_DISCONNECTED);
+
+	return FALSE;
+}
+
+static struct {
+	char *cmd;
+	gboolean (*func)(gpointer cmd);
+	char *param;
+	char *desc;
+} commands[] = {
+	{ "connect",	cmd_connect,	"<bdaddr>",	"Connect"},
+	{ "disconnect",	cmd_disconnect,	NULL,		"Disconnect"},
+	{ "characteristics",	characteristics,	NULL,
+						"Characteristcs Discovery"},
+	{ NULL, NULL, NULL, NULL}
+};
+
+static void parse_line(char *line_read)
+{
+	char **command;
+	int j;
+
+	if (!(line_read && *line_read))
+		return;
+
+	add_history(line_read);
+
+	line_read = g_strstrip(line_read);
+
+	command = g_strsplit(line_read, " ", -1);
+	for (j = 0; commands[j].cmd; j++) {
+		if (strcasecmp(commands[j].cmd, command[0]))
+			continue;
+
+		commands[j].func(command);
+	}
+
+	g_strfreev(command);
+}
+
+static gboolean prompt_read(GIOChannel *chan, GIOCondition cond,
+							gpointer user_data)
+{
+	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
+		g_io_channel_unref(chan);
+		return FALSE;
+	}
+
+	if (conn_state != STATE_CONNECTING)
+		rl_callback_read_char();
+
+	return TRUE;
+}
+
+static int do_interactive(void)
+{
+	GIOChannel *pchan;
+	gint events;
+
+	event_loop = g_main_loop_new(NULL, FALSE);
+	prompt = g_string_new(NULL);
+
+	pchan = g_io_channel_unix_new(fileno(stdin));
+	g_io_channel_set_close_on_unref(pchan, TRUE);
+	events = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+	g_io_add_watch(pchan, events, prompt_read, NULL);
+
+	rl_callback_handler_install(get_prompt(), parse_line);
+
+	g_main_loop_run(event_loop);
+
+	cmd_disconnect(NULL);
+	rl_callback_handler_remove();
+	g_io_channel_unref(pchan);
+	g_main_loop_unref(event_loop);
+
+	return 0;
+}
+
+static void do_noninteractive(void)
+{
+	GSourceFunc callback;
+
+	if (opt_primary)
+		callback = primary;
+	else if (opt_characteristics)
+		callback = characteristics;
+	else if (opt_char_read)
+		callback = characteristics_read;
+	else if (opt_char_write)
+		callback = characteristics_write;
+	else if (opt_char_desc)
+		callback = characteristics_desc;
+	else {
+		gchar *help = g_option_context_get_help(context, TRUE, NULL);
+		g_print("%s\n", help);
+		g_free(help);
+		got_error = TRUE;
+		return;
+	}
+
+	iochannel = do_connect(opt_le, opt_dst, connect_cb);
+	if (iochannel == NULL) {
+		got_error = TRUE;
+		return;
+	}
+
+	attrib = g_attrib_new(iochannel);
+
+	event_loop = g_main_loop_new(NULL, FALSE);
+
+	if (opt_listen)
+		g_idle_add(listen_start, attrib);
+
+	g_idle_add(callback, attrib);
+
+	g_main_loop_run(event_loop);
+
+	g_attrib_unregister_all(attrib);
+
+	g_io_channel_unref(iochannel);
+
+	g_attrib_unref(attrib);
+
+	g_main_loop_unref(event_loop);
+}
+
 static gboolean parse_uuid(const char *key, const char *value,
 				gpointer user_data, GError **error)
 {
@@ -537,6 +788,8 @@ static GOptionEntry gatt_options[] = {
 		"Listen for notifications and indications", NULL },
 	{ "le", 0, 0, G_OPTION_ARG_NONE, &opt_le,
 		"Use Bluetooth Low Energy transport", NULL },
+	{ "interactive", 'I', 0, G_OPTION_ARG_NONE, &opt_interactive,
+		"Use interactive mode", NULL },
 	{ NULL },
 };
 
@@ -556,12 +809,8 @@ static GOptionEntry options[] = {
 
 int main(int argc, char *argv[])
 {
-	GOptionContext *context;
 	GOptionGroup *gatt_group, *params_group, *char_rw_group;
 	GError *gerr = NULL;
-	GAttrib *attrib;
-	GIOChannel *chan;
-	GSourceFunc callback;
 
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
@@ -594,49 +843,11 @@ int main(int argc, char *argv[])
 		g_error_free(gerr);
 	}
 
-	if (opt_primary)
-		callback = primary;
-	else if (opt_characteristics)
-		callback = characteristics;
-	else if (opt_char_read)
-		callback = characteristics_read;
-	else if (opt_char_write)
-		callback = characteristics_write;
-	else if (opt_char_desc)
-		callback = characteristics_desc;
-	else {
-		gchar *help = g_option_context_get_help(context, TRUE, NULL);
-		g_print("%s\n", help);
-		g_free(help);
-		got_error = TRUE;
-		goto done;
-	}
-
-	chan = do_connect(opt_le);
-	if (chan == NULL) {
-		got_error = TRUE;
-		goto done;
-	}
-
-	attrib = g_attrib_new(chan);
-
-	event_loop = g_main_loop_new(NULL, FALSE);
-
-	if (opt_listen)
-		g_idle_add(listen_start, attrib);
-
-	g_idle_add(callback, attrib);
-
-	g_main_loop_run(event_loop);
-
-	g_attrib_unregister_all(attrib);
-
-	g_main_loop_unref(event_loop);
-
-	g_io_channel_unref(chan);
-	g_attrib_unref(attrib);
+	if (opt_interactive)
+		do_interactive();
+	else
+		do_noninteractive();
 
-done:
 	g_option_context_free(context);
 	g_free(opt_src);
 	g_free(opt_dst);
diff --git a/configure.ac b/configure.ac
index bebdc9c..3058fc6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -41,6 +41,7 @@ AC_PATH_ALSA
 AC_PATH_GSTREAMER
 AC_PATH_USB
 AC_PATH_SNDFILE
+AC_PATH_READLINE
 AC_PATH_OUI
 
 AC_ARG_BLUEZ
-- 
1.7.1

