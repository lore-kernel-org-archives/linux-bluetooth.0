Return-Path: <Mitch@0Bits.COM>
Message-ID: <3FE029FA.6010204@0Bits.COM>
Date: Wed, 17 Dec 2003 10:03:38 +0000
From: Mitch <Mitch@0Bits.COM>
MIME-Version: 1.0
To: marcel@holtmann.org, bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] NEC usb bluetooth support
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Ok, thanx to Marcel, i looked again, and no patches/source code changes
are needed. The error

	hci_usb: probe of 7-2:1.1 failed with error -5

is spurious, and the device still works just fine.

Another one to add to the list of working with linux bluetooth devices ;-)

Thanks
Mitch

-------- Original Message --------
Subject: Re: [Bluez-users] NEC usb bluetooth support
Date: Tue, 16 Dec 2003 20:40:00 +0100
From: Marcel Holtmann <marcel@holtmann.org>
To: Mitch <mitch@0bits.com>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <3FDF5C36.7080605@0bits.com>

Hi Mitch,

> Yup i do have an entry (see below), and i've managed to get it to load, but by
> hacking the hci_usb.c to remove the lines
> 
>   	/* Check number of endpoints */
> 	if (intf->altsetting[0].desc.bNumEndpoints < 3)
> 		return -EIO;
> 
> It looks like since there's multiple interface descriptors for the device (see
> attachment), and bNumEndpoints is only equal to 3 in one of them, then the test
> fails and returns EIO. I don't know if this check should be removed altogether since
> we subsequently iterate thru all the interfaces to get the endpoints.
> 
> hciconfig shows me 2 interfaces - is this correct ?

this is wrong. The second interface on the USB layer is for the SCO
audio support and in normal cases correct recognized by the driver. This
is why the above check is in the code. If you not have three endpoints
on the first interface it is not a USB Bluetooth device. Please check
your device with 2.4.23.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
