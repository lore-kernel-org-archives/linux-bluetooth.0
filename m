Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/5] android/gatt: Add helper for updating MTU
Date: Sat,  7 Feb 2015 16:18:18 +0100
Message-Id: <1423322298-6502-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1423322298-6502-1-git-send-email-szymon.janc@tieto.com>
References: <1423322298-6502-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes code cleaner and also put all the MTU checks in single
function.
---
 android/gatt.c | 59 +++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index d5f3d7d..a36922c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -979,13 +979,42 @@ static bool get_local_mtu(struct gatt_device *dev, uint16_t *mtu)
 	return true;
 }
 
+static bool update_mtu(struct gatt_device *device, uint16_t rmtu)
+{
+	uint16_t mtu, lmtu;
+
+	DBG("%u", rmtu);
+
+	if (rmtu < ATT_DEFAULT_LE_MTU) {
+		error("gatt: remote MTU invalid (%u bytes)", rmtu);
+		return false;
+	}
+
+	if (!get_local_mtu(device, &lmtu))
+		return false;
+
+	mtu = MIN(lmtu, rmtu);
+
+	if (mtu == ATT_DEFAULT_LE_MTU)
+		return true;
+
+	if (!g_attrib_set_mtu(device->attrib, mtu)) {
+		error("gatt: Failed to set MTU");
+		return false;
+	}
+
+	DBG("remote_mtu:%d local_mtu:%d", rmtu, lmtu);
+
+	return true;
+}
+
 static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data);
 
 static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
 	struct gatt_device *device = user_data;
-	uint16_t rmtu, lmtu, mtu;
+	uint16_t rmtu;
 
 	if (status) {
 		error("gatt: MTU exchange: %s", att_ecode2str(status));
@@ -997,23 +1026,7 @@ static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		goto failed;
 	}
 
-	if (rmtu < ATT_DEFAULT_LE_MTU) {
-		error("gatt: MTU exchange: remote MTU invalid (%u)", rmtu);
-		goto failed;
-	}
-
-	if (!get_local_mtu(device, &lmtu))
-		goto failed;
-
-	mtu = MIN(lmtu, rmtu);
-
-	if (mtu != ATT_DEFAULT_LE_MTU &&
-				!g_attrib_set_mtu(device->attrib, mtu)) {
-		error("gatt: MTU exchange failed");
-		goto failed;
-	}
-
-	DBG("MTU exchange succeeded: remote mtu:%d local mtu:%d", rmtu, lmtu);
+	update_mtu(device, rmtu);
 
 failed:
 	device_unref(device);
@@ -6149,9 +6162,6 @@ static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
-	if (rmtu < ATT_DEFAULT_LE_MTU)
-		return ATT_ECODE_REQ_NOT_SUPP;
-
 	/* MTU exchange shall not be used on BR/EDR - Vol 3. Part G. 4.3.1 */
 	if (get_cid(dev) != ATT_CID)
 		return ATT_ECODE_UNLIKELY;
@@ -6166,11 +6176,10 @@ static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return ATT_ECODE_UNLIKELY;
 
-	g_attrib_send(dev->attrib, 0, rsp, len, NULL, NULL, NULL);
+	if (!update_mtu(dev, rmtu))
+		return ATT_ECODE_UNLIKELY;
 
-	/* Limit MTU to received value */
-	mtu = MIN(mtu, rmtu);
-	g_attrib_set_mtu(dev->attrib, mtu);
+	g_attrib_send(dev->attrib, 0, rsp, len, NULL, NULL, NULL);
 
 	return 0;
 }
-- 
1.9.3

