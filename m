Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] test/example-gatt-server: Add more comments
Date: Tue,  2 Aug 2016 14:33:57 +0300
Message-Id: <1470137637-6189-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1470137637-6189-1-git-send-email-luiz.dentz@gmail.com>
References: <1470137637-6189-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds more comments what the example is doing.
---
 test/example-gatt-server | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/test/example-gatt-server b/test/example-gatt-server
index 84905f3..44ceb70 100755
--- a/test/example-gatt-server
+++ b/test/example-gatt-server
@@ -42,6 +42,9 @@ class FailedException(dbus.exceptions.DBusException):
 
 
 class Application(dbus.service.Object):
+    """
+    org.bluez.GattApplication1 interface implementation
+    """
     def __init__(self, bus):
         self.path = '/'
         self.services = []
@@ -74,6 +77,9 @@ class Application(dbus.service.Object):
 
 
 class Service(dbus.service.Object):
+    """
+    org.bluez.GattService1 interface implementation
+    """
     PATH_BASE = '/org/bluez/example/service'
 
     def __init__(self, bus, index, uuid, primary):
@@ -121,6 +127,9 @@ class Service(dbus.service.Object):
 
 
 class Characteristic(dbus.service.Object):
+    """
+    org.bluez.GattCharacteristic1 interface implementation
+    """
     def __init__(self, bus, index, uuid, flags, service):
         self.path = service.path + '/char' + str(index)
         self.bus = bus
@@ -195,6 +204,9 @@ class Characteristic(dbus.service.Object):
 
 
 class Descriptor(dbus.service.Object):
+    """
+    org.bluez.GattDescriptor1 interface implementation
+    """
     def __init__(self, bus, index, uuid, flags, characteristic):
         self.path = characteristic.path + '/desc' + str(index)
         self.bus = bus
@@ -636,6 +648,8 @@ def main():
 
     mainloop = GObject.MainLoop()
 
+    print('Registering GATT application...')
+
     service_manager.RegisterApplication(app.get_path(), {},
                                     reply_handler=register_app_cb,
                                     error_handler=register_app_error_cb)
-- 
2.7.4

