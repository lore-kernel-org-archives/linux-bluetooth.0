Return-Path: <strikewing16th@hotmail.com>
From: "Anthony Yulo" <strikewing16th@hotmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "bluez devel" <bluez-devel@lists.sourceforge.net>
References: <Law11-OE54SB2qgrZCT0000dbb9@hotmail.com> <1074452313.6070.7.camel@pegasus>
Subject: Re: [Bluez-devel] Problems switching usb dongles...
Date: Tue, 20 Jan 2004 00:02:15 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <Law11-OE684BEBqjIpl0000d1e9@hotmail.com>
List-ID: <bluez-devel.lists.sourceforge.net>

hi!! 

how do i exactly unload and reload uhci.o? :)
----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "Anthony Yulo" <strikewing16th@hotmail.com>
Cc: "bluez devel" <bluez-devel@lists.sourceforge.net>
Sent: Monday, January 19, 2004 2:58 AM
Subject: Re: [Bluez-devel] Problems switching usb dongles...


> Hi Anthony,
> 
> > Hi! I have a problems switching usb dongles...
> > When i installed bluez the bluetooth dongle i used is the one made by
> > TDK... now when i tried using a different dongle, a Billionton class
> > B, it seems linux cannot startup the bluetooth system...
> >  
> > i.e.
> > "hciconfig hci0 up"
> >  
> > linux outputs a messaging saying the device is not present or not
> > connected.... when i switch back to the TDK dongle, then it was ok... 
> 
> maybe this is the same problems others saw already with some dongles on
> an UHCI USB host controller. Unload and reload the [usb-]uhci.o driver.
> 
> Regards
> 
> Marcel
> 
> 
> 
