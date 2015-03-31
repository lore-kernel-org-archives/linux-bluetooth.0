Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v7 10/10] test: improvements to advertising-example
Date: Tue, 31 Mar 2015 10:24:04 -0700
Message-Id: <1427822644-39009-11-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1427822644-39009-1-git-send-email-jamuraa@chromium.org>
References: <1427822644-39009-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Improves the advertising-example in two ways:

It uses 16-bit service UUIDs so that it does not overflow the
Advertisement Data

It turns the adapter's power on so that it works out of the box.
---
 test/advertisement-example | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/test/advertisement-example b/test/advertisement-example
index 98aeafa..6e47391 100644
--- a/test/advertisement-example
+++ b/test/advertisement-example
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

