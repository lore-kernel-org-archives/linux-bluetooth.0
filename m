Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/4] android/gatt: Use proper identity address for auto connect
Date: Thu,  6 Nov 2014 10:30:38 +0100
Message-Id: <1415266238-12423-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1415266238-12423-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1415266238-12423-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should behave the same as whe nwe connect using active scan.
---
 android/gatt.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 47dadc2..8cc7536 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -583,8 +583,24 @@ static void device_set_state(struct gatt_device *dev, uint32_t state)
 static bool auto_connect_le(struct gatt_device *dev)
 {
 	/*  For LE devices use auto connect feature if possible */
-	if (bt_kernel_conn_control())
-		return  bt_auto_connect_add(&dev->bdaddr);
+	if (bt_kernel_conn_control()) {
+		const bdaddr_t *bdaddr;
+
+		/*
+		 * If address type is random it might be that IRK was received
+		 * and random is just for faking Android Framework. ID address
+		 * should be used for connection if present.
+		 */
+		if (dev->bdaddr_type == BDADDR_LE_RANDOM) {
+			bdaddr = bt_get_id_addr(&dev->bdaddr, NULL);
+			if (!bdaddr)
+				return -EINVAL;
+		} else {
+			bdaddr = &dev->bdaddr;
+		}
+
+		return bt_auto_connect_add(bdaddr);
+	}
 
 	/* Trigger discovery if not already started */
 	if (!scanning) {
-- 
1.9.1

