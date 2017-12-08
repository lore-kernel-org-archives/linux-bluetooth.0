Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 08/10] shell: Add bt_shell_opt
Date: Fri,  8 Dec 2017 08:52:54 -0200
Message-Id: <20171208105256.18635-8-luiz.dentz@gmail.com>
In-Reply-To: <20171208105256.18635-1-luiz.dentz@gmail.com>
References: <20171208105256.18635-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Make use of struct option and getopt_long to parse the options given.
---
 client/main.c            | 40 ++++++++++++++----------
 mesh/main.c              | 25 ++++++++++++---
 src/shared/shell.c       | 81 ++++++++++++++++++++++++++++++++----------------
 src/shared/shell.h       | 11 ++++++-
 tools/bluetooth-player.c |  2 +-
 tools/obexctl.c          |  2 +-
 6 files changed, 111 insertions(+), 50 deletions(-)

diff --git a/client/main.c b/client/main.c
index f0f62fe2a..f3369e89a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2344,22 +2344,27 @@ static const struct bt_shell_menu main_menu = {
 	{ } },
 };
 
-static gboolean parse_agent(const char *key, const char *value,
-					gpointer user_data, GError **error)
-{
-	if (!value)
-		return FALSE;
+static const struct option options[] = {
+	{ "agent",	required_argument, 0, 'a' },
+	{ 0, 0, 0, 0 }
+};
 
-	g_free(auto_register_agent);
-	auto_register_agent = g_strdup(value);
+static const char *agent_option;
 
-	return TRUE;
-}
+static const char **optargs[] = {
+	&agent_option
+};
+
+static const char *help[] = {
+	"Register agent handler: <capability>"
+};
 
-static GOptionEntry options[] = {
-	{ "agent", 'a', 0, G_OPTION_ARG_CALLBACK, parse_agent,
-				"Register agent handler", "CAPABILITY" },
-	{ NULL },
+static const struct bt_shell_opt opt = {
+	.options = options,
+	.optno = sizeof(options) / sizeof(struct option),
+	.optstr = "a:",
+	.optarg = optargs,
+	.help = help,
 };
 
 static void client_ready(GDBusClient *client, void *user_data)
@@ -2371,15 +2376,18 @@ int main(int argc, char *argv[])
 {
 	GDBusClient *client;
 
-	auto_register_agent = g_strdup("");
-
-	bt_shell_init(&argc, &argv, options);
+	bt_shell_init(argc, argv, &opt);
 	bt_shell_set_menu(&main_menu);
 	bt_shell_add_submenu(&advertise_menu);
 	bt_shell_add_submenu(&scan_menu);
 	bt_shell_add_submenu(&gatt_menu);
 	bt_shell_set_prompt(PROMPT_OFF);
 
+	if (agent_option)
+		auto_register_agent = g_strdup(agent_option);
+	else
+		auto_register_agent = g_strdup("");
+
 	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
 	g_dbus_attach_object_manager(dbus_conn);
 
diff --git a/mesh/main.c b/mesh/main.c
index 05841363f..4d63c5751 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -1925,10 +1925,25 @@ static const struct bt_shell_menu main_menu = {
 
 static const char *mesh_config_dir;
 
-static GOptionEntry options[] = {
-	{ "config", 'c', 0, G_OPTION_ARG_STRING, &mesh_config_dir,
-			"Read local mesh config JSON files from <directory>" },
-	{ NULL },
+static const struct option options[] = {
+	{ "config",	required_argument, 0, 'c' },
+	{ 0, 0, 0, 0 }
+};
+
+static const char **optargs[] = {
+	&mesh_config_dir
+};
+
+static const char *help[] = {
+	"Read local mesh config JSON files from <directory>"
+};
+
+static const struct bt_shell_opt opt = {
+	.options = options,
+	.optno = sizeof(options) / sizeof(struct option),
+	.optstr = "c:",
+	.optarg = optargs,
+	.help = help,
 };
 
 static void client_ready(GDBusClient *client, void *user_data)
@@ -1942,7 +1957,7 @@ int main(int argc, char *argv[])
 	int len;
 	int extra;
 
-	bt_shell_init(&argc, &argv, options);
+	bt_shell_init(argc, argv, &opt);
 	bt_shell_set_menu(&main_menu);
 	bt_shell_set_prompt(PROMPT_OFF);
 
diff --git a/src/shared/shell.c b/src/shared/shell.c
index 7e639ccc3..a4be844b7 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -33,6 +33,7 @@
 #include <signal.h>
 #include <sys/signalfd.h>
 #include <wordexp.h>
+#include <getopt.h>
 
 #include <readline/readline.h>
 #include <readline/history.h>
@@ -54,7 +55,6 @@
 			cmd, (int)(CMD_LENGTH - strlen(cmd)), "", desc)
 
 static GMainLoop *main_loop;
-static gboolean option_version = FALSE;
 
 static struct {
 	struct io *input;
@@ -657,12 +657,6 @@ static struct io *setup_signalfd(void)
 	return io;
 }
 
-static GOptionEntry main_options[] = {
-	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
-				"Show version information and exit" },
-	{ NULL },
-};
-
 static void rl_init(void)
 {
 	setlinebuf(stdout);
@@ -672,30 +666,65 @@ static void rl_init(void)
 	rl_callback_handler_install(NULL, rl_handler);
 }
 
-void bt_shell_init(int *argc, char ***argv, GOptionEntry *options)
+static const struct option main_options[] = {
+	{ "version",	no_argument, 0, 'v' },
+	{ "help",	no_argument, 0, 'h' },
+};
+
+static void usage(int argc, char **argv, const struct bt_shell_opt *opt)
 {
-	GOptionContext *context;
-	GError *error = NULL;
+	unsigned int i;
 
-	context = g_option_context_new(NULL);
-	g_option_context_add_main_entries(context, main_options, NULL);
-	if (options)
-		g_option_context_add_main_entries(context, options, NULL);
+	printf("%s ver %s\n", argv[0], VERSION);
+	printf("Usage:\n"
+		"\t%s [options]\n", argv[0]);
 
-	if (g_option_context_parse(context, argc, argv, &error) == FALSE) {
-		if (error != NULL) {
-			g_printerr("%s\n", error->message);
-			g_error_free(error);
-		} else
-			g_printerr("An unknown error occurred\n");
-		exit(1);
-	}
+	printf("Options:\n");
+
+	for (i = 0; opt && opt->options[i].name; i++)
+		printf("\t--%s \t%s\n", opt->options[i].name, opt->help[i]);
+
+	printf("\t--version \tDisplay version\n"
+		"\t--help \t\tDisplay help\n");
+}
+
+void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
+{
+	int c, index = 0;
+	struct option options[256];
+	char optstr[256];
+	size_t offset;
+
+	offset = sizeof(main_options) / sizeof(struct option);
 
-	g_option_context_free(context);
+	memcpy(options, main_options, sizeof(struct option) * offset);
 
-	if (option_version == TRUE) {
-		g_print("%s\n", VERSION);
-		exit(EXIT_SUCCESS);
+	if (opt) {
+		memcpy(options + offset, opt->options,
+				sizeof(struct option) * opt->optno);
+		snprintf(optstr, sizeof(optstr), "+hv%s", opt->optstr);
+	} else
+		snprintf(optstr, sizeof(optstr), "+hv");
+
+	while ((c = getopt_long(argc, argv, optstr, options, &index)) != -1) {
+		switch (c) {
+		case 'v':
+			printf("%s: %s\n", argv[0], VERSION);
+			exit(EXIT_SUCCESS);
+			return;
+		case 'h':
+			usage(argc, argv, opt);
+			exit(EXIT_SUCCESS);
+			return;
+		default:
+			if (c != opt->options[index - offset].val) {
+				usage(argc, argv, opt);
+				exit(EXIT_SUCCESS);
+				return;
+			}
+
+			*opt->optarg[index - offset] = optarg;
+		}
 	}
 
 	main_loop = g_main_loop_new(NULL, FALSE);
diff --git a/src/shared/shell.h b/src/shared/shell.h
index f2eb85474..2b9e918d6 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -20,6 +20,7 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
  */
+#include <getopt.h>
 
 #define COLOR_OFF	"\x1B[0m"
 #define COLOR_RED	"\x1B[0;91m"
@@ -50,7 +51,15 @@ struct bt_shell_menu {
 	const struct bt_shell_menu_entry entries[];
 };
 
-void bt_shell_init(int *argc, char ***argv, GOptionEntry *options);
+struct bt_shell_opt {
+	const struct option *options;
+	size_t optno;
+	const char *optstr;
+	const char ***optarg;
+	const char **help;
+};
+
+void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt);
 
 void bt_shell_run(void);
 
diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index 92235ac8e..f819488f3 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -1132,7 +1132,7 @@ int main(int argc, char *argv[])
 {
 	GDBusClient *client;
 
-	bt_shell_init(&argc, &argv, NULL);
+	bt_shell_init(argc, argv, NULL);
 	bt_shell_set_menu(&main_menu);
 	bt_shell_set_prompt(PROMPT_OFF);
 	bt_shell_attach(fileno(stdin));
diff --git a/tools/obexctl.c b/tools/obexctl.c
index f5ab29612..c4c7686c1 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -2153,7 +2153,7 @@ int main(int argc, char *argv[])
 {
 	GDBusClient *client;
 
-	bt_shell_init(&argc, &argv, NULL);
+	bt_shell_init(argc, argv, NULL);
 	bt_shell_set_menu(&main_menu);
 	bt_shell_set_prompt(PROMPT_OFF);
 	bt_shell_attach(fileno(stdin));
-- 
2.13.6

