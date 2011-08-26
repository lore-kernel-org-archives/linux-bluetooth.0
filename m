Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 5/6] gobex: Add Bluetooth support for test-server
Date: Fri, 26 Aug 2011 12:49:35 +0300
Message-Id: <1314352176-12244-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1314352176-12244-1-git-send-email-luiz.dentz@gmail.com>
References: <1314352176-12244-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/test-server.c |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 85 insertions(+), 1 deletions(-)

diff --git a/tools/test-server.c b/tools/test-server.c
index a25dfb9..d7ffe50 100644
--- a/tools/test-server.c
+++ b/tools/test-server.c
@@ -29,10 +29,12 @@
 #include <sys/un.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <stdio.h>
 #include <string.h>
 #include <errno.h>
 
 #include <gobex/gobex.h>
+#include <btio/btio.h>
 
 #include "glib-helper.h"
 
@@ -42,6 +44,7 @@ static GSList *clients = NULL;
 
 static gboolean option_packet = FALSE;
 static gboolean option_bluetooth = FALSE;
+static int option_channel = -1;
 
 static void sig_term(int sig)
 {
@@ -54,6 +57,8 @@ static GOptionEntry options[] = {
 			&option_bluetooth, "Use a UNIX socket" },
 	{ "bluetooth", 'b', 0, G_OPTION_ARG_NONE,
 			&option_bluetooth, "Use Bluetooth" },
+	{ "channel", 'c', 0, G_OPTION_ARG_INT,
+			&option_channel, "Transport channel", "CHANNEL" },
 	{ "packet", 'p', 0, G_OPTION_ARG_NONE,
 			&option_packet, "Packet based transport" },
 	{ "stream", 's', G_OPTION_FLAG_REVERSE, G_OPTION_ARG_NONE,
@@ -265,6 +270,81 @@ static gboolean unix_accept(GIOChannel *chan, GIOCondition cond, gpointer data)
 	return TRUE;
 }
 
+static void bluetooth_accept(GIOChannel *io, GError *err, gpointer data)
+{
+	GObex *obex;
+	GObexTransportType transport;
+
+	g_print("Accepted new client connection on bluetooth socket\n");
+
+	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);
+	g_io_channel_set_close_on_unref(io, TRUE);
+
+	if (option_packet)
+		transport = G_OBEX_TRANSPORT_PACKET;
+	else
+		transport = G_OBEX_TRANSPORT_STREAM;
+
+	obex = g_obex_new(io, transport, -1, -1);
+	g_obex_set_disconnect_function(obex, disconn_func, NULL);
+	g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put, NULL);
+	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get, NULL);
+	g_obex_add_request_function(obex, G_OBEX_OP_CONNECT, handle_connect,
+									NULL);
+	clients = g_slist_append(clients, obex);
+}
+
+static gboolean bluetooth_watch(GIOChannel *chan, GIOCondition cond, gpointer data)
+{
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	g_io_channel_shutdown(chan, TRUE, NULL);
+	return FALSE;
+}
+
+static guint bluetooth_listen(void)
+{
+	GIOChannel *io;
+	guint id;
+	GError *err = NULL;
+	BtIOType type;
+	BtIOOption option;
+
+	if (option_channel == -1) {
+		g_printerr("Bluetooth channel not set\n");
+		return 0;
+	}
+
+	if (option_packet || option_channel > 31) {
+		type = BT_IO_L2CAP;
+		option = BT_IO_OPT_PSM;
+	} else {
+		type = BT_IO_RFCOMM;
+		option = BT_IO_OPT_CHANNEL;
+	}
+
+	io = bt_io_listen(type, bluetooth_accept, NULL, NULL, NULL, &err,
+				option, option_channel,
+				BT_IO_OPT_INVALID);
+	if (io == NULL) {
+		g_printerr("%s\n", err->message);
+		g_error_free(err);
+		return 0;
+	}
+
+	g_print("Bluetooth socket created\n");
+
+	id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+							bluetooth_watch, NULL);
+
+	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);
+	g_io_channel_set_close_on_unref(io, TRUE);
+	g_io_channel_unref(io);
+
+	return id;
+}
+
 static guint unix_listen(void)
 {
 	GIOChannel *io;
@@ -331,7 +411,11 @@ int main(int argc, char *argv[])
 		exit(EXIT_FAILURE);
 	}
 
-	server_id = unix_listen();
+	if (option_bluetooth)
+		server_id = bluetooth_listen();
+	else
+		server_id = unix_listen();
+
 	if (server_id == 0)
 		exit(EXIT_FAILURE);
 
-- 
1.7.6

