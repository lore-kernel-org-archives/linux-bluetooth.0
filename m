Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] DBT-120 firmware upgrade
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Ruzicka <pavouk@pavouk.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200411272130.44783.pavouk@pavouk.org>
References: <200411261152.29925.pavouk@pavouk.org>
	 <200411271655.27322.pavouk@pavouk.org> <1101579731.27074.8.camel@pegasus>
	 <200411272130.44783.pavouk@pavouk.org>
Content-Type: text/plain
Message-Id: <1101588637.27074.22.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 27 Nov 2004 21:50:37 +0100

Hi Pavel,

> thanks for perfect explaining.

you are welcome.

> I have good news. I flashed my dongle, and she is not dead ;-)
> 
> Dongle now starts in HID mode. I must switch her to HCI with hid2hci.
> hid2hci says something, that it fails, but it works. I have probably old 
> version of this utility.

This is a general problem with using libusb. The URB isn't finished, but
the device already resets. So an error occurs, but this error can be
ignored.

> Dongle in HID mode lights with power LED, but in HCI is power LED off.
> Second LED blinks in both modes.

I know the LED stuff is weird.

> # hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: 00:0D:88:XX:XX:XX ACL MTU: 192:8  SCO MTU: 64:8
>         Build 1586
>         Chip version: BlueCore02
>         Max key size: 128 bit
>         SCO mapping:  HCI

I assume this is HCI 18.2 firmware, but I am not quite sure. It is not
in my list.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
