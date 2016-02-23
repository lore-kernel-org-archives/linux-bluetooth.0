Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 23 Feb 2016 14:44:20 +1300
From: Kurt McAlpine <kurt@linux.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fixed scripts to run with python 3
Message-ID: <20160223014420.GA6471@kurtmc.Eroad.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I created a patch to fix example-gatt-server and example-gatt-client
since they used a mix of python 2 and 3 syntax.

	Kurt

--FL5UXtIhxfXey3p5
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Fixed-scripts-to-run-with-python-3.patch"

Subject: [PATCH] Fixed scripts to run with python 3

Fix up syntax problems so that this code actually runs.

---
 test/example-gatt-client | 13 ++++++++-----
 test/example-gatt-server | 20 ++++++++++++--------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/test/example-gatt-client b/test/example-gatt-client
index 724a45d..5a02505 100755
--- a/test/example-gatt-client
+++ b/test/example-gatt-client
@@ -1,8 +1,11 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 
 import argparse
 import dbus
-import gobject
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 import sys
 
 from dbus.mainloop.glib import DBusGMainLoop
@@ -195,7 +198,7 @@ def main():
     global bus
     bus = dbus.SystemBus()
     global mainloop
-    mainloop = gobject.MainLoop()
+    mainloop = GObject.MainLoop()
 
     om = dbus.Interface(bus.get_object(BLUEZ_SERVICE_NAME, '/'), DBUS_OM_IFACE)
     om.connect_to_signal('InterfacesRemoved', interfaces_removed_cb)
@@ -204,10 +207,10 @@ def main():
         if not process_hr_service(service_path):
             sys.exit(1)
     except dbus.DBusException as e:
-        print e.message
+        print(e)
         sys.exit(1)
 
-    print 'Heart Rate Service ready'
+    print('Heart Rate Service ready')
 
     start_client()
 
diff --git a/test/example-gatt-server b/test/example-gatt-server
index 67dee1a..f2ddb2b 100755
--- a/test/example-gatt-server
+++ b/test/example-gatt-server
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 
 import dbus
 import dbus.exceptions
@@ -6,7 +6,11 @@ import dbus.mainloop.glib
 import dbus.service
 
 import array
-import gobject
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
+import sys
 
 from random import randint
 from collections import OrderedDict
@@ -285,7 +289,7 @@ class HeartRateMeasurementChrc(Characteristic):
         if not self.notifying:
             return
 
-        gobject.timeout_add(1000, self.hr_msrmt_cb)
+        GObject.timeout_add(1000, self.hr_msrmt_cb)
 
     def StartNotify(self):
         if self.notifying:
@@ -372,7 +376,7 @@ class BatteryLevelCharacteristic(Characteristic):
                 service)
         self.notifying = False
         self.battery_lvl = 100
-        gobject.timeout_add(5000, self.drain_battery)
+        GObject.timeout_add(5000, self.drain_battery)
 
     def notify_battery_level(self):
         if not self.notifying:
@@ -480,7 +484,7 @@ class CharacteristicUserDescriptionDescriptor(Descriptor):
 
     def __init__(self, bus, index, characteristic):
         self.writable = 'writable-auxiliaries' in characteristic.flags
-        self.value = array.array('B', 'This is a characteristic for testing')
+        self.value = array.array('B', b'This is a characteristic for testing')
         self.value = self.value.tolist()
         Descriptor.__init__(
                 self, bus, index,
@@ -555,8 +559,8 @@ def find_adapter(bus):
                                DBUS_OM_IFACE)
     objects = remote_om.GetManagedObjects()
 
-    for o, props in objects.iteritems():
-        if props.has_key(GATT_MANAGER_IFACE):
+    for o, props in objects.items():
+        if GATT_MANAGER_IFACE in props.keys():
             return o
 
     return None
@@ -579,7 +583,7 @@ def main():
 
     app = Application(bus)
 
-    mainloop = gobject.MainLoop()
+    mainloop = GObject.MainLoop()
 
     service_manager.RegisterApplication(app.get_path(), {},
                                     reply_handler=register_app_cb,
-- 
2.7.1


--FL5UXtIhxfXey3p5--
