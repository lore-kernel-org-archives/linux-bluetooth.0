Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v7 11/11] bluetooth.conf: Add ObjectManager interface
Date: Wed, 19 Feb 2014 15:51:33 -0300
Message-Id: <1392835893-6723-12-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1392835893-6723-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1B88D85B-35F3-47BB-ACAD-872E6C4F0A79@holtmann.org>
 <1392835893-6723-1-git-send-email-claudio.takahasi@openbossa.org>
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

