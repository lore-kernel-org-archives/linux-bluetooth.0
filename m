Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Rafal Garbat <rafal.garbat@tieto.com>
Subject: [PATCH v4 16/17] heartrate: Add HeartRateWatcher interface to default policy
Date: Thu, 13 Sep 2012 14:13:20 +0200
Message-ID: <1347538401-6417-17-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1347538401-6417-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1347538401-6417-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rafal Garbat <rafal.garbat@tieto.com>

Change-Id: Iaf2416fbcfb1901ff962f5571f5ebeea0ebf6cc9
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

