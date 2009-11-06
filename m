Return-Path: <cyrus@holtmann.org>
Subject: Battery information
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-BWJBSrHPWvwRb3lD6tXc"
Date: Fri, 06 Nov 2009 18:56:09 +0000
Message-ID: <1257533769.23167.194.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-BWJBSrHPWvwRb3lD6tXc
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hello,

A colleague has a Samsung WEP470 headset which triggers an error from
bluetoothd.

Attached is a minimal patch to avoid the error. Would be nice if we
could export that property through bluetoothd.

Cheers

Nov  6 10:27:57 luminos bluetoothd[4848]: link_key_notify
(sba=00:1C:26:F5:21:BB
, dba=00:0D:E6:A6:99:7B, type=0)
Nov  6 10:27:57 luminos bluetoothd[4848]: Stopping discovery
Nov  6 10:27:58 luminos bluetoothd[4848]: Stopping discovery
Nov  6 10:27:58 luminos rtkit-daemon[1606]: Sucessfully made thread 4893 of proc
ess 3010 (/usr/bin/pulseaudio) owned by '500' RT at priority 5.
Nov  6 10:27:58 luminos bluetoothd[4848]: Badly formated or unrecognized command
: AT+CBC=99
Nov  6 10:29:15 luminos bluetoothd[4848]: Software caused connection abort (103)
Nov  6 10:29:15 luminos pulseaudio[3010]: module-bluetooth-device.c: Failed to w
rite data to SCO socket: Transport endpoint is not connected
Nov  6 10:29:59 luminos bluetoothd[4848]: Disconnected from 00:0D:E6:A6:99:7B, /
org/bluez/4847/hci0/dev_00_0D_E6_A6_99_7B

--=-BWJBSrHPWvwRb3lD6tXc
Content-Disposition: attachment; filename*0=0001-Avoid-errors-when-audio-headset-tells-us-its-battery.pat; filename*1=ch
Content-Type: text/x-patch; name="0001-Avoid-errors-when-audio-headset-tells-us-its-battery.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 6e9f62f7251086f09d476d3fce9090e3d22acf63 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Fri, 6 Nov 2009 18:49:53 +0000
Subject: [PATCH] Avoid errors when audio headset tells us its battery charge

Like the Samsung WEP470 does.
---
 audio/headset.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index cf1ae61..36a84c2 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1132,6 +1132,11 @@ static int nr_and_ec(struct audio_device *device, const char *buf)
 	return 0;
 }
 
+static int battery_event(struct audio_device *device, const char *buf)
+{
+	return 0;
+}
+
 static struct event event_callbacks[] = {
 	{ "ATA", answer_call },
 	{ "ATD", dial_number },
@@ -1152,6 +1157,7 @@ static struct event event_callbacks[] = {
 	{ "AT+CCWA", call_waiting_notify },
 	{ "AT+COPS", operator_selection },
 	{ "AT+NREC", nr_and_ec },
+	{ "AT+CBC", battery_event },
 	{ 0 }
 };
 
-- 
1.6.5.2


--=-BWJBSrHPWvwRb3lD6tXc--

