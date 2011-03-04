Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCHv3 1/2] Use CID to infer transport type
Date: Fri,  4 Mar 2011 16:17:44 -0400
Message-Id: <1299269865-1259-1-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1299083684-5062-2-git-send-email-bruna.moreira@openbossa.org>
References: <1299083684-5062-2-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of comparing GIOChannel pointers, use the CID returned by
bt_io_get() to infer the transport type. LE uses the fixed CID for GATT.
---
 src/attrib-server.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index b980b28..61db851 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -899,7 +899,7 @@ done:
 static void connect_event(GIOChannel *io, GError *err, void *user_data)
 {
 	struct gatt_channel *channel;
-	GIOChannel **server_io = user_data;
+	uint16_t cid;
 	GError *gerr = NULL;
 
 	if (err) {
@@ -912,6 +912,7 @@ static void connect_event(GIOChannel *io, GError *err, void *user_data)
 	bt_io_get(io, BT_IO_L2CAP, &gerr,
 			BT_IO_OPT_SOURCE_BDADDR, &channel->src,
 			BT_IO_OPT_DEST_BDADDR, &channel->dst,
+			BT_IO_OPT_CID, &cid,
 			BT_IO_OPT_INVALID);
 	if (gerr) {
 		error("bt_io_get: %s", gerr->message);
@@ -921,7 +922,7 @@ static void connect_event(GIOChannel *io, GError *err, void *user_data)
 		return;
 	}
 
-	if (server_io == &l2cap_io)
+	if (cid != GATT_CID)
 		channel->mtu = ATT_DEFAULT_L2CAP_MTU;
 	else
 		channel->mtu = ATT_DEFAULT_LE_MTU;
@@ -1046,7 +1047,7 @@ int attrib_server_init(void)
 
 	/* BR/EDR socket */
 	l2cap_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
-					&l2cap_io, NULL, &gerr,
+					NULL, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, BDADDR_ANY,
 					BT_IO_OPT_PSM, GATT_PSM,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-- 
1.7.0.4

