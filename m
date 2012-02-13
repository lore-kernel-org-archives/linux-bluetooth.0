Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/5] bluetooth: Add support for L2CAP transport
Date: Mon, 13 Feb 2012 13:37:47 +0200
Message-Id: <1329133070-30003-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1329133070-30003-1-git-send-email-luiz.dentz@gmail.com>
References: <1329133070-30003-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses driver port, if set (!= 0), as psm and export it in the service
record.
---
 plugins/bluetooth.c |  205 ++++++++++++++++++++++++++++++++++++++------------
 plugins/usb.c       |    4 +-
 src/obex-priv.h     |    2 +-
 src/obex.c          |    7 +-
 src/server.c        |    5 +-
 src/server.h        |    3 +-
 6 files changed, 169 insertions(+), 57 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index e547857..7d54997 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -30,6 +30,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <inttypes.h>
+#include <sys/socket.h>
 
 #include <glib.h>
 #include <gdbus.h>
@@ -169,8 +170,16 @@ static void register_record(struct obex_server *server)
 		if (any->path == NULL)
 			continue;
 
-		xml = g_markup_printf_escaped(driver->record, driver->channel,
-						driver->name);
+		if (driver->port != 0)
+			xml = g_markup_printf_escaped(driver->record,
+							driver->channel,
+							driver->name,
+							driver->port);
+		else
+			xml = g_markup_printf_escaped(driver->record,
+							driver->channel,
+							driver->name);
+
 		add_record(any->path, xml, service);
 		g_free(xml);
 	}
@@ -198,11 +207,19 @@ static void find_adapter_any_reply(DBusPendingCall *call, void *user_data)
 
 	for (l = any->services; l; l = l->next) {
 		struct bluetooth_service *service = l->data;
+		struct obex_service_driver *driver = service->driver;
 		char *xml;
 
-		xml = g_markup_printf_escaped(service->driver->record,
-						service->driver->channel,
-						service->driver->name);
+		if (driver->port != 0)
+			xml = g_markup_printf_escaped(driver->record,
+							driver->channel,
+							driver->name,
+							driver->port);
+		else
+			xml = g_markup_printf_escaped(driver->record,
+							driver->channel,
+							driver->name);
+
 		add_record(any->path, xml, service);
 		g_free(xml);
 	}
@@ -288,13 +305,33 @@ static void pending_request_free(struct pending_request *pending)
 
 static void connect_event(GIOChannel *io, GError *err, void *user_data)
 {
+	int sk = g_io_channel_unix_get_fd(io);
 	struct bluetooth_service *service = user_data;
 	struct obex_server *server = service->server;
+	int type;
+	int omtu = BT_TX_MTU;
+	int imtu = BT_RX_MTU;
+	gboolean stream = TRUE;
+	socklen_t len = sizeof(int);
 
 	if (err)
 		goto drop;
 
-	if (obex_server_new_connection(server, io, BT_TX_MTU, BT_RX_MTU) < 0)
+	if (getsockopt(sk, SOL_SOCKET, SO_TYPE, &type, &len) < 0)
+		goto done;
+
+	if (type != SOCK_SEQPACKET)
+		goto done;
+
+	stream = FALSE;
+
+	/* Read MTU if io is an L2CAP socket */
+	bt_io_get(io, BT_IO_L2CAP, NULL, BT_IO_OPT_OMTU, &omtu,
+						BT_IO_OPT_IMTU, &imtu,
+						BT_IO_OPT_INVALID);
+
+done:
+	if (obex_server_new_connection(server, io, omtu, imtu, stream) < 0)
 		g_io_channel_shutdown(io, TRUE, NULL);
 
 	return;
@@ -420,24 +457,15 @@ failed:
 }
 
 static int request_service_authorization(struct bluetooth_service *service,
-					GIOChannel *io, const char *address)
+							GIOChannel *io,
+							const char *source,
+							const char *address)
 {
 	struct pending_request *pending;
-	char source[18];
-	GError *err = NULL;
 
 	if (connection == NULL || any->path == NULL)
 		return -1;
 
-	bt_io_get(io, BT_IO_RFCOMM, &err,
-			BT_IO_OPT_SOURCE, source,
-			BT_IO_OPT_INVALID);
-	if (err) {
-		error("%s", err->message);
-		g_error_free(err);
-		return -EINVAL;
-	}
-
 	pending = g_new0(struct pending_request, 1);
 	pending->call = find_adapter(source, find_adapter_reply, pending);
 	if (!pending->call) {
@@ -452,26 +480,13 @@ static int request_service_authorization(struct bluetooth_service *service,
 	return 0;
 }
 
-static void confirm_event(GIOChannel *io, void *user_data)
+static void confirm_connection(GIOChannel *io, const char *source,
+					const char *address, void *user_data)
 {
+
+	struct obex_service_driver *driver = user_data;
 	struct bluetooth_service *service;
 	GError *err = NULL;
-	char address[18];
-	uint8_t channel;
-	struct obex_service_driver *driver = user_data;
-
-	bt_io_get(io, BT_IO_RFCOMM, &err,
-			BT_IO_OPT_DEST, address,
-			BT_IO_OPT_CHANNEL, &channel,
-			BT_IO_OPT_INVALID);
-	if (err) {
-		error("%s", err->message);
-		g_error_free(err);
-		goto drop;
-	}
-
-	info("bluetooth: New connection from: %s, channel %u", address,
-			channel);
 
 	service = find_service(driver);
 	if (service == NULL) {
@@ -480,7 +495,8 @@ static void confirm_event(GIOChannel *io, void *user_data)
 	}
 
 	if (driver->secure) {
-		if (request_service_authorization(service, io, address) < 0)
+		if (request_service_authorization(service, io, source,
+								address) < 0)
 			goto drop;
 
 		return;
@@ -498,20 +514,70 @@ drop:
 	g_io_channel_shutdown(io, TRUE, NULL);
 }
 
-static GIOChannel *start(struct obex_server *server,
+static void confirm_rfcomm(GIOChannel *io, void *user_data)
+{
+	GError *err = NULL;
+	char source[18];
+	char address[18];
+	uint8_t channel;
+
+	bt_io_get(io, BT_IO_RFCOMM, &err,
+			BT_IO_OPT_SOURCE, source,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_CHANNEL, &channel,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		g_io_channel_shutdown(io, TRUE, NULL);
+		return;
+	}
+
+	info("bluetooth: New connection from: %s, channel %u", address,
+								channel);
+
+	confirm_connection(io, source, address, user_data);
+}
+
+static void confirm_l2cap(GIOChannel *io, void *user_data)
+{
+	GError *err = NULL;
+	char source[18];
+	char address[18];
+	uint16_t psm;
+
+	bt_io_get(io, BT_IO_L2CAP, &err,
+			BT_IO_OPT_SOURCE, source,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_PSM, &psm,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		g_io_channel_shutdown(io, TRUE, NULL);
+		return;
+	}
+
+	info("bluetooth: New connection from: %s, psm %u", address, psm);
+
+	confirm_connection(io, source, address, user_data);
+}
+
+static GSList *start(struct obex_server *server,
 				struct obex_service_driver *service)
 {
 	BtIOSecLevel sec_level;
+	GSList *l = NULL;
 	GIOChannel *io;
 	GError *err = NULL;
+	uint16_t psm;
 
 	if (service->secure == TRUE)
 		sec_level = BT_IO_SEC_MEDIUM;
 	else
 		sec_level = BT_IO_SEC_LOW;
 
-
-	io = bt_io_listen(BT_IO_RFCOMM, NULL, confirm_event,
+	io = bt_io_listen(BT_IO_RFCOMM, NULL, confirm_rfcomm,
 				service, NULL, &err,
 				BT_IO_OPT_CHANNEL, service->channel,
 				BT_IO_OPT_SEC_LEVEL, sec_level,
@@ -520,10 +586,36 @@ static GIOChannel *start(struct obex_server *server,
 		error("bluetooth: unable to listen in channel %d: %s",
 				service->channel, err->message);
 		g_error_free(err);
-	} else
+	} else {
+		l = g_slist_prepend(l, io);
 		DBG("listening on channel %d", service->channel);
+	}
+
+	if (service->port == 0)
+		return l;
+
+	psm = service->port == OBEX_PORT_RANDOM ? 0 : service->port;
+
+	io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_l2cap,
+			service, NULL, &err,
+			BT_IO_OPT_PSM, psm,
+			BT_IO_OPT_MODE, BT_IO_MODE_ERTM,
+			BT_IO_OPT_OMTU, BT_TX_MTU,
+			BT_IO_OPT_IMTU, BT_RX_MTU,
+			BT_IO_OPT_SEC_LEVEL, sec_level,
+			BT_IO_OPT_INVALID);
+	if (io == NULL) {
+		error("bluetooth: unable to listen in psm %d: %s",
+				service->port, err->message);
+		g_error_free(err);
+	} else {
+		l = g_slist_prepend(l, io);
+		bt_io_get(io, BT_IO_L2CAP, &err, BT_IO_OPT_PSM, &service->port,
+							BT_IO_OPT_INVALID);
+		DBG("listening on psm %d", service->port);
+	}
 
-	return io;
+	return l;
 }
 
 static void *bluetooth_start(struct obex_server *server, int *err)
@@ -533,13 +625,13 @@ static void *bluetooth_start(struct obex_server *server, int *err)
 
 	for (l = server->drivers; l; l = l->next) {
 		struct obex_service_driver *service = l->data;
-		GIOChannel *io;
+		GSList *l;
 
-		io = start(server, service);
-		if (io == NULL)
+		l = start(server, service);
+		if (l == NULL)
 			continue;
 
-		ios = g_slist_prepend(ios, io);
+		ios = g_slist_concat(ios, l);
 	}
 
 	register_record(server);
@@ -564,14 +656,29 @@ static void bluetooth_stop(void *data)
 
 static int bluetooth_getpeername(GIOChannel *io, char **name)
 {
+	int sk = g_io_channel_unix_get_fd(io);
 	GError *gerr = NULL;
 	char address[18];
+	int type;
+	socklen_t len = sizeof(int);
 
-	bt_io_get(io, BT_IO_RFCOMM, &gerr,
-			BT_IO_OPT_DEST, address,
-			BT_IO_OPT_INVALID);
-	if (gerr)
+	if (getsockopt(sk, SOL_SOCKET, SO_TYPE, &type, &len) < 0)
+		return -errno;
+
+	if (type == SOCK_STREAM)
+		bt_io_get(io, BT_IO_RFCOMM, &gerr,
+				BT_IO_OPT_DEST, address,
+				BT_IO_OPT_INVALID);
+	else
+		bt_io_get(io, BT_IO_L2CAP, &gerr,
+				BT_IO_OPT_DEST, address,
+				BT_IO_OPT_INVALID);
+
+	if (gerr) {
+		error("%s", gerr->message);
+		g_error_free(gerr);
 		return -EINVAL;
+	}
 
 	*name = g_strdup(address);
 
diff --git a/plugins/usb.c b/plugins/usb.c
index 3da77d0..7b21623 100644
--- a/plugins/usb.c
+++ b/plugins/usb.c
@@ -147,8 +147,8 @@ static int usb_connect(struct obex_server *server)
 	usb_io = g_io_channel_unix_new(fd);
 	g_io_channel_set_close_on_unref(usb_io, TRUE);
 
-	err = obex_server_new_connection(server, usb_io,
-					USB_TX_MTU, USB_RX_MTU);
+	err = obex_server_new_connection(server, usb_io, USB_TX_MTU,
+							USB_RX_MTU, TRUE);
 	if (err < 0)
 		goto failed;
 
diff --git a/src/obex-priv.h b/src/obex-priv.h
index ee03bf4..5b72942 100644
--- a/src/obex-priv.h
+++ b/src/obex-priv.h
@@ -53,4 +53,4 @@ struct obex_session {
 };
 
 int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,
-			struct obex_server *server);
+				gboolean stream, struct obex_server *server);
diff --git a/src/obex.c b/src/obex.c
index b14e0e0..05cc068 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -1119,10 +1119,11 @@ static void disconn_func(GObex *obex, GError *err, gpointer user_data)
 }
 
 int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,
-			struct obex_server *server)
+				gboolean stream, struct obex_server *server)
 {
 	struct obex_session *os;
 	GObex *obex;
+	GObexTransportType type;
 	static uint32_t id = 0;
 
 	DBG("");
@@ -1135,7 +1136,9 @@ int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,
 	os->server = server;
 	os->size = OBJECT_SIZE_DELETE;
 
-	obex = g_obex_new(io, G_OBEX_TRANSPORT_STREAM, rx_mtu, tx_mtu);
+	type = stream ? G_OBEX_TRANSPORT_STREAM : G_OBEX_TRANSPORT_PACKET;
+
+	obex = g_obex_new(io, type, rx_mtu, tx_mtu);
 	if (!obex) {
 		obex_session_free(os);
 		return -EIO;
diff --git a/src/server.c b/src/server.c
index e5dc22d..52f7f1e 100644
--- a/src/server.c
+++ b/src/server.c
@@ -136,7 +136,8 @@ struct obex_service_driver *obex_server_find_driver(
 }
 
 int obex_server_new_connection(struct obex_server *server, GIOChannel *io,
-				uint16_t tx_mtu, uint16_t rx_mtu)
+					uint16_t tx_mtu, uint16_t rx_mtu,
+					gboolean stream)
 {
-	return obex_session_start(io, tx_mtu, rx_mtu, server);
+	return obex_session_start(io, tx_mtu, rx_mtu, stream, server);
 }
diff --git a/src/server.h b/src/server.h
index 81c0b5d..e211f1f 100644
--- a/src/server.h
+++ b/src/server.h
@@ -35,4 +35,5 @@ void obex_server_exit(void);
 struct obex_service_driver *obex_server_find_driver(struct obex_server *server,
 							uint8_t channel);
 int obex_server_new_connection(struct obex_server *server, GIOChannel *io,
-				uint16_t tx_mtu, uint16_t rx_mtu);
+					uint16_t tx_mtu, uint16_t rx_mtu,
+					gboolean stream);
-- 
1.7.7.6

