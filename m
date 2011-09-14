Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] btusb.c: add support for 2011 mac mini
From: Jurgen Kramer <gtmkramer@xs4all.nl>
To: Gustavo Padovan <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 14 Sep 2011 16:05:52 +0200
In-Reply-To: <20110913235205.GI16856@joana>
References: <1315152103.2441.6.camel@paragon.slim>
	 <20110913235205.GI16856@joana>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316009157.1992.5.camel@paragon.slim>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2011-09-13 at 20:52 -0300, Gustavo Padovan wrote:
> Hi Jurgen,
> 
> * Jurgen Kramer <gtmkramer@xs4all.nl> [2011-09-04 18:01:42 +0200]:
> 
> > Today I noticed that the usb bluetooth adapter (BCM2046B1) on my 2011
> > mac mini was not working. I've created a patch to get it going.
> 
> I need your Signed-off-by: line to apply the patch.
> 
> 	Gustavo
> --
OK, thanks. Here it goes:

Patch for btusb.c to enable the usb bluetooth adapter (BCM2046B1) on the
2011 mac mini (MacMini5,1).

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3ef4760..cbecc6e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -75,6 +75,9 @@ static struct usb_device_id btusb_table[] = {
 	/* Apple MacBookPro8,2 */
 	{ USB_DEVICE(0x05ac, 0x821a) },
 
+	{* Apple MacMini5,1 */
+	{ USB_DEVICE(0x05ac, 0x8281) },
+
 	/* AVM BlueFRITZ! USB v2.0 */
 	{ USB_DEVICE(0x057c, 0x3800) },

Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>



Jurgen

