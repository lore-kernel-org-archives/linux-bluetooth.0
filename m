Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/7] core: Cleanup bluetooth.conf
Date: Thu,  2 Nov 2017 16:15:18 +0200
Message-Id: <20171102141519.28446-6-luiz.dentz@gmail.com>
In-Reply-To: <20171102141519.28446-1-luiz.dentz@gmail.com>
References: <20171102141519.28446-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This removes interfaces that no longer exists.
---
 src/bluetooth.conf | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 74a2d3147..0c0b221bb 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -13,11 +13,7 @@
     <allow send_interface="org.bluez.Agent1"/>
     <allow send_interface="org.bluez.MediaEndpoint1"/>
     <allow send_interface="org.bluez.MediaPlayer1"/>
-    <allow send_interface="org.bluez.ThermometerWatcher1"/>
-    <allow send_interface="org.bluez.AlertAgent1"/>
     <allow send_interface="org.bluez.Profile1"/>
-    <allow send_interface="org.bluez.HeartRateWatcher1"/>
-    <allow send_interface="org.bluez.CyclingSpeedWatcher1"/>
     <allow send_interface="org.bluez.GattCharacteristic1"/>
     <allow send_interface="org.bluez.GattDescriptor1"/>
     <allow send_interface="org.bluez.LEAdvertisement1"/>
-- 
2.13.6

