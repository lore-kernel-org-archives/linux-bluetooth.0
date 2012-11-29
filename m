Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 09/15] test: Add helper function to find devices
Date: Thu, 29 Nov 2012 13:47:30 +0100
Message-Id: <1354193256-30610-10-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add a helper function to the utility library as an alternative to the
convenience method Adapter.FindDevice() in the D-Bus API.
---
 test/testutils.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/test/testutils.py b/test/testutils.py
index a74ef35..45ef381 100644
--- a/test/testutils.py
+++ b/test/testutils.py
@@ -2,6 +2,7 @@ import dbus
 
 SERVICE_NAME = "org.bluez"
 ADAPTER_INTERFACE = SERVICE_NAME + ".Adapter"
+DEVICE_INTERFACE = SERVICE_NAME + ".Device"
 
 def get_managed_objects():
 	bus = dbus.SystemBus()
@@ -23,3 +24,24 @@ def find_adapter_in_objects(objects, pattern=None):
 			obj = bus.get_object(SERVICE_NAME, path)
 			return dbus.Interface(obj, ADAPTER_INTERFACE)
 	raise Exception("Bluetooth adapter not found")
+
+def find_device(device_address, adapter_pattern=None):
+	return find_device_in_objects(get_managed_objects(), device_address,
+								adapter_pattern)
+
+def find_device_in_objects(objects, device_address, adapter_pattern=None):
+	bus = dbus.SystemBus()
+	path_prefix = ""
+	if adapter_pattern != None:
+		adapter = find_adapter_in_objects(objects, adapter_pattern)
+		path_prefix = adapter.object_path
+	for path, ifaces in objects.iteritems():
+		device = ifaces.get(DEVICE_INTERFACE)
+		if device == None:
+			continue
+		if (device["Address"] == device_address and
+						path.startswith(path_prefix)):
+			obj = bus.get_object(SERVICE_NAME, path)
+			return dbus.Interface(obj, DEVICE_INTERFACE)
+
+	raise Exception("Bluetooth device not found")
-- 
1.7.11.7

