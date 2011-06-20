Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <haijun@qca.qualcomm.com>, <openobex-users@lists.sourceforge.net>,
	Nami <nami.li@atheros.com>
Subject: [PATCH openobex 2/3] Add transport format parameter when setup fd obex transprot.
Date: Mon, 20 Jun 2011 13:47:28 +0800
Message-ID: <1308548849-11615-2-git-send-email-nami.li@atheros.com>
In-Reply-To: <1308548849-11615-1-git-send-email-nami.li@atheros.com>
References: <1308548849-11615-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


---
 include/openobex/obex.h |    2 +-
 lib/obex.c              |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

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
diff --git a/lib/obex.c b/lib/obex.c
index 165fcb8..304bc15 100644
--- a/lib/obex.c
+++ b/lib/obex.c
@@ -1116,10 +1116,11 @@ int CALLAPI BtOBEX_TransportConnect(obex_t *self, bdaddr_t *src,
 	\param rfd descriptor to read
 	\param wfd descriptor to write
 	\param mtu transport mtu: 0 - default
+	\param fmt transport format: 0 - default
 	\return -1 or negative error code on error
  */
 LIB_SYMBOL
-int CALLAPI FdOBEX_TransportSetup(obex_t *self, int rfd, int wfd, int mtu)
+int CALLAPI FdOBEX_TransportSetup(obex_t *self, int rfd, int wfd, int mtu, int fmt)
 {
 	DEBUG(4, "\n");

@@ -1132,6 +1133,7 @@ int CALLAPI FdOBEX_TransportSetup(obex_t *self, int rfd, int wfd, int mtu)
 	self->trans.fd = rfd;
 	self->trans.data.fd.writefd = wfd;
 	self->trans.mtu = mtu ? mtu : self->mtu_tx_max;
+	self->trans.data.fd.fmt = fmt;
 	return obex_transport_connect_request(self);
 }

--
1.7.1

