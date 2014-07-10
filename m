Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 3/5] android/gatt: Choose LE or BR/EDR based on last seen bearer
Date: Thu, 10 Jul 2014 16:30:34 +0200
Message-Id: <1405002636-10737-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1405002636-10737-1-git-send-email-szymon.janc@tieto.com>
References: <1405002636-10737-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to connect both over LE and BR/EDR bearer.
---
 android/gatt.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index e07226c..6f04439 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1702,6 +1702,49 @@ static void app_disconnect_devices(struct gatt_app *client)
 	}
 }
 
+static int connect_bredr(struct gatt_device *dev)
+{
+	BtIOSecLevel sec_level;
+	GIOChannel *io;
+	GError *gerr = NULL;
+	char addr[18];
+
+	ba2str(&dev->bdaddr, addr);
+
+	/* There is one connection attempt going on */
+	if (dev->att_io) {
+		info("gatt: connection to dev %s is ongoing", addr);
+		return -EALREADY;
+	}
+
+	DBG("Connection attempt to: %s", addr);
+
+	sec_level = bt_device_is_bonded(&dev->bdaddr) ? BT_IO_SEC_MEDIUM :
+								BT_IO_SEC_LOW;
+
+	io = bt_io_connect(connect_cb, device_ref(dev), NULL, &gerr,
+			BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+			BT_IO_OPT_SOURCE_TYPE, BDADDR_BREDR,
+			BT_IO_OPT_DEST_BDADDR, &dev->bdaddr,
+			BT_IO_OPT_DEST_TYPE, BDADDR_BREDR,
+			BT_IO_OPT_PSM, ATT_PSM,
+			BT_IO_OPT_SEC_LEVEL, sec_level,
+			BT_IO_OPT_INVALID);
+	if (!io) {
+		error("gatt: Failed bt_io_connect(%s): %s", addr,
+							gerr->message);
+		g_error_free(gerr);
+		return -EIO;
+	}
+
+	device_set_state(dev, DEVICE_CONNECT_READY);
+
+	/* Keep this, so we can cancel the connection */
+	dev->att_io = io;
+
+	return 0;
+}
+
 static bool trigger_connection(struct app_connection *connection)
 {
 	switch (connection->device->state) {
@@ -1715,6 +1758,11 @@ static bool trigger_connection(struct app_connection *connection)
 		break;
 	}
 
+	/* If device was last seen over BR/EDR connect over it */
+	if (bt_device_last_seen_bearer(&connection->device->bdaddr) ==
+								BDADDR_BREDR)
+		return connect_bredr(connection->device) == 0;
+
 	/* after state change trigger discovering */
 	if (!scanning && (connection->device->state == DEVICE_CONNECT_INIT))
 		if (!bt_le_discovery_start()) {
-- 
1.9.1

