Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] NEC usb bluetooth support
From: Marcel Holtmann <marcel@holtmann.org>
To: Mitch <mitch@0bits.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3FDF5C36.7080605@0bits.com>
References: <3FDF5C36.7080605@0bits.com>
Content-Type: text/plain
Message-Id: <1071603600.27570.30.camel@pegasus>
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
Date: Tue, 16 Dec 2003 20:40:00 +0100

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
