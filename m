Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 8/8] test/example-gatt-server: Add encrypt attributes
Date: Mon, 27 Apr 2015 16:14:35 +0300
Message-Id: <1430140475-20349-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1430140475-20349-1-git-send-email-luiz.dentz@gmail.com>
References: <1430140475-20349-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds new attributes that requires encryption for TestService.
---
 test/example-gatt-server | 52 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/test/example-gatt-server b/test/example-gatt-server
index 9e7d0f5..47219b8 100755
--- a/test/example-gatt-server
+++ b/test/example-gatt-server
@@ -172,10 +172,11 @@ class Characteristic(dbus.service.Object):
 
 
 class Descriptor(dbus.service.Object):
-    def __init__(self, bus, index, uuid, characteristic):
+    def __init__(self, bus, index, uuid, flags, characteristic):
         self.path = characteristic.path + '/desc' + str(index)
         self.bus = bus
         self.uuid = uuid
+        self.flags = flags
         self.chrc = characteristic
         dbus.service.Object.__init__(self, bus, self.path)
 
@@ -184,6 +185,7 @@ class Descriptor(dbus.service.Object):
                 GATT_DESC_IFACE: {
                         'Characteristic': self.chrc.get_path(),
                         'UUID': self.uuid,
+                        'Flags': self.flags,
                 }
         }
 
@@ -401,7 +403,7 @@ class TestService(Service):
     def __init__(self, bus, index):
         Service.__init__(self, bus, index, self.TEST_SVC_UUID, False)
         self.add_characteristic(TestCharacteristic(bus, 0, self))
-
+        self.add_characteristic(TestEncryptCharacteristic(bus, 1, self))
 
 class TestCharacteristic(Characteristic):
     """
@@ -442,6 +444,7 @@ class TestDescriptor(Descriptor):
         Descriptor.__init__(
                 self, bus, index,
                 self.TEST_DESC_UUID,
+                ['read', 'write'],
                 characteristic)
 
     def ReadValue(self):
@@ -464,6 +467,7 @@ class CharacteristicUserDescriptionDescriptor(Descriptor):
         Descriptor.__init__(
                 self, bus, index,
                 self.CUD_UUID,
+                ['read', 'write'],
                 characteristic)
 
     def ReadValue(self):
@@ -474,6 +478,50 @@ class CharacteristicUserDescriptionDescriptor(Descriptor):
             raise NotPermittedException()
         self.value = value
 
+class TestEncryptCharacteristic(Characteristic):
+    """
+    Dummy test characteristic requiring encryption.
+
+    """
+    TEST_CHRC_UUID = '12345678-1234-5678-1234-56789abcdef3'
+
+    def __init__(self, bus, index, service):
+        Characteristic.__init__(
+                self, bus, index,
+                self.TEST_CHRC_UUID,
+                ['encrypt-read', 'encrypt-write'],
+                service)
+        self.value = []
+        self.add_descriptor(TestEncryptDescriptor(bus, 2, self))
+        self.add_descriptor(
+                CharacteristicUserDescriptionDescriptor(bus, 3, self))
+
+    def ReadValue(self):
+        print('TestCharacteristic Read: ' + repr(self.value))
+        return self.value
+
+    def WriteValue(self, value):
+        print('TestCharacteristic Write: ' + repr(value))
+        self.value = value
+
+class TestEncryptDescriptor(Descriptor):
+    """
+    Dummy test descriptor requiring encryption. Returns a static value.
+
+    """
+    TEST_DESC_UUID = '12345678-1234-5678-1234-56789abcdef4'
+
+    def __init__(self, bus, index, characteristic):
+        Descriptor.__init__(
+                self, bus, index,
+                self.TEST_DESC_UUID,
+                ['encrypt-read', 'encrypt-write'],
+                characteristic)
+
+    def ReadValue(self):
+        return [
+                dbus.Byte('T'), dbus.Byte('e'), dbus.Byte('s'), dbus.Byte('t')
+        ]
 
 def register_service_cb():
     print('GATT service registered')
-- 
2.1.0

