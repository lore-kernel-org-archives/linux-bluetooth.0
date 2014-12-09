Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 06/25] android/gatt: Add paired cb to gatt.c
Date: Tue,  9 Dec 2014 16:11:28 +0100
Message-Id: <1418137907-16981-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be required in order to register for Service Changed on remote
device
---
 android/gatt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 9c2260c..4c16ce6 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6957,6 +6957,24 @@ static bool start_listening(void)
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
@@ -6980,6 +6998,11 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
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
@@ -7029,6 +7052,10 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
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

