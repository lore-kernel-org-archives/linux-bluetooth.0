Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0] device: Add DiscoveryComplete signal
Date: Mon, 24 Sep 2012 13:19:31 +0200
Message-Id: <1348485571-17397-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The D-Bus API has to report when the UUID property has been fully
populated, once the service discovery has been finished as part of the
pairing process. This allows UIs to show the device only after its
services are known, avoiding transitional states.
---
We want to have a pairing UI that will let the user choose which profiles he wants to use with a specific device. We listen to DeviceCreated and then gather all device properties, but there is no way to know when the UUIDs have reached a stable state after the first discovery.

 doc/device-api.txt |   12 ++++++++++++
 src/device.c       |    8 +++++++-
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 1f0dc96..1d64ac2 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -82,6 +82,13 @@ Signals		PropertyChanged(string name, variant value)
 			disconnection to a remote device has been requested.
 			The actual disconnection will happen 2 seconds later.
 
+		DiscoveryComplete()
+
+			This signal will be sent when the service discovery
+			of a recently paired device has completed. This means
+			the UUIDs property has been populated with the
+			discovered remote services.
+
 Properties	string Address [readonly]
 
 			The Bluetooth device address of the remote device.
@@ -125,6 +132,11 @@ Properties	string Address [readonly]
 			List of 128-bit UUIDs that represents the available
 			remote services.
 
+			Note that this value can change over time, specially
+			during the pairing process. See the above described
+			DiscoveryComplete signal in order to know when the
+			list has been populated with the discovered services.
+
 		array{object} Services [readonly]
 
 			List of characteristics based services.
diff --git a/src/device.c b/src/device.c
index aa3a607..6bac826 100644
--- a/src/device.c
+++ b/src/device.c
@@ -887,6 +887,7 @@ static const GDBusSignalTable device_signals[] = {
 	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ GDBUS_SIGNAL("DisconnectRequested", NULL) },
+	{ GDBUS_SIGNAL("DiscoveryComplete", NULL) },
 	{ }
 };
 
@@ -1649,8 +1650,13 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 	uuids_changed(req->device);
 
 send_reply:
-	if (!req->msg)
+	if (!req->msg) {
+		g_dbus_emit_signal(btd_get_dbus_connection(),
+				device->path,
+				DEVICE_INTERFACE, "DiscoveryComplete",
+				DBUS_TYPE_INVALID);
 		goto cleanup;
+	}
 
 	if (dbus_message_is_method_call(req->msg, DEVICE_INTERFACE,
 					"DiscoverServices"))
-- 
1.7.7.6

