Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050317092024.80833.qmail@web26605.mail.ukl.yahoo.com>
From: BZ Benny <bennybbz@yahoo.fr>
Subject: Re: [Bluez-users] Adresse resolution in BlueZ
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 17 Mar 2005 10:20:24 +0100 (CET)

Hi Marcel

> you like to see a problem where there is no problem.

I know that every thing is working in BlueZ but I just
want to know how your bnep virtual card works.

> This BNEP virtual network card is as dumb as a
normal 
> Ethernet network card. The networklayer knows our
MAC
> address (BD_ADDR) and 

Actually I'm talking about the peer MAC address.

> if you set the IP to the bnep0
> interface, the kernel TCP/IP can deal with any ARP
> requests by itself.


> Everything we need we get from the network layer.

No, there is a translation that every network card or
virtual network card had to do with ARP table in the
IP layer.


see the exemple below from:
http://www.ietf.org/rfc/rfc826.txt

An Example:
-----------

Let there exist machines X and Y that are on the same
10Mbit
Ethernet cable.  They have Ethernet address EA(X) and
EA(Y) and
DOD Internet addresses IPA(X) and IPA(Y) .  Let the
Ethernet type
of Internet be ET(IP).  Machine X has just been
started, and
sooner or later wants to send an Internet packet to
machine Y on
the same cable.  X knows that it wants to send to
IPA(Y) and
tells the hardware driver (here an Ethernet driver)
IPA(Y).  The
driver consults the Address Resolution module to
convert <ET(IP),
IPA(Y)> into a 48.bit Ethernet address, but because X
was just
started, it does not have this information.  It throws
the
Internet packet away and instead creates an ADDRESS
RESOLUTION
packet with
	(ar$hrd) = ares_hrd$Ethernet
	(ar$pro) = ET(IP)
	(ar$hln) = length(EA(X))
	(ar$pln) = length(IPA(X))
	(ar$op)  = ares_op$REQUEST
	(ar$sha) = EA(X)
	(ar$spa) = IPA(X)
	(ar$tha) = don't care
	(ar$tpa) = IPA(Y)
and broadcasts this packet to everybody on the cable.

Machine Y gets this packet, and determines that it
understands
the hardware type (Ethernet), that it speaks the
indicated
protocol (Internet) and that the packet is for it
((ar$tpa)=IPA(Y)).  It enters (probably replacing any
existing
entry) the information that <ET(IP), IPA(X)> maps to
EA(X).  It
then notices that it is a request, so it swaps fields,
putting
EA(Y) in the new sender Ethernet address field
(ar$sha), sets the
opcode to reply, and sends the packet directly (not
broadcast) to
EA(X).  At this point Y knows how to send to X, but X
still
doesn't know how to send to Y.

Machine X gets the reply packet from Y, forms the map
from
<ET(IP), IPA(Y)> to EA(Y), notices the packet is a
reply and
throws it away.  The next time X's Internet module
tries to send
a packet to Y on the Ethernet, the translation will
succeed, and
the packet will (hopefully) arrive.  If Y's Internet
module then
wants to talk to X, this will also succeed since Y has
remembered
the information from X's request for Address
Resolution.
-------------------------------------
In this exemple we talk about a translation of
IP->MAC.
When I do a #ping "dstIP". The IP layer sends an IP
frame to BNEP the BNEP layer reads the dstIP from the
IP frame. BNEP had to translate destIP->destMAC.It ask
ARP table for such a thing. If ARP knows dstIP it make
the transation for BNEP. If it dosen't it sends an ARP
request to all the peer devices (Broadcast). And ARP
fill the tables with the ARP reply from the peer
devices. After that ARP is able to make translation
for BNEP.

My question is how BNEP ask ARP for such a
translation? I know that for Ethernet such thing is
made in the driver code. 

Regards,
Benny



	

	
		
Découvrez nos promotions exclusives "destination de la Tunisie, du Maroc, des Baléares et la Rép. Dominicaine sur Yahoo! Voyages :
http://fr.travel.yahoo.com/promotions/mar14.html


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
