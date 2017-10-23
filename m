Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] test/example-gatt-server: Don't change measuments if not notifying
Date: Mon, 23 Oct 2017 14:17:23 +0300
Message-Id: <20171023111723.20729-3-luiz.dentz@gmail.com>
In-Reply-To: <20171023111723.20729-1-luiz.dentz@gmail.com>
References: <20171023111723.20729-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes it clearer when notifications are actually in effect.
---
 test/example-gatt-server | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/example-gatt-server b/test/example-gatt-server
index 24aaff973..689e86ff7 100755
--- a/test/example-gatt-server
+++ b/test/example-gatt-server
@@ -401,6 +401,8 @@ class BatteryLevelCharacteristic(Characteristic):
                 { 'Value': [dbus.Byte(self.battery_lvl)] }, [])
 
     def drain_battery(self):
+        if not self.notifying:
+            return True
         if self.battery_lvl > 0:
             self.battery_lvl -= 2
             if self.battery_lvl < 0:
-- 
2.13.6

