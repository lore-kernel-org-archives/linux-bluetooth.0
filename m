Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050221190756.66973.qmail@web53009.mail.yahoo.com>
From: Alfredo Meraz <alfredo_meraz@yahoo.com.mx>
Subject: Re: [Bluez-users] how get differenced two simultaneous bnep interfaces with the same IP address in a single Bluetooth dongle?
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4219DBCF.6040300@teltronic.es>
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
Date: Mon, 21 Feb 2005 13:07:55 -0600 (CST)

Hi Esteban:
This doesn't seem like a bluetooth problem to me,
rather a network problem. And the root, as it appears
to me, is that at some point you will have to
dupplicate the network packets so that they go through
both access points :) ... and manage your routing
table acordingly... and some more tweakings :S
I had a simpler problem a few months back, when I
inserted 2 NIC's of the same brand into a
server-router. The second NIC, even when configured
properly, would not receive packets at all! Using a
network sniffer, ethereal, I found out that packets
would leave the second NIC, with the right IP address,
but with the MAC address of the first NIC!
The solution? I had to use a second NIC of a different
brand, and now it works :D
Regards.
Alfredo

 --- Esteban Monturus <emonturus@teltronic.es>
escribió: 
>     Hi all.
> 
>     I am working with a single USB dongle in a Linux
> laptop with BlueZ 
> and two PAN-profile access points connected to the
> same LAN. Each access 
> point is implemented with a PC with bridge-utils and
> bluez packets 
> installed. I stablish two simultaneous PAN
> connectionsfrom the laptop: 
> each one to a different access point. Having both
> connections would 
> prevent the loss of data between the LAN and the
> laptop. I would like to 
> receive all the packets through both connections, in
> order to have 
> redundancy.
> 
>     I configure both resulting bnep interfaces to
> have the same IP 
> address, since I don't want the other side of the
> communication to know 
> the existence of two different paths. When I do
> "ifconfig" in the  
> laptop, I realize that both bnep interfaces show the
> same hardware 
> address, which would let my laptop receive each
> packet from the LAN 
> twice. But the reality is that only one of the
> interfaces at a time 
> receives the packets.
> 
>     For example, when "ping" my laptop from a
> computer connected to the 
> LAN, only bnep0 receives ICMP requests, and bnep1
> doesn't. If I use the 
> metrics of the routing table to force bnep1 to
> answer the ping, then 
> ICMP requests start to be received by bnep1, and
> bnep0 receives nothing now.
> 
>     I would like to know if this issue depends on
> the bnep 
> implementation and also would like to know how can
> the net make 
> differences between both interfaces, as they have
> same MAC and IP addresses.
> 
>     Thanks a lot.
> 
> 
>
-------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT
> Products from real users.
> Discover which products truly live up to the hype.
> Start reading now.
>
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
>  

_________________________________________________________
Do You Yahoo!?
La mejor conexión a internet y 25MB extra a tu correo por $100 al mes. http://net.yahoo.com.mx


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
