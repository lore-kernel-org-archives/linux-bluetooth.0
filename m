Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Wacom Bluetooth mode-2 activation
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-oVTmZxlq0NDXlQtAlJZU"
Date: Tue, 17 Mar 2009 23:54:45 +0000
Message-Id: <1237334085.15346.99.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-oVTmZxlq0NDXlQtAlJZU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

Patch is necessary to make the Wacom Bluetooth driver I posted to
linux-input work as expected. I've tested this successfully with my
tablet[1].

Cheers

[1]: For Marcel, if you want a funky new device, look for CTE-630BT:
http://www.wacom-europe.com/index2.asp?pid=163&lang=en
http://www.wacom-shop.net/cgi-bin/wacom.storefront/49c0379700eeee24273f4ddcef2606ba/Product/View/CTE&2D630BT3

--=-oVTmZxlq0NDXlQtAlJZU
Content-Disposition: attachment; filename="0001-Add-Mode-2-activation-for-the-Wacom-BT-tablet.patch"
Content-Type: text/x-patch; name="0001-Add-Mode-2-activation-for-the-Wacom-BT-tablet.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 7446ea0afdbdb602261c3d43efc4f29bac47cc4b Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Tue, 17 Mar 2009 23:44:44 +0000
Subject: [PATCH] Add Mode-2 activation for the Wacom BT tablet

Otherwise the device shows up as a simple mouse, and extended
events aren't being pushed to the kernel.
---
 input/device.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/input/device.c b/input/device.c
index 0090bd4..8d65148 100644
--- a/input/device.c
+++ b/input/device.c
@@ -658,6 +658,19 @@ static int hidp_add_connection(const struct input_device *idev,
 		err = write(sk, buf, sizeof(buf));
 	}
 
+	if (req->vendor == 0x056a && req->product == 0x81) {
+		unsigned char buf[3];
+		int sk = g_io_channel_unix_get_fd(iconn->ctrl_io);
+
+		buf[0] = 0x53; /* HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE */
+		buf[1] = 0x03; buf[2] = 0x00;
+		write(sk, buf, sizeof(buf));
+
+		buf[0] = 0x71; /* HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE */
+		/* 0x06 - high reporting speed, 0x05 - low speed */
+		buf[1] = 0x06; buf[2] = 0x00;
+		write(sk, buf, sizeof(buf));
+	}
 	err = ioctl_connadd(req);
 
 cleanup:
-- 
1.6.2


--=-oVTmZxlq0NDXlQtAlJZU--

