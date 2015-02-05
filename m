Return-Path: <cyrus@holtmann.org>
Message-ID: <54D395C8.607@ubuntu.com>
Date: Thu, 05 Feb 2015 17:09:44 +0100
From: Sebastien Bacher <seb128@ubuntu.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Restart bluetooth on failure?
Content-Type: multipart/mixed;
 boundary="------------010709050404000403080801"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010709050404000403080801
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hey,

Is there any reason bluetoothd is not restarted on failure? I recently
hit a segfault in the service and it let the user client non-working,
looks like the service doesn't get restarted either by systemd nor dbus
activation

The attached patch uncomment the restart from the systemd service

Cheers,
Sebastien Bacher

--------------010709050404000403080801
Content-Type: text/x-diff;
 name="0001-restart-service-on-failure.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-restart-service-on-failure.patch"

>From b5f1ca81438f9072fa1928d1603d25f062210665 Mon Sep 17 00:00:00 2001
From: Sebastien Bacher <seb128@ubuntu.com>
Date: Thu, 5 Feb 2015 17:06:04 +0100
Subject: [PATCH] restart service on failure

---
 src/bluetooth.service.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index 35e9457..36a8883 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -8,7 +8,7 @@ BusName=org.bluez
 ExecStart=@libexecdir@/bluetoothd
 NotifyAccess=main
 #WatchdogSec=10
-#Restart=on-failure
+Restart=on-failure
 CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
 LimitNPROC=1
 
-- 
2.1.4


--------------010709050404000403080801--
