Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Anselm Martin Hoffmeister <anselm@hoffmeister-online.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060727143305.GC28854@pangeia.com.br>
References: <1153915377.6149.1.camel@anselm.venusberg.augustinnetz.de>
	<20060727143305.GC28854@pangeia.com.br>
Date: Thu, 27 Jul 2006 16:56:53 +0200
Message-Id: <1154012213.6222.16.camel@anselm.venusberg.augustinnetz.de>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] HIDclient: Using a Bluez PC as virtual
	Bluetooth	keyboard and	mouse [repost]
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

Am Donnerstag, den 27.07.2006, 11:33 -0300 schrieb Nelson Murilo:
> Great job!
> 
> I got tarball, ran make and copied hdi*.bin to /etc/bluetooth
> 
> After run hdiclient, I get: 
>  ./hidclient 
> HID keyboard/mouse service registered
> Opened event device [/dev/input/event0]
> Opened event device [/dev/input/event1]
> Opened event device [/dev/input/event2]
> Opened event device [/dev/input/event3]
> Bind error (PSM 19): Address already in use
> Failed to bind sockets (9/8) to PSM (17/19)
> 
> #  hciconfig hci0 version
> hci0:   Type: USB
>         BD Address: 00:02:C7:96:9C:74 ACL MTU: 192:8 SCO MTU: 64:8
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x570 LMP Ver: 1.2 (0x2) LMP Subver: 0x570
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> Any hints? 

It seems you already have a bluetooth daemon using the PSM 19. I do not
know which one that might be, but if I remember right, that should be
reserved for HID!? Sorry I cannot tell you how to find out which program
that might be. If possible, you could try to shutdown the bluetooth
daemons currently running, and see wether that port becomes free.

Sorry for being so unspecific.

Anselm

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
