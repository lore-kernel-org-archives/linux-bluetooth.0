Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hid2hci and Logitech Hub
From: Marcel Holtmann <marcel@holtmann.org>
To: Alexander Holler <holler@ahsoftware.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <27150000.1072412780@[192.168.207.2]>
References: <8430000.1072356496@[192.168.207.2]>
	 <1072363056.2876.75.camel@pegasus>  <30700000.1072366993@[192.168.207.2]>
	 <1072369721.2876.90.camel@pegasus>  <19230000.1072404120@[192.168.207.2]>
	 <1072406653.2876.98.camel@pegasus>  <27150000.1072412780@[192.168.207.2]>
Content-Type: text/plain
Message-Id: <1072451203.2640.11.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 26 Dec 2003 16:06:43 +0100

Hi Alexander,

> Hmm, such an report I've searched. How to do you got this?

I decoded the HID report descriptor of the HID mouse interface.

> But reading other messages on the usb-ml it seems I'm not the only one 
> having problems sending multiples bytes with hiddev.

The complete hiddev interface is a mess and I even don't understand the
basic parts at the moment.

> The next thing I will try, is using usbfs, but first I have to read how. ;)

Won't work until you unload the USB HID driver and this is not what we
want to do. The only way is hiddev :(

> Surely, but the comment to usb_driver_release_interface clearly says the 
> call of that function in hci_usb.c is not needed:
> 
> -------------
>  * When the USB subsystem disconnect()s a driver from some interface,
>  * it automatically invokes this method for that interface.  That
>  * means that even drivers that used usb_driver_claim_interface()
>  * usually won't need to call this.
> -----------------
> 
> So removing it, isn't wrong and it avoids the oops. ;)

This is wrong, because it is only invoked for the interface that is
probed. It is not invoked for the additional interface we claim with SCO
audio support. Leaving this command out only works in the case you
unplug the device. If you only unload the driver you got trouble in the
USB subsystem.

> I think that maybe something is released twice. I've digged somewhat deeper 
> into the usb code, but haven't find something. So I will this left 'as an 
> excercise for the reader'. Choke, I will report it to the usb-ml. ;)

Our code is correct and it works perfect with my OHCI controller. It
only hard lock the system if I plug the device into the UHCI controller
on my motherboard.

	00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 12)
	00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 12)
	02:0c.0 USB Controller: NEC Corporation USB (rev 43)
	02:0c.1 USB Controller: NEC Corporation USB (rev 43)
	02:0c.2 USB Controller: NEC Corporation USB 2.0 (rev 04)

The Intel one is the onboard UHCI controller and the NEC is a USB 2.0
PCI card that also includes and USB 1.1 OHCI controller.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
