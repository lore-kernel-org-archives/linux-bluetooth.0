Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 04/19] android/gatt: Add paired cb to gatt.c
Date: Wed, 17 Dec 2014 16:49:02 +0100
Message-Id: <1418831357-23100-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be required in order to register for Service Changed on remote
device
---
 android/gatt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 2aa52b0..c47e948 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -7037,6 +7037,24 @@ static bool start_listening(void)
 	return true;
 }
 
+static void gatt_paired_cb(const bdaddr_t *addr, uint8_t type)
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
+	DBG("Paired device %s", address);
+
+	/* Find Service Changed and register for it.*/
+}
+
 static void gatt_unpaired_cb(const bdaddr_t *addr, uint8_t type)
 {
 	struct gatt_device *dev;
@@ -7060,6 +7078,11 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 {
 	DBG("");
 
+	if (!bt_paired_register(gatt_paired_cb)) {
+		error("gatt: Could not register paired callback");
+		return false;
+	}
+
 	if (!bt_unpaired_register(gatt_unpaired_cb)) {
 		error("gatt: Could not register unpaired callback");
 		return false;
@@ -7109,6 +7132,10 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	return true;
 
 failed:
+
+	bt_paired_unregister(gatt_paired_cb);
+	bt_unpaired_unregister(gatt_unpaired_cb);
+
 	queue_destroy(gatt_apps, NULL);
 	gatt_apps = NULL;
 
-- 
1.8.4

