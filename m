Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 3/3] android/gatt: Add remove bond handling
Date: Thu, 28 Aug 2014 10:37:22 +0200
Message-Id: <1409215042-11313-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409215042-11313-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409215042-11313-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch GATT is aware about unpaired devices so the local cache
can be cleared
---
 android/gatt.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 89748d2..b3c9c5c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6496,10 +6496,34 @@ static bool start_listening(void)
 	return true;
 }
 
+static void gatt_unpaired_cb(const bdaddr_t *addr, uint8_t type)
+{
+	struct gatt_device *dev;
+	char address[18];
+
+	dev = find_device_by_addr(addr);
+	if (!dev)
+		return;
+
+	if (dev->bdaddr_type != type)
+		return;
+
+	ba2str(addr, address);
+	DBG("Unpaired device %s", address);
+
+	queue_remove(gatt_devices, dev);
+	destroy_device(dev);
+}
+
 bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 {
 	DBG("");
 
+	if (!bt_unpaired_register(gatt_unpaired_cb)) {
+		error("gatt: Could not register unpaired callback");
+		return false;
+	}
+
 	if (!start_listening())
 		return false;
 
-- 
1.8.4

