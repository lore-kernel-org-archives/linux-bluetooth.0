Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v4 06/10] core: device: Add getters for GATT db and client
Date: Tue, 16 Dec 2014 18:07:14 -0800
Message-Id: <1418782038-10999-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1418782038-10999-1-git-send-email-armansito@chromium.org>
References: <1418782038-10999-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds btd_device_get_gatt_db and btd_device_get_gatt_client
functions.
---
 src/device.c | 16 ++++++++++++++++
 src/device.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/src/device.c b/src/device.c
index 64591d0..854d9f3 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4844,6 +4844,22 @@ GSList *btd_device_get_primaries(struct btd_device *device)
 	return device->primaries;
 }
 
+struct gatt_db *btd_device_get_gatt_db(struct btd_device *device)
+{
+	if (!device)
+		return NULL;
+
+	return device->db;
+}
+
+struct bt_gatt_client *btd_device_get_gatt_client(struct btd_device *device)
+{
+	if (!device)
+		return NULL;
+
+	return device->client;
+}
+
 void btd_device_gatt_set_service_changed(struct btd_device *device,
 						uint16_t start, uint16_t end)
 {
diff --git a/src/device.h b/src/device.h
index 487bd27..a7fefee 100644
--- a/src/device.h
+++ b/src/device.h
@@ -67,6 +67,8 @@ const sdp_record_t *btd_device_get_record(struct btd_device *device,
 struct gatt_primary *btd_device_get_primary(struct btd_device *device,
 							const char *uuid);
 GSList *btd_device_get_primaries(struct btd_device *device);
+struct gatt_db *btd_device_get_gatt_db(struct btd_device *device);
+struct bt_gatt_client *btd_device_get_gatt_client(struct btd_device *device);
 void btd_device_gatt_set_service_changed(struct btd_device *device,
 						uint16_t start, uint16_t end);
 bool device_attach_att(struct btd_device *dev, GIOChannel *io);
-- 
2.2.0.rc0.207.ga3a616c

