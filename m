Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/7] core: Add LEAdvertisement1 to bluetooth.conf
Date: Thu,  2 Nov 2017 16:43:50 +0200
Message-Id: <20171102144352.32353-5-luiz.dentz@gmail.com>
In-Reply-To: <20171102144352.32353-1-luiz.dentz@gmail.com>
References: <20171102144352.32353-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

LEAdvertisement1 must be included in order to be able to call Release.
---
 src/bluetooth.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 10d2d3688..74a2d3147 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -20,6 +20,7 @@
     <allow send_interface="org.bluez.CyclingSpeedWatcher1"/>
     <allow send_interface="org.bluez.GattCharacteristic1"/>
     <allow send_interface="org.bluez.GattDescriptor1"/>
+    <allow send_interface="org.bluez.LEAdvertisement1"/>
     <allow send_interface="org.freedesktop.DBus.ObjectManager"/>
     <allow send_interface="org.freedesktop.DBus.Properties"/>
   </policy>
-- 
2.13.6

