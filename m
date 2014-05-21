Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 1/2] android/gatt: Send Exchange MTU request on connect
Date: Wed, 21 May 2014 12:18:57 +0200
Message-Id: <1400667538-14306-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds sending exchange MTU request on connection. This is send only
if no previous negotiaion was done (as client or server).

This is needed to pass TC_GAC_CL_BV_01_C.
---
 android/gatt.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 89da60d..55ffed5 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -144,6 +144,7 @@ struct gatt_device {
 
 	gatt_device_state_t state;
 
+	size_t negotiated_mtu;
 	GAttrib *attrib;
 	GIOChannel *att_io;
 	struct queue *services;
@@ -979,6 +980,86 @@ static void send_app_connect_notifications(void *data, void *user_data)
 
 static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data);
 
+static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct gatt_device *device = user_data;
+	GError *gerr = NULL;
+	uint16_t cid, imtu, rmtu, mtu;
+	GIOChannel *io;
+
+	if (status) {
+		error("gatt: MTU exchange: %s", att_ecode2str(status));
+		goto failed;
+	}
+
+	if (!dec_mtu_resp(pdu, plen, &rmtu)) {
+		error("gatt: MTU exchange: protocol error");
+		goto failed;
+	}
+
+	if (rmtu < ATT_DEFAULT_LE_MTU) {
+		error("gatt: MTU exchange: mtu error");
+		goto failed;
+	}
+
+	io = g_attrib_get_channel(device->attrib);
+
+	bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &imtu,
+				BT_IO_OPT_CID, &cid,
+				BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("gatt: Failed to acquire imtu and cid: %s",
+								gerr->message);
+		g_error_free(gerr);
+
+		goto failed;
+	}
+
+	if (cid != ATT_CID)
+		goto failed;
+
+	mtu = MIN(rmtu, imtu);
+	if (mtu != imtu && !g_attrib_set_mtu(device->attrib, rmtu)) {
+		error("gatt: MTU exchange failed");
+		goto failed;
+	}
+
+	device->negotiated_mtu = mtu;
+	DBG("MTU exchange succeeded: rmtu:%d, imtu:%d, set mtu: %d", rmtu,
+								imtu, mtu);
+
+failed:
+	device_unref(device);
+}
+
+static void send_exchange_mtu_request(struct gatt_device *device)
+{
+	GError *gerr = NULL;
+	uint16_t cid, imtu;
+	GIOChannel *io;
+
+	io = g_attrib_get_channel(device->attrib);
+
+	bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &imtu,
+				BT_IO_OPT_CID, &cid,
+				BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("gatt: Failed to acquire imtu and cid: %s",
+								gerr->message);
+		g_error_free(gerr);
+
+		return;
+	}
+
+	if (cid != ATT_CID)
+		return;
+
+	if (!gatt_exchange_mtu(device->attrib, imtu, exchange_mtu_cb,
+							device_ref(device)))
+		device_unref(device);
+}
+
 static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -1012,6 +1093,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		goto reply;
 	}
 
+	device->negotiated_mtu = 0;
 	dev->attrib = attrib;
 	dev->watch_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 							disconnected_cb, dev);
@@ -1026,6 +1108,10 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 	status = GATT_SUCCESS;
 
+	/* If mtu not negotiated yet - exchange mtu */
+	if (!dev->negotiated_mtu)
+		send_exchange_mtu_request(dev);
+
 reply:
 	data.dev = dev;
 	data.status = status;
@@ -4513,8 +4599,8 @@ static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
 	}
 
 	/* Limit OMTU to received value */
-	mtu = MIN(mtu, omtu);
-	g_attrib_set_mtu(dev->attrib, mtu);
+	dev->negotiated_mtu = MIN(mtu, omtu);
+	g_attrib_set_mtu(dev->attrib, dev->negotiated_mtu);
 
 	/* Respond with our IMTU */
 	len = enc_mtu_resp(imtu, rsp, rsp_size);
-- 
1.9.3

