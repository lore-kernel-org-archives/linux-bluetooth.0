Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/5] android/gatt: Add helper for getting local MTU
Date: Sat,  7 Feb 2015 16:18:17 +0100
Message-Id: <1423322298-6502-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1423322298-6502-1-git-send-email-szymon.janc@tieto.com>
References: <1423322298-6502-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This helper makes code easier to follow. Also local MTU is now
MIN(IMTU,OMTU) to avoid situation that where local OMTU is
lower than negotiated MTU.
---
 android/gatt.c | 97 ++++++++++++++++++++++++++++------------------------------
 1 file changed, 46 insertions(+), 51 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 45d70fd..d5f3d7d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -954,15 +954,38 @@ static gboolean disconnected_cb(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
+static bool get_local_mtu(struct gatt_device *dev, uint16_t *mtu)
+{
+	GIOChannel *io;
+	uint16_t imtu, omtu;
+
+	io = g_attrib_get_channel(dev->attrib);
+
+	if (!bt_io_get(io, NULL, BT_IO_OPT_IMTU, &imtu, BT_IO_OPT_OMTU, &omtu,
+							BT_IO_OPT_INVALID)) {
+		error("gatt: Failed to get local MTU");
+		return false;
+	}
+
+	/*
+	 * Limit MTU to  MIN(IMTU, OMTU). This is to avoid situation where
+	 * local OMTU < MIN(remote MTU, IMTU)
+	 */
+	if (mtu)
+		*mtu = MIN(imtu, omtu);
+
+	DBG("mtu %u", *mtu);
+
+	return true;
+}
+
 static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data);
 
 static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
 	struct gatt_device *device = user_data;
-	GIOChannel *io;
-	GError *gerr = NULL;
-	uint16_t rmtu, mtu, imtu;
+	uint16_t rmtu, lmtu, mtu;
 
 	if (status) {
 		error("gatt: MTU exchange: %s", att_ecode2str(status));
@@ -975,28 +998,22 @@ static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	}
 
 	if (rmtu < ATT_DEFAULT_LE_MTU) {
-		error("gatt: MTU exchange: mtu error");
+		error("gatt: MTU exchange: remote MTU invalid (%u)", rmtu);
 		goto failed;
 	}
 
-	io = g_attrib_get_channel(device->attrib);
+	if (!get_local_mtu(device, &lmtu))
+		goto failed;
 
-	bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &imtu, BT_IO_OPT_INVALID);
-	if (gerr) {
-		error("gatt: Could not get imtu: %s", gerr->message);
-		g_error_free(gerr);
+	mtu = MIN(lmtu, rmtu);
 
-		return;
-	}
-
-	mtu = MIN(rmtu, imtu);
-	if (mtu != imtu && !g_attrib_set_mtu(device->attrib, mtu)) {
+	if (mtu != ATT_DEFAULT_LE_MTU &&
+				!g_attrib_set_mtu(device->attrib, mtu)) {
 		error("gatt: MTU exchange failed");
 		goto failed;
 	}
 
-	DBG("MTU exchange succeeded: rmtu:%d, old mtu:%d, new mtu:%d", rmtu,
-								imtu, mtu);
+	DBG("MTU exchange succeeded: remote mtu:%d local mtu:%d", rmtu, lmtu);
 
 failed:
 	device_unref(device);
@@ -1004,21 +1021,12 @@ failed:
 
 static void send_exchange_mtu_request(struct gatt_device *device)
 {
-	GIOChannel *io;
-	GError *gerr = NULL;
-	uint16_t imtu;
-
-	io = g_attrib_get_channel(device->attrib);
-
-	bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &imtu, BT_IO_OPT_INVALID);
-	if (gerr) {
-		error("gatt: Could not get imtu: %s", gerr->message);
-		g_error_free(gerr);
+	uint16_t mtu;
 
+	if (!get_local_mtu(device, &mtu))
 		return;
-	}
 
-	if (!gatt_exchange_mtu(device->attrib, imtu, exchange_mtu_cb,
+	if (!gatt_exchange_mtu(device->attrib, mtu, exchange_mtu_cb,
 							device_ref(device)))
 		device_unref(device);
 }
@@ -6131,50 +6139,37 @@ static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
 static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
 							struct gatt_device *dev)
 {
-	uint16_t mtu, imtu, omtu, cid;
+	uint16_t rmtu, mtu, len;
 	size_t length;
-	GIOChannel *io;
-	GError *gerr = NULL;
-	uint16_t len;
 	uint8_t *rsp;
 
 	DBG("");
 
-	len = dec_mtu_req(cmd, cmd_len, &mtu);
+	len = dec_mtu_req(cmd, cmd_len, &rmtu);
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
-	if (mtu < ATT_DEFAULT_LE_MTU)
+	if (rmtu < ATT_DEFAULT_LE_MTU)
 		return ATT_ECODE_REQ_NOT_SUPP;
 
-	io = g_attrib_get_channel(dev->attrib);
-
-	bt_io_get(io, &gerr,
-			BT_IO_OPT_CID, &cid,
-			BT_IO_OPT_IMTU, &imtu,
-			BT_IO_OPT_OMTU, &omtu,
-			BT_IO_OPT_INVALID);
-	if (gerr) {
-		error("bt_io_get: %s", gerr->message);
-		g_error_free(gerr);
+	/* MTU exchange shall not be used on BR/EDR - Vol 3. Part G. 4.3.1 */
+	if (get_cid(dev) != ATT_CID)
 		return ATT_ECODE_UNLIKELY;
-	}
 
-	/* MTU exchange shall not be used on BR/EDR - Vol 3. Part G. 4.3.1 */
-	if (cid != ATT_CID)
+	if (!get_local_mtu(dev, &mtu))
 		return ATT_ECODE_UNLIKELY;
 
 	rsp = g_attrib_get_buffer(dev->attrib, &length);
 
-	/* Respond with our IMTU */
-	len = enc_mtu_resp(imtu, rsp, length);
+	/* Respond with our MTU */
+	len = enc_mtu_resp(mtu, rsp, length);
 	if (!len)
 		return ATT_ECODE_UNLIKELY;
 
 	g_attrib_send(dev->attrib, 0, rsp, len, NULL, NULL, NULL);
 
-	/* Limit OMTU to received value */
-	mtu = MIN(mtu, omtu);
+	/* Limit MTU to received value */
+	mtu = MIN(mtu, rmtu);
 	g_attrib_set_mtu(dev->attrib, mtu);
 
 	return 0;
-- 
1.9.3

