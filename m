Return-Path: <guy@alum.mit.edu>
In-Reply-To: <1067425631.24043.224.camel@pegasus>
References: <1067379074.2419.24.camel@paul> <1067425631.24043.224.camel@pegasus>
Mime-Version: 1.0 (Apple Message framework v606)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D4C83C06-0A45-11D8-B1BA-000A958097E4@alum.mit.edu>
Cc: Paul Ionescu <paul@acorp.ro>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   ethereal-dev@ethereal.com
From: Guy Harris <guy@alum.mit.edu>
Subject: Re: [Ethereal-dev] Re: [Bluez-devel] bluetooth ethereal dissector
Date: Wed, 29 Oct 2003 11:26:44 -0800
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <bluez-devel.lists.sourceforge.net>


On Oct 29, 2003, at 3:07 AM, Marcel Holtmann wrote:
> from my point of view this is not a good idea, because libpcap is for
> Ethernet traffic. But ask the libpcap guys what they think about it.

Well, as one of the libpcap people, I'd first like to note that libpcap 
is also for UNIX loopback (when the UNIX system in question lets you 
capture on it), Token Ring, ARCNET, SLIP, PPP, FDDI, ATM, Cisco HDLC, 
802.11, Frame Relay, LocalTalk, IP-over-Fibre-Channel, etc. traffic - 
there's nothing magical about Ethernet (other than the fact that it's 
displacing more and more network types over time).

If a given type of link-layer interface can act as a network interface 
(in the sense of something that "ifconfig" on UNIX can tell you about, 
or that plugs into NDIS on Windows), you can probably capture on it.  
Depending on the OS on which you're running, you might even be able to 
see all the link-layer traffic, not just the stuff that gets handed to 
network protocol handlers such as IP.

The current CVS version of libpcap lets you plug in (at compile time) 
modules to let you open for capturing devices *other* than network 
interfaces, such as the DAG cards from Endace (it was put in for them, 
but it should be usable for other devices as well).

>> 2. Make ethereal read capture files made with hcidump -w.
>
> This should be the way to go, because live capturing is not always what
> you want.

Yes, but that doesn't *exclude* support for libpcap-based live 
capturing; a Wiretap module to read "hcidump -w" files would be useful, 
but if that's added you might still want support for libpcap-based 
capturing.

>  However ethereal can read from stdin

Within limits - if you're loading a saved capture, you have to read 
from a file (Ethereal needs to be able to go back and read packet data 
again), but you can "capture from a pipe", at least on UNIX - but that 
requires that the capture be written in libpcap format.
