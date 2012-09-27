Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 27/27] alert: Add org.bluez.AlertAgent to D-Bus policy file
Date: Thu, 27 Sep 2012 14:36:36 -0400
Message-Id: <1348770996-12236-28-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
 <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows BlueZ to call the methods on the org.bluez.AlertAgent
interface.
---
 src/bluetooth.conf |    1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 26fde34..8b656f3 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -16,6 +16,7 @@
     <allow send_interface="org.bluez.MediaPlayer"/>
     <allow send_interface="org.bluez.Watcher"/>
     <allow send_interface="org.bluez.ThermometerWatcher"/>
+    <allow send_interface="org.bluez.AlertAgent"/>
     <allow send_interface="org.bluez.Profile"/>
   </policy>
 
-- 
1.7.9.5

