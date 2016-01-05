Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] test/example-gatt-server: Make use of RegisterApplication
Date: Tue,  5 Jan 2016 14:54:37 -0300
Message-Id: <1452016478-17221-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1452016478-17221-1-git-send-email-luiz.dentz@gmail.com>
References: <1452016478-17221-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This updates example-gatt-server to use RegisterApplication.
---
 test/example-gatt-server | 72 +++++++++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/test/example-gatt-server b/test/example-gatt-server
index 47219b8..67dee1a 100755
--- a/test/example-gatt-server
+++ b/test/example-gatt-server
@@ -9,6 +9,7 @@ import array
 import gobject
 
 from random import randint
+from collections import OrderedDict
 
 mainloop = None
 
@@ -37,6 +38,38 @@ class FailedException(dbus.exceptions.DBusException):
     _dbus_error_name = 'org.bluez.Error.Failed'
 
 
+class Application(dbus.service.Object):
+    def __init__(self, bus):
+        self.path = '/'
+        self.services = []
+        dbus.service.Object.__init__(self, bus, self.path)
+        self.add_service(HeartRateService(bus, 0))
+        self.add_service(BatteryService(bus, 1))
+        self.add_service(TestService(bus, 2))
+
+    def get_path(self):
+        return dbus.ObjectPath(self.path)
+
+    def add_service(self, service):
+        self.services.append(service)
+
+    @dbus.service.method(DBUS_OM_IFACE, out_signature='a{oa{sa{sv}}}')
+    def GetManagedObjects(self):
+        response = OrderedDict()
+        print('GetManagedObjects')
+
+        for service in self.services:
+            response[service.get_path()] = service.get_properties()
+            chrcs = service.get_characteristics()
+            for chrc in chrcs:
+                response[chrc.get_path()] = chrc.get_properties()
+                descs = chrc.get_descriptors()
+                for desc in descs:
+                    response[desc.get_path()] = desc.get_properties()
+
+        return response
+
+
 class Service(dbus.service.Object):
     PATH_BASE = '/org/bluez/example/service'
 
@@ -83,21 +116,6 @@ class Service(dbus.service.Object):
 
         return self.get_properties[GATT_SERVICE_IFACE]
 
-    @dbus.service.method(DBUS_OM_IFACE, out_signature='a{oa{sa{sv}}}')
-    def GetManagedObjects(self):
-        response = {}
-        print('GetManagedObjects')
-
-        response[self.get_path()] = self.get_properties()
-        chrcs = self.get_characteristics()
-        for chrc in chrcs:
-            response[chrc.get_path()] = chrc.get_properties()
-            descs = chrc.get_descriptors()
-            for desc in descs:
-                response[desc.get_path()] = desc.get_properties()
-
-        return response
-
 
 class Characteristic(dbus.service.Object):
     def __init__(self, bus, index, uuid, flags, service):
@@ -523,12 +541,12 @@ class TestEncryptDescriptor(Descriptor):
                 dbus.Byte('T'), dbus.Byte('e'), dbus.Byte('s'), dbus.Byte('t')
         ]
 
-def register_service_cb():
-    print('GATT service registered')
+def register_app_cb():
+    print('GATT application registered')
 
 
-def register_service_error_cb(error):
-    print('Failed to register service: ' + str(error))
+def register_app_error_cb(error):
+    print('Failed to register application: ' + str(error))
     mainloop.quit()
 
 
@@ -559,21 +577,13 @@ def main():
             bus.get_object(BLUEZ_SERVICE_NAME, adapter),
             GATT_MANAGER_IFACE)
 
-    hr_service = HeartRateService(bus, 0)
-    bat_service = BatteryService(bus, 1)
-    test_service = TestService(bus, 2)
+    app = Application(bus)
 
     mainloop = gobject.MainLoop()
 
-    service_manager.RegisterService(hr_service.get_path(), {},
-                                    reply_handler=register_service_cb,
-                                    error_handler=register_service_error_cb)
-    service_manager.RegisterService(bat_service.get_path(), {},
-                                    reply_handler=register_service_cb,
-                                    error_handler=register_service_error_cb)
-    service_manager.RegisterService(test_service.get_path(), {},
-                                    reply_handler=register_service_cb,
-                                    error_handler=register_service_error_cb)
+    service_manager.RegisterApplication(app.get_path(), {},
+                                    reply_handler=register_app_cb,
+                                    error_handler=register_app_error_cb)
 
     mainloop.run()
 
-- 
2.4.3

