Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 04/26] client: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:34 -0300
Message-Id: <1368073016-28434-4-git-send-email-lucas.demarchi@profusion.mobi>
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
 client/main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/client/main.c b/client/main.c
index b0a66d8..79660a7 100644
--- a/client/main.c
+++ b/client/main.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
@@ -1204,10 +1205,10 @@ static gboolean input_handler(GIOChannel *channel, GIOCondition condition,
 	return TRUE;
 }
 
-static guint setup_standard_input(void)
+static unsigned int setup_standard_input(void)
 {
 	GIOChannel *channel;
-	guint source;
+	unsigned int source;
 
 	channel = g_io_channel_unix_new(fileno(stdin));
 
@@ -1260,10 +1261,10 @@ static gboolean signal_handler(GIOChannel *channel, GIOCondition condition,
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
 
@@ -1324,7 +1325,7 @@ int main(int argc, char *argv[])
 	GOptionContext *context;
 	GError *error = NULL;
 	GDBusClient *client;
-	guint signal, input;
+	unsigned int signal, input;
 
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
-- 
1.8.2.2

