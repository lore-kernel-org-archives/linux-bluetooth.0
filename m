Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 4/4] android: Update README with init.rc updates
Date: Tue, 14 Jan 2014 16:28:03 +0100
Message-Id: <1389713283-13038-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1389713283-13038-1-git-send-email-szymon.janc@tieto.com>
References: <1389713283-13038-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/README | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/android/README b/android/README
index 717ffa2..24ed703 100644
--- a/android/README
+++ b/android/README
@@ -36,31 +36,13 @@ Runtime requirements
 ====================
 
 BlueZ HAL library requires 'bluetoothd' and 'bluetoothd-snoop' services to be
-available on Android system. This can be done by defining following services in
-init.rc file of targeted board:
-
-service bluetoothd /system/bin/logwrapper /system/bin/bluetoothd
-  class main
-  group bluetooth net_admin
-  disabled
-  oneshot
-
-service bluetoothd-snoop /system/bin/bluetoothd-snoop
-  class main
-  group bluetooth net_admin
-  disabled
-  oneshot
-
-It is required that bluetooth user could start and stop bluetoothd and
-bluetoothd-snoop services by setting 'ctl.start' or 'ctl.stop' property. This
-can be achieved by whitelisting bluetooth user and bluetoothd and
-bluetoothd-snoop services in init source code.
-
-Required Android init system modifications can be found at
-https://code.google.com/p/aosp-bluez.platform-system-core/
-
-Some configuration changes like setting permissions, starting hciattach
-services etc. are device specific. For convenience examples are provided at:
+available on Android system. Some permissions settings are also required.
+
+This can be done by importing init.bluetooth.rc file in init.rc file of targeted
+board:
+import init.bluetooth.rc
+
+For convenience examples are provided at:
 https://code.google.com/p/aosp-bluez.device-lge-mako/    (Nexus 4)
 https://code.google.com/p/aosp-bluez.device-asus-flo/    (Nexus 7 2013)
 
-- 
1.8.3.2

