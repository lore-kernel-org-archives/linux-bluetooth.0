Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 4/6] gobex: Add Bluetooth support for test-client
Date: Fri, 26 Aug 2011 12:49:34 +0300
Message-Id: <1314352176-12244-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1314352176-12244-1-git-send-email-luiz.dentz@gmail.com>
References: <1314352176-12244-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/test-client.c |  216 ++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 155 insertions(+), 61 deletions(-)

diff --git a/tools/test-client.c b/tools/test-client.c
index ec6d1c2..d967f02 100644
--- a/tools/test-client.c
+++ b/tools/test-client.c
@@ -33,12 +33,16 @@
 #include <readline/history.h>
 
 #include <gobex/gobex.h>
+#include <btio/btio.h>
 
 static GMainLoop *main_loop = NULL;
 static GObex *obex = NULL;
 
 static gboolean option_packet = FALSE;
 static gboolean option_bluetooth = FALSE;
+static char *option_source = NULL;
+static char *option_dest = NULL;
+static int option_channel = -1;
 
 static void sig_term(int sig)
 {
@@ -51,6 +55,14 @@ static GOptionEntry options[] = {
 			&option_bluetooth, "Use a UNIX socket" },
 	{ "bluetooth", 'b', 0, G_OPTION_ARG_NONE,
 			&option_bluetooth, "Use Bluetooth" },
+	{ "source", 's', 0, G_OPTION_ARG_STRING,
+			&option_source, "Bluetooth adapter address",
+			"00:..." },
+	{ "destination", 'd', 0, G_OPTION_ARG_STRING,
+			&option_dest, "Remote bluetooth address",
+			"00:..." },
+	{ "channel", 'c', 0, G_OPTION_ARG_INT,
+			&option_channel, "Transport channel", "CHANNEL" },
 	{ "packet", 'p', 0, G_OPTION_ARG_NONE,
 			&option_packet, "Packet based transport" },
 	{ "stream", 's', G_OPTION_FLAG_REVERSE, G_OPTION_ARG_NONE,
@@ -58,48 +70,6 @@ static GOptionEntry options[] = {
 	{ NULL },
 };
 
-static void disconn_func(GObex *obex, GError *err, gpointer user_data)
-{
-	g_printerr("Disconnected: %s\n", err ? err->message : "(no error)");
-	g_main_loop_quit(main_loop);
-}
-
-static GIOChannel *unix_connect(void)
-{
-	GIOChannel *io;
-	struct sockaddr_un addr = {
-		AF_UNIX, "\0/gobex/server"
-	};
-	int sk, err, sock_type;
-
-	if (option_packet)
-		sock_type = SOCK_SEQPACKET;
-	else
-		sock_type = SOCK_STREAM;
-
-	sk = socket(PF_LOCAL, sock_type, 0);
-	if (sk < 0) {
-		err = errno;
-		g_printerr("Can't create unix socket: %s (%d)\n",
-						strerror(err), err);
-		return NULL;
-	}
-
-	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		err = errno;
-		g_printerr("connect: %s (%d)\n", strerror(err), err);
-		return NULL;
-	}
-
-	io = g_io_channel_unix_new(sk);
-	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);
-	g_io_channel_set_close_on_unref(io, TRUE);
-
-	g_print("Unix socket created: %d\n", sk);
-
-	return io;
-}
-
 static void conn_complete(GObex *obex, GError *err, GObexPacket *rsp,
 							gpointer user_data)
 {
@@ -293,13 +263,145 @@ static gboolean prompt_read(GIOChannel *chan, GIOCondition cond,
 	return TRUE;
 }
 
+static void disconn_func(GObex *obex, GError *err, gpointer user_data)
+{
+	g_printerr("Disconnected: %s\n", err ? err->message : "(no error)");
+	g_main_loop_quit(main_loop);
+}
+
+static void transport_connect(GIOChannel *io, GObexTransportType transport,
+				gssize rx_mtu, gssize tx_mtu)
+{
+	GIOChannel *input;
+	GIOCondition events;
+
+	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);
+	g_io_channel_set_close_on_unref(io, TRUE);
+
+	obex = g_obex_new(io, transport, rx_mtu, tx_mtu);
+	g_obex_set_disconnect_function(obex, disconn_func, NULL);
+
+	input = g_io_channel_unix_new(STDIN_FILENO);
+	g_io_channel_set_close_on_unref(input, TRUE);
+	events = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+	g_io_add_watch(input, events, prompt_read, NULL);
+	g_io_channel_unref(input);
+	rl_callback_handler_install("client> ", parse_line);
+}
+
+static GIOChannel *unix_connect(GObexTransportType transport)
+{
+	GIOChannel *io;
+	struct sockaddr_un addr = {
+		AF_UNIX, "\0/gobex/server"
+	};
+	int sk, err, sock_type;
+
+	if (option_packet)
+		sock_type = SOCK_SEQPACKET;
+	else
+		sock_type = SOCK_STREAM;
+
+	sk = socket(PF_LOCAL, sock_type, 0);
+	if (sk < 0) {
+		err = errno;
+		g_printerr("Can't create unix socket: %s (%d)\n",
+						strerror(err), err);
+		return NULL;
+	}
+
+	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		err = errno;
+		g_printerr("connect: %s (%d)\n", strerror(err), err);
+		return NULL;
+	}
+
+	io = g_io_channel_unix_new(sk);
+
+	g_print("Unix socket created: %d\n", sk);
+
+	transport_connect(io, transport, -1, -1);
+
+	return io;
+}
+
+static void conn_callback(GIOChannel *io, GError *err, gpointer user_data)
+{
+	GObexTransportType transport = GPOINTER_TO_UINT(user_data);
+	guint16 imtu = 4096, omtu = 32767;
+
+	if (err != NULL) {
+		g_printerr("%s\n", err->message);
+		return;
+	}
+
+	if (transport == G_OBEX_TRANSPORT_PACKET) {
+		GError *err = NULL;
+
+		if (!bt_io_get(io, BT_IO_L2CAP, &err,
+					BT_IO_OPT_OMTU, &omtu,
+					BT_IO_OPT_IMTU, &imtu,
+					BT_IO_OPT_INVALID)) {
+			g_printerr("%s\n", err->message);
+			g_clear_error(&err);
+			exit(EXIT_FAILURE);
+		} else
+			g_print("imtu=%u, omtu=%u\n", imtu, omtu);
+	}
+
+	g_print("Bluetooth socket connected\n");
+
+	transport_connect(io, transport, imtu, omtu);
+}
+
+static GIOChannel *bluetooth_connect(GObexTransportType transport)
+{
+	GIOChannel *io;
+	GError *err = NULL;
+	BtIOType type;
+	BtIOOption option;
+
+	if (option_dest == NULL || option_channel < 0)
+		return NULL;
+
+	if (transport == G_OBEX_TRANSPORT_PACKET || option_channel > 31) {
+		type = BT_IO_L2CAP;
+		option = BT_IO_OPT_PSM;
+	} else {
+		type = BT_IO_RFCOMM;
+		option = BT_IO_OPT_CHANNEL;
+	}
+
+	if (option_source)
+		io = bt_io_connect(type, conn_callback, GUINT_TO_POINTER(transport),
+				NULL, &err,
+				BT_IO_OPT_SOURCE, option_source,
+				BT_IO_OPT_DEST, option_dest,
+				option, option_channel,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_INVALID);
+	else
+		io = bt_io_connect(type, conn_callback, GUINT_TO_POINTER(transport),
+				NULL, &err,
+				BT_IO_OPT_DEST, option_dest,
+				option, option_channel,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_INVALID);
+
+	if (io != NULL)
+		return io;
+
+	g_printerr("%s\n", err->message);
+	g_error_free(err);
+	return NULL;
+}
+
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
 	GError *err = NULL;
 	struct sigaction sa;
 	GIOChannel *io;
-	GIOCondition events;
 	GObexTransportType transport;
 
 	context = g_option_context_new(NULL);
@@ -312,7 +414,16 @@ int main(int argc, char *argv[])
 		exit(EXIT_FAILURE);
 	}
 
-	io = unix_connect();
+	if (option_packet)
+		transport = G_OBEX_TRANSPORT_PACKET;
+	else
+		transport = G_OBEX_TRANSPORT_STREAM;
+
+	if (option_bluetooth)
+		io = bluetooth_connect(transport);
+	else
+		io = unix_connect(transport);
+
 	if (io == NULL)
 		exit(EXIT_FAILURE);
 
@@ -323,23 +434,6 @@ int main(int argc, char *argv[])
 
 	main_loop = g_main_loop_new(NULL, FALSE);
 
-	if (option_packet)
-		transport = G_OBEX_TRANSPORT_PACKET;
-	else
-		transport = G_OBEX_TRANSPORT_STREAM;
-
-	obex = g_obex_new(io, transport, -1, -1);
-	g_io_channel_unref(io);
-
-	g_obex_set_disconnect_function(obex, disconn_func, NULL);
-
-	io = g_io_channel_unix_new(STDIN_FILENO);
-	g_io_channel_set_close_on_unref(io, TRUE);
-	events = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
-	g_io_add_watch(io, events, prompt_read, NULL);
-	g_io_channel_unref(io);
-	rl_callback_handler_install("client> ", parse_line);
-
 	g_main_loop_run(main_loop);
 
 	rl_callback_handler_remove();
-- 
1.7.6

