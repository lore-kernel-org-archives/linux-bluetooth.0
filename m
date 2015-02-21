Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 04/18] bluetooth.conf: Add DBus.Properties interface
Date: Fri, 20 Feb 2015 17:56:49 -0800
Message-Id: <1424483824-27374-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1424483824-27374-1-git-send-email-armansito@chromium.org>
References: <1424483824-27374-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GattManager1 communicates with external services using their properties.
This patch adds the org.freedesktop.DBus.Properties interface to the
list of allowed interfaces in the D-Bus configuration.
---
 src/bluetooth.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index ad8891a..10d2d36 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -18,7 +18,10 @@
     <allow send_interface="org.bluez.Profile1"/>
     <allow send_interface="org.bluez.HeartRateWatcher1"/>
     <allow send_interface="org.bluez.CyclingSpeedWatcher1"/>
+    <allow send_interface="org.bluez.GattCharacteristic1"/>
+    <allow send_interface="org.bluez.GattDescriptor1"/>
     <allow send_interface="org.freedesktop.DBus.ObjectManager"/>
+    <allow send_interface="org.freedesktop.DBus.Properties"/>
   </policy>
 
   <policy at_console="true">
-- 
2.2.0.rc0.207.ga3a616c

