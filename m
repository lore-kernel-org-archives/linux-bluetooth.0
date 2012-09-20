Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v6 10/13] heartrate: Add support to reset Energy Expended
Date: Thu, 20 Sep 2012 13:14:47 +0200
Message-ID: <1348139690-26985-11-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348139690-26985-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348139690-26985-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds Reset method on HeartRate interface to reset Energy Expended.
---
 profiles/heartrate/heartrate.c | 45 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 2e8e896..21ec1f7 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -41,6 +41,7 @@
 #include "log.h"
 #include "heartrate.h"
 
+#define HEART_RATE_INTERFACE		"org.bluez.HeartRate"
 #define HEART_RATE_MANAGER_INTERFACE	"org.bluez.HeartRateManager"
 #define HEART_RATE_WATCHER_INTERFACE	"org.bluez.HeartRateWatcher"
 
@@ -628,6 +629,35 @@ static const GDBusMethodTable heartrate_manager_methods[] = {
 	{ }
 };
 
+static DBusMessage *hrcp_reset(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct heartrate *hr = data;
+	uint8_t value;
+	char *vmsg;
+
+	if (!hr->hrcp_val_handle)
+		return btd_error_not_supported(msg);
+
+	if (!hr->attrib)
+		return btd_error_not_available(msg);
+
+	value = 0x01;
+	vmsg = g_strdup("Reset Control Point");
+	gatt_write_char(hr->attrib, hr->hrcp_val_handle, &value,
+					sizeof(value), char_write_cb, vmsg);
+
+	DBG("Energy Expended Value has been reset");
+
+	return dbus_message_new_method_return(msg);
+}
+
+static const GDBusMethodTable heartrate_device_methods[] = {
+	{ GDBUS_METHOD("Reset", NULL, NULL,
+			hrcp_reset) },
+	{ }
+};
+
 int heartrate_adapter_register(struct btd_adapter *adapter)
 {
 	struct heartrate_adapter *hradapter;
@@ -685,6 +715,18 @@ int heartrate_device_register(struct btd_device *device,
 	hr->dev = btd_device_ref(device);
 	hr->hradapter = hradapter;
 
+	if (!g_dbus_register_interface(get_dbus_connection(),
+						device_get_path(device),
+						HEART_RATE_INTERFACE,
+						heartrate_device_methods,
+						NULL, NULL, hr,
+						destroy_heartrate)) {
+		error("D-Bus failed to register %s interface",
+						HEART_RATE_INTERFACE);
+		destroy_heartrate(hr);
+		return -EIO;
+	}
+
 	hr->svc_range = g_new0(struct att_range, 1);
 	hr->svc_range->start = prim->range.start;
 	hr->svc_range->end = prim->range.end;
@@ -718,5 +760,6 @@ void heartrate_device_unregister(struct btd_device *device)
 
 	hradapter->devices = g_slist_remove(hradapter->devices, hr);
 
-	destroy_heartrate(hr);
+	g_dbus_unregister_interface(get_dbus_connection(),
+				device_get_path(device), HEART_RATE_INTERFACE);
 }
-- 
1.7.11.3

