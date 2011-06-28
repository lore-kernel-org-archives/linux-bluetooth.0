Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Nami <nami.li@atheros.com>
Subject: [PATCH v3 openobex 2/3] Create new API to set fd obex transport format.
Date: Tue, 28 Jun 2011 15:56:59 +0800
Message-ID: <1309247819-11369-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 include/openobex/obex.h |    1 +
 lib/obex.c              |   16 ++++++++++++++++
 lib/obex.sym            |    1 +
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/include/openobex/obex.h b/include/openobex/obex.h
index f948113..cb1d66a 100644
--- a/include/openobex/obex.h
+++ b/include/openobex/obex.h
@@ -148,6 +148,7 @@ OPENOBEX_SYMBOL(int) BtOBEX_TransportConnect(obex_t *self, bt_addr_t *src, bt_ad
  * OBEX File API
  */
 OPENOBEX_SYMBOL(int) FdOBEX_TransportSetup(obex_t *self, int rfd, int wfd, int mtu);
+OPENOBEX_SYMBOL(void)FdOBEX_SetTransportFormat(obex_t *self, enum fdobex_transport_format fmt);

 /*
  * OBEX interface discovery API
diff --git a/lib/obex.c b/lib/obex.c
index 165fcb8..8679648 100644
--- a/lib/obex.c
+++ b/lib/obex.c
@@ -1136,6 +1136,22 @@ int CALLAPI FdOBEX_TransportSetup(obex_t *self, int rfd, int wfd, int mtu)
 }

 /**
+	FdOBEX_SetTransportFormat - set transport format for OBEX_TRANS_FD transport.
+
+	\param self OBEX handle
+	\param fmt transport format: FDOBEX_MT_STREAM - default
+ */
+LIB_SYMBOL
+void FdOBEX_SetTransportFormat(obex_t *self, enum fdobex_transport_format fmt)
+{
+	DEBUG(4, "\n");
+
+	obex_return_if_fail(self != NULL);
+
+	self->trans.data.fd.fmt = fmt;
+}
+
+/**
 	Connect USB interface.
 	\param self OBEX handle
 	\param intf USB interface to connect to
diff --git a/lib/obex.sym b/lib/obex.sym
index 0c33b63..0f59042 100644
--- a/lib/obex.sym
+++ b/lib/obex.sym
@@ -39,6 +39,7 @@ IrOBEX_TransportConnect
 BtOBEX_ServerRegister
 BtOBEX_TransportConnect
 FdOBEX_TransportSetup
+FdOBEX_SetTransportFormat
 OBEX_InterfaceConnect
 OBEX_EnumerateInterfaces
 OBEX_GetInterfaceByIndex
--
1.7.1

