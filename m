Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 4/8] core: device: Add getter for GATT server
Date: Wed, 18 Feb 2015 00:18:35 -0800
Message-Id: <1424247519-21684-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1424247519-21684-1-git-send-email-armansito@chromium.org>
References: <1424247519-21684-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added btd_device_get_gatt_server function.
---
 src/device.c | 8 ++++++++
 src/device.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/src/device.c b/src/device.c
index 678a6ac..3ce5897 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5268,6 +5268,14 @@ struct bt_gatt_client *btd_device_get_gatt_client(struct btd_device *device)
 	return device->client;
 }
 
+struct bt_gatt_server *btd_device_get_gatt_server(struct btd_device *device)
+{
+	if (!device)
+		return NULL;
+
+	return device->server;
+}
+
 void btd_device_gatt_set_service_changed(struct btd_device *device,
 						uint16_t start, uint16_t end)
 {
diff --git a/src/device.h b/src/device.h
index f250bfa..0387409 100644
--- a/src/device.h
+++ b/src/device.h
@@ -71,6 +71,7 @@ struct gatt_primary *btd_device_get_primary(struct btd_device *device,
 GSList *btd_device_get_primaries(struct btd_device *device);
 struct gatt_db *btd_device_get_gatt_db(struct btd_device *device);
 struct bt_gatt_client *btd_device_get_gatt_client(struct btd_device *device);
+struct bt_gatt_server *btd_device_get_gatt_server(struct btd_device *device);
 void btd_device_gatt_set_service_changed(struct btd_device *device,
 						uint16_t start, uint16_t end);
 bool device_attach_att(struct btd_device *dev, GIOChannel *io);
-- 
2.2.0.rc0.207.ga3a616c

