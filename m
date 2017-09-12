Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Tomasz Duszynski <tduszyns@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] test/example-advertisement: add LocalName to properties
Date: Tue, 12 Sep 2017 18:57:02 +0200
Message-Id: <20170912165702.856-1-tduszyns@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since local name in advertisement is useful for telling the difference
between devices expose LocalName via properties.
---
 test/example-advertisement | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/test/example-advertisement b/test/example-advertisement
index 7da0c7b25..26c3578df 100755
--- a/test/example-advertisement
+++ b/test/example-advertisement
@@ -51,6 +51,7 @@ class Advertisement(dbus.service.Object):
         self.manufacturer_data = None
         self.solicit_uuids = None
         self.service_data = None
+        self.local_name = None
         self.include_tx_power = None
         dbus.service.Object.__init__(self, bus, self.path)

@@ -69,6 +70,8 @@ class Advertisement(dbus.service.Object):
         if self.service_data is not None:
             properties['ServiceData'] = dbus.Dictionary(self.service_data,
                                                         signature='sv')
+        if self.local_name is not None:
+            properties['LocalName'] = dbus.String(self.local_name)
         if self.include_tx_power is not None:
             properties['IncludeTxPower'] = dbus.Boolean(self.include_tx_power)
         return {LE_ADVERTISEMENT_IFACE: properties}
@@ -96,6 +99,11 @@ class Advertisement(dbus.service.Object):
             self.service_data = dbus.Dictionary({}, signature='sv')
         self.service_data[uuid] = dbus.Array(data, signature='y')

+    def add_local_name(self, name):
+        if not self.local_name:
+            self.local_name = ""
+        self.local_name = dbus.String(name)
+
     @dbus.service.method(DBUS_PROP_IFACE,
                          in_signature='s',
                          out_signature='a{sv}')
@@ -120,6 +128,7 @@ class TestAdvertisement(Advertisement):
         self.add_service_uuid('180F')
         self.add_manufacturer_data(0xffff, [0x00, 0x01, 0x02, 0x03, 0x04])
         self.add_service_data('9999', [0x00, 0x01, 0x02, 0x03, 0x04])
+        self.add_local_name('TestAdvertisement')
         self.include_tx_power = True


--
2.14.1

