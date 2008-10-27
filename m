Return-Path: <cyrus@holtmann.org>
Subject: Re: Establish a SPP Connection between two linux computers
From: Marcel Holtmann <marcel@holtmann.org>
To: Daniel Matthes <matthes@ftz.htwk-leipzig.de>
Cc: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <09E68493E3CD0D47BF12172B07F527382CC88B2B9C@mail1.ftz.htwk-leipzig.de>
References: <09E68493E3CD0D47BF12172B07F527382CC88B2B9C@mail1.ftz.htwk-leipzig.de>
Content-Type: text/plain
Date: Mon, 27 Oct 2008 21:01:01 +0100
Message-Id: <1225137661.7157.36.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

> I want to connect two debian (lenny) systems with two Anycom USB-200 USB Dongles, so I've downloaded the bluez-1.41 driver.
> 
> I want to create a serial connection (by using SPP). 
> 
> At the beginning, I've tested the driver by connecting a linux operating system with a windows operating system.
> 
> I run  sdptool browse and I've found:
> 
> Service Name: Serieller Bluetooth-Anschluss
> .
> Protocol Descriptor List:
>             "L2CAP"  (0x0100)
>             "RFCOMM"  (0x0003)
>                         Channel: 1
> ..
> 
> After this I run rfcomm bind 0 <bdaddr> 1 and then I could establish with minicom  a connection to the windows system and send data.
> 
> In the second turn. I install bluez on the second linux computer. After running sdptool browse, there are no entries for serial support.
> I've also created an entry with sdptool add -channel 1 SP. Afterwards I could browse the serial port entry with the other computer,
> but there was also no way to connect the computers.
> 
> So here my question:  How can I connect two linux systems with bluetooth by using the serial port profile.

the rfcomm listen command might get you somewhere, but also rctest would
do it. However in the end you have to write your own daemon to do the
work correctly.

Regards

Marcel


