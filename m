Return-Path: <mrison@hotmail.com>
From: "M RISON" <mrison@hotmail.com>
To: marcel@holtmann.org, survivor@uni-paderborn.de
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Piconet Routing
Date: Thu, 21 Oct 2004 09:51:13 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY8-F70Vy134IpLcEc000010f6@hotmail.com>
List-ID: <bluez-devel.lists.sourceforge.net>

> > > > Since Bluetooth uses Time Division Duplex, a slave is not allowed to
> > > > talk to another slave in the same Piconet. The logical consequence 
>must
> > > > be that the data is routed over the master. I've used l2test to 
>check if
> > > > l2cap does this kind of routing automatically. It doesn't but rather
> > > > creates a new, direct acl link to the remote slave device 
>(scatternet).
> > > > I don't know how it is with rfcomm, but I suppose it's the same. My
> > > > question: Is there any automatic Piconet Routing inside BlueZ or 
>does
> > > > one have to implement it by oneself?
> > > you must do it by yourself, because even if the master manages to put
> > > all devices into the same piconet the connections are point to point.
> > TCP connections are also point to point, but since it's built on top
> > of IP, it goes (transparently) over many routers. Before I tested it,
> > I thought the link manager would take care of this. How does the
> > communiction of many BT devices work in practice? Who manages this
> > routing, since one device can only be point-to-point-connected to 2
> > devices (an this doesn't work really smooth)?

[No, a master can be P2P-connected to up to 7 active slaves in a piconet,
and if you support scatternets then you can in theory also be P2P-connected
to several masters (although this is indeed not very smooth in BT1.2).]

> > There must be one
> > controlling instance. One cannot let the different applications handle
> > this, can one?
>this is true, but the problem is, that a slave does not know to which
>other slaves a master is connected. There is no routing stuff like in IP
>and you can't retrieve these information from the HCI layer.

A solution to the OP's problem is to use the PAN profile.  The master (GN)
will then automatically "route" (bridge, actually) BNEP (Ethernet) packets
between the slaves (PANUs).

Mark

--
CPC/IP - A TCP/IP stack for Amstrad CPCs
-- http://www.nenie.org/cpcip/
"Z88 vs CPC? Christ. How did we miss that platform war?"
-- http://www.ntk.net/index.cgi?back=archive00/now0128.txt&line=110#l
