Return-Path: <cyrus@holtmann.org>
From: Martin Pitt <martin.pitt@ubuntu.com>
To: linux-bluetooth@vger.kernel.org
Cc: Martin Pitt <martin.pitt@ubuntu.com>
Subject: [PATCH] systemd: Check if bluetooth is supported in the kernel
Date: Tue, 20 Oct 2015 12:24:45 +0200
Message-Id: <1445336685-20506-1-git-send-email-martin.pitt@ubuntu.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When running a kernel without bluetooth support, bluetooth.service fails to
start with

    bluetoothd[1640]: Failed to access management interface
    bluetoothd[1640]: Adapter handling initialization failed
    systemd[1]: bluetooth.service: Main process exited, code=exited, status=1/FAILURE
    systemd[1]: Failed to start Bluetooth service.

This causes an unnecessary "degraded" state and more importantly breaks package
installation when the bluez package auto-starts the daemon.

Add a condition to only start the service if /sys/class/bluetooth exists.

https://launchpad.net/bugs/1506774
---
 src/bluetooth.service.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index 35e9457..83e4732 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -1,6 +1,7 @@
 [Unit]
 Description=Bluetooth service
 Documentation=man:bluetoothd(8)
+ConditionPathIsDirectory=/sys/class/bluetooth
 
 [Service]
 Type=dbus
-- 
2.5.0

