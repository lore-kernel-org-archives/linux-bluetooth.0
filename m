Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC obexd 1/8] client: add plugin support
Date: Tue,  9 Aug 2011 14:03:42 +0300
Message-Id: <1312887829-4770-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Plugins can be enable/disable using -p/P options similarly to BlueZ,
ofono and connman.
---
 Makefile.am       |   32 +++++++--
 client/genbuiltin |   17 +++++
 client/main.c     |   11 +++
 client/plugin.c   |  203 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/plugin.h   |   45 ++++++++++++
 5 files changed, 302 insertions(+), 6 deletions(-)
 create mode 100755 client/genbuiltin
 create mode 100644 client/plugin.c
 create mode 100644 client/plugin.h

diff --git a/Makefile.am b/Makefile.am
index d412f02..d3e89b9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -120,9 +120,13 @@ endif
 if CLIENT
 service_in_files += client/obex-client.service.in
 
+client_builtin_modules =
+client_builtin_sources =
+client_builtin_nodist =
+
 libexec_PROGRAMS += client/obex-client
 
-client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
+client_obex_client_SOURCES = $(gdbus_sources) $(client_builtin_sources) \
 				$(gwobex_sources) $(btio_sources) \
 				client/main.c src/log.h src/log.c \
 				client/manager.h client/manager.c \
@@ -131,10 +135,24 @@ client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
 				client/sync.h client/sync.c \
 				client/ftp.h client/ftp.c \
 				client/transfer.h client/transfer.c \
-				client/agent.h client/agent.c
+				client/agent.h client/agent.c \
+				client/plugin.h client/plugin.c
+
+client_obex_client_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ @OPENOBEX_LIBS@ @BLUEZ_LIBS@ -ldl
+
+client_obex_client_LDFLAGS = -Wl,--export-dynamic
+
+client_builtin_files = client/builtin.h $(client_builtin_nodist)
+
+nodist_client_obex_client_SOURCES = $(client_builtin_files)
+
+clientplugindir = $(libdir)/obex/client/plugins
+
+client/plugin.$(OBJEXT): client/builtin.h
 
+client/builtin.h: client/genbuiltin $(client_builtin_sources)
+	$(AM_V_GEN)$(srcdir)/client/genbuiltin $(client_builtin_modules) > $@
 
-client_obex_client_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ @OPENOBEX_LIBS@ @BLUEZ_LIBS@
 endif
 
 service_DATA = $(service_in_files:.service.in=.service)
@@ -143,15 +161,17 @@ AM_CFLAGS = @OPENOBEX_CFLAGS@ @BLUEZ_CFLAGS@ @EBOOK_CFLAGS@ \
 			@GTHREAD_CFLAGS@ @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
 			@LIBICAL_CFLAGS@ -D_FILE_OFFSET_BITS=64 \
 			@TRACKER_CFLAGS@ \
-			-DOBEX_PLUGIN_BUILTIN -DPLUGINDIR=\""$(plugindir)"\"
+			-DOBEX_PLUGIN_BUILTIN -DPLUGINDIR=\""$(plugindir)"\" \
+			-DOBEX_CLIENT_PLUGIN_BUILTIN -DCLIENTPLUGINDIR=\""$(clientplugindir)"\"
 
 INCLUDES = -I$(builddir)/src -I$(srcdir)/src -I$(srcdir)/plugins \
 				-I$(srcdir)/gdbus -I$(srcdir)/gwobex \
 				-I$(srcdir)/btio -I$(srcdir)/gobex
 
-CLEANFILES = $(service_DATA) $(builtin_files)
+CLEANFILES = $(service_DATA) $(builtin_files) $(client_builtin_files)
 
-EXTRA_DIST = src/genbuiltin $(doc_files) $(test_files) \
+EXTRA_DIST = src/genbuiltin client/genbuiltin \
+			$(doc_files) $(test_files) \
 			src/obexd.service.in client/obex-client.service.in \
 			plugins/phonebook-dummy.c plugins/phonebook-ebook.c \
 			plugins/phonebook-tracker.c \
diff --git a/client/genbuiltin b/client/genbuiltin
new file mode 100755
index 0000000..f3a549f
--- /dev/null
+++ b/client/genbuiltin
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+for i in $*
+do
+	echo "extern struct obex_client_plugin_desc __obex_client_builtin_$i;"
+done
+
+echo
+echo "static struct obex_client_plugin_desc *__obex_client_builtin[] = {"
+
+for i in $*
+do
+	echo "  &__obex_client_builtin_$i,"
+done
+
+echo "  NULL"
+echo "};"
diff --git a/client/main.c b/client/main.c
index 618ad21..053a482 100644
--- a/client/main.c
+++ b/client/main.c
@@ -36,10 +36,13 @@
 
 #include "log.h"
 #include "manager.h"
+#include "plugin.h"
 
 static GMainLoop *event_loop = NULL;
 
 static char *option_debug = NULL;
+static char *option_plugin = NULL;
+static char *option_noplugin = NULL;
 static gboolean option_stderr = FALSE;
 
 static gboolean parse_debug(const char *key, const char *value,
@@ -59,6 +62,10 @@ static GOptionEntry options[] = {
 				"Enable debug information output", "DEBUG" },
 	{ "stderr", 's', 0, G_OPTION_ARG_NONE, &option_stderr,
 				"Write log information to stderr" },
+	{ "plugin", 'p', 0, G_OPTION_ARG_STRING, &option_plugin,
+				"Specify plugins to load", "NAME,..." },
+	{ "noplugin", 'P', 0, G_OPTION_ARG_STRING, &option_noplugin,
+				"Specify plugins not to load", "NAME,..." },
 	{ NULL },
 };
 
@@ -92,6 +99,8 @@ int main(int argc, char *argv[])
 
 	__obex_log_init("obex-client", option_debug, !option_stderr);
 
+	plugin_init(option_plugin, option_noplugin);
+
 	DBG("Entering main loop");
 
 	memset(&sa, 0, sizeof(sa));
@@ -103,6 +112,8 @@ int main(int argc, char *argv[])
 
 	manager_exit();
 
+	plugin_cleanup();
+
 	g_main_loop_unref(event_loop);
 
 	__obex_log_cleanup();
diff --git a/client/plugin.c b/client/plugin.c
new file mode 100644
index 0000000..e43e855
--- /dev/null
+++ b/client/plugin.c
@@ -0,0 +1,203 @@
+/*
+ *
+ *  OBEX Server
+ *
+ *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <dlfcn.h>
+#include <string.h>
+#include <sys/stat.h>
+
+#include <glib.h>
+
+#include "plugin.h"
+#include "log.h"
+
+/*
+ * Plugins that are using libraries with threads and their own mainloop
+ * will crash on exit. This is a bug inside these libraries, but there is
+ * nothing much that can be done about it. One bad example is libebook.
+ */
+#ifdef NEED_THREADS
+#define PLUGINFLAG (RTLD_NOW | RTLD_NODELETE)
+#else
+#define PLUGINFLAG (RTLD_NOW)
+#endif
+
+static GSList *plugins = NULL;
+
+struct obex_client_plugin {
+	void *handle;
+	struct obex_client_plugin_desc *desc;
+};
+
+static gboolean add_plugin(void *handle, struct obex_client_plugin_desc *desc)
+{
+	struct obex_client_plugin *plugin;
+
+	if (desc->init == NULL)
+		return FALSE;
+
+	plugin = g_try_new0(struct obex_client_plugin, 1);
+	if (plugin == NULL)
+		return FALSE;
+
+	plugin->handle = handle;
+	plugin->desc = desc;
+
+	if (desc->init() < 0) {
+		g_free(plugin);
+		return FALSE;
+	}
+
+	plugins = g_slist_append(plugins, plugin);
+	DBG("Plugin %s loaded", desc->name);
+
+	return TRUE;
+}
+
+static gboolean check_plugin(struct obex_client_plugin_desc *desc,
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
+#include "builtin.h"
+
+gboolean plugin_init(const char *pattern, const char *exclude)
+{
+	gchar **patterns = NULL;
+	gchar **excludes = NULL;
+	GDir *dir;
+	const char *file;
+	unsigned int i;
+
+	if (strlen(CLIENTPLUGINDIR) == 0)
+		return FALSE;
+
+	if (pattern)
+		patterns = g_strsplit_set(pattern, ":, ", -1);
+
+	if (exclude)
+		excludes = g_strsplit_set(exclude, ":, ", -1);
+
+	DBG("Loading builtin plugins");
+
+	for (i = 0; __obex_client_builtin[i]; i++) {
+		if (check_plugin(__obex_client_builtin[i],
+					patterns, excludes) == FALSE)
+			continue;
+
+		add_plugin(NULL,  __obex_client_builtin[i]);
+	}
+
+	DBG("Loading plugins %s", CLIENTPLUGINDIR);
+
+	dir = g_dir_open(CLIENTPLUGINDIR, 0, NULL);
+	if (!dir)
+		return FALSE;
+
+	while ((file = g_dir_read_name(dir)) != NULL) {
+		struct obex_client_plugin_desc *desc;
+		void *handle;
+		char *filename;
+
+		if (g_str_has_prefix(file, "lib") == TRUE ||
+				g_str_has_suffix(file, ".so") == FALSE)
+			continue;
+
+		filename = g_build_filename(CLIENTPLUGINDIR, file, NULL);
+
+		handle = dlopen(filename, PLUGINFLAG);
+		if (handle == NULL) {
+			error("Can't load plugin %s: %s", filename,
+								dlerror());
+			g_free(filename);
+			continue;
+		}
+
+		g_free(filename);
+
+		desc = dlsym(handle, "obex_client_plugin_desc");
+		if (desc == NULL) {
+			error("Can't load plugin description: %s", dlerror());
+			dlclose(handle);
+			continue;
+		}
+
+		if (check_plugin(desc, patterns, excludes) == FALSE) {
+			dlclose(handle);
+			continue;
+		}
+
+		if (add_plugin(handle, desc) == FALSE)
+			dlclose(handle);
+	}
+
+	g_dir_close(dir);
+
+	return TRUE;
+}
+
+void plugin_cleanup(void)
+{
+	GSList *list;
+
+	DBG("Cleanup plugins");
+
+	for (list = plugins; list; list = list->next) {
+		struct obex_client_plugin *plugin = list->data;
+
+		if (plugin->desc->exit)
+			plugin->desc->exit();
+
+		if (plugin->handle != NULL)
+			dlclose(plugin->handle);
+
+		g_free(plugin);
+	}
+
+	g_slist_free(plugins);
+}
diff --git a/client/plugin.h b/client/plugin.h
new file mode 100644
index 0000000..1e2b906
--- /dev/null
+++ b/client/plugin.h
@@ -0,0 +1,45 @@
+/*
+ *
+ *  OBEX Server
+ *
+ *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+struct obex_client_plugin_desc {
+	const char *name;
+	int (*init) (void);
+	void (*exit) (void);
+};
+
+#ifdef OBEX_CLIENT_PLUGIN_BUILTIN
+#define OBEX_CLIENT_PLUGIN_DEFINE(name, init, exit) \
+		struct obex_client_plugin_desc __obex_client_builtin_ ## name = { \
+			#name, init, exit \
+		};
+#else
+#define OBEX_CLIENT_PLUGIN_DEFINE(name,init,exit) \
+		extern struct obex_client_plugin_desc obex_client_plugin_desc \
+				__attribute__ ((visibility("default"))); \
+		struct obex_client_plugin_desc obex_plugin_desc = { \
+			#name, init, exit \
+		};
+#endif
+
+gboolean plugin_init(const char *pattern, const char *exclude);
+void plugin_cleanup(void);
-- 
1.7.6

