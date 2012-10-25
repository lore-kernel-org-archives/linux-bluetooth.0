Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC 16/18] core: Add CyclingSpeedWatcher interface to default policy
Date: Thu, 25 Oct 2012 16:43:46 +0200
Message-ID: <1351176228-5789-17-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/bluetooth.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 2db43d9..a1269a4 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -19,6 +19,7 @@
     <allow send_interface="org.bluez.AlertAgent"/>
     <allow send_interface="org.bluez.Profile"/>
     <allow send_interface="org.bluez.HeartRateWatcher"/>
+    <allow send_interface="org.bluez.CyclingSpeedWatcher"/>
   </policy>
 
   <policy at_console="true">
-- 
1.8.0

