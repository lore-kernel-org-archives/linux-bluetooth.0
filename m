Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 4/4] android/hidhost: Start encryption for HOG when bonded
Date: Thu, 19 Jun 2014 00:41:26 +0200
Message-Id: <1403131286-15028-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1403131286-15028-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1403131286-15028-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HOG requires encryption on connection, so make sure it is on.

On the other hand we don't need medium security always when
connecting LE device even device are bonded. It depends on permissions
on characteristics. That's why we want security low in connect_le()
---
 android/gatt.c    | 6 +-----
 android/hidhost.c | 4 ++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 9471eaf..746316d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1419,7 +1419,6 @@ reply:
 
 static int connect_le(struct gatt_device *dev)
 {
-	BtIOSecLevel sec_level;
 	GIOChannel *io;
 	GError *gerr = NULL;
 	char addr[18];
@@ -1434,9 +1433,6 @@ static int connect_le(struct gatt_device *dev)
 
 	DBG("Connection attempt to: %s", addr);
 
-	sec_level = bt_device_is_bonded(&dev->bdaddr) ? BT_IO_SEC_MEDIUM :
-								BT_IO_SEC_LOW;
-
 	/*
 	 * This connection will help us catch any PDUs that comes before
 	 * pairing finishes
@@ -1448,7 +1444,7 @@ static int connect_le(struct gatt_device *dev)
 			BT_IO_OPT_DEST_BDADDR, &dev->bdaddr,
 			BT_IO_OPT_DEST_TYPE, dev->bdaddr_type,
 			BT_IO_OPT_CID, ATT_CID,
-			BT_IO_OPT_SEC_LEVEL, sec_level,
+			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 			BT_IO_OPT_INVALID);
 	if (!io) {
 		error("gatt: Failed bt_io_connect(%s): %s", addr,
diff --git a/android/hidhost.c b/android/hidhost.c
index 846dd57..1f66454 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -777,6 +777,10 @@ static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
 		bt_hid_notify_state(dev, HAL_HIDHOST_STATE_CONNECTING);
 	}
 
+	/* If device is bonded lets enable encryption */
+	if (bt_device_is_bonded(addr))
+		bt_gatt_set_security(addr, BT_SECURITY_MEDIUM);
+
 	if (!dev->hog) {
 		/* TODO: Get device details and primary */
 		dev->hog = bt_hog_new("bluez-input-device", dev->vendor,
-- 
1.8.4

