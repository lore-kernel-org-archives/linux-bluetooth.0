Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <freemail.20060820112703.62459@fm06.freemail.hu>
References: <freemail.20060820112703.62459@fm06.freemail.hu>
Date: Wed, 20 Sep 2006 11:54:33 +0200
Message-Id: <1158746073.22924.4.camel@localhost>
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

Hi,

> First of all, I have a few USB-BT dongle (no brand info, CSR
> chipset, HCI and LMP ver. 2.0, EEPROM on the board). They
> all have the same BD address (Yes, it seems I bought pirated
> dongles).
> 
> As far as I know the BD has same function like ether MAC. So
> if I want to use these devices together it can cause problems...
> 
> I would like to know, is there any way to change the BD
> address (preferable) permanently or temporary (like ifconfig
> ethX hw ether AA:BB:CC:DD:EE:FF for ethernet)?

you can use the bdaddr utility from bluez-utils, but you need to compile
it by yourself and use it at your own risk. It can render your dongle
useless.

And in general such dongles should not be put on the market. I have seen
this with ISSC dongles before. The BD_ADDR suppose to be unique.

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
