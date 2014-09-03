Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 2/6] android/gatt: Unsubscribe from autoconnect on unregister
Date: Wed,  3 Sep 2014 16:42:29 +0200
Message-Id: <1409755353-6027-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409755353-6027-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409755353-6027-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When application does unregister, lets make sure that BfA does not keep
any auto connect devices for this app.
---
 android/gatt.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index a3486ca..645f5f2 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1865,10 +1865,31 @@ static bool trigger_connection(struct app_connection *connection)
 	return ret;
 }
 
+static void clear_autoconnect_devices(void *data, void *user_data)
+{
+	struct gatt_device *dev = data;
+
+	if (queue_remove(dev->autoconnect_apps, user_data))
+		if (queue_isempty(dev->autoconnect_apps)) {
+			bt_auto_connect_remove(&dev->bdaddr);
+
+			if (dev->state == DEVICE_CONNECT_INIT)
+				device_set_state(dev, DEVICE_DISCONNECTED);
+
+			device_unref(dev);
+		}
+}
+
 static uint8_t unregister_app(int client_if)
 {
 	struct gatt_app *cl;
 
+	/*
+	 * Make sure that there is no devices in auto connect list for this
+	 * application
+	 */
+	queue_foreach(gatt_devices, clear_autoconnect_devices, INT_TO_PTR(client_if));
+
 	cl = queue_remove_if(gatt_apps, match_app_by_id, INT_TO_PTR(client_if));
 	if (!cl) {
 		error("gatt: client_if=%d not found", client_if);
-- 
1.8.4

