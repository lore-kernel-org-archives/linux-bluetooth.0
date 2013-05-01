Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 4/6] obexd: Get rid of gchar
Date: Wed,  1 May 2013 01:51:59 -0300
Message-Id: <1367383921-19129-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367383921-19129-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367383921-19129-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain char instead of gchar.
---
 obexd/client/mns.c | 6 +++---
 obexd/src/log.c    | 2 +-
 obexd/src/plugin.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/obexd/client/mns.c b/obexd/client/mns.c
index 752452c..9a86462 100644
--- a/obexd/client/mns.c
+++ b/obexd/client/mns.c
@@ -214,12 +214,12 @@ static struct map_event_report_parser {
 };
 
 static void event_report_element(GMarkupParseContext *ctxt,
-				const gchar *element, const gchar **names,
-				const gchar **values, gpointer user_data,
+				const char *element, const char **names,
+				const char **values, gpointer user_data,
 								GError **gerr)
 {
 	struct map_event *event = user_data;
-	const gchar *key;
+	const char *key;
 	gint i;
 
 	if (strcasecmp("event", element) != 0)
diff --git a/obexd/src/log.c b/obexd/src/log.c
index a96b07b..ace7ab6 100644
--- a/obexd/src/log.c
+++ b/obexd/src/log.c
@@ -69,7 +69,7 @@ void obex_debug(const char *format, ...)
 extern struct obex_debug_desc __start___debug[];
 extern struct obex_debug_desc __stop___debug[];
 
-static gchar **enabled = NULL;
+static char **enabled = NULL;
 
 static gboolean is_enabled(struct obex_debug_desc *desc)
 {
diff --git a/obexd/src/plugin.c b/obexd/src/plugin.c
index c8ec642..7d971b6 100644
--- a/obexd/src/plugin.c
+++ b/obexd/src/plugin.c
@@ -110,8 +110,8 @@ static gboolean check_plugin(struct obex_plugin_desc *desc,
 
 gboolean plugin_init(const char *pattern, const char *exclude)
 {
-	gchar **patterns = NULL;
-	gchar **excludes = NULL;
+	char **patterns = NULL;
+	char **excludes = NULL;
 	GDir *dir;
 	const char *file;
 	unsigned int i;
-- 
1.8.2.2

