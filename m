Return-Path: <cyrus@holtmann.org>
From: Tom Gundersen <teg@jklm.no>
To: linux-bluetooth@vger.kernel.org
Cc: Tom Gundersen <teg@jklm.no>
Subject: [PATCH 1/2] systemd: don't order against syslog.target
Date: Fri,  4 May 2012 00:21:52 +0200
Message-Id: <1336083713-8417-1-git-send-email-teg@jklm.no>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This was only needed in old versions of systemd. All messages are logged
by default to the journal now, no ordering required.

Signed-off-by: Tom Gundersen <teg@jklm.no>
---
 src/bluetooth.service.in |    2 --
 1 file changed, 2 deletions(-)

diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index 02b6707..8a9edb6 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -1,12 +1,10 @@
 [Unit]
 Description=Bluetooth service
-After=syslog.target
 
 [Service]
 Type=dbus
 BusName=org.bluez
 ExecStart=@prefix@/sbin/bluetoothd -n
-StandardOutput=syslog
 
 [Install]
 WantedBy=bluetooth.target
-- 
1.7.10.1

