Return-Path: <tam99@t-online.de>
From: tam99@t-online.de (Stefan)
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] bluez-utils compile error
Date: Thu, 12 Aug 2004 15:19:43 +0200
References: <200408121348.18203.tam99@t-online.de> <1092313255.28711.120.camel@pegasus>
In-Reply-To: <1092313255.28711.120.camel@pegasus>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408121519.43356.tam99@t-online.de>
List-ID: <bluez-users.lists.sourceforge.net>

Thanks a lot!!
Now it works!
Is this a bug or why I had to remove this lines?

MfG Stefan




On Thursday 12 August 2004 14:20, you wrote:
> Hi Stefan,
>
> > when I try to compile bluez-utils I get the following error:
> >
> > ...
> > c `test -f 'hid2hci.c' || echo './'`hid2hci.c
> > gcc -I/usr/include  -I/usr/include -Wall -g -O2   -o hid2hci  hid2hci.o
> > -L/usr/lib -lusb
> >
> > /usr/lib/libusb.a(usb.o)(.text+0x7e9): In function `usb_get_busses':
> > : multiple definition of `usb_get_busses'
> >
> > hid2hci.o(.text+0x0):/home/stefan/bluez-utils-2.9/tools/hid2hci.c:45:
> > first defined here
> > collect2: ld returned 1 exit status
> > make[2]: *** [hid2hci] Error 1
> > make[2]: Leaving directory `/home/stefan/bluez-utils-2.9/tools'
> > make[1]: *** [all-recursive] Error 1
> > make[1]: Leaving directory `/home/stefan/bluez-utils-2.9'
> > make: *** [all] Error 2
> > bash-2.05b$
> >
> > bluez-libs and libusb are installed
>
> remove this:
>
> 	#ifndef usb_get_busses
> 	struct usb_bus *usb_get_busses(void)
> 	{
> 	        return usb_busses;
> 	}
> 	#endif
>
> from the hid2hci.c file and try again.
>
> Regards
>
> Marcel
