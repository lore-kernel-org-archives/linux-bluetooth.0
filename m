Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <haijun@qca.qualcomm.com>, <yongli@qca.qualcomm.com>,
	Nami <nami.li@atheros.com>
Subject: [PATCH obexd 07/14] Set different data format for different OBEX protocol.
Date: Mon, 20 Jun 2011 17:44:53 +0800
Message-ID: <1308563100-18917-7-git-send-email-nami.li@atheros.com>
In-Reply-To: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
References: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/obex.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index e6585ca..4c032bc 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -1264,11 +1264,13 @@ int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,
 	struct obex_session *os;
 	obex_t *obex;
 	int ret, fd;
+	int fmt = FDOBEX_MT_STREAM;

 	os = g_new0(struct obex_session, 1);

-	os->service = obex_service_driver_find(server->drivers, NULL,
-							0, NULL, 0);
+	//os->service = obex_service_driver_find(server->drivers, NULL,
+		//					0, NULL, 0);
+	os->service = server->drivers->data;
 	os->server = server;
 	os->rx_mtu = rx_mtu != 0 ? rx_mtu : DEFAULT_RX_MTU;
 	os->tx_mtu = tx_mtu != 0 ? tx_mtu : DEFAULT_TX_MTU;
@@ -1287,7 +1289,9 @@ int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,

 	fd = g_io_channel_unix_get_fd(io);

-	ret = FdOBEX_TransportSetup(obex, fd, fd, 0);
+	if(os->service->protocol == L2CAP_OBEX)
+		fmt = FDOBEX_MT_SEQPACKET;
+	ret = FdOBEX_TransportSetup(obex, fd, fd, 0, fmt);
 	if (ret < 0) {
 		obex_session_free(os);
 		OBEX_Cleanup(obex);
--
1.7.1

