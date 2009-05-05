Return-Path: <cyrus@holtmann.org>
From: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: BT git version triggers BUG: scheduling while atomic: swapper/0/0x10000100
Date: Tue, 5 May 2009 08:29:25 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200905050301.37528.Hugo.Mildenberger@namir.de> <200905050323.42101.Hugo.Mildenberger@namir.de> <1241488613.3319.3.camel@localhost.localdomain>
In-Reply-To: <1241488613.3319.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200905050829.26036.Hugo.Mildenberger@namir.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

> > > > When I tried to get a mobile phone connected to asterisk via
> > > > bluetooth, the current git version of the linux bluetooth stack
> > > > triggers a kernel bug:
> > > >
> > > > 	BUG: scheduling while atomic: swapper/0/0x10000100
> > > >
> > > > This is triggered the moment when asterisk tries to pair the phone
> > > > and leaves at least the BT subsystem in an unusable state.
> > >
> > > are you running Linus' tree or bluetooth-testing.git? If your are not
> > > running bluetooth-testing.git, then please try that one since it
> > > includes a fix for it.
> >
> > I'm running bluetooth-testing.git and pulled that tree just an hour ago.
>
> does the attached patch fixes your issue?
>
> Regards
>
> Marcel

you are really fast ... and your patch actually fixed the problem. Thank you 
very much!

Rests to mention a problem which could again be linked to the bluetooth stack, 
but also to the CSR dongle (which is blacklisted in btusb.c: 0x0a12:0001), to 
Asterisk's "chan_mobile" module or even to the Nokia 6280 V6.43 firmware. 
Should I better start another thread here?


[Outbound GSM call via Asterisk and BT-adapter, wait until the other side 
hangs up]

hci_scodata_packet: hci0 SCO packet for unknown connection handle 46
hci_scodata_packet: hci0 SCO packet for unknown connection handle 46
hci_scodata_packet: hci0 SCO packet for unknown connection handle 46
hci_scodata_packet: hci0 SCO packet for unknown connection handle 46
hci_scodata_packet: hci0 SCO packet for unknown connection handle 47
hci_scodata_packet: hci0 SCO packet for unknown connection handle 47
hci_scodata_packet: hci0 SCO packet for unknown connection handle 47

[Outbound GSM call via Asterisk and BT-adapter, hang up the IP phone up before 
the other side does so]

btusb_isoc_complete: hci0 corrupted SCO packet
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0

[And Asterisk says: - Bluetooth Device Nokia has disconnected, reason (104)]


Best Regards

Hugo
