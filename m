Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Rafal Garbat <rafal.garbat@tieto.com>
Subject: [PATCH v8 12/13] heartrate: Add HeartRateWatcher interface to default policy
Date: Tue, 25 Sep 2012 16:27:45 +0200
Message-ID: <1348583267-16816-13-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348583267-16816-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348583267-16816-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rafal Garbat <rafal.garbat@tieto.com>

---
 src/bluetooth.conf | 1 +
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
1.7.11.3

