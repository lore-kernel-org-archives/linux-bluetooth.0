Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] how get differenced two simultaneous bnep
	interfaces with the same IP address in a single Bluetooth dongle?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4219DBCF.6040300@teltronic.es>
References: <4219DBCF.6040300@teltronic.es>
Content-Type: text/plain
Message-Id: <1109026258.7626.7.camel@pegasus>
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
Date: Mon, 21 Feb 2005 23:50:58 +0100

Hi Esteban,

>     I am working with a single USB dongle in a Linux laptop with BlueZ 
> and two PAN-profile access points connected to the same LAN. Each access 
> point is implemented with a PC with bridge-utils and bluez packets 
> installed. I stablish two simultaneous PAN connectionsfrom the laptop: 
> each one to a different access point. Having both connections would 
> prevent the loss of data between the LAN and the laptop. I would like to 
> receive all the packets through both connections, in order to have 
> redundancy.

this sound like a job for the Netfilter.

>     I configure both resulting bnep interfaces to have the same IP 
> address, since I don't want the other side of the communication to know 
> the existence of two different paths. When I do "ifconfig" in the  
> laptop, I realize that both bnep interfaces show the same hardware 
> address, which would let my laptop receive each packet from the LAN 
> twice. But the reality is that only one of the interfaces at a time 
> receives the packets.

The hardware of every BNEP virtual network card is taken from the
BD_ADDR of the local dongle. However how do you expect that using the
same IP address should work anyway. The bnepX devices are a virtual
network and they react the same like ethX.

>     I would like to know if this issue depends on the bnep 
> implementation and also would like to know how can the net make 
> differences between both interfaces, as they have same MAC and IP addresses.

This is not a BNEP issue, because it is only sending/receiving what the
network subsystem tolds it. Ask the Linux network guys for this kind of
specific thing you wanna do.

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
