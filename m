Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 02/15] test: Add utility library for python scripts
Date: Wed,  5 Dec 2012 13:51:29 +0100
Message-Id: <1354711902-16390-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354711902-16390-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354711902-16390-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Several convenience functions/features will be removed from BlueZ's
D-Bus API, and therefore a utility library is required to avoid
boilerplate code in the test scripts.
---
 Makefile.tools     |  2 +-
 test/bluezutils.py | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644 test/bluezutils.py

diff --git a/Makefile.tools b/Makefile.tools
index 1cbd876..90b35d5 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -210,7 +210,7 @@ else
 EXTRA_DIST += test/rctest.1 test/hciemu.1 test/bdaddr.8
 endif
 
-EXTRA_DIST += test/sap_client.py test/hsplay test/hsmicro \
+EXTRA_DIST += test/sap_client.py test/hsplay test/hsmicro test/bluezutils.py \
 		test/dbusdef.py test/monitor-bluetooth test/list-devices \
 		test/test-discovery test/test-manager test/test-adapter \
 		test/test-device test/test-service test/simple-agent \
diff --git a/test/bluezutils.py b/test/bluezutils.py
new file mode 100644
index 0000000..0b8aec3
--- /dev/null
+++ b/test/bluezutils.py
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
+		if adapter is None:
+			continue
+		if not pattern or pattern == adapter["Address"] or
+							path.endswith(pattern)):
+			obj = bus.get_object(SERVICE_NAME, path)
+			return dbus.Interface(obj, ADAPTER_INTERFACE)
+	raise Exception("Bluetooth adapter not found")
-- 
1.7.11.7

