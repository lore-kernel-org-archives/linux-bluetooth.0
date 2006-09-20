Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <feb8dc070609200304l4f3ecb05r2b844f408ef7b13@mail.gmail.com>
References: <freemail.20060820112703.62459@fm06.freemail.hu>
	<1158746073.22924.4.camel@localhost>
	<feb8dc070609200304l4f3ecb05r2b844f408ef7b13@mail.gmail.com>
Date: Wed, 20 Sep 2006 12:29:39 +0200
Message-Id: <1158748179.22924.11.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Changing BD address on CSR based USB dongle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Jinesh,

> > And in general such dongles should not be put on the market. I have seen
> > this with ISSC dongles before. The BD_ADDR suppose to be unique.
> >
> 
> Yes ! The dongle that I've recently bought is ISSC. Its windows
> utility doesn't come(AFAIK) with any option to change the BD address.
> But my vendor does provide guarantee for it. ie, even if it gets
> damaged, they will give a replacement. So, may be i should try it and
> see.
> 
> So, since my windows utility doesn't provide any option to change its
> BD, does it mean that the dongle is illegal? Should i report this to
> some authority?

if you start up Windows with the software for this dongle, plug it in
and make it discoverable. Then search with another device from another
machine and if you still see 11:11:11:11:11:11 as address, then you
should return the dongle.

There are ROM based dongles/chips where the host software has to set the
BD_ADDR. This is totally legal. However you mostly see this for chips
used in embedded devices and not USB dongles for desktop systems.

If you know the manufacturer of this dongle, then you might contact them
and/or public relations of the Bluetooth SIG.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
