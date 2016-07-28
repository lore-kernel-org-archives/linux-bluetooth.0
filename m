Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: fabien.proriolpatch@kazoe.org
To: linux-bluetooth@vger.kernel.org
Cc: Fabien Proriol <fabien.proriol@jdsu.com>
Subject: [PATCH BlueZ] Fix obex protocol for powerpc
Date: Thu, 28 Jul 2016 16:06:48 +0200
Message-Id: <1469714808-18136-2-git-send-email-fabien.proriolpatch@kazoe.org>
In-Reply-To: <1469714808-18136-1-git-send-email-fabien.proriolpatch@kazoe.org>
References: <1469714808-18136-1-git-send-email-fabien.proriolpatch@kazoe.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Fabien Proriol <fabien.proriol@jdsu.com>

omtu and imtu is define as uint16_t in l2cap_get function (use with va_arg).
---
 obexd/client/bluetooth.c  | 4 ++--
 obexd/plugins/bluetooth.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/obexd/client/bluetooth.c b/obexd/client/bluetooth.c
index be007de..e35124a 100644
--- a/obexd/client/bluetooth.c
+++ b/obexd/client/bluetooth.c
@@ -443,8 +443,8 @@ static int bluetooth_getpacketopt(GIOChannel *io, int *tx_mtu, int *rx_mtu)
 {
 	int sk = g_io_channel_unix_get_fd(io);
 	int type;
-	int omtu = -1;
-	int imtu = -1;
+	uint16_t omtu = BT_TX_MTU;
+	uint16_t imtu = BT_RX_MTU;
 	socklen_t len = sizeof(int);
 
 	DBG("");
diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index d8b872a..3ee5432 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -75,8 +75,8 @@ static void connect_event(GIOChannel *io, GError *err, void *user_data)
 	struct bluetooth_profile *profile = user_data;
 	struct obex_server *server = profile->server;
 	int type;
-	int omtu = BT_TX_MTU;
-	int imtu = BT_RX_MTU;
+	uint16_t omtu = BT_TX_MTU;
+	uint16_t imtu = BT_RX_MTU;
 	gboolean stream = TRUE;
 	socklen_t len = sizeof(int);
 
-- 
2.7.3
