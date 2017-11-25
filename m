Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Michal Hobot <michal.hobot@silvair.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: [PATCH BlueZ] mesh/onoff-model: Fix msec to sec conversion
Message-Id: <2C0A6DE1-E4B3-4728-B485-0A19BF3419CA@silvair.com>
Date: Sat, 25 Nov 2017 10:01:13 +0100
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is an error in meshctl while displaying transition time. 1000 ms =
is being presented as 16 sec, 40 ms. The reason is incorrect conversion =
of milliseconds to seconds.
The fix is pretty trivial.

--- ../../bluez/mesh/onoff-model.c	2017-11-21 18:04:57.000000000 =
+0100
+++ onoff-model.c	2017-11-21 17:25:14.000000000 +0100
@@ -77,8 +77,8 @@ static void print_remaining_time(uint8_t
 	switch (step) {
 	case 0:
 		msecs =3D 100 * count;
-		secs =3D msecs / 60;
-		msecs -=3D (secs * 60);
+		secs =3D msecs / 1000;
+		msecs -=3D (secs * 1000);
 		break;
 	case 1:
 		secs =3D 1 * count;

