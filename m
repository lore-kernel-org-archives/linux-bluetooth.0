Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v4 14/17] heartrate: Add Reset method
Date: Thu, 13 Sep 2012 14:13:18 +0200
Message-ID: <1347538401-6417-15-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1347538401-6417-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1347538401-6417-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds Reset method on HeartRate interface to reset Energy Expended.

Change-Id: I54eb89c757627757dc1b934c103fc9444326b36a
---
 profiles/heartrate/heartrate.c | 58 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 0031e4d..8fec7e7 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -43,6 +43,7 @@
 
 #define HEART_RATE_MANAGER_IFACE "org.bluez.HeartRateManager"
 #define HEART_RATE_WATCHER_IFACE "org.bluez.HeartRateWatcher"
+#define HEART_RATE_IFACE "org.bluez.HeartRate"
 
 #define MIN_NOTIFICATION_LEN 3  /* 1-byte opcode + 2-byte handle */
 
@@ -432,6 +433,43 @@ static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static gint process_att_reset(struct heartrate_device *hrdev)
+{
+	struct characteristic *ch;
+	char *msg;
+	uint8_t atval;
+
+	if (hrdev->attrib == NULL)
+		return -1;
+
+	ch = get_characteristic(hrdev, HEART_RATE_CONTROL_POINT_UUID);
+	if (ch == NULL)
+		return -1;
+
+	atval = 0x01;
+	msg = g_strdup("Reset Control Point");
+
+	gatt_write_char(hrdev->attrib, ch->attr.value_handle, &atval,
+							1, char_write_cb, msg);
+	return 0;
+}
+
+static DBusMessage *control_point_reset(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct heartrate_device *hrdev = data;
+
+	if (!hrdev->has_cp_reset)
+		return btd_error_not_supported(msg);
+
+	if (process_att_reset(hrdev) < 0)
+		return btd_error_not_available(msg);
+
+	DBG("Energy Expended Value has been reset");
+
+	return dbus_message_new_method_return(msg);
+}
+
 static const GDBusMethodTable heartrate_manager_methods[] = {
 	{ GDBUS_METHOD("RegisterWatcher",
 			GDBUS_ARGS({ "agent", "o" }), NULL,
@@ -442,6 +480,12 @@ static const GDBusMethodTable heartrate_manager_methods[] = {
 	{ }
 };
 
+static const GDBusMethodTable heartrate_device_methods[] = {
+	{ GDBUS_METHOD("Reset", NULL, NULL,
+			control_point_reset) },
+	{ }
+};
+
 static void read_sensor_location_cb(guint8 status, const guint8 *pdu,
 						guint16 len, gpointer user_data)
 {
@@ -844,6 +888,16 @@ int heartrate_device_register(struct btd_device *device,
 	hrdev->dev = btd_device_ref(device);
 	hrdev->hr = hr;
 
+	if (!g_dbus_register_interface(get_dbus_connection(),
+				device_get_path(device), HEART_RATE_IFACE,
+				heartrate_device_methods, NULL, NULL,
+				hrdev, destroy_heartrate_device)) {
+		error("D-Bus failed to register %s interface",
+						HEART_RATE_IFACE);
+		destroy_heartrate_device(hrdev);
+		return -EIO;
+	}
+
 	hr->devices = g_slist_prepend(hr->devices, hrdev);
 
 	hrdev->svc_range = g_new0(struct att_range, 1);
@@ -878,5 +932,7 @@ void heartrate_device_unregister(struct btd_device *device)
 
 	hr->devices = g_slist_remove(hr->devices, hrdev);
 
-	destroy_heartrate_device(hrdev);
+	g_dbus_unregister_interface(get_dbus_connection(),
+							device_get_path(device),
+							HEART_RATE_IFACE);
 }
-- 
1.7.11.3

