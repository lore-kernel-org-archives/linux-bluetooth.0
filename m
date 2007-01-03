Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: jbarnett@pobox.com, BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1167854661.3145.4.camel@localhost>
References: <mailman.341782.1167746753.8777.bluez-devel@lists.sourceforge.net>
	<1167793130.3356.17.camel@localhost> <1167816533.20568.12.camel@violet>
	<1167843929.3164.1.camel@localhost> <1167844461.20568.18.camel@violet>
	<1167854661.3145.4.camel@localhost>
Date: Wed, 03 Jan 2007 21:13:39 +0100
Message-Id: <1167855219.20568.25.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Problems with Dell BCM2045 USB device
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

Hi Jon,

> > did you reload the driver or reboot your system? This would have been
> > the first Broadcom chip where the values are correct. Can you
> > check /sys/class/module/parameters/* that no quirk is actually active.
> 
> Oops, my bad! When I restored my original modprobe file it had my
> initial force scofix quirk in it.
> 
> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
>         DOWN 
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:0 acl:0 sco:0 commands:0 errors:0

please call at least "hciconfig hci0 up". This is an adapter in down
state.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
