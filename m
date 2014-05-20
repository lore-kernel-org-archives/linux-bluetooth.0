Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 1/3] android/gatt: Send Exchange MTU request on connect
Date: Tue, 20 May 2014 12:52:42 +0200
Message-Id: <1400583164-23776-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds sending exchange MTU request on connection. If exchange MTU
request is received when negotiating MTU as client, we send default MTU
as described in spec, without setting the MTU. It will be set in
response to our MTU exchange request.

According to spec: "This request shall only be sent once during a
connection by the client." This is needed to pass TC_GAC_CL_BV_01_C.
---
 android/gatt.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 8e0d72a..98a52d2 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -144,6 +144,7 @@ struct gatt_device {
 
 	gatt_device_state_t state;
 
+	size_t negotiated_mtu;
 	GAttrib *attrib;
 	GIOChannel *att_io;
 	struct queue *services;
@@ -978,6 +979,80 @@ static void send_app_connect_notifications(void *data, void *user_data)
 
 static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data);
 
+static size_t get_device_att_mtu(struct gatt_device *device)
+{
+	size_t mtu;
+
+	g_attrib_get_buffer(device->attrib, &mtu);
+
+	return mtu;
+}
+
+static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct gatt_device *device = user_data;
+	GError *gerr = NULL;
+	uint16_t cid, imtu;
+	GIOChannel *io;
+	uint16_t rmtu;
+
+	if (status) {
+		error("gatt: MTU exchange: %s", att_ecode2str(status));
+		device->negotiated_mtu = 0;
+		goto done;
+	}
+
+	if (!dec_mtu_resp(pdu, plen, &rmtu)) {
+		error("gatt: MTU exchange: protocol error");
+		device->negotiated_mtu = 0;
+		goto done;
+	}
+
+	if (rmtu < ATT_DEFAULT_LE_MTU) {
+		error("gatt: MTU exchange: mtu error");
+		device->negotiated_mtu = 0;
+		goto done;
+	}
+
+	io = g_attrib_get_channel(device->attrib);
+
+	if (bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &imtu,	BT_IO_OPT_CID, &cid,
+					BT_IO_OPT_INVALID) && cid == ATT_CID) {
+		device->negotiated_mtu = MIN(rmtu, imtu);
+		if (g_attrib_set_mtu(device->attrib, device->negotiated_mtu)) {
+			DBG("MTU exchange succeeded: %ld",
+							device->negotiated_mtu);
+			goto done;
+		}
+	}
+
+	DBG("gatt: MTU exchange failed");
+	device->negotiated_mtu = 0;
+
+done:
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
+	if (bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &imtu,	BT_IO_OPT_CID, &cid,
+					BT_IO_OPT_INVALID) && cid == ATT_CID) {
+		device->negotiated_mtu = imtu;
+		if (!gatt_exchange_mtu(device->attrib, device->negotiated_mtu,
+					exchange_mtu_cb, device_ref(device))) {
+			device->negotiated_mtu = 0;
+			device_unref(device);
+		}
+	}
+}
+
 static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -1023,6 +1098,8 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 	status = GATT_SUCCESS;
 
+	send_exchange_mtu_request(dev);
+
 reply:
 	data.dev = dev;
 	data.status = status;
@@ -4497,6 +4574,12 @@ static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
 	if (mtu < ATT_DEFAULT_LE_MTU)
 		return ATT_ECODE_REQ_NOT_SUPP;
 
+	/* If mtu negotiation is ongoing, send default MTU (See Spec 3.4.2.2) */
+	if (dev->negotiated_mtu) {
+		imtu = get_device_att_mtu(dev);
+		goto done;
+	}
+
 	io = g_attrib_get_channel(dev->attrib);
 
 	bt_io_get(io, &gerr,
@@ -4513,6 +4596,7 @@ static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
 	mtu = MIN(mtu, omtu);
 	g_attrib_set_mtu(dev->attrib, mtu);
 
+done:
 	/* Respond with our IMTU */
 	len = enc_mtu_resp(imtu, rsp, rsp_size);
 	if (!len)
-- 
1.9.3

