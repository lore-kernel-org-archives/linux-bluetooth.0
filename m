Return-Path: <albert.ribas@estudiants.urv.es>
Date: Tue, 27 Apr 2004 10:44:15 +0200
From: ALBERT RIBAS GUASCH <albert.ribas@estudiants.urv.es>
Subject: Re: [Bluez-users] PAN
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-users@lists.sourceforge.net
Message-id: <f79eaf238e.f238ef79ea@estudiants.urv.es>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
List-ID: <bluez-users.lists.sourceforge.net>

Hi!!

I already have two computers to try the PAN on them
with two USB dongles,  but I still have some problems.

In one computer I run:

modprobe bnep
hcid
pand --listen --role GN

And in the other one:
modprobe bnep
hcid
pand --connect 00:0A:3A:50:20:3C

then, I look at ifconfig (on both sides) and the
connection is ok for a while, but when I check
ifconfig again it has disappeared!!

Then, If _I do a pand --show on the client side, I
see nothing, but on the master side, it is shown as
if the connection was still ok!

Could you help me to mantain stable this connection??

Thank you!!!!

ALBERT

----- Missatge original -----
De: Marcel Holtmann <marcel@holtmann.org>
Data: Dimarts, Abril 20, 2004 1:07 pm
Assumpte: Re: [Bluez-users] PAN

> Hi Albert,
> 
> > Well, I already solved the problem with rfcomm, and
> > now I'm trying to set up a PAN between two Belkin
> > USB dongles. The thing is, when I have both USB
> > plugged into my computer, I just can get one of them
> > UP RUNNING, the other one is not possible to
> > initialize, so it continues with DOWN, I want to
> > create the PAN but I only have one computer to test
> > it. Is this possible to do? 
> 
> getting both dongles running on the same computer
is possible and you
> can use up to 16 dongles, PCMCIA cards or serial
adapters at the same
> time. But it is not possible to create a PAN
between two dongles on 
> thesame computer. You won't see any traffic
between them, because
> everything goes over the loopback interface.
> 
> Regards
> 
> Marcel
> 
> 
> 
