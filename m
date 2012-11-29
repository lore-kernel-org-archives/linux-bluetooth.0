Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 02/15] test: Add utility library for python scripts
Date: Thu, 29 Nov 2012 13:47:23 +0100
Message-Id: <1354193256-30610-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Several convenience functions/features will be removed from BlueZ's
D-Bus API, and therefore a utility library is required to avoid
boilerplate code in the test scripts.
---
 Makefile.tools    |  3 +--
 test/testutils.py | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100644 test/testutils.py

diff --git a/Makefile.tools b/Makefile.tools
index 689b4d2..5409432 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -1,4 +1,3 @@
-
 if TOOLS
 bin_PROGRAMS += tools/rfcomm tools/l2ping \
 				tools/hcitool tools/sdptool tools/ciptool
@@ -199,7 +198,7 @@ else
 EXTRA_DIST += test/rctest.1 test/hciemu.1 test/bdaddr.8
 endif
 
-EXTRA_DIST += test/sap_client.py test/hsplay test/hsmicro \
+EXTRA_DIST += test/sap_client.py test/hsplay test/hsmicro test/testutils.py \
 		test/dbusdef.py test/monitor-bluetooth test/list-devices \
 		test/test-discovery test/test-manager test/test-adapter \
 		test/test-device test/test-service test/simple-agent \
diff --git a/test/testutils.py b/test/testutils.py
new file mode 100644
index 0000000..a74ef35
--- /dev/null
+++ b/test/testutils.py
@@ -0,0 +1,25 @@
+import dbus
+
+SERVICE_NAME = "org.bluez"
+ADAPTER_INTERFACE = SERVICE_NAME + ".Adapter"
+
+def get_managed_objects():
+	bus = dbus.SystemBus()
+	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+				"org.freedesktop.DBus.ObjectManager")
+	return manager.GetManagedObjects()
+
+def find_adapter(pattern=None):
+	return find_adapter_in_objects(get_managed_objects(), pattern)
+
+def find_adapter_in_objects(objects, pattern=None):
+	bus = dbus.SystemBus()
+	for path, ifaces in objects.iteritems():
+		adapter = ifaces.get(ADAPTER_INTERFACE)
+		if adapter == None:
+			continue
+		if (pattern == None or pattern == adapter["Address"] or
+							path.endswith(pattern)):
+			obj = bus.get_object(SERVICE_NAME, path)
+			return dbus.Interface(obj, ADAPTER_INTERFACE)
+	raise Exception("Bluetooth adapter not found")
-- 
1.7.11.7

