Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <marcel@holtmann.org>, Andrzej Kaczmarek
	<andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/9] core: Add ConnectionRSSI property
Date: Tue, 27 May 2014 09:52:44 +0200
Message-ID: <1401177171-19994-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401177171-19994-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401177171-19994-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds ConnectionRSSI property on org.bluez.Device1 interface
which provides RSSI on currently connected link (unlike RSSI which
provides RSSI for inquiry/advertising packets).

Property value will be refreshed once connection monitoring code is in
place.
---
 src/device.c | 30 ++++++++++++++++++++++++++++++
 src/device.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/src/device.c b/src/device.c
index 8222610..fd4e120 100644
--- a/src/device.c
+++ b/src/device.c
@@ -219,6 +219,8 @@ struct btd_device {
 	bool		legacy;
 	int8_t		rssi;
 
+	int8_t		conn_rssi;
+
 	GIOChannel	*att_io;
 	guint		cleanup_id;
 	guint		store_id;
@@ -825,6 +827,17 @@ static gboolean dev_property_get_trusted(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean dev_property_get_conn_rssi(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	dbus_int16_t val = device->conn_rssi;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_INT16, &val);
+
+	return TRUE;
+}
+
 static void set_trust(GDBusPendingPropertySet id, gboolean value, void *data)
 {
 	struct btd_device *device = data;
@@ -1918,6 +1931,7 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "Modalias", "s", dev_property_get_modalias, NULL,
 						dev_property_exists_modalias },
 	{ "Adapter", "o", dev_property_get_adapter },
+	{ "ConnectionRSSI", "n", dev_property_get_conn_rssi },
 	{ }
 };
 
@@ -4043,6 +4057,22 @@ void device_set_rssi(struct btd_device *device, int8_t rssi)
 						DEVICE_INTERFACE, "RSSI");
 }
 
+void device_set_conn_rssi(struct btd_device *device, int8_t rssi)
+{
+	if (!device)
+		return;
+
+	if (device->conn_rssi == rssi)
+		return;
+
+	DBG("conn_rssi %d", rssi);
+
+	device->conn_rssi = rssi;
+
+	g_dbus_emit_property_changed(dbus_conn, device->path, DEVICE_INTERFACE,
+							"ConnectionRSSI");
+}
+
 static void device_set_auto_connect(struct btd_device *device, gboolean enable)
 {
 	char addr[18];
diff --git a/src/device.h b/src/device.h
index 2e0473e..79d5132 100644
--- a/src/device.h
+++ b/src/device.h
@@ -88,6 +88,7 @@ void btd_device_set_trusted(struct btd_device *device, gboolean trusted);
 void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type);
 void device_set_legacy(struct btd_device *device, bool legacy);
 void device_set_rssi(struct btd_device *device, int8_t rssi);
+void device_set_conn_rssi(struct btd_device *device, int8_t rssi);
 bool btd_device_is_connected(struct btd_device *dev);
 uint8_t btd_device_get_bdaddr_type(struct btd_device *dev);
 bool device_is_retrying(struct btd_device *device);
-- 
1.9.3
