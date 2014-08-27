Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/3] android/gatt: Add remove bond handling
Date: Wed, 27 Aug 2014 22:47:44 +0200
Message-Id: <1409172464-30369-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409172464-30369-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409172464-30369-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch GATT is aware about unpaired devices so the local cache
can be cleared
---
 android/gatt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 89748d2..9dcac0b 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6496,6 +6496,22 @@ static bool start_listening(void)
 	return true;
 }
 
+static void gatt_unpaired_cb(const bdaddr_t *addr)
+{
+	struct gatt_device *dev;
+	char address[18];
+
+	dev = find_device_by_addr(addr);
+	if (!dev)
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
@@ -6541,6 +6557,8 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	info("gatt: LE: %s BR/EDR: %s", le_io ? "enabled" : "disabled",
 					bredr_io ? "enabled" : "disabled");
 
+	bt_unpaired_register(gatt_unpaired_cb);
+
 	return true;
 
 failed:
-- 
1.8.4

