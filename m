Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Add conf file support
Date: Tue, 24 May 2011 19:12:00 +0300
Message-Id: <1306253521-30725-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This should reduce the amount of options which normally don't change
each time obexd is executed.
---
 Makefile.am   |    2 +-
 plugins/ftp.c |    8 ++-
 src/main.c    |  173 +++++++++++++++++++++++++++++++++++++++-----------------
 3 files changed, 127 insertions(+), 56 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 8d8fdc6..2b329a6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -138,7 +138,7 @@ INCLUDES = -I$(builddir)/src -I$(srcdir)/src -I$(srcdir)/plugins \
 
 CLEANFILES = $(service_DATA) $(builtin_files)
 
-EXTRA_DIST = src/genbuiltin $(doc_files) $(test_files) src/obex.conf \
+EXTRA_DIST = src/genbuiltin $(doc_files) $(test_files) src/obexd.conf \
 			src/obexd.service.in client/obex-client.service.in \
 			plugins/phonebook-dummy.c plugins/phonebook-ebook.c \
 			plugins/phonebook-tracker.c \
diff --git a/plugins/ftp.c b/plugins/ftp.c
index 79223bf..879d9e9 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -179,8 +179,12 @@ static int get_by_type(struct ftp_session *ftp, const char *type)
 	if (type == NULL && name == NULL)
 		return -EBADR;
 
-	if (g_strcmp0(type, CAP_TYPE) == 0)
-		return obex_get_stream_start(os, capability);
+	if (g_strcmp0(type, CAP_TYPE) == 0) {
+		if (capability)
+			return obex_get_stream_start(os, capability);
+		else
+			return -ENOENT;
+	}
 
 	path = g_build_filename(ftp->folder, name, NULL);
 	err = obex_get_stream_start(os, path);
diff --git a/src/main.c b/src/main.c
index 8154e3b..6e8ef8d 100644
--- a/src/main.c
+++ b/src/main.c
@@ -54,7 +54,81 @@
 
 #define DEFAULT_ROOT_PATH "/tmp"
 
-#define DEFAULT_CAP_FILE CONFIGDIR "/capability.xml"
+static struct {
+	char *root_setup;
+	char *root_folder;
+	char *capability;
+	gboolean symlinks;
+} obexd_settings  = {
+	.root_setup = NULL,
+	.root_folder = DEFAULT_ROOT_PATH,
+	.capability = NULL,
+	.symlinks = FALSE
+};
+
+static void parse_config(GKeyFile *config)
+{
+	GError *error = NULL;
+	char *string;
+	gboolean boolean;
+
+	string = g_key_file_get_string(config, "General",
+						"RootSetup", &error);
+	if (error == NULL)
+		obexd_settings.root_setup = string;
+	else
+		g_clear_error(&error);
+
+	string = g_key_file_get_string(config, "General",
+						"RootFolder", &error);
+	if (error == NULL) {
+		if (string[0] != '/') {
+			char *old_root = string, *home = getenv("HOME");
+			if (home) {
+				string = g_strdup_printf("%s/%s", home, old_root);
+				g_free(old_root);
+			}
+		}
+
+		obexd_settings.root_folder = string;
+	} else
+		g_clear_error(&error);
+
+	string = g_key_file_get_string(config, "General",
+						"Capability", &error);
+	if (error == NULL)
+		obexd_settings.capability = string;
+	else
+		g_clear_error(&error);
+
+	boolean = g_key_file_get_boolean(config, "General",
+						"Symlinks", &error);
+	if (error == NULL)
+		obexd_settings.symlinks = boolean;
+
+	g_clear_error(&error);
+}
+
+static void load_config(const char *file)
+{
+	GError *err = NULL;
+	GKeyFile *keyfile;
+
+	DBG("%s", file);
+
+	keyfile = g_key_file_new();
+
+	g_key_file_set_list_separator(keyfile, ',');
+
+	if (!g_key_file_load_from_file(keyfile, file, 0, &err)) {
+		error("Parsing %s failed: %s", file, err->message);
+		g_error_free(err);
+		g_key_file_free(keyfile);
+		return;
+	}
+
+	parse_config(keyfile);
+}
 
 static GMainLoop *main_loop = NULL;
 
@@ -71,10 +145,7 @@ static void sig_debug(int sig)
 
 static gboolean option_detach = TRUE;
 static char *option_debug = NULL;
-
-static char *option_root = NULL;
-static char *option_root_setup = NULL;
-static char *option_capability = NULL;
+static char *option_config = NULL;
 
 static gboolean option_autoaccept = FALSE;
 static gboolean option_opp = FALSE;
@@ -82,7 +153,6 @@ static gboolean option_ftp = FALSE;
 static gboolean option_pbap = FALSE;
 static gboolean option_irmc = FALSE;
 static gboolean option_pcsuite = FALSE;
-static gboolean option_symlinks = FALSE;
 static gboolean option_syncevolution = FALSE;
 static gboolean option_mas = FALSE;
 
@@ -97,6 +167,17 @@ static gboolean parse_debug(const char *key, const char *value,
 	return TRUE;
 }
 
+static gboolean set_config(const char *key, const char *value,
+				gpointer user_data, GError **error)
+{
+	if (!value)
+		return FALSE;
+
+	option_config = g_strdup(value);
+
+	return TRUE;
+}
+
 static GOptionEntry options[] = {
 	{ "nodaemon", 'n', G_OPTION_FLAG_REVERSE,
 				G_OPTION_ARG_NONE, &option_detach,
@@ -104,14 +185,9 @@ static GOptionEntry options[] = {
 	{ "debug", 'd', G_OPTION_FLAG_OPTIONAL_ARG,
 				G_OPTION_ARG_CALLBACK, parse_debug,
 				"Enable debug information output", "DEBUG" },
-	{ "root", 'r', 0, G_OPTION_ARG_STRING, &option_root,
-				"Specify root folder location", "PATH" },
-	{ "root-setup", 'S', 0, G_OPTION_ARG_STRING, &option_root_setup,
-				"Root folder setup script", "SCRIPT" },
-	{ "symlinks", 'l', 0, G_OPTION_ARG_NONE, &option_symlinks,
-				"Enable symlinks on root folder" },
-	{ "capability", 'c', 0, G_OPTION_ARG_STRING, &option_capability,
-				"Specify capability file", "FILE" },
+	{ "config", 'c', G_OPTION_FLAG_OPTIONAL_ARG,
+				G_OPTION_ARG_CALLBACK, set_config,
+				"Config file location", "FILE" },
 	{ "auto-accept", 'a', 0, G_OPTION_ARG_NONE, &option_autoaccept,
 				"Automatically accept push requests" },
 	{ "opp", 'o', 0, G_OPTION_ARG_NONE, &option_opp,
@@ -133,12 +209,12 @@ static GOptionEntry options[] = {
 
 const char *obex_option_root_folder(void)
 {
-	return option_root;
+	return obexd_settings.root_folder;
 }
 
 gboolean obex_option_symlinks(void)
 {
-	return option_symlinks;
+	return obexd_settings.symlinks;
 }
 
 static gboolean is_dir(const char *dir) {
@@ -152,32 +228,33 @@ static gboolean is_dir(const char *dir) {
 	return S_ISDIR(st.st_mode);
 }
 
-static gboolean root_folder_setup(char *root, char *root_setup)
+static gboolean root_folder_setup()
 {
 	int status;
-	char *argv[3] = { root_setup, root, NULL };
+	char *argv[3] = { obexd_settings.root_setup,
+					obexd_settings.root_folder, NULL };
 
-	if (is_dir(root))
+	if (is_dir(argv[1]))
 		return TRUE;
 
-	if (root_setup == NULL)
+	if (argv[0] == NULL || strlen(argv[0]) == 0)
 		return FALSE;
 
-	DBG("Setting up %s using %s", root, root_setup);
+	DBG("Setting up %s using %s", argv[1], argv[0]);
 
 	if (!g_spawn_sync(NULL, argv, NULL, 0, NULL, NULL, NULL, NULL,
 							&status, NULL)) {
-		error("Unable to execute %s", root_setup);
+		error("Unable to execute %s", argv[0]);
 		return FALSE;
 	}
 
 	if (WEXITSTATUS(status) != EXIT_SUCCESS) {
-		error("%s exited with status %d", root_setup,
+		error("%s exited with status %d", argv[0],
 							WEXITSTATUS(status));
 		return FALSE;
 	}
 
-	return is_dir(root);
+	return is_dir(argv[1]);
 }
 
 int main(int argc, char *argv[])
@@ -224,6 +301,9 @@ int main(int argc, char *argv[])
 
 	__obex_log_init("obexd", option_debug, option_detach);
 
+	if (option_config)
+		load_config(option_config);
+
 	DBG("Entering main loop");
 
 	main_loop = g_main_loop_new(NULL, FALSE);
@@ -240,43 +320,32 @@ int main(int argc, char *argv[])
 		exit(EXIT_FAILURE);
 	}
 
-	if (option_root == NULL)
-		option_root = g_strdup(DEFAULT_ROOT_PATH);
-
-	if (option_root[0] != '/') {
-		char *old_root = option_root, *home = getenv("HOME");
-		if (home) {
-			option_root = g_strdup_printf("%s/%s", home, old_root);
-			g_free(old_root);
-		}
-	}
-
 	plugin_init();
 
-	if (option_capability == NULL)
-		option_capability = g_strdup(DEFAULT_CAP_FILE);
-
 	if (option_opp == TRUE)
-		obex_server_init(OBEX_OPP, option_root, FALSE,
-				option_autoaccept, option_symlinks,
-				NULL);
+		obex_server_init(OBEX_OPP, obexd_settings.root_folder,
+						FALSE, option_autoaccept,
+						obexd_settings.symlinks,
+						NULL);
 
 	if (option_ftp == TRUE)
-		obex_server_init(OBEX_FTP, option_root, TRUE,
-				option_autoaccept, option_symlinks,
-				option_capability);
+		obex_server_init(OBEX_FTP, obexd_settings.root_folder,
+						TRUE, option_autoaccept,
+						obexd_settings.symlinks,
+						obexd_settings.capability);
 
 	if (option_pbap == TRUE)
 		obex_server_init(OBEX_PBAP, NULL, TRUE, FALSE, FALSE, NULL);
 
 	if (option_pcsuite == TRUE)
-		obex_server_init(OBEX_PCSUITE, option_root, TRUE,
-				option_autoaccept, option_symlinks,
-				option_capability);
+		obex_server_init(OBEX_PCSUITE, obexd_settings.root_folder,
+						TRUE, option_autoaccept,
+						obexd_settings.symlinks,
+						obexd_settings.capability);
 
 	if (option_irmc == TRUE)
 		obex_server_init(OBEX_IRMC, NULL, TRUE, FALSE, FALSE,
-				option_capability);
+						obexd_settings.capability);
 
 	if (option_syncevolution == TRUE)
 		obex_server_init(OBEX_SYNCEVOLUTION, NULL, TRUE, FALSE,
@@ -285,8 +354,9 @@ int main(int argc, char *argv[])
 	if (option_mas == TRUE)
 		obex_server_init(OBEX_MAS, NULL, TRUE, FALSE, FALSE, NULL);
 
-	if (!root_folder_setup(option_root, option_root_setup)) {
-		error("Unable to setup root folder %s", option_root);
+	if (!root_folder_setup()) {
+		error("Unable to setup root folder %s",
+						obexd_settings.root_folder);
 		exit(EXIT_FAILURE);
 	}
 
@@ -308,9 +378,6 @@ int main(int argc, char *argv[])
 
 	g_main_loop_unref(main_loop);
 
-	g_free(option_capability);
-	g_free(option_root);
-
 	__obex_log_cleanup();
 
 	return 0;
-- 
1.7.5.1

