Return-Path: <strikewing16th@hotmail.com>
From: "Anthony Yulo" <strikewing16th@hotmail.com>
To: marcel@holtmann.org, bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Difference between rctest.c and main.c in/rfcomm directory
Date: Tue, 20 Apr 2004 05:18:28 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY16-F864HGXAwxXSX000013f9@hotmail.com>
List-ID: <bluez-devel.lists.sourceforge.net>


transforming a TTY device? so it would run as a standard Serial Port?

>From: Marcel Holtmann <marcel@holtmann.org>
>To: Anthony Yulo <strikewing16th@hotmail.com>
>CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
>Subject: Re: [Bluez-devel] Difference between rctest.c and main.c in/rfcomm 
>directory
>Date: Mon, 19 Apr 2004 18:13:20 +0200
>
>Hi Anthony,
>
> > I am only familiar with rfcomm that uses plain sockets...
> >
> > I am only familiart with the rctest.c code that just setup the socket 
>for
> > RFCOMM..
> >
> > but i noticed some additional constants i.e. RFCOMM_REUSE_DLC,
> > RFCOMM_RELEASE_ONHUP..  in main.c of the /rfcomm directory (src)
> >
> > Can someone explain to me briefly whats this for?
>
>they are for transforming a Bluetooth RFCOMM socket into a TTY device.
>
>Regards
>
>Marcel
>
>

_________________________________________________________________
The new MSN 8: advanced junk mail protection and 2 months FREE* 
http://join.msn.com/?page=features/junkmail
