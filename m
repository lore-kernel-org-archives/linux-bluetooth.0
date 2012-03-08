Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH 3/8] adapter: add DeviceAdded signal when existing device is added
Date: Thu,  8 Mar 2012 15:57:07 +0200
Message-Id: <1331215032-27695-4-git-send-email-arik@wizery.com>
In-Reply-To: <1331215032-27695-1-git-send-email-arik@wizery.com>
References: <1331215032-27695-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Emit a signal when an existing device is added to the device list of the
adapter. These are devices which are added on adapter startup, from
stored link-keys, long-term-keys, etc. These devices will appear in the
"Devices" property of the adapter.
---
 doc/adapter-api.txt |    5 +++++
 src/adapter.c       |   17 +++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 20cef03..99b5524 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -212,6 +212,11 @@ Signals		PropertyChanged(string name, variant value)
 
 			Parameter is object path of removed device.
 
+		DeviceAdded(object device)
+
+			Parameter is object path of existing device added
+			to the device list.
+
 Properties	string Address [readonly]
 
 			The Bluetooth device address.
diff --git a/src/adapter.c b/src/adapter.c
index f817975..5054450 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1688,12 +1688,24 @@ static GDBusMethodTable adapter_methods[] = {
 static GDBusSignalTable adapter_signals[] = {
 	{ "PropertyChanged",		"sv"		},
 	{ "DeviceCreated",		"o"		},
+	{ "DeviceAdded",		"o"		},
 	{ "DeviceRemoved",		"o"		},
 	{ "DeviceFound",		"sa{sv}"	},
 	{ "DeviceDisappeared",		"s"		},
 	{ }
 };
 
+static void emit_device_added(struct btd_adapter *adapter,
+			      struct btd_device *device)
+{
+	const char *path = device_get_path(device);
+
+	g_dbus_emit_signal(connection, adapter->path,
+			ADAPTER_INTERFACE, "DeviceAdded",
+			DBUS_TYPE_OBJECT_PATH, &path,
+			DBUS_TYPE_INVALID);
+}
+
 static void create_stored_device_from_profiles(char *key, char *value,
 						void *user_data)
 {
@@ -1719,6 +1731,7 @@ static void create_stored_device_from_profiles(char *key, char *value,
 	device_probe_drivers(device, uuids);
 
 	g_slist_free_full(uuids, g_free);
+	emit_device_added(adapter, device);
 }
 
 struct adapter_keys {
@@ -1826,6 +1839,7 @@ static void create_stored_device_from_linkkeys(char *key, char *value,
 	if (device) {
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
+		emit_device_added(adapter, device);
 	}
 }
 
@@ -1859,6 +1873,7 @@ static void create_stored_device_from_ltks(char *key, char *value,
 	if (device) {
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
+		emit_device_added(adapter, device);
 	}
 }
 
@@ -1876,6 +1891,7 @@ static void create_stored_device_from_blocked(char *key, char *value,
 	if (device) {
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
+		emit_device_added(adapter, device);
 	}
 }
 
@@ -1947,6 +1963,7 @@ static void create_stored_device_from_primary(char *key, char *value,
 	device_probe_drivers(device, uuids);
 
 	g_slist_free(uuids);
+	emit_device_added(adapter, device);
 }
 
 static void smp_key_free(void *data)
-- 
1.7.5.4

