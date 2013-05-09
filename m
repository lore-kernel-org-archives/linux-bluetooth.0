Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 24/26] tools: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:54 -0300
Message-Id: <1368073016-28434-24-git-send-email-lucas.demarchi@profusion.mobi>
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
 tools/btiotest.c         |  6 +++---
 tools/mpris-player.c     |  2 +-
 tools/obex-server-tool.c | 15 ++++++++-------
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/btiotest.c b/tools/btiotest.c
index 5359ace..3c6a86e 100644
--- a/tools/btiotest.c
+++ b/tools/btiotest.c
@@ -26,9 +26,9 @@
 #include "config.h"
 #endif
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <stdint.h>
 #include <errno.h>
 #include <string.h>
 #include <signal.h>
@@ -41,7 +41,7 @@
 static int opt_update_sec = 0;
 
 struct io_data {
-	guint ref;
+	unsigned int ref;
 	GIOChannel *io;
 	int reject;
 	int disconn;
@@ -519,7 +519,7 @@ static int opt_sec = 0;
 static gboolean opt_master = FALSE;
 static int opt_priority = 0;
 static int opt_cid = 0;
-static guint8 opt_addr_type = 0;
+static uint8_t opt_addr_type = 0;
 
 static GMainLoop *main_loop;
 
diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index a7a506c..3ad72e8 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -1844,7 +1844,7 @@ int main(int argc, char *argv[])
 {
 	GOptionContext *context;
 	GError *error = NULL;
-	guint owner_watch, properties_watch;
+	unsigned int owner_watch, properties_watch;
 	struct sigaction sa;
 
 	context = g_option_context_new(NULL);
diff --git a/tools/obex-server-tool.c b/tools/obex-server-tool.c
index e37c56f..08a21a1 100644
--- a/tools/obex-server-tool.c
+++ b/tools/obex-server-tool.c
@@ -27,6 +27,7 @@
 #include <sys/socket.h>
 #include <fcntl.h>
 #include <sys/un.h>
+#include <inttypes.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -121,7 +122,7 @@ static void handle_put(GObex *obex, GObexPacket *req, gpointer user_data)
 
 	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_TYPE);
 	if (hdr != NULL) {
-		g_obex_header_get_bytes(hdr, (const guint8 **) &type,
+		g_obex_header_get_bytes(hdr, (const uint8_t **) &type,
 								&type_len);
 		if (type[type_len - 1] != '\0') {
 			g_printerr("non-nul terminated type header\n");
@@ -180,7 +181,7 @@ static void handle_get(GObex *obex, GObexPacket *req, gpointer user_data)
 
 	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_TYPE);
 	if (hdr != NULL) {
-		g_obex_header_get_bytes(hdr, (const guint8 **) &type,
+		g_obex_header_get_bytes(hdr, (const uint8_t **) &type,
 								&type_len);
 		if (type[type_len - 1] != '\0') {
 			g_printerr("non-nul terminated type header\n");
@@ -327,10 +328,10 @@ static GIOChannel *rfcomm_listen(GError **err)
 					BT_IO_OPT_INVALID);
 }
 
-static guint bluetooth_listen(void)
+static unsigned int bluetooth_listen(void)
 {
 	GIOChannel *io;
-	guint id;
+	unsigned int id;
 	GError *err = NULL;
 
 	if (option_channel == -1) {
@@ -361,14 +362,14 @@ static guint bluetooth_listen(void)
 	return id;
 }
 
-static guint unix_listen(void)
+static unsigned int unix_listen(void)
 {
 	GIOChannel *io;
 	struct sockaddr_un addr = {
 		AF_UNIX, "\0/gobex/server"
 	};
 	int sk, err, sock_type;
-	guint id;
+	unsigned int id;
 
 	if (option_packet)
 		sock_type = SOCK_SEQPACKET;
@@ -415,7 +416,7 @@ int main(int argc, char *argv[])
 	GOptionContext *context;
 	GError *err = NULL;
 	struct sigaction sa;
-	guint server_id;
+	unsigned int server_id;
 
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
-- 
1.8.2.2

