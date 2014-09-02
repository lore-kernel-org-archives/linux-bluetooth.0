Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 08/16] android/gatt: Unsubscribe from autoconnect on unregister
Date: Tue,  2 Sep 2014 12:09:53 +0200
Message-Id: <1409652601-28689-9-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When application does unregister, lets make sure that BfA does not keep
any auto connect devices for this app.
---
 android/gatt.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 0d0b56d..348a2a2 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -370,6 +370,13 @@ static bool match_device_by_state(const void *data, const void *user_data)
 	return true;
 }
 
+static bool match_device_by_ac_id(const void *data, const void *user_data)
+{
+	const struct gatt_device *dev = data;
+
+	return queue_find(dev->autoconnect_apps, match_by_value, user_data);
+}
+
 static bool match_pending_device(const void *data, const void *user_data)
 {
 	const struct gatt_device *dev = data;
@@ -442,6 +449,11 @@ static struct gatt_device *find_device_by_state(uint32_t state)
 							UINT_TO_PTR(state));
 }
 
+static struct gatt_device *find_device_by_autoconnect_app_id(uint32_t id)
+{
+	return queue_find(gatt_devices, match_device_by_ac_id,
+							UINT_TO_PTR(id));
+}
 static bool match_srvc_by_element_id(const void *data, const void *user_data)
 {
 	const struct element_id *exp_id = user_data;
@@ -1825,10 +1837,40 @@ static bool trigger_connection(struct app_connection *connection)
 	return ret;
 }
 
+static void clear_autoconnect_devices(int app_id)
+{
+	struct gatt_device *dev;
+
+	/*
+	 * Check if application was registered for any devices to
+	 * reconnect
+	 */
+	dev = find_device_by_autoconnect_app_id(app_id);
+	while (dev) {
+		queue_remove(dev->autoconnect_apps, INT_TO_PTR(app_id));
+
+		if (queue_isempty(dev->autoconnect_apps)) {
+			bt_auto_connect_remove(&dev->bdaddr);
+			device_unref(dev);
+
+			if (dev->state == DEVICE_CONNECT_INIT)
+				device_set_state(dev, DEVICE_DISCONNECTED);
+		}
+
+		dev = find_device_by_autoconnect_app_id(app_id);
+	};
+}
+
 static uint8_t unregister_app(int client_if)
 {
 	struct gatt_app *cl;
 
+	/*
+	 * Make sure that there is no devices in auto connect list for this
+	 * application
+	 */
+	clear_autoconnect_devices(client_if);
+
 	cl = queue_remove_if(gatt_apps, match_app_by_id, INT_TO_PTR(client_if));
 	if (!cl) {
 		error("gatt: client_if=%d not found", client_if);
-- 
1.8.4

