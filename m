Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <de33c8be0502111358420c770b@mail.gmail.com>
From: =?ISO-8859-1?Q?Fl=E1vio?= <flavio.henriques@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] dd - device descriptor HELP :)
In-Reply-To: <1108155254.18099.62.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <de33c8be05021107172b943a1e@mail.gmail.com>
	 <1108149073.18099.50.camel@pegasus>
	 <de33c8be050211121066edf6c1@mail.gmail.com>
	 <1108155254.18099.62.camel@pegasus>
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
Date: Fri, 11 Feb 2005 21:58:27 +0000

Hi Marcel,

 I know that "work" with the level HCI is more dificult but the
information that i need is rssi and transmit power level (tpl) :( in a
connection! In l2cap that information isn=B4t given right?

I need to create a software that creates a connection between my
computer (hci0) and a mobile phone (that don=B4t have any software mine,
so isn=B4t listenning for connections l2cap) that only accepts
connections so i think that l2cap isn=B4t a solution! it=B4s necessary
that in the mobile phone a program waiting for a connection l2cap (on
the right psm ) right?

So i need to work in HCI!

For the people like me :) "role" in hci_creat_connection() :
role=3D1 ->SLAVE
role=3D0 -> MASTER
 :P


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
