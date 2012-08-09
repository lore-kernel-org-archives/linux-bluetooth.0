Return-Path: <cyrus@holtmann.org>
From: Rafal Garbat <rafal.garbat@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <rafal.garbat@tieto.com>
Subject: [PATCH 12/13] heartrate: Add org.bluez.HeartRateWatcher iface to default policy
Date: Thu, 9 Aug 2012 09:20:15 +0200
Message-ID: <1344496816-4641-13-git-send-email-rafal.garbat@tieto.com>
In-Reply-To: <1344496816-4641-1-git-send-email-rafal.garbat@tieto.com>
References: <1344496816-4641-1-git-send-email-rafal.garbat@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/bluetooth.conf |    1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 664dbd9..77a9371 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -16,6 +16,7 @@
     <allow send_interface="org.bluez.MediaPlayer"/>
     <allow send_interface="org.bluez.Watcher"/>
     <allow send_interface="org.bluez.ThermometerWatcher"/>
+    <allow send_interface="org.bluez.HeartRateWatcher"/>
   </policy>
 
   <policy at_console="true">
-- 
1.7.9.5

