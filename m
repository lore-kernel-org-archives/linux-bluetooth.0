Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Subject: [PATCH v4 29/38] android/gatt: Add MTU request cmd handling
Date: Wed, 30 Apr 2014 11:14:00 +0200
Message-Id: <1398849249-5868-30-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>

The Exchange MTU Request is used by the client to inform the server of
client's maximum receive MTU size and request the server to respond with
its maximum receive MTU size.
---
 android/gatt.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 2177c968..962c71c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -138,6 +138,8 @@ struct gatt_device {
 	guint watch_id;
 	guint server_id;
 
+	guint mtu_size;
+
 	int ref;
 	int conn_cnt;
 };
@@ -3764,6 +3766,47 @@ static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
 	return 0;
 }
 
+static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
+					uint8_t *rsp, size_t rsp_size,
+					struct gatt_device *dev,
+					uint16_t *length)
+{
+	uint16_t mtu, imtu;
+	GIOChannel *io;
+	GError *gerr = NULL;
+	uint16_t len;
+
+	DBG("");
+
+	len = dec_mtu_req(cmd, cmd_len, &mtu);
+	if (!len)
+		return ATT_ECODE_INVALID_PDU;
+
+	if (mtu < ATT_DEFAULT_LE_MTU)
+		return ATT_ECODE_REQ_NOT_SUPP;
+
+	io = g_attrib_get_channel(dev->attrib);
+
+	bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &imtu, BT_IO_OPT_INVALID);
+
+	if (gerr) {
+		error("bt_io_get: %s", gerr->message);
+		g_error_free(gerr);
+		return ATT_ECODE_UNLIKELY;
+	}
+
+	dev->mtu_size = MIN(mtu, imtu);
+	g_attrib_set_mtu(dev->attrib, dev->mtu_size);
+
+	len = enc_mtu_resp(imtu, rsp, rsp_size);
+	if (!len)
+		return ATT_ECODE_UNLIKELY;
+
+	*length = len;
+
+	return 0;
+}
+
 static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -3797,6 +3840,9 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 			return;
 		break;
 	case ATT_OP_MTU_REQ:
+		status = mtu_att_handle(ipdu, len, opdu, sizeof(opdu), dev,
+								&length);
+		break;
 	case ATT_OP_FIND_INFO_REQ:
 	case ATT_OP_WRITE_REQ:
 	case ATT_OP_WRITE_CMD:
-- 
1.8.4

