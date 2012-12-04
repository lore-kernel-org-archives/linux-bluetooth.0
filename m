Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 15/20] core: Add CyclingSpeedWatcher interface to default policy
Date: Tue, 4 Dec 2012 13:43:41 +0100
Message-ID: <1354625026-29358-16-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/bluetooth.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index bd48cf9..4d0d504 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -19,6 +19,7 @@
     <allow send_interface="org.bluez.AlertAgent"/>
     <allow send_interface="org.bluez.Profile1"/>
     <allow send_interface="org.bluez.HeartRateWatcher"/>
+    <allow send_interface="org.bluez.CyclingSpeedWatcher"/>
   </policy>
 
   <policy at_console="true">
-- 
1.8.0

