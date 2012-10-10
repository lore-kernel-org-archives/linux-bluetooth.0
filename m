Return-Path: <cyrus@holtmann.org>
From: Marti Raudsepp <marti@juffo.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marti Raudsepp <marti@juffo.org>
Subject: [PATCH] systemd: prevent duplicate logging messages in journal
Date: Wed, 10 Oct 2012 18:59:29 +0300
Message-Id: <1349884769-5157-1-git-send-email-marti@juffo.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

By default, both stdout and syslog messages go to the systemd journal,
which results in duplicate messages being logged.
---
 src/bluetooth.service.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index 2a576a3..a8442a9 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -5,6 +5,7 @@ Description=Bluetooth service
 Type=dbus
 BusName=org.bluez
 ExecStart=@prefix@/sbin/bluetoothd -n
+StandardOutput=null
 
 [Install]
 WantedBy=bluetooth.target
-- 
1.7.12.2

