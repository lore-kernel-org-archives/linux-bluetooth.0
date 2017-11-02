Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/7] core: Add LEAdvertising1 to bluetooth.conf
Date: Thu,  2 Nov 2017 16:15:17 +0200
Message-Id: <20171102141519.28446-5-luiz.dentz@gmail.com>
In-Reply-To: <20171102141519.28446-1-luiz.dentz@gmail.com>
References: <20171102141519.28446-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

LEAdvertising1 must be included in order to be able to call Release.
---
 src/bluetooth.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 60e75955c..74a2d3147 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -20,7 +20,7 @@
     <allow send_interface="org.bluez.CyclingSpeedWatcher1"/>
     <allow send_interface="org.bluez.GattCharacteristic1"/>
     <allow send_interface="org.bluez.GattDescriptor1"/>
-    <allow send_interface="org.bluez.LEAdvertisement1"/>   
+    <allow send_interface="org.bluez.LEAdvertisement1"/>
     <allow send_interface="org.freedesktop.DBus.ObjectManager"/>
     <allow send_interface="org.freedesktop.DBus.Properties"/>
   </policy>
-- 
2.13.6

