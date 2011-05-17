Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Simplify options for including/excluding plugins
Date: Tue, 17 May 2011 11:17:44 +0300
Message-Id: <1305620264-22304-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1305620264-22304-1-git-send-email-luiz.dentz@gmail.com>
References: <1305620264-22304-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Plugins options are now handle with --plugin(-p)/--noplugin(-P) which
takes a string set containing the plugin names separated by ',',':' or
' 'similar to bluetoothd, ofono and connman.
---
 src/main.c   |   76 ++++++++++++++-------------------------------------------
 src/obexd.h  |    2 +-
 src/plugin.c |   51 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 69 insertions(+), 60 deletions(-)

diff --git a/src/main.c b/src/main.c
index 018a8cf..fb4c8e0 100644
--- a/src/main.c
+++ b/src/main.c
@@ -148,15 +148,10 @@ static void sig_debug(int sig)
 static gboolean option_detach = TRUE;
 static char *option_debug = NULL;
 static char *option_config = NULL;
+static char *option_plugin = NULL;
+static char *option_noplugin = NULL;
 
 static gboolean option_autoaccept = FALSE;
-static gboolean option_opp = FALSE;
-static gboolean option_ftp = FALSE;
-static gboolean option_pbap = FALSE;
-static gboolean option_irmc = FALSE;
-static gboolean option_pcsuite = FALSE;
-static gboolean option_syncevolution = FALSE;
-static gboolean option_mas = FALSE;
 
 static gboolean parse_debug(const char *key, const char *value,
 				gpointer user_data, GError **error)
@@ -192,20 +187,10 @@ static GOptionEntry options[] = {
 				"Config file location", "FILE" },
 	{ "auto-accept", 'a', 0, G_OPTION_ARG_NONE, &option_autoaccept,
 				"Automatically accept push requests" },
-	{ "opp", 'o', 0, G_OPTION_ARG_NONE, &option_opp,
-				"Enable Object Push server" },
-	{ "ftp", 'f', 0, G_OPTION_ARG_NONE, &option_ftp,
-				"Enable File Transfer server" },
-	{ "pbap", 'p', 0, G_OPTION_ARG_NONE, &option_pbap,
-				"Enable Phonebook Access server" },
-	{ "irmc", 'i', 0, G_OPTION_ARG_NONE, &option_irmc,
-				"Enable IrMC Sync server" },
-	{ "pcsuite", 's', 0, G_OPTION_ARG_NONE, &option_pcsuite,
-				"Enable PC Suite Services server" },
-	{ "syncevolution", 'e', 0, G_OPTION_ARG_NONE, &option_syncevolution,
-				"Enable OBEX server for SyncEvolution" },
-        { "mas", 'm', 0, G_OPTION_ARG_NONE, &option_mas,
-				"Enable Message Access server" },
+	{ "plugin", 'p', 0, G_OPTION_ARG_STRING, &option_plugin,
+				"Specify plugins to load", "NAME,..." },
+	{ "noplugin", 'P', 0, G_OPTION_ARG_STRING, &option_noplugin,
+				"Specify plugins not to load", "NAME,..." },
 	{ NULL },
 };
 
@@ -292,16 +277,6 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (option_opp == FALSE && option_ftp == FALSE &&
-				option_pbap == FALSE &&
-				option_irmc == FALSE &&
-				option_syncevolution == FALSE &&
-				option_mas == FALSE) {
-		fprintf(stderr, "No server selected (use either "
-				"--opp, --ftp, --pbap, --irmc, --mas, or --syncevolution)\n");
-		exit(EXIT_FAILURE);
-	}
-
 	__obex_log_init("obexd", option_debug, option_detach);
 
 	if (option_config)
@@ -323,39 +298,26 @@ int main(int argc, char *argv[])
 		exit(EXIT_FAILURE);
 	}
 
-	plugin_init();
+	plugin_init(option_plugin, option_noplugin);
 
-	if (option_opp == TRUE)
-		obex_server_init(OBEX_OPP, obexd_settings.root_folder,
-						FALSE, option_autoaccept,
-						obexd_settings.symlinks,
-						NULL);
+	obex_server_init(OBEX_OPP, obexd_settings.root_folder, FALSE,
+			option_autoaccept, obexd_settings.symlinks, NULL);
 
-	if (option_ftp == TRUE)
-		obex_server_init(OBEX_FTP, obexd_settings.root_folder,
-						TRUE, option_autoaccept,
-						obexd_settings.symlinks,
-						obexd_settings.capability);
+	obex_server_init(OBEX_FTP, obexd_settings.root_folder, TRUE,
+			option_autoaccept, obexd_settings.symlinks,
+			obexd_settings.capability);
 
-	if (option_pbap == TRUE)
-		obex_server_init(OBEX_PBAP, NULL, TRUE, FALSE, FALSE, NULL);
+	obex_server_init(OBEX_PCSUITE, obexd_settings.root_folder, TRUE,
+			option_autoaccept, obexd_settings.symlinks,
+			obexd_settings.capability);
 
-	if (option_pcsuite == TRUE)
-		obex_server_init(OBEX_PCSUITE, obexd_settings.root_folder,
-						TRUE, option_autoaccept,
-						obexd_settings.symlinks,
-						obexd_settings.capability);
+	obex_server_init(OBEX_PBAP, NULL, TRUE, FALSE, FALSE, NULL);
 
-	if (option_irmc == TRUE)
-		obex_server_init(OBEX_IRMC, NULL, TRUE, FALSE, FALSE,
-						obexd_settings.capability);
+	obex_server_init(OBEX_IRMC, NULL, TRUE, FALSE, FALSE, NULL);
 
-	if (option_syncevolution == TRUE)
-		obex_server_init(OBEX_SYNCEVOLUTION, NULL, TRUE, FALSE,
-							FALSE, NULL);
+	obex_server_init(OBEX_SYNCEVOLUTION, NULL, TRUE, FALSE, FALSE, NULL);
 
-	if (option_mas == TRUE)
-		obex_server_init(OBEX_MAS, NULL, TRUE, FALSE, FALSE, NULL);
+	obex_server_init(OBEX_MAS, NULL, TRUE, FALSE, FALSE, NULL);
 
 	if (!root_folder_setup()) {
 		error("Unable to setup root folder %s",
diff --git a/src/obexd.h b/src/obexd.h
index df21f00..37106b7 100644
--- a/src/obexd.h
+++ b/src/obexd.h
@@ -21,7 +21,7 @@
  *
  */
 
-gboolean plugin_init(void);
+gboolean plugin_init(const char *pattern, const char *exclude);
 void plugin_cleanup(void);
 
 gboolean manager_init(void);
diff --git a/src/plugin.c b/src/plugin.c
index 14a569f..c8ec642 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -79,10 +79,39 @@ static gboolean add_plugin(void *handle, struct obex_plugin_desc *desc)
 	return TRUE;
 }
 
+static gboolean check_plugin(struct obex_plugin_desc *desc,
+				char **patterns, char **excludes)
+{
+	if (excludes) {
+		for (; *excludes; excludes++)
+			if (g_pattern_match_simple(*excludes, desc->name))
+				break;
+		if (*excludes) {
+			info("Excluding %s", desc->name);
+			return FALSE;
+		}
+	}
+
+	if (patterns) {
+		for (; *patterns; patterns++)
+			if (g_pattern_match_simple(*patterns, desc->name))
+				break;
+		if (*patterns == NULL) {
+			info("Ignoring %s", desc->name);
+			return FALSE;
+		}
+	}
+
+	return TRUE;
+}
+
+
 #include "builtin.h"
 
-gboolean plugin_init(void)
+gboolean plugin_init(const char *pattern, const char *exclude)
 {
+	gchar **patterns = NULL;
+	gchar **excludes = NULL;
 	GDir *dir;
 	const char *file;
 	unsigned int i;
@@ -90,10 +119,21 @@ gboolean plugin_init(void)
 	if (strlen(PLUGINDIR) == 0)
 		return FALSE;
 
+	if (pattern)
+		patterns = g_strsplit_set(pattern, ":, ", -1);
+
+	if (exclude)
+		excludes = g_strsplit_set(exclude, ":, ", -1);
+
 	DBG("Loading builtin plugins");
 
-	for (i = 0; __obex_builtin[i]; i++)
+	for (i = 0; __obex_builtin[i]; i++) {
+		if (check_plugin(__obex_builtin[i],
+					patterns, excludes) == FALSE)
+			continue;
+
 		add_plugin(NULL,  __obex_builtin[i]);
+	}
 
 	DBG("Loading plugins %s", PLUGINDIR);
 
@@ -129,11 +169,18 @@ gboolean plugin_init(void)
 			continue;
 		}
 
+		if (check_plugin(desc, patterns, excludes) == FALSE) {
+			dlclose(handle);
+			continue;
+		}
+
 		if (add_plugin(handle, desc) == FALSE)
 			dlclose(handle);
 	}
 
 	g_dir_close(dir);
+	g_strfreev(patterns);
+	g_strfreev(excludes);
 
 	return TRUE;
 }
-- 
1.7.1

