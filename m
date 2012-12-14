Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 13/13] core: Remove org.bluez.Watcher from bluetooth.conf
Date: Fri, 14 Dec 2012 11:13:07 +0200
Message-Id: <1355476387-2165-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
References: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This interface is not used anywhere
---
 src/bluetooth.conf | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index e5da643..0495200 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -13,7 +13,6 @@
     <allow send_interface="org.bluez.Agent1"/>
     <allow send_interface="org.bluez.MediaEndpoint1"/>
     <allow send_interface="org.bluez.MediaPlayer1"/>
-    <allow send_interface="org.bluez.Watcher"/>
     <allow send_interface="org.bluez.ThermometerWatcher1"/>
     <allow send_interface="org.bluez.AlertAgent1"/>
     <allow send_interface="org.bluez.Profile1"/>
-- 
1.7.11.7

