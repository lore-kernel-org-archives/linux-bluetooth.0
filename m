Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/gatt: Set attrib MTU correctly
Date: Wed,  4 Jun 2014 14:54:08 +0200
Message-Id: <1401886448-28463-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should set g_attrib mtu with MIN of two values: Remote Rx MTU
and local Tx MTU. In previous solution once we set g_attrib mtu, we
could only reduce MTU (because we took previously set g_attrib MTU
and Remote Rx MTU). It affected cases when remote wanted to increase
MTU.
---
 android/gatt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 429181f..5bf7694 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4857,8 +4857,8 @@ static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
 static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
 							struct gatt_device *dev)
 {
-	uint16_t mtu, imtu;
-	size_t omtu;
+	uint16_t mtu, imtu, omtu;
+	size_t length;
 	GIOChannel *io;
 	GError *gerr = NULL;
 	uint16_t len;
@@ -4877,6 +4877,7 @@ static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
 
 	bt_io_get(io, &gerr,
 			BT_IO_OPT_IMTU, &imtu,
+			BT_IO_OPT_OMTU, &omtu,
 			BT_IO_OPT_INVALID);
 	if (gerr) {
 		error("bt_io_get: %s", gerr->message);
@@ -4884,10 +4885,10 @@ static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
 		return ATT_ECODE_UNLIKELY;
 	}
 
-	rsp = g_attrib_get_buffer(dev->attrib, &omtu);
+	rsp = g_attrib_get_buffer(dev->attrib, &length);
 
 	/* Respond with our IMTU */
-	len = enc_mtu_resp(imtu, rsp, omtu);
+	len = enc_mtu_resp(imtu, rsp, length);
 	if (!len)
 		return ATT_ECODE_UNLIKELY;
 
-- 
1.9.0

