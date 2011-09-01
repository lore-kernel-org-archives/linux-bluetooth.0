Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/4] gobex: add option to set input/output MTU to test-server
Date: Thu,  1 Sep 2011 12:21:26 +0300
Message-Id: <1314868888-31435-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1314868888-31435-1-git-send-email-luiz.dentz@gmail.com>
References: <1314868888-31435-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/test-server.c |   74 +++++++++++++++++++++++++++------------------------
 1 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/tools/test-server.c b/tools/test-server.c
index 728e2ad..4b39ba8 100644
--- a/tools/test-server.c
+++ b/tools/test-server.c
@@ -45,6 +45,8 @@ static GSList *clients = NULL;
 static gboolean option_packet = FALSE;
 static gboolean option_bluetooth = FALSE;
 static int option_channel = -1;
+static int option_imtu = -1;
+static int option_omtu = -1;
 static char *option_root = NULL;
 
 static void sig_term(int sig)
@@ -66,6 +68,10 @@ static GOptionEntry options[] = {
 			&option_packet, "Stream based transport" },
 	{ "root", 'r', 0, G_OPTION_ARG_STRING,
 			&option_root, "Root dir", "/..." },
+	{ "input-mtu", 'i', 0, G_OPTION_ARG_INT,
+			&option_imtu, "Transport input MTU", "MTU" },
+	{ "output-mtu", 'o', 0, G_OPTION_ARG_INT,
+			&option_omtu, "Transport output MTU", "MTU" },
 	{ NULL },
 };
 
@@ -158,8 +164,12 @@ static void handle_put(GObex *obex, GObexPacket *req, gpointer user_data)
 static gssize send_data(void *buf, gsize len, gpointer user_data)
 {
 	struct transfer_data *data = user_data;
+	gssize ret;
 
-	return read(data->fd, buf, len);
+	ret = read(data->fd, buf, len);
+	g_print("sending %zu bytes of data\n", ret);
+
+	return ret;
 }
 
 static void handle_get(GObex *obex, GObexPacket *req, gpointer user_data)
@@ -220,14 +230,34 @@ static void handle_connect(GObex *obex, GObexPacket *req, gpointer user_data)
 	g_obex_send(obex, rsp, NULL);
 }
 
+static void transport_accept(GIOChannel *io)
+{
+	GObex *obex;
+	GObexTransportType transport;
+
+	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);
+	g_io_channel_set_close_on_unref(io, TRUE);
+
+	if (option_packet)
+		transport = G_OBEX_TRANSPORT_PACKET;
+	else
+		transport = G_OBEX_TRANSPORT_STREAM;
+
+	obex = g_obex_new(io, transport, option_imtu, option_omtu);
+	g_obex_set_disconnect_function(obex, disconn_func, NULL);
+	g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put, NULL);
+	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get, NULL);
+	g_obex_add_request_function(obex, G_OBEX_OP_CONNECT, handle_connect,
+									NULL);
+	clients = g_slist_append(clients, obex);
+}
+
 static gboolean unix_accept(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	struct sockaddr_un addr;
 	socklen_t addrlen;
 	int sk, cli_sk;
 	GIOChannel *io;
-	GObex *obex;
-	GObexTransportType transport;
 
 	if (cond & G_IO_NVAL)
 		return FALSE;
@@ -253,48 +283,22 @@ static gboolean unix_accept(GIOChannel *chan, GIOCondition cond, gpointer data)
 
 	io = g_io_channel_unix_new(cli_sk);
 
-	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);
-	g_io_channel_set_close_on_unref(io, TRUE);
-
-	if (option_packet)
-		transport = G_OBEX_TRANSPORT_PACKET;
-	else
-		transport = G_OBEX_TRANSPORT_STREAM;
-
-	obex = g_obex_new(io, transport, -1, -1);
+	transport_accept(io);
 	g_io_channel_unref(io);
-	g_obex_set_disconnect_function(obex, disconn_func, NULL);
-	g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put, NULL);
-	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get, NULL);
-	g_obex_add_request_function(obex, G_OBEX_OP_CONNECT, handle_connect,
-									NULL);
-	clients = g_slist_append(clients, obex);
 
 	return TRUE;
 }
 
 static void bluetooth_accept(GIOChannel *io, GError *err, gpointer data)
 {
-	GObex *obex;
-	GObexTransportType transport;
+	if (err) {
+		g_printerr("accept: %s\n", err->message);
+		return;
+	}
 
 	g_print("Accepted new client connection on bluetooth socket\n");
 
-	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);
-	g_io_channel_set_close_on_unref(io, TRUE);
-
-	if (option_packet)
-		transport = G_OBEX_TRANSPORT_PACKET;
-	else
-		transport = G_OBEX_TRANSPORT_STREAM;
-
-	obex = g_obex_new(io, transport, -1, -1);
-	g_obex_set_disconnect_function(obex, disconn_func, NULL);
-	g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put, NULL);
-	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get, NULL);
-	g_obex_add_request_function(obex, G_OBEX_OP_CONNECT, handle_connect,
-									NULL);
-	clients = g_slist_append(clients, obex);
+	transport_accept(io);
 }
 
 static gboolean bluetooth_watch(GIOChannel *chan, GIOCondition cond, gpointer data)
-- 
1.7.6

