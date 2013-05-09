Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 16/26] iap: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:46 -0300
Message-Id: <1368073016-28434-16-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

guint -> unsigned int
guint8 -> uint8_t
guint16 -> uint16_t
guint32 -> uint32_t
guint64 -> uint64_t

Add "#include <inttypes.h>" where appropriate.
---
 profiles/iap/main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/profiles/iap/main.c b/profiles/iap/main.c
index 0e8f43f..08dcce3 100644
--- a/profiles/iap/main.c
+++ b/profiles/iap/main.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <errno.h>
 #include <ctype.h>
@@ -102,7 +103,7 @@
 
 static GMainLoop *main_loop;
 
-static guint iap_source = 0;
+static unsigned int iap_source = 0;
 
 static gboolean iap_handler(GIOChannel *channel, GIOCondition condition,
 							gpointer user_data)
@@ -127,10 +128,10 @@ static gboolean iap_handler(GIOChannel *channel, GIOCondition condition,
 	return TRUE;
 }
 
-static guint create_source(int fd, GIOFunc func)
+static unsigned int create_source(int fd, GIOFunc func)
 {
 	GIOChannel *channel;
-	guint source;
+	unsigned int source;
 
 	channel = g_io_channel_unix_new(fd);
 
@@ -370,10 +371,10 @@ static gboolean signal_handler(GIOChannel *channel, GIOCondition condition,
 	return TRUE;
 }
 
-static guint setup_signalfd(void)
+static unsigned int setup_signalfd(void)
 {
 	GIOChannel *channel;
-	guint source;
+	unsigned int source;
 	sigset_t mask;
 	int fd;
 
@@ -421,7 +422,7 @@ int main(int argc, char *argv[])
 	GError *error = NULL;
 	DBusConnection *dbus_conn;
 	GDBusClient *client;
-	guint signal;
+	unsigned int signal;
 
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
-- 
1.8.2.2

