Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/init: Update init script with proper selinux domain label
Date: Fri, 21 Nov 2014 14:58:21 +0100
Message-Id: <1416578301-11341-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is to get rid of SEPolicy complain about service running without
defined policies.
---
 android/init.bluetooth.rc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/init.bluetooth.rc b/android/init.bluetooth.rc
index af62121..1815fac 100644
--- a/android/init.bluetooth.rc
+++ b/android/init.bluetooth.rc
@@ -25,6 +25,7 @@ service bluetoothd /system/bin/logwrapper /system/bin/bluetoothd
     class main
     # init does not yet support setting capabilities so run as root,
     # bluetoothd drop uid to bluetooth with the right linux capabilities
+    seclabel u:r:bluetoothd:s0
     group bluetooth
     disabled
     oneshot
@@ -33,6 +34,7 @@ service bluetoothd-snoop /system/bin/logwrapper /system/bin/bluetoothd-snoop
     class main
     # init does not yet support setting capabilities so run as root,
     # bluetoothd-snoop drops unneeded linux capabilities
+    seclabel u:r:bluetoothd:s0
     group nobody
     disabled
     oneshot
-- 
1.9.1

