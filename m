Return-Path: <cyrus@holtmann.org>
From: Simon Fels <simon.fels@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH 1/2] core/device: expose list of connected profiles
Date: Thu,  8 Oct 2015 09:43:51 +0200
Message-Id: <1444290232-19779-1-git-send-email-simon.fels@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently users don't have any way to find out which profile is connected
and which not. This adds a new property 'ConnectedProfiles' for the
org.bluez.Device1 interface which exposes a list of UUIDs of profile we're
currently connected.
---
 doc/device-api.txt |  5 +++++
 src/device.c       | 31 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index a8076a2..9f27dbd 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -146,6 +146,11 @@ Properties	string Address [readonly]
 			A PropertiesChanged signal indicate changes to this
 			status.
 
+		array{string} ConnectedProfiles [readonly]
+
+			List of 128-bit UUIDs that represents the currently
+			connected profiles.
+
 		boolean Trusted [readwrite]
 
 			Indicates if the remote is seen as trusted. This
diff --git a/src/device.c b/src/device.c
index 5ec8780..aa8bae7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1091,6 +1091,33 @@ static gboolean dev_property_get_connected(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean dev_property_get_connected_profiles(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *dev = data;
+	DBusMessageIter entry;
+	GSList *l;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_STRING_AS_STRING, &entry);
+
+	for (l = dev->services; l != NULL; l = g_slist_next(l)) {
+		struct btd_service *service = l->data;
+		struct btd_profile *profile = btd_service_get_profile(service);
+		btd_service_state_t state = btd_service_get_state(service);
+
+		if (state != BTD_SERVICE_STATE_CONNECTED)
+			continue;
+
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+						&profile->remote_uuid);
+	}
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
 static gboolean dev_property_get_uuids(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -2504,6 +2531,7 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "LegacyPairing", "b", dev_property_get_legacy },
 	{ "RSSI", "n", dev_property_get_rssi, NULL, dev_property_exists_rssi },
 	{ "Connected", "b", dev_property_get_connected },
+	{ "ConnectedProfiles", "as", dev_property_get_connected_profiles },
 	{ "UUIDs", "as", dev_property_get_uuids },
 	{ "Modalias", "s", dev_property_get_modalias, NULL,
 						dev_property_exists_modalias },
@@ -6088,6 +6116,9 @@ static void service_state_changed(struct btd_service *service,
 		device_profile_connected(device, profile, err);
 	else if (old_state == BTD_SERVICE_STATE_DISCONNECTING)
 		device_profile_disconnected(device, profile, err);
+
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+						DEVICE_INTERFACE, "ConnectedProfiles");
 }
 
 struct btd_service *btd_device_get_service(struct btd_device *dev,
-- 
2.5.0

