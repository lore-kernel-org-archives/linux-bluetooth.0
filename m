Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/4] gobex: add option to set input/output MTU to test-client
Date: Thu,  1 Sep 2011 12:21:25 +0300
Message-Id: <1314868888-31435-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/test-client.c |   30 ++++++++++--------------------
 1 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/tools/test-client.c b/tools/test-client.c
index d967f02..e27cd3c 100644
--- a/tools/test-client.c
+++ b/tools/test-client.c
@@ -43,6 +43,8 @@ static gboolean option_bluetooth = FALSE;
 static char *option_source = NULL;
 static char *option_dest = NULL;
 static int option_channel = -1;
+static int option_imtu = -1;
+static int option_omtu = -1;
 
 static void sig_term(int sig)
 {
@@ -67,6 +69,10 @@ static GOptionEntry options[] = {
 			&option_packet, "Packet based transport" },
 	{ "stream", 's', G_OPTION_FLAG_REVERSE, G_OPTION_ARG_NONE,
 			&option_packet, "Stream based transport" },
+	{ "input-mtu", 'i', 0, G_OPTION_ARG_INT,
+			&option_imtu, "Transport input MTU", "MTU" },
+	{ "output-mtu", 'o', 0, G_OPTION_ARG_INT,
+			&option_omtu, "Transport output MTU", "MTU" },
 	{ NULL },
 };
 
@@ -269,8 +275,7 @@ static void disconn_func(GObex *obex, GError *err, gpointer user_data)
 	g_main_loop_quit(main_loop);
 }
 
-static void transport_connect(GIOChannel *io, GObexTransportType transport,
-				gssize rx_mtu, gssize tx_mtu)
+static void transport_connect(GIOChannel *io, GObexTransportType transport)
 {
 	GIOChannel *input;
 	GIOCondition events;
@@ -278,7 +283,7 @@ static void transport_connect(GIOChannel *io, GObexTransportType transport,
 	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);
 	g_io_channel_set_close_on_unref(io, TRUE);
 
-	obex = g_obex_new(io, transport, rx_mtu, tx_mtu);
+	obex = g_obex_new(io, transport, option_imtu, option_omtu);
 	g_obex_set_disconnect_function(obex, disconn_func, NULL);
 
 	input = g_io_channel_unix_new(STDIN_FILENO);
@@ -320,7 +325,7 @@ static GIOChannel *unix_connect(GObexTransportType transport)
 
 	g_print("Unix socket created: %d\n", sk);
 
-	transport_connect(io, transport, -1, -1);
+	transport_connect(io, transport);
 
 	return io;
 }
@@ -328,30 +333,15 @@ static GIOChannel *unix_connect(GObexTransportType transport)
 static void conn_callback(GIOChannel *io, GError *err, gpointer user_data)
 {
 	GObexTransportType transport = GPOINTER_TO_UINT(user_data);
-	guint16 imtu = 4096, omtu = 32767;
 
 	if (err != NULL) {
 		g_printerr("%s\n", err->message);
 		return;
 	}
 
-	if (transport == G_OBEX_TRANSPORT_PACKET) {
-		GError *err = NULL;
-
-		if (!bt_io_get(io, BT_IO_L2CAP, &err,
-					BT_IO_OPT_OMTU, &omtu,
-					BT_IO_OPT_IMTU, &imtu,
-					BT_IO_OPT_INVALID)) {
-			g_printerr("%s\n", err->message);
-			g_clear_error(&err);
-			exit(EXIT_FAILURE);
-		} else
-			g_print("imtu=%u, omtu=%u\n", imtu, omtu);
-	}
-
 	g_print("Bluetooth socket connected\n");
 
-	transport_connect(io, transport, imtu, omtu);
+	transport_connect(io, transport);
 }
 
 static GIOChannel *bluetooth_connect(GObexTransportType transport)
-- 
1.7.6

