Return-Path: <adq_dvb@lidskialf.net>
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] rfcomm problems
Date: Thu, 25 Nov 2004 01:31:50 +0000
Cc: Marcel Holtmann <marcel@holtmann.org>
References: <200411241854.13007.adq_dvb@lidskialf.net> <1101325813.7538.6.camel@pegasus>
In-Reply-To: <1101325813.7538.6.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411250131.50765.adq_dvb@lidskialf.net>
List-ID: <bluez-users.lists.sourceforge.net>

On Wednesday 24 Nov 2004 19:50, Marcel Holtmann wrote:
> Hi Andrew,
>
> > Hi, I'm using linux kernel 2.6.9, gentoo, bluez-utils/libs 2.10.
> > I have a Nokia 3650, with firmware 3.16.
> >
> > I've initially been just trying to connect to the phone using rfcomm...
> >
> > rfcomm connect 0 MACADDR 1
> >
> > this works - I get the "Press Ctrl-C to hangup" and /dev/rfcomm0 appears
> > (using udev BTW).
> >
> > I then try to use minicom on /dev/rfcomm0. It opens it OK, but nothing
> > happens... I mean, I send AT commands at it, but I get no response. Do I
> > have to use a certain set of serial port settings (I've tried quite a
> > few)?
>
> No. This should simply work.
>
> However some people complained about that minicom and RFCOMM TTY do not
> work very good together. The BlueZ utils packages contains test/attest.c
> and you should give it a try.
>
> > I also tried running hcidump whilst typing stuff in minicom - nothing was
> > logged.
>
> Do you started hcidump as root? You must see at least the RFCOMM channel
> setup.

Nice one! I've now got GPRS and everything working. I can confirm minicom just 
does not work with it.


OK: my next question is about the "Bluetooth serial port" on the phone. When I 
connect to it with:

rfcomm connect 0 00:60:57:7C:31:49 2

It connects, but then the phone immediately disconnects. A short time later,  
the phone connects back to my computer on seemingly the service with the 
highest channel id - in my case kbemusedsrv (from kdebluetooth - an XMMS 
control service for the phone).

kbemused handily has a raw data dump option, and I can see the phone sending 
what are obviously PPP LCP packets at it.

How do I get the phone to connect to something sensible - e.g. to dund. I 
found various sets of instructions on the web, but the damn thing keeps 
connecting to kbedmused. 

Is this connect-disconnect-reconnect behaviour normal?
