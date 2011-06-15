Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: nami <nami.li@atheros.com>
Subject: [PATCH 2/2] Bluetooth:  FTP and OPP over L2CAP
Date: Wed, 15 Jun 2011 11:54:06 +0800
Message-ID: <1308110046-5704-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: nami <nami.li@atheros.com>


Signed-off-by: Nami <nami.li@atheros.com>
---
 glib/obex-lowlevel.c          |    2 +-
 include/openobex/obex.h       |    2 +-
 include/openobex/obex_const.h |    5 +++++
 lib/obex.c                    |    3 ++-
 lib/obex_main.c               |    5 ++++-
 lib/obex_transport.h          |    1 +
 6 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/glib/obex-lowlevel.c b/glib/obex-lowlevel.c
index 65172fc..660fc37 100644
--- a/glib/obex-lowlevel.c
+++ b/glib/obex-lowlevel.c
@@ -496,7 +496,7 @@ obex_t *obex_open(int fd, obex_callback_t *callback, void *data)

 	OBEX_SetTransportMTU(handle, sizeof(context->buf), sizeof(context->buf));

-	if (FdOBEX_TransportSetup(handle, fd, fd, 0) < 0) {
+	if (FdOBEX_TransportSetup(handle, fd, fd, 0, OBEX_MT_STREAM) < 0) {
 		OBEX_Cleanup(handle);
 		return NULL;
 	}
diff --git a/include/openobex/obex.h b/include/openobex/obex.h
index f948113..0d7afec 100644
--- a/include/openobex/obex.h
+++ b/include/openobex/obex.h
@@ -147,7 +147,7 @@ OPENOBEX_SYMBOL(int) BtOBEX_TransportConnect(obex_t *self, bt_addr_t *src, bt_ad
 /*
  * OBEX File API
  */
-OPENOBEX_SYMBOL(int) FdOBEX_TransportSetup(obex_t *self, int rfd, int wfd, int mtu);
+OPENOBEX_SYMBOL(int) FdOBEX_TransportSetup(obex_t *self, int rfd, int wfd, int mtu, int fmt);

 /*
  * OBEX interface discovery API
diff --git a/include/openobex/obex_const.h b/include/openobex/obex_const.h
index cb7afeb..4a0a7e9 100644
--- a/include/openobex/obex_const.h
+++ b/include/openobex/obex_const.h
@@ -302,6 +302,11 @@ enum obex_rsp_mode {
   OBEX_RSP_MODE_SINGLE = 1, /**< single response mode (SRM) */
 };

+enum obex_transport_format{
+	 OBEX_MT_STREAM ,
+	 OBEX_MT_SEQPACKET
+};
+
 /* Min, Max and default transport MTU */
 #define OBEX_DEFAULT_MTU	1024
 #define OBEX_MINIMUM_MTU	255
diff --git a/lib/obex.c b/lib/obex.c
index 5ca14a2..06c890a 100644
--- a/lib/obex.c
+++ b/lib/obex.c
@@ -1118,7 +1118,7 @@ int CALLAPI BtOBEX_TransportConnect(obex_t *self, bdaddr_t *src,
 	\return -1 or negative error code on error
  */
 LIB_SYMBOL
-int CALLAPI FdOBEX_TransportSetup(obex_t *self, int rfd, int wfd, int mtu)
+int CALLAPI FdOBEX_TransportSetup(obex_t *self, int rfd, int wfd, int mtu, int fmt)
 {
 	DEBUG(4, "\n");

@@ -1131,6 +1131,7 @@ int CALLAPI FdOBEX_TransportSetup(obex_t *self, int rfd, int wfd, int mtu)
 	self->trans.fd = rfd;
 	self->trans.data.fd.writefd = wfd;
 	self->trans.mtu = mtu ? mtu : self->mtu_tx_max;
+	self->trans.fmt = fmt;
 	return obex_transport_connect_request(self);
 }

diff --git a/lib/obex_main.c b/lib/obex_main.c
index 387f271..8730419 100644
--- a/lib/obex_main.c
+++ b/lib/obex_main.c
@@ -301,7 +301,10 @@ int obex_data_indication(obex_t *self)

 	/* First we need 3 bytes to be able to know how much data to read */
 	if (msg->data_size < sizeof(*hdr))  {
-		actual = obex_transport_read(self, sizeof(*hdr)-msg->data_size);
+		if(self->trans.fmt == OBEX_MT_STREAM)
+			actual = obex_transport_read(self, sizeof(*hdr)-msg->data_size);
+		else
+			actual = obex_transport_read(self, self->mtu_rx);

 		DEBUG(4, "Got %d bytes\n", actual);

diff --git a/lib/obex_transport.h b/lib/obex_transport.h
index a39f563..e80a5cb 100644
--- a/lib/obex_transport.h
+++ b/lib/obex_transport.h
@@ -114,6 +114,7 @@ typedef struct obex_transport {

 	int connected;		/* Link connection state */
 	unsigned int mtu;	/* Tx MTU of the link */
+	enum obex_transport_format fmt;	/* Data transport foramt */

 } obex_transport_t;

--
1.7.1

