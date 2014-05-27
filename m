Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <marcel@holtmann.org>, Andrzej Kaczmarek
	<andrzej.kaczmarek@tieto.com>
Subject: [PATCH 3/9] core: Add ConnectionTXPower property
Date: Tue, 27 May 2014 09:52:45 +0200
Message-ID: <1401177171-19994-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401177171-19994-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401177171-19994-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds ConnectionTXPower property on org.bluez.Device1
interface which provides local TX power on currently connected link.

Property value will be refreshed once connection monitoring code is in
place.
---
 src/device.c | 32 ++++++++++++++++++++++++++++++++
 src/device.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/src/device.c b/src/device.c
index fd4e120..ac42a75 100644
--- a/src/device.c
+++ b/src/device.c
@@ -220,6 +220,7 @@ struct btd_device {
 	int8_t		rssi;
 
 	int8_t		conn_rssi;
+	int8_t		conn_tx_power;
 
 	GIOChannel	*att_io;
 	guint		cleanup_id;
@@ -838,6 +839,18 @@ static gboolean dev_property_get_conn_rssi(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean dev_property_get_conn_txpower(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	dbus_int16_t val = device->conn_tx_power;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_INT16, &val);
+
+	return TRUE;
+}
+
 static void set_trust(GDBusPendingPropertySet id, gboolean value, void *data)
 {
 	struct btd_device *device = data;
@@ -1932,6 +1945,7 @@ static const GDBusPropertyTable device_properties[] = {
 						dev_property_exists_modalias },
 	{ "Adapter", "o", dev_property_get_adapter },
 	{ "ConnectionRSSI", "n", dev_property_get_conn_rssi },
+	{ "ConnectionTXPower", "n", dev_property_get_conn_txpower },
 	{ }
 };
 
@@ -2327,6 +2341,8 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 	str2ba(address, &device->bdaddr);
 	device->adapter = adapter;
 
+	device->conn_tx_power = 127; /* invalid */
+
 	return btd_device_ref(device);
 }
 
@@ -4073,6 +4089,22 @@ void device_set_conn_rssi(struct btd_device *device, int8_t rssi)
 							"ConnectionRSSI");
 }
 
+void device_set_conn_tx_power(struct btd_device *device, int8_t tx_power)
+{
+	if (!device)
+		return;
+
+	if (device->conn_tx_power == tx_power)
+		return;
+
+	DBG("conn_tx_power %d", tx_power);
+
+	device->conn_tx_power = tx_power;
+
+	g_dbus_emit_property_changed(dbus_conn, device->path, DEVICE_INTERFACE,
+							"ConnectionTXPower");
+}
+
 static void device_set_auto_connect(struct btd_device *device, gboolean enable)
 {
 	char addr[18];
diff --git a/src/device.h b/src/device.h
index 79d5132..e0e44cc 100644
--- a/src/device.h
+++ b/src/device.h
@@ -89,6 +89,7 @@ void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type);
 void device_set_legacy(struct btd_device *device, bool legacy);
 void device_set_rssi(struct btd_device *device, int8_t rssi);
 void device_set_conn_rssi(struct btd_device *device, int8_t rssi);
+void device_set_conn_tx_power(struct btd_device *device, int8_t tx_power);
 bool btd_device_is_connected(struct btd_device *dev);
 uint8_t btd_device_get_bdaddr_type(struct btd_device *dev);
 bool device_is_retrying(struct btd_device *device);
-- 
1.9.3
