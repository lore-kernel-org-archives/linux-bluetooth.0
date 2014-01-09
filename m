Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@gmail.com,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 18/18] bluetooth.conf: Add ObjectManager interface
Date: Thu,  9 Jan 2014 13:38:23 -0300
Message-Id: <1389285503-19348-19-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1389285503-19348-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1385585457-26951-1-git-send-email-claudio.takahasi@openbossa.org>
 <1389285503-19348-1-git-send-email-claudio.takahasi@openbossa.org>
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

