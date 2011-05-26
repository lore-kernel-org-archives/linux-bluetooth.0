Return-Path: <cyrus@holtmann.org>
Subject: Remove obsolete code in hidd
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Thu, 26 May 2011 15:14:42 +0100
Content-Type: multipart/mixed; boundary="=-PtPFu3UDpt4LAvnXl2wO"
Message-ID: <1306419283.2010.245.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-PtPFu3UDpt4LAvnXl2wO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

This code has now been in the kernel for a while.

Cheers

--=-PtPFu3UDpt4LAvnXl2wO
Content-Disposition: attachment;
	filename="0001-Remove-obsolete-Sixaxis-enablement-in-hidd.patch"
Content-Type: text/x-patch; name="0001-Remove-obsolete-Sixaxis-enablement-in-hidd.patch";
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 3a22abd3eb4b8b428bb76069c46d5e8ac2cebb10 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Thu, 5 May 2011 19:41:07 +0100
Subject: [PATCH] Remove obsolete Sixaxis enablement in hidd

Seeing as this is now handled in the kernel.
---
 compat/hidd.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/compat/hidd.c b/compat/hidd.c
index 64dd455..fd1b28c 100644
--- a/compat/hidd.c
+++ b/compat/hidd.c
@@ -237,15 +237,6 @@ static int request_encryption(bdaddr_t *src, bdaddr_t *dst)
 	return err;
 }
 
-static int enable_sixaxis(int csk)
-{
-	const unsigned char buf[] = {
-		0x53 /*HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE*/,
-		0xf4,  0x42, 0x03, 0x00, 0x00 };
-
-	return write(csk, buf, sizeof(buf));
-}
-
 static int create_device(int ctl, int csk, int isk, uint8_t subclass, int nosdp, int nocheck, int bootonly, int encrypt, int timeout)
 {
 	struct hidp_connadd_req req;
@@ -334,9 +325,6 @@ create:
 		req.flags |= (1 << HIDP_BOOT_PROTOCOL_MODE);
 	}
 
-	if (req.vendor == 0x054c && req.product == 0x0268)
-		enable_sixaxis(csk);
-
 	err = ioctl(ctl, HIDPCONNADD, &req);
 
 error:
-- 
1.7.5.1


--=-PtPFu3UDpt4LAvnXl2wO--

