Return-Path: <cyrus@holtmann.org>
Subject: Fix bluetoothd not starting on cold boot
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-+nALwioBaoLKLFxS8qg3"
Date: Wed, 22 Sep 2010 12:38:01 +0100
Message-ID: <1285155481.13582.99.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-+nALwioBaoLKLFxS8qg3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Patch attached.

Cheers

--=-+nALwioBaoLKLFxS8qg3
Content-Disposition: attachment; filename="0001-Also-run-bluetoothd-on-udev-change-events.patch"
Content-Type: text/x-patch; name="0001-Also-run-bluetoothd-on-udev-change-events.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 156877874776d3caec3641f09a34a42e4102ef71 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 22 Sep 2010 12:35:54 +0100
Subject: [PATCH] Also run bluetoothd on udev change events

Fixes bluetoothd not starting on cold boot with newer versions
of udev. See:
https://bugzilla.redhat.com/show_bug.cgi?id=634205
---
 scripts/bluetooth.rules.in |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/scripts/bluetooth.rules.in b/scripts/bluetooth.rules.in
index 6809e9d..64df69d 100644
--- a/scripts/bluetooth.rules.in
+++ b/scripts/bluetooth.rules.in
@@ -1,3 +1,4 @@
 # Run helper every time a Bluetooth device appears
 # On remove actions, bluetoothd should go away by itself
 ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="@prefix@/sbin/bluetoothd --udev"
+ACTION=="change", SUBSYSTEM=="bluetooth", RUN+="@prefix@/sbin/bluetoothd --udev"
-- 
1.7.2.3


--=-+nALwioBaoLKLFxS8qg3--

