Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 3/3] android: Run services without logwrapper
Date: Mon, 15 Dec 2014 15:07:55 +0100
Message-Id: <1418652475-19842-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1418652475-19842-1-git-send-email-szymon.janc@tieto.com>
References: <1418652475-19842-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those services now log directly to Android logger so no need for
logwrapper which was causing issues with SELinux.
---
 android/init.bluetooth.rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/init.bluetooth.rc b/android/init.bluetooth.rc
index af62121..2d43f73 100644
--- a/android/init.bluetooth.rc
+++ b/android/init.bluetooth.rc
@@ -21,7 +21,7 @@ on property:bluetooth.stop=snoop
     setprop bluetooth.stop none
     stop bluetoothd-snoop
 
-service bluetoothd /system/bin/logwrapper /system/bin/bluetoothd
+service bluetoothd /system/bin/bluetoothd
     class main
     # init does not yet support setting capabilities so run as root,
     # bluetoothd drop uid to bluetooth with the right linux capabilities
@@ -29,7 +29,7 @@ service bluetoothd /system/bin/logwrapper /system/bin/bluetoothd
     disabled
     oneshot
 
-service bluetoothd-snoop /system/bin/logwrapper /system/bin/bluetoothd-snoop
+service bluetoothd-snoop /system/bin/bluetoothd-snoop
     class main
     # init does not yet support setting capabilities so run as root,
     # bluetoothd-snoop drops unneeded linux capabilities
-- 
1.9.1

