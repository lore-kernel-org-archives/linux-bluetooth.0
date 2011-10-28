Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] Add rule to allow sending messages to MediaPlayer interface
Date: Fri, 28 Oct 2011 10:49:19 +0300
Message-Id: <1319788162-5606-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/bluetooth.conf |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 853f926..b5a6af3 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -13,6 +13,7 @@
     <allow send_interface="org.bluez.Agent"/>
     <allow send_interface="org.bluez.HandsfreeAgent"/>
     <allow send_interface="org.bluez.MediaEndpoint"/>
+    <allow send_interface="org.bluez.MediaPlayer"/>
     <allow send_interface="org.bluez.Watcher"/>
   </policy>
 
-- 
1.7.6.4

