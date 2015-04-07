Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Subject: [PATCH] bluetooth.service.in: do not start if CAP_NET_ADMIN was dropped
Date: Tue,  7 Apr 2015 17:09:36 -0300
Message-Id: <1428437376-31629-1-git-send-email-crrodriguez@opensuse.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

which is the case of systemd-nspawn containers started with --private-network
---
 src/bluetooth.service.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index 35e9457..153840a 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -1,6 +1,7 @@
 [Unit]
 Description=Bluetooth service
 Documentation=man:bluetoothd(8)
+ConditionCapability=CAP_NET_ADMIN
 
 [Service]
 Type=dbus
-- 
2.3.4

