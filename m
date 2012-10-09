Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 02/15] thermometer: Register ThermometerManager interface on adapter path
Date: Tue, 9 Oct 2012 13:19:45 +0200
Message-ID: <1349781598-22580-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1349781598-22580-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1349781598-22580-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/thermometer/thermometer.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index e98be94..cc5f23f 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -42,7 +42,8 @@
 #include "gatt.h"
 #include "thermometer.h"
 
-#define THERMOMETER_INTERFACE "org.bluez.Thermometer"
+#define THERMOMETER_INTERFACE		"org.bluez.Thermometer"
+#define THERMOMETER_MANAGER_INTERFACE	"org.bluez.ThermometerManager"
 
 /* Temperature measurement flag fields */
 #define TEMP_UNITS		0x01
@@ -189,6 +190,16 @@ static void destroy_thermometer(gpointer user_data)
 	g_free(t);
 }
 
+static void destroy_thermometer_adapter(gpointer user_data)
+{
+	struct thermometer_adapter *tadapter = user_data;
+
+	if (tadapter->devices != NULL)
+		g_slist_free_full(tadapter->devices, destroy_thermometer);
+
+	g_free(tadapter);
+}
+
 static gint cmp_adapter(gconstpointer a, gconstpointer b)
 {
 	const struct thermometer_adapter *tadapter = a;
@@ -1321,6 +1332,10 @@ void thermometer_unregister(struct btd_device *device)
 				device_get_path(t->dev), THERMOMETER_INTERFACE);
 }
 
+static const GDBusMethodTable thermometer_manager_methods[] = {
+	{ }
+};
+
 int thermometer_adapter_register(struct btd_adapter *adapter)
 {
 	struct thermometer_adapter *tadapter;
@@ -1328,6 +1343,18 @@ int thermometer_adapter_register(struct btd_adapter *adapter)
 	tadapter = g_new0(struct thermometer_adapter, 1);
 	tadapter->adapter = adapter;
 
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+						adapter_get_path(adapter),
+						THERMOMETER_MANAGER_INTERFACE,
+						thermometer_manager_methods,
+						NULL, NULL, tadapter,
+						destroy_thermometer_adapter)) {
+		error("D-Bus failed to register %s interface",
+						THERMOMETER_MANAGER_INTERFACE);
+		destroy_thermometer_adapter(tadapter);
+		return -EIO;
+	}
+
 	thermometer_adapters = g_slist_prepend(thermometer_adapters, tadapter);
 
 	return 0;
@@ -1342,4 +1369,8 @@ void thermometer_adapter_unregister(struct btd_adapter *adapter)
 		return;
 
 	thermometer_adapters = g_slist_remove(thermometer_adapters, tadapter);
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+					adapter_get_path(tadapter->adapter),
+					THERMOMETER_MANAGER_INTERFACE);
 }
-- 
1.7.11.3

