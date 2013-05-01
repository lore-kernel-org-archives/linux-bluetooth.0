Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 5/6] core: Get rid of gchar
Date: Wed,  1 May 2013 01:52:00 -0300
Message-Id: <1367383921-19129-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367383921-19129-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367383921-19129-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain char instead of gchar.
---
 src/log.c    | 2 +-
 src/main.c   | 6 +++---
 src/plugin.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/log.c b/src/log.c
index 75a98a9..ca783f3 100644
--- a/src/log.c
+++ b/src/log.c
@@ -80,7 +80,7 @@ void btd_debug(const char *format, ...)
 extern struct btd_debug_desc __start___debug[];
 extern struct btd_debug_desc __stop___debug[];
 
-static gchar **enabled = NULL;
+static char **enabled = NULL;
 
 static gboolean is_enabled(struct btd_debug_desc *desc)
 {
diff --git a/src/main.c b/src/main.c
index 1e40ebc..dc0478e 100644
--- a/src/main.c
+++ b/src/main.c
@@ -378,9 +378,9 @@ static guint setup_signalfd(void)
 	return source;
 }
 
-static gchar *option_debug = NULL;
-static gchar *option_plugin = NULL;
-static gchar *option_noplugin = NULL;
+static char *option_debug = NULL;
+static char *option_plugin = NULL;
+static char *option_noplugin = NULL;
 static gboolean option_compat = FALSE;
 static gboolean option_detach = TRUE;
 static gboolean option_version = FALSE;
diff --git a/src/plugin.c b/src/plugin.c
index f231f34..a23e533 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -116,7 +116,7 @@ gboolean plugin_init(const char *enable, const char *disable)
 {
 	GSList *list;
 	GDir *dir;
-	const gchar *file;
+	const char *file;
 	char **cli_disabled, **cli_enabled;
 	unsigned int i;
 
@@ -156,7 +156,7 @@ gboolean plugin_init(const char *enable, const char *disable)
 	while ((file = g_dir_read_name(dir)) != NULL) {
 		struct bluetooth_plugin_desc *desc;
 		void *handle;
-		gchar *filename;
+		char *filename;
 
 		if (g_str_has_prefix(file, "lib") == TRUE ||
 				g_str_has_suffix(file, ".so") == FALSE)
-- 
1.8.2.2

