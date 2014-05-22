Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv5 4/4] android/gatt: Use default mtu on mtu exchange response
Date: Thu, 22 May 2014 12:54:33 +0200
Message-Id: <1400756073-16330-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1400756073-16330-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1400756073-16330-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should be setting new mtu after sending response using old mtu. This
also moves sending the response from att_handler to mtu_att_handle.
---
 android/gatt.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 4a9fd56..d42fd0b 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4554,14 +4554,14 @@ static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
 }
 
 static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
-					uint8_t *rsp, size_t rsp_size,
-					struct gatt_device *dev,
-					uint16_t *length)
+							struct gatt_device *dev)
 {
-	uint16_t mtu, imtu, omtu;
+	uint16_t mtu, imtu;
+	size_t omtu;
 	GIOChannel *io;
 	GError *gerr = NULL;
 	uint16_t len;
+	uint8_t *rsp;
 
 	DBG("");
 
@@ -4576,7 +4576,6 @@ static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
 
 	bt_io_get(io, &gerr,
 			BT_IO_OPT_IMTU, &imtu,
-			BT_IO_OPT_OMTU, &omtu,
 			BT_IO_OPT_INVALID);
 	if (gerr) {
 		error("bt_io_get: %s", gerr->message);
@@ -4584,16 +4583,18 @@ static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
 		return ATT_ECODE_UNLIKELY;
 	}
 
-	/* Limit OMTU to received value */
-	mtu = MIN(mtu, omtu);
-	g_attrib_set_mtu(dev->attrib, mtu);
+	rsp = g_attrib_get_buffer(dev->attrib, &omtu);
 
 	/* Respond with our IMTU */
-	len = enc_mtu_resp(imtu, rsp, rsp_size);
+	len = enc_mtu_resp(imtu, rsp, omtu);
 	if (!len)
 		return ATT_ECODE_UNLIKELY;
 
-	*length = len;
+	g_attrib_send(dev->attrib, 0, rsp, len, NULL, NULL, NULL);
+
+	/* Limit OMTU to received value */
+	mtu = MIN(mtu, omtu);
+	g_attrib_set_mtu(dev->attrib, mtu);
 
 	return 0;
 }
@@ -4806,8 +4807,7 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 		status = read_request(ipdu, len, dev);
 		break;
 	case ATT_OP_MTU_REQ:
-		status = mtu_att_handle(ipdu, len, opdu, length, dev,
-								&resp_length);
+		status = mtu_att_handle(ipdu, len, dev);
 		break;
 	case ATT_OP_FIND_INFO_REQ:
 		status = find_info_handle(ipdu, len, opdu, length,
-- 
1.9.3

