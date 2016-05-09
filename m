Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 BlueZ 4/6] test: Update GATT examples with the new API
Date: Mon,  9 May 2016 16:51:21 +0300
Message-Id: <1462801883-6361-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1462801883-6361-1-git-send-email-luiz.dentz@gmail.com>
References: <1462801883-6361-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/example-gatt-client |   2 +-
 test/example-gatt-server |  90 +++++++++++++++++++++++++-------
 test/test-gatt-profile   | 130 ++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 172 insertions(+), 50 deletions(-)

diff --git a/test/example-gatt-client b/test/example-gatt-client
index b77a627..4d1df2f 100755
--- a/test/example-gatt-client
+++ b/test/example-gatt-client
@@ -113,7 +113,7 @@ def hr_msrmt_changed_cb(iface, changed_props, invalidated_props):
 
 def start_client():
     # Read the Body Sensor Location value and print it asynchronously.
-    body_snsr_loc_chrc[0].ReadValue(reply_handler=body_sensor_val_cb,
+    body_snsr_loc_chrc[0].ReadValue({}, reply_handler=body_sensor_val_cb,
                                     error_handler=generic_error_cb,
                                     dbus_interface=GATT_CHRC_IFACE)
 
diff --git a/test/example-gatt-server b/test/example-gatt-server
index 93cf068..71aeb1b 100755
--- a/test/example-gatt-server
+++ b/test/example-gatt-server
@@ -166,13 +166,15 @@ class Characteristic(dbus.service.Object):
 
         return self.get_properties[GATT_CHRC_IFACE]
 
-    @dbus.service.method(GATT_CHRC_IFACE, out_signature='ay')
-    def ReadValue(self):
+    @dbus.service.method(GATT_CHRC_IFACE,
+                        in_signature='a{sv}',
+                        out_signature='ay')
+    def ReadValue(self, options):
         print('Default ReadValue called, returning error')
         raise NotSupportedException()
 
-    @dbus.service.method(GATT_CHRC_IFACE, in_signature='ay')
-    def WriteValue(self, value):
+    @dbus.service.method(GATT_CHRC_IFACE, in_signature='aya{sv}')
+    def WriteValue(self, value, options):
         print('Default WriteValue called, returning error')
         raise NotSupportedException()
 
@@ -222,13 +224,15 @@ class Descriptor(dbus.service.Object):
 
         return self.get_properties[GATT_CHRC_IFACE]
 
-    @dbus.service.method(GATT_DESC_IFACE, out_signature='ay')
-    def ReadValue(self):
+    @dbus.service.method(GATT_DESC_IFACE,
+                        in_signature='a{sv}',
+                        out_signature='ay')
+    def ReadValue(self, options):
         print ('Default ReadValue called, returning error')
         raise NotSupportedException()
 
-    @dbus.service.method(GATT_DESC_IFACE, in_signature='ay')
-    def WriteValue(self, value):
+    @dbus.service.method(GATT_DESC_IFACE, in_signature='aya{sv}')
+    def WriteValue(self, value, options):
         print('Default WriteValue called, returning error')
         raise NotSupportedException()
 
@@ -317,7 +321,7 @@ class BodySensorLocationChrc(Characteristic):
                 ['read'],
                 service)
 
-    def ReadValue(self):
+    def ReadValue(self, options):
         # Return 'Chest' as the sensor location.
         return [ 0x01 ]
 
@@ -331,7 +335,7 @@ class HeartRateControlPointChrc(Characteristic):
                 ['write'],
                 service)
 
-    def WriteValue(self, value):
+    def WriteValue(self, value, options):
         print('Heart Rate Control Point WriteValue called')
 
         if len(value) != 1:
@@ -393,7 +397,7 @@ class BatteryLevelCharacteristic(Characteristic):
         self.notify_battery_level()
         return True
 
-    def ReadValue(self):
+    def ReadValue(self, options):
         print('Battery Level read: ' + repr(self.battery_lvl))
         return [dbus.Byte(self.battery_lvl)]
 
@@ -425,6 +429,7 @@ class TestService(Service):
         Service.__init__(self, bus, index, self.TEST_SVC_UUID, False)
         self.add_characteristic(TestCharacteristic(bus, 0, self))
         self.add_characteristic(TestEncryptCharacteristic(bus, 1, self))
+        self.add_characteristic(TestSecureCharacteristic(bus, 2, self))
 
 class TestCharacteristic(Characteristic):
     """
@@ -445,11 +450,11 @@ class TestCharacteristic(Characteristic):
         self.add_descriptor(
                 CharacteristicUserDescriptionDescriptor(bus, 1, self))
 
-    def ReadValue(self):
+    def ReadValue(self, options):
         print('TestCharacteristic Read: ' + repr(self.value))
         return self.value
 
-    def WriteValue(self, value):
+    def WriteValue(self, value, options):
         print('TestCharacteristic Write: ' + repr(value))
         self.value = value
 
@@ -468,7 +473,7 @@ class TestDescriptor(Descriptor):
                 ['read', 'write'],
                 characteristic)
 
-    def ReadValue(self):
+    def ReadValue(self, options):
         return [
                 dbus.Byte('T'), dbus.Byte('e'), dbus.Byte('s'), dbus.Byte('t')
         ]
@@ -491,10 +496,10 @@ class CharacteristicUserDescriptionDescriptor(Descriptor):
                 ['read', 'write'],
                 characteristic)
 
-    def ReadValue(self):
+    def ReadValue(self, options):
         return self.value
 
-    def WriteValue(self, value):
+    def WriteValue(self, value, options):
         if not self.writable:
             raise NotPermittedException()
         self.value = value
@@ -517,11 +522,11 @@ class TestEncryptCharacteristic(Characteristic):
         self.add_descriptor(
                 CharacteristicUserDescriptionDescriptor(bus, 3, self))
 
-    def ReadValue(self):
+    def ReadValue(self, options):
         print('TestCharacteristic Read: ' + repr(self.value))
         return self.value
 
-    def WriteValue(self, value):
+    def WriteValue(self, value, options):
         print('TestCharacteristic Write: ' + repr(value))
         self.value = value
 
@@ -539,7 +544,54 @@ class TestEncryptDescriptor(Descriptor):
                 ['encrypt-read', 'encrypt-write'],
                 characteristic)
 
-    def ReadValue(self):
+    def ReadValue(self, options):
+        return [
+                dbus.Byte('T'), dbus.Byte('e'), dbus.Byte('s'), dbus.Byte('t')
+        ]
+
+
+class TestSecureCharacteristic(Characteristic):
+    """
+    Dummy test characteristic requiring secure connection.
+
+    """
+    TEST_CHRC_UUID = '12345678-1234-5678-1234-56789abcdef5'
+
+    def __init__(self, bus, index, service):
+        Characteristic.__init__(
+                self, bus, index,
+                self.TEST_CHRC_UUID,
+                ['secure-read', 'secure-write'],
+                service)
+        self.value = []
+        self.add_descriptor(TestEncryptDescriptor(bus, 2, self))
+        self.add_descriptor(
+                CharacteristicUserDescriptionDescriptor(bus, 3, self))
+
+    def ReadValue(self, options):
+        print('TestCharacteristic Read: ' + repr(self.value))
+        return self.value
+
+    def WriteValue(self, value, options):
+        print('TestCharacteristic Write: ' + repr(value))
+        self.value = value
+
+
+class TestSecureDescriptor(Descriptor):
+    """
+    Dummy test descriptor requiring secure connection. Returns a static value.
+
+    """
+    TEST_DESC_UUID = '12345678-1234-5678-1234-56789abcdef6'
+
+    def __init__(self, bus, index, characteristic):
+        Descriptor.__init__(
+                self, bus, index,
+                self.TEST_DESC_UUID,
+                ['secure-read', 'secure-write'],
+                characteristic)
+
+    def ReadValue(self, options):
         return [
                 dbus.Byte('T'), dbus.Byte('e'), dbus.Byte('s'), dbus.Byte('t')
         ]
diff --git a/test/test-gatt-profile b/test/test-gatt-profile
index ad320b1..995a659 100755
--- a/test/test-gatt-profile
+++ b/test/test-gatt-profile
@@ -15,46 +15,116 @@ except ImportError:
   import gobject as GObject
 import bluezutils
 
-class GattProfile(dbus.service.Object):
-	@dbus.service.method("org.bluez.GattProfile1",
-					in_signature="", out_signature="")
-	def Release(self):
-		print("Release")
-		mainloop.quit()
+BLUEZ_SERVICE_NAME = 'org.bluez'
+GATT_MANAGER_IFACE = 'org.bluez.GattManager1'
+DBUS_OM_IFACE = 'org.freedesktop.DBus.ObjectManager'
+DBUS_PROP_IFACE = 'org.freedesktop.DBus.Properties'
 
-if __name__ == '__main__':
-	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+GATT_PROFILE_IFACE = 'org.bluez.GattProfile1'
+
+
+class InvalidArgsException(dbus.exceptions.DBusException):
+    _dbus_error_name = 'org.freedesktop.DBus.Error.InvalidArgs'
+
+
+class Application(dbus.service.Object):
+    def __init__(self, bus):
+        self.path = '/'
+        self.profiles = []
+        dbus.service.Object.__init__(self, bus, self.path)
+
+    def get_path(self):
+        return dbus.ObjectPath(self.path)
+
+    def add_profile(self, profile):
+        self.profiles.append(profile)
+
+    @dbus.service.method(DBUS_OM_IFACE, out_signature='a{oa{sa{sv}}}')
+    def GetManagedObjects(self):
+        response = {}
+        print('GetManagedObjects')
+
+        for profile in self.profiles:
+            response[profile.get_path()] = profile.get_properties()
+
+        return response
+
+
+class Profile(dbus.service.Object):
+    PATH_BASE = '/org/bluez/example/profile'
 
-	bus = dbus.SystemBus()
+    def __init__(self, bus, uuids):
+        self.path = self.PATH_BASE
+        self.bus = bus
+        self.uuids = uuids
+        dbus.service.Object.__init__(self, bus, self.path)
+
+    def get_properties(self):
+        return {
+            GATT_PROFILE_IFACE: {
+                'UUIDs': self.uuids,
+            }
+        }
+
+    def get_path(self):
+        return dbus.ObjectPath(self.path)
+
+    @dbus.service.method(GATT_PROFILE_IFACE,
+                        in_signature="",
+                        out_signature="")
+    def Release(self):
+        print("Release")
+        mainloop.quit()
+
+    @dbus.service.method(DBUS_PROP_IFACE,
+                         in_signature='s',
+                         out_signature='a{sv}')
+    def GetAll(self, interface):
+        if interface != GATT_PROFILE_IFACE:
+            raise InvalidArgsException()
+
+        return self.get_properties[GATT_PROFILE_IFACE]
+
+
+def register_app_cb():
+    print('GATT application registered')
+
+
+def register_app_error_cb(error):
+    print('Failed to register application: ' + str(error))
+    mainloop.quit()
+
+if __name__ == '__main__':
+    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
-	path = bluezutils.find_adapter().object_path
+    bus = dbus.SystemBus()
 
-	manager = dbus.Interface(bus.get_object("org.bluez", path),
-				"org.bluez.GattManager1")
+    path = bluezutils.find_adapter().object_path
 
-	option_list = [
-			make_option("-u", "--uuid", action="store",
-					type="string", dest="uuid",
-					default=None),
-			make_option("-p", "--path", action="store",
-					type="string", dest="path",
-					default="/foo/bar/profile"),
-			]
+    manager = dbus.Interface(bus.get_object("org.bluez", path),
+                            GATT_MANAGER_IFACE)
 
-	opts = dbus.Dictionary({ }, signature='sv')
+    option_list = [make_option("-u", "--uuid", action="store",
+                                type="string", dest="uuid",
+                                default=None),
+    ]
 
-	parser = OptionParser(option_list=option_list)
+    opts = dbus.Dictionary({}, signature='sv')
 
-	(options, args) = parser.parse_args()
+    parser = OptionParser(option_list=option_list)
 
-	profile = GattProfile(bus, options.path)
+    (options, args) = parser.parse_args()
 
-	mainloop = GObject.MainLoop()
+    mainloop = GObject.MainLoop()
 
-	if not options.uuid:
-		options.uuid = str(uuid.uuid4())
+    if not options.uuid:
+        options.uuid = str(uuid.uuid4())
 
-	uuids = { options.uuid }
-	manager.RegisterProfile(options.path, uuids, opts)
+    app = Application(bus)
+    profile = Profile(bus, [options.uuid])
+    app.add_profile(profile)
+    manager.RegisterApplication(app.get_path(), {},
+                                reply_handler=register_app_cb,
+                                error_handler=register_app_error_cb)
 
-	mainloop.run()
+    mainloop.run()
-- 
2.5.5

