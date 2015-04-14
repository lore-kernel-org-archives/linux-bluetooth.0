Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 5/6] test: add IncludeTXPower to example-advertisement
Date: Tue, 14 Apr 2015 15:07:00 -0700
Message-Id: <1429049221-21984-6-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1429049221-21984-1-git-send-email-jamuraa@chromium.org>
References: <1429049221-21984-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/example-advertisement | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/test/example-advertisement b/test/example-advertisement
index 6e47391..1198f2e 100755
--- a/test/example-advertisement
+++ b/test/example-advertisement
@@ -51,6 +51,7 @@ class Advertisement(dbus.service.Object):
         self.manufacturer_data = None
         self.solicit_uuids = None
         self.service_data = None
+        self.include_tx_power = None
         dbus.service.Object.__init__(self, bus, self.path)
 
     def get_properties(self):
@@ -68,6 +69,8 @@ class Advertisement(dbus.service.Object):
         if self.service_data is not None:
             properties['ServiceData'] = dbus.Dictionary(self.service_data,
                                                         signature='say')
+        if self.include_tx_power is not None:
+            properties['IncludeTXPower'] = dbus.Boolean(self.include_tx_power)
         return {LE_ADVERTISEMENT_IFACE: properties}
 
     def get_path(self):
@@ -117,6 +120,7 @@ class TestAdvertisement(Advertisement):
         self.add_service_uuid('180F')
         self.add_manufacturer_data(0xffff, [0x00, 0x01, 0x02, 0x03, 0x04])
         self.add_service_data('9999', [0x00, 0x01, 0x02, 0x03, 0x04])
+        self.include_tx_power = True
 
 
 def register_ad_cb():
-- 
2.2.0.rc0.207.ga3a616c

