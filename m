Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <feb8dc070609200250i4eb3dbc2lc915bf751138cf90@mail.gmail.com>
References: <freemail.20060820112703.62459@fm06.freemail.hu>
	<feb8dc070609200250i4eb3dbc2lc915bf751138cf90@mail.gmail.com>
Date: Wed, 20 Sep 2006 11:57:44 +0200
Message-Id: <1158746264.22924.8.camel@localhost>
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

> > First of all, I have a few USB-BT dongle (no brand info, CSR
> > chipset, HCI and LMP ver. 2.0, EEPROM on the board). They
> > all have the same BD address (Yes, it seems I bought pirated
> > dongles).
> >
> > As far as I know the BD has same function like ether MAC. So
> > if I want to use these devices together it can cause problems...
> >
> > I would like to know, is there any way to change the BD
> > address (preferable) permanently or temporary (like ifconfig
> > ethX hw ether AA:BB:CC:DD:EE:FF for ethernet)?
> >
> 
> I'm also having almost the same situation. I bought a USB dongle and
> its BD address seem to be 11:11:11:11:11:11 which don't seem to be
> unique. I would like to know whether my dongle is illegal(if that's
> the case then i need to get my money back). If the dongle is ok, then
> how i would like to know how to change its BD address.

in general such a dongle is illegal. If the Windows software that comes
with your dongle is capable of changing this address and make it unique
and persistent again, then it is not illegal. However this is an unclear
area and it might help to report such dongles to the Bluetooth SIG.

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
