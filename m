Return-Path: <strikewing16th@hotmail.com>
From: "Anthony Yulo" <strikewing16th@hotmail.com>
To: marcel@holtmann.org
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] rfcomm error message?
Date: Wed, 21 Jan 2004 08:32:20 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law11-F41C9IHzQL9P30004988b@hotmail.com>
List-ID: <bluez-devel.lists.sourceforge.net>


Hey Marcel,

sorry, i didn't know i'm sending html, because i'm sending the previous 
emails using Outlook express, maybe i have to set it to send text only...
sorry..:)

well, im just testing with the rfcomm program to see if i can connect to the 
linux box with a smartphone.. i didn't read the source of rfcomm that much, 
so im asking if i can still make a bluetooth program thru RFCOMM, without 
the TTY support?..

how do i set the kernel options CONFIG_BLUEZ_RFCOMM_TTY? The only way i know 
how to set it is thru recompiling the kernel.. i.e. "make xconfig"... other 
ways to do it?

sorry :) hehe im just starting bluetooth programming, and i know very little 
on the kernel...

regards,

Anton

>
>Hi Anthony,
>
>first, can you please send text only emails. There is no reason to send
>HTML emails to a mailing list and I tend to delete emails with a blue
>background without reading them. Thanks.
>
> > i tried using the rfcomm program to test for connections between
> > cellphone and linux pc...
> >
> > anton@maverick home]rfcomm -i hci0 listen 2
> > Waiting for connection on channel 1
> >
> > ...when i try to connect the smartphone the program returns and
> > outputs the error message:
> >
> > "can't create RFCOMM TTY: Operation not supported"
> >
> > whats wrong with this? do i have to set some configuration files?
>
>your kernel is compiled without RFCOMM TTY support. Set the kernel
>option CONFIG_BLUEZ_RFCOMM_TTY.
>
>Regards
>
>Marcel
>
>

_________________________________________________________________
MSN 8 helps eliminate e-mail viruses. Get 2 months FREE*. 
http://join.msn.com/?page=features/virus
