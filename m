Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 5/8] core: gatt: Send not/ind to devices
Date: Wed, 18 Feb 2015 00:18:36 -0800
Message-Id: <1424247519-21684-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1424247519-21684-1-git-send-email-armansito@chromium.org>
References: <1424247519-21684-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds code that sends out characteristic value
notification/indication PDUs by obtaining the bt_gatt_server
from each device that has the associated CCC configured.
---
 src/gatt-database.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 1a77e6b..710f277 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -496,6 +496,11 @@ struct not_data {
 	bool indicate;
 };
 
+static void conf_cb(void *user_data)
+{
+	DBG("GATT server received confirmation");
+}
+
 static void send_notification_to_device(void *data, void *user_data)
 {
 	struct device_state *device_state = data;
@@ -517,8 +522,24 @@ static void send_notification_to_device(void *data, void *user_data)
 		return;
 
 	/*
-	 * TODO: Notify device via bt_gatt_server
+	 * TODO: If the device is not connected but bonded, send the
+	 * notification/indication when it becomes connected.
 	 */
+	if (!not_data->indicate) {
+		DBG("GATT server sending notification");
+		bt_gatt_server_send_notification(
+					btd_device_get_gatt_server(device),
+					not_data->handle, not_data->value,
+					not_data->len);
+		return;
+	}
+
+	DBG("GATT server sending indication");
+	bt_gatt_server_send_indication(btd_device_get_gatt_server(device),
+							not_data->handle,
+							not_data->value,
+							not_data->len, conf_cb,
+							NULL, NULL);
 }
 
 static void send_notification_to_devices(struct btd_gatt_database *database,
-- 
2.2.0.rc0.207.ga3a616c

