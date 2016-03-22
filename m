Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] tests/example-gatt-client: Fix using invalid property
Date: Tue, 22 Mar 2016 16:54:35 +0200
Message-Id: <1458658475-2381-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following trace caused by GattServices1 no longer
containing a property called Characteristics:

Traceback (most recent call last):
  File "./example-gatt-client", line 221, in <module>
    main()
  File "./example-gatt-client", line 207, in main
    if not process_hr_service(service_path):
  File "./example-gatt-client", line 167, in process_hr_service
    chrc_paths = service_props['Characteristics']
KeyError: 'Characteristics'
---
 test/example-gatt-client | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/test/example-gatt-client b/test/example-gatt-client
index 5a02505..b77a627 100755
--- a/test/example-gatt-client
+++ b/test/example-gatt-client
@@ -1,6 +1,5 @@
 #!/usr/bin/env python3
 
-import argparse
 import dbus
 try:
   from gi.repository import GObject
@@ -152,7 +151,7 @@ def process_chrc(chrc_path):
     return True
 
 
-def process_hr_service(service_path):
+def process_hr_service(service_path, chrc_paths):
     service = bus.get_object(BLUEZ_SERVICE_NAME, service_path)
     service_props = service.GetAll(GATT_SERVICE_IFACE,
                                    dbus_interface=DBUS_PROP_IFACE)
@@ -160,11 +159,11 @@ def process_hr_service(service_path):
     uuid = service_props['UUID']
 
     if uuid != HR_SVC_UUID:
-        print('Service is not a Heart Rate Service: ' + uuid)
         return False
 
+    print('Heart Rate Service found: ' + service_path)
+
     # Process the characteristics.
-    chrc_paths = service_props['Characteristics']
     for chrc_path in chrc_paths:
         process_chrc(chrc_path)
 
@@ -184,15 +183,6 @@ def interfaces_removed_cb(object_path, interfaces):
 
 
 def main():
-    # Prase the service path from the arguments.
-    parser = argparse.ArgumentParser(
-            description='D-Bus Heart Rate Service client example')
-    parser.add_argument('service_path', metavar='<service-path>',
-                        type=dbus.ObjectPath, nargs=1,
-                        help='GATT service object path')
-    args = parser.parse_args()
-    service_path = args.service_path[0]
-
     # Set up the main loop.
     DBusGMainLoop(set_as_default=True)
     global bus
@@ -203,14 +193,26 @@ def main():
     om = dbus.Interface(bus.get_object(BLUEZ_SERVICE_NAME, '/'), DBUS_OM_IFACE)
     om.connect_to_signal('InterfacesRemoved', interfaces_removed_cb)
 
-    try:
-        if not process_hr_service(service_path):
-            sys.exit(1)
-    except dbus.DBusException as e:
-        print(e)
-        sys.exit(1)
+    objects = om.GetManagedObjects()
+    chrcs = []
+
+    for path, interfaces in objects.items():
+        if GATT_CHRC_IFACE not in interfaces.keys():
+            continue
+        chrcs.append(path)
+
+    for path, interfaces in objects.items():
+        if GATT_SERVICE_IFACE not in interfaces.keys():
+            continue
 
-    print('Heart Rate Service ready')
+        chrc_paths = [d for d in chrcs if d.startswith(path + "/")]
+
+        if process_hr_service(path, chrc_paths):
+            break
+
+    if not hr_service:
+        print('No Heart Rate Service found')
+        sys.exit(1)
 
     start_client()
 
-- 
2.5.0

