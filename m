Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Adresse resolution in BlueZ
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050316102129.28080.qmail@web26610.mail.ukl.yahoo.com>
References: <20050316102129.28080.qmail@web26610.mail.ukl.yahoo.com>
Content-Type: text/plain
Message-Id: <1110969441.9818.117.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 16 Mar 2005 11:37:21 +0100

Hi Benny,

> Excuse me if I wasn't precise.
> 
> I know that the BD_ADDR is the MAC address it is
> explained in the BNEP spec. and when I do ifconfig
> bnep0 i see in the MAC address feild the BD_ADDR.
> 
> When we conect tow bluetooth devices with a PAN
> connection, we use ifconfig to affect an IP address
> for both our PC.
> 
> The IP address is in the IP layer.When the tcp stack
> send an IP frame in the IP headers we find the IP
> address of the sender and the IP address of the dst.
> 
> when BNEP receive this IP frame it needs to build its
> BNEP headers. The BNEP header cantains (not in
> ETHERNET_COMPRESSED) the BD_ADDR of the dst and the
> src. BNEP needs to convert the IP address into
> BD_ADDR.
> 
> So BNEP ask IP for such a thing. This BD_ADDR is
> stored in an ARP table. the ARP table is in the IP
> layer. The ARP table contains for any known IP address
> its related BD_ADDR (or MAC address as you want).
> 
> If this IP isn't known like when we begin a conection
> the IP layer send an ARP resolution request asking
> which device owns this IP address. The device it have
> this IP address reply with " this Ip address is owne
> by this BD_ADDR"
> so the IP layer store this BD_ADRR in this ARP table.
> 
> you can see that with #tcpdump -i bnep0.
> 
> The ARP protocol is explained here. 
> http://www.ietf.org/rfc/rfc826.txt.
> 
> Actually this is the protocol between the IP layer and
> the Ethernet layer. Since the BNEP have to replace the
> Ethernet layer, I wanted to know how is implemented
> address resolution in BNEP. Exactly how BNEP ask IP
> for getting the BD_ADDR stored in the ARP table. 

you like to see a problem where there is no problem. This BNEP virtual
network card is as dumb as a normal Ethernet network card. The network
layer knows our MAC address (BD_ADDR) and if you set the IP to the bnep0
interface, the kernel TCP/IP can deal with any ARP requests by itself.
Everything we need we get from the network layer.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
