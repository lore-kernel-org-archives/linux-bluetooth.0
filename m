Return-Path: <cyrus@holtmann.org>
From: Hui Li <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Hui Li <nami@qca.qualcomm.com>
Subject: [PATCH obexd]  Return correct obex service driver in obex_session_start
Date: Thu, 30 Jun 2011 15:34:54 +0800
Message-ID: <1309419294-9903-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Hui Li <nami@qca.qualcomm.com>

 The original return value is NULL.
---
 src/obex.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 49d9c18..978894e 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -1377,8 +1377,7 @@ int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,

 	os = g_new0(struct obex_session, 1);

-	os->service = obex_service_driver_find(server->drivers, NULL,
-							0, NULL, 0);
+	os->service = server->drivers->data;
 	os->server = server;
 	os->rx_mtu = rx_mtu != 0 ? rx_mtu : DEFAULT_RX_MTU;
 	os->tx_mtu = tx_mtu != 0 ? tx_mtu : DEFAULT_TX_MTU;
--
1.7.1

