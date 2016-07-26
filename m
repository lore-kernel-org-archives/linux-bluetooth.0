Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: fabien.proriolpatch@kazoe.org
To: linux-bluetooth@vger.kernel.org
Cc: fabien.proriol@jdsu.com
Subject: [PATCH] Fix obex protocol for powerpc
Date: Tue, 26 Jul 2016 15:14:11 +0200
Message-Id: <1469538851-17006-1-git-send-email-fabien.proriolpatch@kazoe.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Fabien Proriol <fabien.proriol@jdsu.com>

omtu and imtu is define as uint16_t in l2cap_get function (use with va_arg).

Signed-off-by: Fabien Proriol <fabien.proriol@jdsu.com>
---
 obexd/plugins/bluetooth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
