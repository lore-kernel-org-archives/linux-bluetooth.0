Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/13] core: Remove another left over of HFP removal
Date: Fri, 14 Dec 2012 11:13:06 +0200
Message-Id: <1355476387-2165-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
References: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/bluetooth.conf | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 8dfdc77..e5da643 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -11,7 +11,6 @@
     <allow own="org.bluez"/>
     <allow send_destination="org.bluez"/>
     <allow send_interface="org.bluez.Agent1"/>
-    <allow send_interface="org.bluez.HandsfreeAgent"/>
     <allow send_interface="org.bluez.MediaEndpoint1"/>
     <allow send_interface="org.bluez.MediaPlayer1"/>
     <allow send_interface="org.bluez.Watcher"/>
-- 
1.7.11.7

