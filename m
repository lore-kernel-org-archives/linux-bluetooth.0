Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45BCFC2F.6090203@free.fr>
Date: Sun, 28 Jan 2007 20:40:31 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: Florian Schaefer <listbox@netego.de>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
References: <E1HAsSn-0000V7-5M@washu.netego.de>
	<E1HBB3Y-0000YF-QI@washu.netego.de>
In-Reply-To: <E1HBB3Y-0000YF-QI@washu.netego.de>
Subject: Re: [Bluez-devel] aplay freezes with headsetd
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Florian,

Could you give me the output of
'hciconfig -a' once you have done the
'modprobe hci_usb force_scofix' ?

Cheers,

Fabien

> root@washu:~ # hciconfig hci0 revision
> hci0:	Type: USB
> 	BD Address: 00:02:78:3D:18:DD ACL MTU: 1017:8 SCO MTU: 64:0
> 	Firmware 220.65 / 92
> 
> I already tried to load hci_usb via "modprobe hci_usb force_scofix" as
> advised by the contact website but that didn't change anything. I'm using
> linux kernel 2.6.19 with the "plugz/patches/sco-flowcontrol-v3.0.diff"
> patches here.
> 
> Does anyone have positive or negative experiences with this Broadcom
> adapter?
> Anything else I might try?
> 
> Ciao
> Florian
> 
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
