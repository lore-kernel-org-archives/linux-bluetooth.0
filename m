Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 3/8] attrib-server: Fix gatt_channel MTU value
Date: Wed,  6 Jun 2012 21:40:58 -0300
Message-Id: <1339029663-25654-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
References: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In attrib_channel_attach, channel->mtu should be initialized according
to ATT_MTU value.

Over BR/EDR, ATT_MTU should be set to the L2CAP imtu negotiated during
L2CAP configuration phase. Over LE, ATT_MTU should be 23 octets.
---
 src/attrib-server.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index d2a2520..4dc3ff9 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1033,6 +1033,7 @@ guint attrib_channel_attach(GAttrib *attrib)
 	GError *gerr = NULL;
 	char addr[18];
 	uint16_t cid;
+	guint mtu = 0;
 
 	io = g_attrib_get_channel(attrib);
 
@@ -1042,7 +1043,7 @@ guint attrib_channel_attach(GAttrib *attrib)
 			BT_IO_OPT_SOURCE_BDADDR, &channel->src,
 			BT_IO_OPT_DEST_BDADDR, &channel->dst,
 			BT_IO_OPT_CID, &cid,
-			BT_IO_OPT_OMTU, &channel->mtu,
+			BT_IO_OPT_IMTU, &mtu,
 			BT_IO_OPT_INVALID);
 	if (gerr) {
 		error("bt_io_get: %s", gerr->message);
@@ -1069,14 +1070,13 @@ guint attrib_channel_attach(GAttrib *attrib)
 	if (device == NULL || device_is_bonded(device) == FALSE)
 		delete_device_ccc(&channel->src, &channel->dst);
 
-	if (channel->mtu > ATT_MAX_MTU)
-		channel->mtu = ATT_MAX_MTU;
-
-	if (cid != ATT_CID)
+	if (cid != ATT_CID) {
 		channel->le = FALSE;
-	else
+		channel->mtu = mtu;
+	} else {
 		channel->le = TRUE;
-
+		channel->mtu = ATT_DEFAULT_LE_MTU;
+	}
 
 	channel->attrib = g_attrib_ref(attrib);
 	channel->id = g_attrib_register(channel->attrib, GATTRIB_ALL_REQS,
-- 
1.7.10.3

