Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] IPv6 Bluez and Router Advertissement
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?J=E9r=F4me?= LECOMTE <lecomte@celar.fr>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <410E51C9.1020401@celar.fr>
References: <410E51C9.1020401@celar.fr>
Content-Type: text/plain
Message-Id: <1091473147.4259.9.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 02 Aug 2004 20:59:07 +0200

Hi Jerome,

> I'm having a problem concerning IPv6 autoconfiguration over Bluetooth 
> with Bluez Stack.
> I set up a PICONET architecture like described in the "PAN How to". A 
> bridgde is taking care of all point-to-point bnep interfaces between the 
> master node and the slaves.
> This master node acts like a router to provide access to a MANET 802.11b 
> network and implements IPV6 technology. Ipv4 configuration works well.
> My aim is to provide IPv6 autoconfiguration to the BT slaves nodes.
> I installed RADVD on the router in order to broadcast an ipv6 prefix to 
> BT nodes but they can't achieve to auto-configure.
> The auto configuration is working through an ethernet link so the 
> problem comes from Bluetooth  I think.
> With a sniffer, router sollicication are going well from the slave to 
> the router but router advertisement (with ipv6 prefix) can't go through 
> Bluetooth links (sniffer on slaves shows that) and I don't understand why.
> Experience about this would be welcome

I don't know what's the problem here, but may you wanna take a look at
the BNEP protocol filters. It is only a guess.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
