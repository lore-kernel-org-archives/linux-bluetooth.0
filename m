Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v6 18/18] bluetooth.conf: Add ObjectManager interface
Date: Tue,  4 Feb 2014 14:53:49 -0300
Message-Id: <1391536429-8345-19-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1391536429-8345-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1390854924-31904-1-git-send-email-claudio.takahasi@openbossa.org>
 <1391536429-8345-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/bluetooth.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 0495200..ad8891a 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -18,6 +18,7 @@
     <allow send_interface="org.bluez.Profile1"/>
     <allow send_interface="org.bluez.HeartRateWatcher1"/>
     <allow send_interface="org.bluez.CyclingSpeedWatcher1"/>
+    <allow send_interface="org.freedesktop.DBus.ObjectManager"/>
   </policy>
 
   <policy at_console="true">
-- 
1.8.3.1

