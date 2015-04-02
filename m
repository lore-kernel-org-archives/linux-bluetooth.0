Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v9 10/12] test: improvements to example-advertisement
Date: Thu,  2 Apr 2015 11:59:26 -0700
Message-Id: <1428001168-32822-11-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1428001168-32822-1-git-send-email-jamuraa@chromium.org>
References: <1428001168-32822-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Improves the example-advertisement script in two ways:

It uses 16-bit service UUIDs so that it does not overflow the
Advertisement Data

It turns the adapter's power on so that it works out of the box.
---
 test/example-advertisement | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/test/example-advertisement b/test/example-advertisement
index 98aeafa..6e47391 100755
--- a/test/example-advertisement
+++ b/test/example-advertisement
@@ -113,11 +113,10 @@ class TestAdvertisement(Advertisement):
 
     def __init__(self, bus, index):
         Advertisement.__init__(self, bus, index, 'broadcast')
-        self.add_service_uuid('0000180D-0000-1000-8000-00805F9B34FB')
-        self.add_service_uuid('0000180F-0000-1000-8000-00805F9B34FB')
+        self.add_service_uuid('180D')
+        self.add_service_uuid('180F')
         self.add_manufacturer_data(0xffff, [0x00, 0x01, 0x02, 0x03, 0x04])
-        self.add_service_data('00009999-0000-1000-8000-00805F9B34FB',
-                              [0x00, 0x01, 0x02, 0x03, 0x04])
+        self.add_service_data('9999', [0x00, 0x01, 0x02, 0x03, 0x04])
 
 
 def register_ad_cb():
@@ -153,6 +152,11 @@ def main():
         print 'LEAdvertisingManager1 interface not found'
         return
 
+    adapter_props = dbus.Interface(bus.get_object(BLUEZ_SERVICE_NAME, adapter),
+                                   "org.freedesktop.DBus.Properties");
+
+    adapter_props.Set("org.bluez.Adapter1", "Powered", dbus.Boolean(1))
+
     ad_manager = dbus.Interface(bus.get_object(BLUEZ_SERVICE_NAME, adapter),
                                 LE_ADVERTISING_MANAGER_IFACE)
 
-- 
2.2.0.rc0.207.ga3a616c

