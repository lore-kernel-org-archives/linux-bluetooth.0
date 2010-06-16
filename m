Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH 1/2] log: Add function to get/set debug_string
Date: Wed, 16 Jun 2010 04:31:17 -0300
Message-Id: <1276673478-9273-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/log.c |   53 +++++++++++++++++++++++++++++++++++++++++------------
 src/log.h |    2 ++
 2 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/src/log.c b/src/log.c
index ed6e428..f53ace3 100644
--- a/src/log.c
+++ b/src/log.c
@@ -71,6 +71,8 @@ extern struct btd_debug_desc __stop___debug[];
 
 static gchar **enabled = NULL;
 
+static char *debug_string = NULL;
+
 static gboolean is_enabled(struct btd_debug_desc *desc)
 {
         int i;
@@ -90,22 +92,15 @@ static gboolean is_enabled(struct btd_debug_desc *desc)
         return 0;
 }
 
-void __btd_toggle_debug()
-{
-	struct btd_debug_desc *desc;
-
-	for (desc = __start___debug; desc < __stop___debug; desc++)
-		desc->flags |= BTD_DEBUG_FLAG_PRINT;
-}
-
-void __btd_log_init(const char *debug, int detach)
+static void debug_on()
 {
-	int option = LOG_NDELAY | LOG_PID;
 	struct btd_debug_desc *desc;
 	const char *name = NULL, *file = NULL;
 
-	if (debug != NULL)
-		enabled = g_strsplit_set(debug, ":, ", 0);
+	if (debug_string == NULL)
+		debug_string = g_strdup("");
+
+	enabled = g_strsplit_set(debug_string, ":, ", 0);
 
 	for (desc = __start___debug; desc < __stop___debug; desc++) {
 		if (file != NULL || name != NULL) {
@@ -118,7 +113,41 @@ void __btd_log_init(const char *debug, int detach)
 
 		if (is_enabled(desc))
 			desc->flags |= BTD_DEBUG_FLAG_PRINT;
+		else
+			desc->flags &= ~BTD_DEBUG_FLAG_PRINT;
 	}
+}
+
+char *__btd_get_debug()
+{
+	return debug_string;
+}
+
+char *__btd_set_debug(char *str)
+{
+	g_free(debug_string);
+	debug_string = g_strdup(str);
+
+	debug_on();
+
+	return debug_string;
+}
+
+void __btd_toggle_debug()
+{
+	struct btd_debug_desc *desc;
+
+	for (desc = __start___debug; desc < __stop___debug; desc++)
+		desc->flags |= BTD_DEBUG_FLAG_PRINT;
+}
+
+void __btd_log_init(const char *debug, int detach)
+{
+	int option = LOG_NDELAY | LOG_PID;
+
+	debug_string = (char *)debug;
+
+	debug_on();
 
 	if (!detach)
 		option |= LOG_PERROR;
diff --git a/src/log.h b/src/log.h
index 4e0e518..2dfce8d 100644
--- a/src/log.h
+++ b/src/log.h
@@ -28,6 +28,8 @@ void btd_debug(const char *format, ...) __attribute__((format(printf, 1, 2)));
 
 void __btd_log_init(const char *debug, int detach);
 void __btd_log_cleanup(void);
+char *__btd_get_debug();
+char *__btd_set_debug(char *str);
 void __btd_toggle_debug();
 
 struct btd_debug_desc {
-- 
1.7.1

