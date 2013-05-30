Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 1/5] core: Add option to list available plugins
Date: Fri, 31 May 2013 00:01:53 +0200
Message-Id: <1369951317-16789-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to list plugins names that can be passed with -p/-P
options. This is usefull with binary provided by distribution to easily
determine what plugins are supported.
---
 src/hcid.h   |    1 +
 src/main.c   |    8 ++++++++
 src/plugin.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/src/hcid.h b/src/hcid.h
index ea67cc2..ff4a3c5 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -43,6 +43,7 @@ extern struct main_opts main_opts;
 
 gboolean plugin_init(const char *enable, const char *disable);
 void plugin_cleanup(void);
+void plugin_list(void);
 
 void rfkill_init(void);
 void rfkill_exit(void);
diff --git a/src/main.c b/src/main.c
index dc0478e..aea3e3f 100644
--- a/src/main.c
+++ b/src/main.c
@@ -381,6 +381,7 @@ static guint setup_signalfd(void)
 static char *option_debug = NULL;
 static char *option_plugin = NULL;
 static char *option_noplugin = NULL;
+static gboolean option_listplugins = FALSE;
 static gboolean option_compat = FALSE;
 static gboolean option_detach = TRUE;
 static gboolean option_version = FALSE;
@@ -468,6 +469,8 @@ static GOptionEntry options[] = {
 				"Specify plugins to load", "NAME,..," },
 	{ "noplugin", 'P', 0, G_OPTION_ARG_STRING, &option_noplugin,
 				"Specify plugins not to load", "NAME,..." },
+	{ "list-plugins", 'l', 0, G_OPTION_ARG_NONE, &option_listplugins,
+				"List available plugins", },
 	{ "compat", 'C', 0, G_OPTION_ARG_NONE, &option_compat,
 				"Provide deprecated command line interfaces" },
 	{ "experimental", 'E', 0, G_OPTION_ARG_NONE, &option_experimental,
@@ -512,6 +515,11 @@ int main(int argc, char *argv[])
 		exit(0);
 	}
 
+	if (option_listplugins == TRUE) {
+		plugin_list();
+		exit(0);
+	}
+
 	umask(0077);
 
 	event_loop = g_main_loop_new(NULL, FALSE);
diff --git a/src/plugin.c b/src/plugin.c
index 51c98bc..b6e0ad7 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -230,3 +230,50 @@ void plugin_cleanup(void)
 
 	g_slist_free(plugins);
 }
+
+void plugin_list(void)
+{
+	int i;
+	GDir *dir;
+	const char *file;
+
+	printf("builtin plugins:\n");
+
+	for (i = 0; __bluetooth_builtin[i]; i++) {
+		printf("  %s\n", __bluetooth_builtin[i]->name);
+	}
+
+	dir = g_dir_open(PLUGINDIR, 0, NULL);
+	if (!dir)
+		return;
+
+	printf("\nplugins from '%s':\n", PLUGINDIR);
+
+	while ((file = g_dir_read_name(dir)) != NULL) {
+		struct bluetooth_plugin_desc *desc;
+		void *handle;
+		char *filename;
+
+		if (g_str_has_prefix(file, "lib") == TRUE ||
+				g_str_has_suffix(file, ".so") == FALSE)
+			continue;
+
+		filename = g_build_filename(PLUGINDIR, file, NULL);
+
+		handle = dlopen(filename, RTLD_NOW);
+		if (handle == NULL) {
+			g_free(filename);
+			continue;
+		}
+
+		g_free(filename);
+
+		desc = dlsym(handle, "bluetooth_plugin_desc");
+		if (desc && strcmp(desc->version, VERSION) == 0)
+			printf("  %s\n", desc->name);
+
+		dlclose(handle);
+	}
+
+	g_dir_close(dir);
+}
-- 
1.7.10.4

