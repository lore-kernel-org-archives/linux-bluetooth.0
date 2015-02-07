Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/5] android/gatt: Exchange MTU only on LE link
Date: Sat,  7 Feb 2015 16:18:15 +0100
Message-Id: <1423322298-6502-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1423322298-6502-1-git-send-email-szymon.janc@tieto.com>
References: <1423322298-6502-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As per Core Specification Vol 3. Part G. 4.3.1 ATT MTU exchange
procedure shall not be used on BR/EDR link.
---
 android/gatt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index f754f30..49fff6f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1550,7 +1550,10 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 	/* Send exchange mtu request as we assume being client and server */
 	/* TODO: Dont exchange mtu if no client apps */
-	send_exchange_mtu_request(dev);
+
+	/* MTU exchange shall not be used on BR/EDR - Vol 3. Part G. 4.3.1 */
+	if (cid == ATT_CID)
+		send_exchange_mtu_request(dev);
 
 	/*
 	 * Service Changed Characteristic and CCC Descriptor handles
@@ -6120,7 +6123,7 @@ static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
 static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
 							struct gatt_device *dev)
 {
-	uint16_t mtu, imtu, omtu;
+	uint16_t mtu, imtu, omtu, cid;
 	size_t length;
 	GIOChannel *io;
 	GError *gerr = NULL;
@@ -6139,6 +6142,7 @@ static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
 	io = g_attrib_get_channel(dev->attrib);
 
 	bt_io_get(io, &gerr,
+			BT_IO_OPT_CID, &cid,
 			BT_IO_OPT_IMTU, &imtu,
 			BT_IO_OPT_OMTU, &omtu,
 			BT_IO_OPT_INVALID);
@@ -6148,6 +6152,10 @@ static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
 		return ATT_ECODE_UNLIKELY;
 	}
 
+	/* MTU exchange shall not be used on BR/EDR - Vol 3. Part G. 4.3.1 */
+	if (cid != ATT_CID)
+		return ATT_ECODE_UNLIKELY;
+
 	rsp = g_attrib_get_buffer(dev->attrib, &length);
 
 	/* Respond with our IMTU */
-- 
1.9.3

