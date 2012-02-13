Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 5/5] client: Add L2CAP support in bluetooth module
Date: Mon, 13 Feb 2012 13:37:50 +0200
Message-Id: <1329133070-30003-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1329133070-30003-1-git-send-email-luiz.dentz@gmail.com>
References: <1329133070-30003-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for reading GoepL2capPsm attribute from sdp record
and connect to it.
---
 client/bluetooth.c |   84 +++++++++++++++++++++++++++++++++++++++++++--------
 client/session.c   |   12 +++++++-
 client/transport.h |    1 +
 3 files changed, 82 insertions(+), 15 deletions(-)

diff --git a/client/bluetooth.c b/client/bluetooth.c
index 558c408..b49a82e 100644
--- a/client/bluetooth.c
+++ b/client/bluetooth.c
@@ -46,6 +46,9 @@
 #define BT_ADAPTER_IFACE	"org.bluez.Adapter"
 #define BT_MANAGER_IFACE	"org.bluez.Manager"
 
+#define BT_RX_MTU 32767
+#define BT_TX_MTU 32767
+
 #define OBC_BT_ERROR obc_bt_error_quark()
 
 struct bluetooth_session {
@@ -163,7 +166,7 @@ static void session_destroy(struct bluetooth_session *session)
 	g_free(session);
 }
 
-static void rfcomm_callback(GIOChannel *io, GError *err, gpointer user_data)
+static void transport_callback(GIOChannel *io, GError *err, gpointer user_data)
 {
 	struct bluetooth_session *session = user_data;
 
@@ -176,21 +179,36 @@ static void rfcomm_callback(GIOChannel *io, GError *err, gpointer user_data)
 		session_destroy(session);
 }
 
-static GIOChannel *rfcomm_connect(const bdaddr_t *src, const bdaddr_t *dst,
-					uint8_t channel, BtIOConnect function,
+static GIOChannel *transport_connect(const bdaddr_t *src, const bdaddr_t *dst,
+					uint16_t port, BtIOConnect function,
 					gpointer user_data)
 {
 	GIOChannel *io;
 	GError *err = NULL;
 
-	DBG("");
+	DBG("port %u", port);
 
-	io = bt_io_connect(BT_IO_RFCOMM, function, user_data, NULL, &err,
+	if (port > 31) {
+		io = bt_io_connect(BT_IO_L2CAP, function, user_data,
+				NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, src,
+				BT_IO_OPT_DEST_BDADDR, dst,
+				BT_IO_OPT_PSM, port,
+				BT_IO_OPT_MODE, BT_IO_MODE_ERTM,
+				BT_IO_OPT_OMTU, BT_TX_MTU,
+				BT_IO_OPT_IMTU, BT_RX_MTU,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_INVALID);
+	} else {
+		io = bt_io_connect(BT_IO_RFCOMM, function, user_data,
+				NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_DEST_BDADDR, dst,
-				BT_IO_OPT_CHANNEL, channel,
+				BT_IO_OPT_CHANNEL, port,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 				BT_IO_OPT_INVALID);
+	}
+
 	if (io != NULL)
 		return io;
 
@@ -205,7 +223,8 @@ static void search_callback(uint8_t type, uint16_t status,
 	struct bluetooth_session *session = user_data;
 	unsigned int scanned, bytesleft = size;
 	int seqlen = 0;
-	uint8_t dataType, channel = 0;
+	uint8_t dataType;
+	uint16_t port = 0;
 	GError *gerr = NULL;
 
 	if (status || type != SDP_SVC_SEARCH_ATTR_RSP)
@@ -220,6 +239,7 @@ static void search_callback(uint8_t type, uint16_t status,
 	do {
 		sdp_record_t *rec;
 		sdp_list_t *protos;
+		sdp_data_t *data;
 		int recsize, ch = -1;
 
 		recsize = 0;
@@ -240,10 +260,14 @@ static void search_callback(uint8_t type, uint16_t status,
 			protos = NULL;
 		}
 
+		data = sdp_data_get(rec, 0x0200);
+		if (data != NULL)
+			ch = data->val.uint16;
+
 		sdp_record_free(rec);
 
 		if (ch > 0) {
-			channel = ch;
+			port = ch;
 			break;
 		}
 
@@ -252,16 +276,16 @@ static void search_callback(uint8_t type, uint16_t status,
 		bytesleft -= recsize;
 	} while (scanned < size && bytesleft > 0);
 
-	if (channel == 0)
+	if (port == 0)
 		goto failed;
 
-	session->port = channel;
+	session->port = port;
 
 	g_io_channel_set_close_on_unref(session->io, FALSE);
 	g_io_channel_unref(session->io);
 
-	session->io = rfcomm_connect(&session->src, &session->dst, channel,
-					rfcomm_callback, session);
+	session->io = transport_connect(&session->src, &session->dst, port,
+						transport_callback, session);
 	if (session->io != NULL) {
 		sdp_close(session->sdp);
 		session->sdp = NULL;
@@ -279,6 +303,7 @@ failed:
 					"Unable to find service record");
 	if (session->func)
 		session->func(session->io, gerr, session->user_data);
+
 	g_clear_error(&gerr);
 
 	session_destroy(session);
@@ -413,9 +438,9 @@ static int session_connect(struct bluetooth_session *session)
 	int err;
 
 	if (session->port > 0) {
-		session->io = rfcomm_connect(&session->src, &session->dst,
+		session->io = transport_connect(&session->src, &session->dst,
 							session->port,
-							rfcomm_callback,
+							transport_callback,
 							session);
 		err = (session->io == NULL) ? -EINVAL : 0;
 	} else {
@@ -587,9 +612,40 @@ static void bluetooth_disconnect(guint id)
 	}
 }
 
+static int bluetooth_getpacketopt(GIOChannel *io, int *tx_mtu, int *rx_mtu)
+{
+	int sk = g_io_channel_unix_get_fd(io);
+	int type;
+	int omtu = -1;
+	int imtu = -1;
+	socklen_t len = sizeof(int);
+
+	DBG("");
+
+	if (getsockopt(sk, SOL_SOCKET, SO_TYPE, &type, &len) < 0)
+		return -errno;
+
+	if (type != SOCK_SEQPACKET)
+		return -EINVAL;
+
+	if (!bt_io_get(io, BT_IO_L2CAP, NULL, BT_IO_OPT_OMTU, &omtu,
+						BT_IO_OPT_IMTU, &imtu,
+						BT_IO_OPT_INVALID))
+		return -EINVAL;
+
+	if (tx_mtu)
+		*tx_mtu = omtu;
+
+	if (rx_mtu)
+		*rx_mtu = imtu;
+
+	return 0;
+}
+
 static struct obc_transport bluetooth = {
 	.name = "Bluetooth",
 	.connect = bluetooth_connect,
+	.getpacketopt = bluetooth_getpacketopt,
 	.disconnect = bluetooth_disconnect,
 };
 
diff --git a/client/session.c b/client/session.c
index 585e402..0fa8efc 100644
--- a/client/session.c
+++ b/client/session.c
@@ -257,7 +257,11 @@ static void transport_func(GIOChannel *io, GError *err, gpointer user_data)
 	struct callback_data *callback = user_data;
 	struct obc_session *session = callback->session;
 	struct obc_driver *driver = session->driver;
+	struct obc_transport *transport = session->transport;
 	GObex *obex;
+	GObexTransportType type;
+	int tx_mtu = -1;
+	int rx_mtu = -1;
 
 	DBG("");
 
@@ -268,7 +272,13 @@ static void transport_func(GIOChannel *io, GError *err, gpointer user_data)
 
 	g_io_channel_set_close_on_unref(io, FALSE);
 
-	obex = g_obex_new(io, G_OBEX_TRANSPORT_STREAM, -1, -1);
+	if (transport->getpacketopt &&
+			transport->getpacketopt(io, &tx_mtu, &rx_mtu) == 0)
+		type = G_OBEX_TRANSPORT_PACKET;
+	else
+		type = G_OBEX_TRANSPORT_STREAM;
+
+	obex = g_obex_new(io, type, tx_mtu, rx_mtu);
 	if (obex == NULL)
 		goto done;
 
diff --git a/client/transport.h b/client/transport.h
index 4c9bf2d..5140840 100644
--- a/client/transport.h
+++ b/client/transport.h
@@ -29,6 +29,7 @@ struct obc_transport {
 	guint (*connect) (const char *source, const char *destination,
 				const char *service, uint16_t port,
 				obc_transport_func func, void *user_data);
+	int (*getpacketopt) (GIOChannel *io, int *tx_mtu, int *rx_mtu);
 	void (*disconnect) (guint id);
 };
 
-- 
1.7.7.6

