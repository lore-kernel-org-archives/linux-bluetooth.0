Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCHv2 2/2] Fix MTU value used on MTU exchange response
Date: Wed,  2 Mar 2011 12:34:44 -0400
Message-Id: <1299083684-5062-2-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1298583454-18227-1-git-send-email-bruna.moreira@openbossa.org>
References: <1298583454-18227-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ATT_MTU_RESP shall send the original MTU value prior to the exchange. If
client sends an invalid value, the server shall use the ATT_DEFAULT_LE_MTU
value. This operation is not supported in BR/EDR, so if any client sends
this request it will be ignored by server and it will reply with
"Request not supported".

For BR/EDR, the MTU is limited to ATT_MAX_MTU (currently 256). This
avoids allocating a big buffer when most ATT PDUs are small.

Note: the kernel currently limits the minimum MTU to 48, regardless of
transport type. This limit is valid only for BR/EDR, for LE the minimum
is 23. This bug will be fixed, but it does not affect the outgoing MTU
for new created LE sockets, which are correctly set to 23.
---
 src/attrib-server.c |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 61db851..cc4b601 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -59,6 +59,7 @@ struct gatt_channel {
 	GSList *indicate;
 	GAttrib *attrib;
 	guint mtu;
+	gboolean le;
 	guint id;
 	gboolean encrypted;
 };
@@ -759,9 +760,14 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
 		uint8_t *pdu, int len)
 {
-	channel->mtu = MIN(mtu, channel->mtu);
+	guint old_mtu = channel->mtu;
 
-	return enc_mtu_resp(channel->mtu, pdu, len);
+	if (mtu < ATT_DEFAULT_LE_MTU)
+		channel->mtu = ATT_DEFAULT_LE_MTU;
+	else
+		channel->mtu = MIN(mtu, channel->mtu);
+
+	return enc_mtu_resp(old_mtu, pdu, len);
 }
 
 static void channel_disconnect(void *user_data)
@@ -831,6 +837,11 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 		length = read_blob(channel, start, offset, opdu, channel->mtu);
 		break;
 	case ATT_OP_MTU_REQ:
+		if (!channel->le) {
+			status = ATT_ECODE_REQ_NOT_SUPP;
+			goto done;
+		}
+
 		length = dec_mtu_req(ipdu, len, &mtu);
 		if (length == 0) {
 			status = ATT_ECODE_INVALID_PDU;
@@ -913,6 +924,7 @@ static void connect_event(GIOChannel *io, GError *err, void *user_data)
 			BT_IO_OPT_SOURCE_BDADDR, &channel->src,
 			BT_IO_OPT_DEST_BDADDR, &channel->dst,
 			BT_IO_OPT_CID, &cid,
+			BT_IO_OPT_OMTU, &channel->mtu,
 			BT_IO_OPT_INVALID);
 	if (gerr) {
 		error("bt_io_get: %s", gerr->message);
@@ -922,10 +934,13 @@ static void connect_event(GIOChannel *io, GError *err, void *user_data)
 		return;
 	}
 
+	if (channel->mtu > ATT_MAX_MTU)
+		channel->mtu = ATT_MAX_MTU;
+
 	if (cid != GATT_CID)
-		channel->mtu = ATT_DEFAULT_L2CAP_MTU;
+		channel->le = FALSE;
 	else
-		channel->mtu = ATT_DEFAULT_LE_MTU;
+		channel->le = TRUE;
 
 	channel->attrib = g_attrib_new(io);
 	g_io_channel_unref(io);
-- 
1.7.0.4

