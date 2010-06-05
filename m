Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH 3/5] log: Add function to get/set debug_string
Date: Sat,  5 Jun 2010 04:25:34 -0300
Message-Id: <1275722736-28895-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275722736-28895-2-git-send-email-gustavo@padovan.org>
References: <1275722736-28895-1-git-send-email-gustavo@padovan.org>
 <1275722736-28895-2-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/log.c |   56 +++++++++++++++++++++++++++++++++++++++++---------------
 src/log.h |    2 ++
 2 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/src/log.c b/src/log.c
index 4043ee3..f0f2465 100644
--- a/src/log.c
+++ b/src/log.c
@@ -72,6 +72,7 @@ extern struct btd_debug_desc __stop___debug[];
 static gchar **enabled = NULL;
 
 int debug_enabled = FALSE;
+static char *debug_string = NULL;
 
 static gboolean is_enabled(struct btd_debug_desc *desc)
 {
@@ -92,6 +93,44 @@ static gboolean is_enabled(struct btd_debug_desc *desc)
         return 0;
 }
 
+static void debug_on()
+{
+	struct btd_debug_desc *desc;
+	const char *name = NULL, *file = NULL;
+
+	enabled = g_strsplit_set(debug_string, ":, ", 0);
+
+	for (desc = __start___debug; desc < __stop___debug; desc++) {
+		if (file != NULL || name != NULL) {
+			if (g_strcmp0(desc->file, file) == 0) {
+				if (desc->name == NULL)
+					desc->name = name;
+			} else
+				file = NULL;
+		}
+
+		if (is_enabled(desc))
+			desc->flags |= BTD_DEBUG_FLAG_PRINT;
+		else
+			desc->flags &= ~BTD_DEBUG_FLAG_PRINT;
+	}
+}
+
+char *__btd_get_debug_string()
+{
+	return debug_string;
+}
+
+char *__btd_set_debug_string(char *str)
+{
+	g_free(debug_string);
+	debug_string = g_strdup(str);
+
+	debug_on();
+
+	return debug_string;
+}
+
 void __btd_toggle_debug()
 {
 	debug_enabled = !debug_enabled;
@@ -105,8 +144,6 @@ int __btd_debug_enabled()
 void __btd_log_init(const char *debug, int detach)
 {
 	int option = LOG_NDELAY | LOG_PID;
-	struct btd_debug_desc *desc;
-	const char *name = NULL, *file = NULL;
 
 	if (debug != NULL) {
 		debug_enabled = TRUE;
@@ -115,20 +152,9 @@ void __btd_log_init(const char *debug, int detach)
 		debug_enabled = FALSE;
 	}
 
-	enabled = g_strsplit_set(debug, ":, ", 0);
-
-	for (desc = __start___debug; desc < __stop___debug; desc++) {
-		if (file != NULL || name != NULL) {
-			if (g_strcmp0(desc->file, file) == 0) {
-				if (desc->name == NULL)
-					desc->name = name;
-			} else
-				file = NULL;
-		}
+	debug_string = (char *)debug;
 
-		if (is_enabled(desc))
-			desc->flags |= BTD_DEBUG_FLAG_PRINT;
-	}
+	debug_on();
 
 	if (!detach)
 		option |= LOG_PERROR;
diff --git a/src/log.h b/src/log.h
index 681e71d..392c716 100644
--- a/src/log.h
+++ b/src/log.h
@@ -29,6 +29,8 @@ void debug(const char *format, ...) __attribute__((format(printf, 1, 2)));
 
 void __btd_log_init(const char *debug, int detach);
 void __btd_log_cleanup(void);
+char *__btd_get_debug_string();
+char *__btd_set_debug_string(char *str);
 void __btd_toggle_debug();
 int __btd_debug_enabled();
 
-- 
1.7.1

