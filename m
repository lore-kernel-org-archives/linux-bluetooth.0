Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core: Allow sending to org.mpris.MediaPlayer2.Player
Date: Wed, 13 Jun 2018 17:39:22 +0300
Message-Id: <20180613143922.11016-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a policy to allow sending to org.mpris.MediaPlayer2.Player
interface since that is used when the player supports it.
---
 src/bluetooth.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 0c0b221bb..b67a954a2 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -19,6 +19,7 @@
     <allow send_interface="org.bluez.LEAdvertisement1"/>
     <allow send_interface="org.freedesktop.DBus.ObjectManager"/>
     <allow send_interface="org.freedesktop.DBus.Properties"/>
+    <allow send_interface="org.mpris.MediaPlayer2.Player"/>
   </policy>
 
   <policy at_console="true">
-- 
2.17.0

