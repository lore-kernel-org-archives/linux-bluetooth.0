Return-Path: <strikewing16th@hotmail.com>
From: "Anthony Yulo" <strikewing16th@hotmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "bluez devel" <bluez-devel@lists.sourceforge.net>
References: <Law11-OE54SB2qgrZCT0000dbb9@hotmail.com> <1074452313.6070.7.camel@pegasus> <Law11-OE684BEBqjIpl0000d1e9@hotmail.com> <1074528420.6070.122.camel@pegasus>
Subject: Re: [Bluez-devel] Problems switching usb dongles...
Date: Tue, 20 Jan 2004 21:32:09 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <LAW11-OE40QXgo3DUHB0002de10@hotmail.com>
List-ID: <bluez-devel.lists.sourceforge.net>


Hi!!

i did what u said .....
anton@maverick rfcomm]# rmmod uhci && modprobe uhci

rmmod: module uhci is not loaded

i tried also rmmod hci_usb && modprobe hci_usb... but still the new dongle
can't be detected..

anton@maverick rfcomm] hciconfig hci0 up
can't get device info: No such device


> Hi Anthony,
>
> > how do i exactly unload and reload uhci.o? :)
>
> rmmod uhci && modprobe uhci
>
> Regards
>
> Marcel
>
>
>
