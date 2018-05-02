Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 9/9] test/example-advertisement: Add Data property
Date: Wed,  2 May 2018 12:24:42 +0300
Message-Id: <20180502092442.10567-9-luiz.dentz@gmail.com>
In-Reply-To: <20180502092442.10567-1-luiz.dentz@gmail.com>
References: <20180502092442.10567-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Data property using TDS AD type:

@ MGMT Command: Add Advertising (0x003e) plen 59
        Instance: 1
        Flags: 0x00000001
          Switch into Connectable mode
        Duration: 0
        Timeout: 0
        Advertising data length: 29
        16-bit Service UUIDs (complete): 2 entries
          Heart Rate (0x180d)
          Battery Service (0x180f)
        Company: internal use (65535)
          Data: 0001020304
        Service Data (UUID 0x9999): 0001020304
        Transport Discovery Data
          Organization: Bluetooth SIG (0x01)
          Flags: 0x01
            Role: 0x01
              Seeker Only
            Transport Data Incomplete: False (0x00)
            Transport State: 0x00
              Off
          Length: 0
          Data:
        Scan response length: 19
        Name (complete): TestAdvertisement
---
 test/example-advertisement | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/test/example-advertisement b/test/example-advertisement
index 26c3578df..d9b5b42d8 100755
--- a/test/example-advertisement
+++ b/test/example-advertisement
@@ -53,6 +53,7 @@ class Advertisement(dbus.service.Object):
         self.service_data = None
         self.local_name = None
         self.include_tx_power = None
+        self.data = None
         dbus.service.Object.__init__(self, bus, self.path)
 
     def get_properties(self):
@@ -74,6 +75,10 @@ class Advertisement(dbus.service.Object):
             properties['LocalName'] = dbus.String(self.local_name)
         if self.include_tx_power is not None:
             properties['IncludeTxPower'] = dbus.Boolean(self.include_tx_power)
+
+        if self.data is not None:
+            properties['Data'] = dbus.Dictionary(
+                self.data, signature='yv')
         return {LE_ADVERTISEMENT_IFACE: properties}
 
     def get_path(self):
@@ -104,6 +109,11 @@ class Advertisement(dbus.service.Object):
             self.local_name = ""
         self.local_name = dbus.String(name)
 
+    def add_data(self, ad_type, data):
+        if not self.data:
+            self.data = dbus.Dictionary({}, signature='yv')
+        self.data[ad_type] = dbus.Array(data, signature='y')
+
     @dbus.service.method(DBUS_PROP_IFACE,
                          in_signature='s',
                          out_signature='a{sv}')
@@ -130,6 +140,7 @@ class TestAdvertisement(Advertisement):
         self.add_service_data('9999', [0x00, 0x01, 0x02, 0x03, 0x04])
         self.add_local_name('TestAdvertisement')
         self.include_tx_power = True
+        self.add_data(0x26, [0x01, 0x01, 0x00])
 
 
 def register_ad_cb():
-- 
2.14.3

