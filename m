Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Remove sixaxis quirk
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-G2Vl1QFsC3iEOipfkz8e"
Date: Fri, 05 Feb 2010 13:52:15 +0000
Message-ID: <1265377935.2383.59.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-G2Vl1QFsC3iEOipfkz8e
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

As it's now done in the kernel.

Cheers

--=-G2Vl1QFsC3iEOipfkz8e
Content-Disposition: attachment; filename="0001-Remove-Sixaxis-quirk-now-in-the-kernel.patch"
Content-Type: text/x-patch; name="0001-Remove-Sixaxis-quirk-now-in-the-kernel.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 67fbab5f326492dc0f3a9190f6e184bfbdefae30 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Fri, 5 Feb 2010 13:49:55 +0000
Subject: [PATCH] Remove Sixaxis quirk, now in the kernel

The quirk in input/device.c to make the Sixaxis joypad operational
in Bluetooth mode is now available directly in the kernel.
---
 input/device.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/input/device.c b/input/device.c
index c8ef1ad..922dc98 100644
--- a/input/device.c
+++ b/input/device.c
@@ -659,12 +659,6 @@ static int hidp_add_connection(const struct input_device *idev,
 		}
 	}
 
-	if (req->vendor == 0x054c && req->product == 0x0268) {
-		unsigned char buf[] = { 0x53, 0xf4,  0x42, 0x03, 0x00, 0x00 };
-		int sk = g_io_channel_unix_get_fd(iconn->ctrl_io);
-		err = write(sk, buf, sizeof(buf));
-	}
-
 	err = ioctl_connadd(req);
 
 cleanup:
-- 
1.6.6


--=-G2Vl1QFsC3iEOipfkz8e--

