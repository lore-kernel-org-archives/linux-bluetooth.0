Return-Path: <philipl@mail.utexas.edu>
Message-ID: <4498AA79.3060709@mail.utexas.edu>
Date: Tue, 20 Jun 2006 19:10:01 -0700
From: Philip Langdale <philipl@mail.utexas.edu>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: bluez-devel@lists.sourceforge.net
Subject: Re: Observations from mx-5000 bluetooth keyboard + mouse combo
References: <448D88EE.3030902@mail.utexas.edu> <1150540883.17539.38.camel@aeonflux.holtmann.net>
In-Reply-To: <1150540883.17539.38.camel@aeonflux.holtmann.net>
Content-Type: multipart/mixed;
 boundary="------------040008000304020500060003"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------040008000304020500060003
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:
>>
>> 1) The patch to hid2hci.c that Trevor Joynson provided and which was
>> incorporated is not correct - and this is consistent with the reported
>> experience of other people with the di novo laser desktop combo.
> 
> I have no idea what you are talking about. If you think that something
> is wrong, please provide a patch to fix it.

I have attached the patch against hid2hci.

I'll followup on the other items and get back to you when I've got
some information.

--phil

--------------040008000304020500060003
Content-Type: text/x-patch;
 name="hid2hci-mx5000.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hid2hci-mx5000.diff"

--- hid2hci.c	2006-06-20 19:08:09.000000000 -0700
+++ hid2hci.c.org	2006-06-20 19:07:20.000000000 -0700
@@ -222,10 +222,7 @@
 	{ HCI, 0x046d, 0xc703, switch_logitech },
 	{ HCI, 0x046d, 0xc704, switch_logitech },
 	{ HCI, 0x046d, 0xc705, switch_logitech },
-	{ HCI, 0x046d, 0xc70a, switch_logitech }, /* Logitech MX-5000 Desktop */
-	{ HCI, 0x046d, 0xc70b, switch_logitech }, /* Logitech diNovo Desktop */
-	{ HCI, 0x046d, 0xc70c, switch_logitech }, /* Logitech diNovo Desktop */
-	{ HCI, 0x046d, 0xc70e, switch_logitech }, /* Logitech MX-5000 Desktop */
+	{ HCI, 0x046d, 0x0b02, switch_logitech },	/* Logitech diNovo Media Desktop Laser */
 	{ -1 }
 };
 

--------------040008000304020500060003--
