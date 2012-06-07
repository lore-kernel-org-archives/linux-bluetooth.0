Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 4/8] attrib-server: Fix mtu_exchange
Date: Wed,  6 Jun 2012 21:40:59 -0300
Message-Id: <1339029663-25654-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
References: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the client requests an ATT_MTU less than the minimum ATT_MTU,
the server should send an Error Response message with Request Not
Supported code.

According to GATT spec, the server shall respond to Exchange MTU
Requests messages with an Exchange MTU Response with the Server
Rx MTU parameter set to the maximum MTU that this server can
receive. Thus, we should get L2CAP imtu value in order to properly
send the Exchange MTU Response message.

Additionally, we should not change the L2CAP ATT fixed channel MTU.
bt_io_set call will always fail since we are not supposed to change
L2CAP MTU after connection is established.
---
 src/attrib-server.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 4dc3ff9..3954f99 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -867,18 +867,27 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
 		uint8_t *pdu, int len)
 {
-	guint old_mtu = channel->mtu;
+	GError *gerr = NULL;
+	GIOChannel *io;
+	uint16_t imtu;
 
 	if (mtu < ATT_DEFAULT_LE_MTU)
-		channel->mtu = ATT_DEFAULT_LE_MTU;
-	else
-		channel->mtu = MIN(mtu, channel->mtu);
+		return enc_error_resp(ATT_OP_MTU_REQ, 0,
+					ATT_ECODE_REQ_NOT_SUPP, pdu, len);
 
-	bt_io_set(channel->server->le_io, BT_IO_L2CAP, NULL,
-			BT_IO_OPT_OMTU, channel->mtu,
+	io = g_attrib_get_channel(channel->attrib);
+
+	bt_io_get(io, BT_IO_L2CAP, &gerr,
+			BT_IO_OPT_IMTU, &imtu,
 			BT_IO_OPT_INVALID);
 
-	return enc_mtu_resp(old_mtu, pdu, len);
+	if (gerr)
+		return enc_error_resp(ATT_OP_MTU_REQ, 0,
+					ATT_ECODE_UNLIKELY, pdu, len);
+
+	channel->mtu = MIN(mtu, imtu);
+
+	return enc_mtu_resp(imtu, pdu, len);
 }
 
 static void channel_remove(struct gatt_channel *channel)
-- 
1.7.10.3

