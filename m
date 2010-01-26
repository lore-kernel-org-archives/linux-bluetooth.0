Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Add icons for video devices
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-gieFaOU5rT/NN06fc4YC"
Date: Tue, 26 Jan 2010 16:13:19 +0000
Message-ID: <1264522399.2556.11996.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-gieFaOU5rT/NN06fc4YC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Looks nicer :)

--=-gieFaOU5rT/NN06fc4YC
Content-Disposition: attachment; filename="0001-Add-icons-for-video-type-devices.patch"
Content-Type: text/x-patch; name="0001-Add-icons-for-video-type-devices.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From ebe19c2ae65eea9dc46f1c62dc1e2483390e7e9d Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Tue, 26 Jan 2010 15:41:04 +0000
Subject: [PATCH] Add icons for video-type devices

---
 src/dbus-hci.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index 4b58a81..a943b9b 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -114,6 +114,10 @@ const char *class_to_icon(uint32_t class)
 			return "audio-card";	/* Headset */
 		case 0x06:
 			return "audio-card";	/* Headphone */
+		case 0x0b: /* VCR */
+		case 0x0c: /* Video Camera */
+		case 0x0d: /* Camcorder */
+			return "camera-video";
 		default:
 			return "audio-card";	/* Other audio device */
 		}
-- 
1.6.6


--=-gieFaOU5rT/NN06fc4YC--

