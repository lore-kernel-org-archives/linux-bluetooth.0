Return-Path: <cyrus@holtmann.org>
From: Denis Kenzior <denkenz@gmail.com>
To: "linux-bluetooth" <linux-bluetooth@vger.kernel.org>
Cc: Denis Kenzior <denis.kenzior@intel.com>
Subject: [PATCH] Punch a hole for HandsfreeAgent in dbus policy
Date: Fri, 12 Feb 2010 20:06:53 -0600
Message-Id: <1266026813-29676-2-git-send-email-denis.kenzior@intel.com>
In-Reply-To: <1266026813-29676-1-git-send-email-denis.kenzior@intel.com>
References: <1266026813-29676-1-git-send-email-denis.kenzior@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/bluetooth.conf |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 315009c..56e7a83 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -11,6 +11,7 @@
     <allow own="org.bluez"/>
     <allow send_destination="org.bluez"/>
     <allow send_interface="org.bluez.Agent"/>
+    <allow send_interface="org.bluez.HandsfreeAgent"/>
   </policy>
 
   <policy at_console="true">
-- 
1.6.4.4

