Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] AVM BlueFritz with Linux Kernel 2.6.3-15mdk
From: Marcel Holtmann <marcel@holtmann.org>
To: Sigrid Kronenberger <skronenberger@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040813210346.6c40aed3@localhost>
References: <20040811231204.18574a27@localhost>
	 <1092262417.4564.259.camel@pegasus> <20040812194818.7d3d1ce6@localhost>
	 <1092334021.28711.169.camel@pegasus> <20040812203428.0bd25290@localhost>
	 <1092336801.28711.172.camel@pegasus>  <20040813210346.6c40aed3@localhost>
Content-Type: text/plain
Message-Id: <1092424207.4501.27.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 13 Aug 2004 21:10:07 +0200

Hi Sigrid,

> > and this is the problem. The firmware loading generates an oops. You
> > must install a newer kernel (at least 2.6.8-rc3) before we can
> > proceed.
> 
> Now, I have updated to 2.6.8-0.rc2.2mdk (sorry, but I'm not used in
> compiling my own kernel, so I prefer rpm-packages, is easier... ;))

this depends on if we get this working without any trouble. Otherwise
you must compile a vanilla kernel, because I don't know what patches
they included.

> Now, it looks a little bit better: 
> 
> /var/log/dmesg (partly)
> 
> uhci_hcd 0000:00:07.3: irq 11, io base 00009800
> uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> usb 1-2: new full speed USB device using address 2
> usb 1-2: configuration #1 chosen from 2 choices
> Bluetooth: Core ver 2.6
> NET: Registered protocol family 31
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> Bluetooth: BlueFRITZ! USB driver ver 1.1
> bfusb_probe: Firmware request failed
> bfusb: probe of 1-2:1.0 failed with error -5
> usbcore: registered new driver bfusb

But the firmware request still fails. Where do you put your bfubase.frm
file? Is hotplug installed and do you have a firmware.agent script under
/etc/hotplug.

> Should I change the firmware again? Do you know which version of the
> AVM-firmware have problems with the kernel? The first version I've
> tested, was 3-18-39, after that, I've changed to 3-17-53. 

Use the older one, because I don't know if this kernel includes my
workaround.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
