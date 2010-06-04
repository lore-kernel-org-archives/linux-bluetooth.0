Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH 2/4] Add debug_string and debug_enabled vars
Date: Fri,  4 Jun 2010 07:16:51 -0300
Message-Id: <1275646613-32639-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275646613-32639-1-git-send-email-gustavo@padovan.org>
References: <1275646613-32639-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Both will be very useful when we add Debug property to DBus.
---
 src/log.c |   10 ++++++++++
 src/log.h |    5 ++++-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/src/log.c b/src/log.c
index 4ef178a..9248c4d 100644
--- a/src/log.c
+++ b/src/log.c
@@ -75,6 +75,9 @@ extern struct btd_debug_desc __start___debug[];
 extern struct btd_debug_desc __stop___debug[];
 
 static gchar **enabled = NULL;
+static const char *debug_string = NULL;
+
+int debug_enabled = FALSE;
 
 static gboolean is_enabled(struct btd_debug_desc *desc)
 {
@@ -100,9 +103,12 @@ static void turn_debug_on(const char *debug)
 	struct btd_debug_desc *desc;
 	const char *name = NULL, *file = NULL;
 
+
 	if (debug != NULL)
 		enabled = g_strsplit_set(debug, ":, ", 0);
 
+	debug_enabled = TRUE;
+
 	for (desc = __start___debug; desc < __stop___debug; desc++) {
 		if (file != NULL || name != NULL) {
 			if (g_strcmp0(desc->file, file) == 0) {
@@ -121,6 +127,8 @@ static void turn_debug_off()
 {
 	struct btd_debug_desc *desc;
 
+	debug_enabled = FALSE;
+
 	for (desc = __start___debug; desc < __stop___debug; desc++) {
 		if (is_enabled(desc))
 			desc->flags &= ~BTD_DEBUG_FLAG_PRINT;
@@ -142,6 +150,8 @@ void __btd_log_init(const char *debug, int detach)
 {
 	int option = LOG_NDELAY | LOG_PID;
 
+	debug_string = debug;
+
 	turn_debug_on(debug);
 
 	if (!detach)
diff --git a/src/log.h b/src/log.h
index 8c1b937..235430e 100644
--- a/src/log.h
+++ b/src/log.h
@@ -24,6 +24,8 @@
 #ifndef __LOGGING_H
 #define __LOGGING_H
 
+extern int debug_enabled;
+
 void info(const char *format, ...) __attribute__((format(printf, 1, 2)));
 void error(const char *format, ...) __attribute__((format(printf, 1, 2)));
 void debug(const char *format, ...) __attribute__((format(printf, 1, 2)));
@@ -53,7 +55,8 @@ struct btd_debug_desc {
         __attribute__((used, section("__debug"), aligned(8))) = { \
                 .file = __FILE__, .flags = BTD_DEBUG_FLAG_DEFAULT, \
         }; \
-        if (__btd_debug_desc.flags & BTD_DEBUG_FLAG_PRINT) \
+        if (__btd_debug_desc.flags & BTD_DEBUG_FLAG_PRINT \
+			&& debug_enabled) \
                 debug("%s:%s() " fmt, \
                                         __FILE__, __FUNCTION__ , ## arg); \
 } while (0)
-- 
1.7.1

