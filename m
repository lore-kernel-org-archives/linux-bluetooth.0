Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] dd - device descriptor HELP :)
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <de33c8be0502111358420c770b@mail.gmail.com>
References: <de33c8be05021107172b943a1e@mail.gmail.com>
	 <1108149073.18099.50.camel@pegasus>
	 <de33c8be050211121066edf6c1@mail.gmail.com>
	 <1108155254.18099.62.camel@pegasus>
	 <de33c8be0502111358420c770b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1108160249.18099.68.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 11 Feb 2005 23:17:29 +0100

Hi Flavio,

>  I know that "work" with the level HCI is more dificult but the
> information that i need is rssi and transmit power level (tpl) :( in a
> connection! In l2cap that information isn=B4t given right?

when you create a L2CAP connection you can retrieve the ACL handle of
the used underlaying link. So where is the problem?

> I need to create a software that creates a connection between my
> computer (hci0) and a mobile phone (that don=B4t have any software mine=
,
> so isn=B4t listenning for connections l2cap) that only accepts
> connections so i think that l2cap isn=B4t a solution! it=B4s necessary
> that in the mobile phone a program waiting for a connection l2cap (on
> the right psm ) right?

What about PSM 1. The SDP is listening on this PSM.

> So i need to work in HCI!
>=20
> For the people like me :) "role" in hci_creat_connection() :
> role=3D1 ->SLAVE
> role=3D0 -> MASTER

Not quite right. It stands for "allow role switch". This is a different
meaning.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
